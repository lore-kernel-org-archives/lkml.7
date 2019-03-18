Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46310C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126CD20835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fq6G0g5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfCRPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:54:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58722 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfCRPw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZzqstxTm+4RKpAgonk1jK5brJjDJNa9fUa5HmM0UqMk=; b=fq6G0g5yV0qih+1vTQYPLzrZg+
        5pf2RKMVYlFtoTUmod8/ZpXCnU8fQZO31sE3z0zsnioTvhGxSgDxB07c5SquL5ZX+bZDbl3dDx9uv
        /GZ5RsUAy8T17gDe1x15d7EdSiaHgsTnR3ijuV5/cS2eUuXAxcr5iMJH8SxLyLZHjrkkbbvFQxTse
        eapo/86xsZHS8sfBmY6o+Uark/4IWou1exK0GPh8D0KsEFFh0g3jj1Cnv2jIQ8aY4+SuJG6K/Dd2l
        cVVeJv0WbsHdx8yKw9Pt+LsXAj7gl2QpbqzyQ7mBaFdu4lvt4BvE/4Pgn/ZEm6o29e3XSgIsxh7zp
        oJUr++cA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ5-0005Uh-Rk; Mon, 18 Mar 2019 15:52:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 824EC2026BE92; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155139.963285969@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 01/25] x86: Make SMAP 64-bit only
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We rely on objtool to verify AC=1 doesn't escape. However there is no
objtool support for x86_32, and thus we cannot guarantee the
correctness of the 32bit code.

Also; if you're running 32bit kernels on hardware with SMAP (which all
should have LM support afaik) you're doing it wrong anyway.

XXX: we could do the PUSHF/POPF thing in __switch_to_asm() on x86_32,
but why bother.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1853,6 +1853,8 @@ config ARCH_RANDOM
 
 config X86_SMAP
 	def_bool y
+	# Note: we rely on objtool to validate AC=1 doesn't escape
+	depends on HAVE_STACK_VALIDATION
 	prompt "Supervisor Mode Access Prevention" if EXPERT
 	---help---
 	  Supervisor Mode Access Prevention (SMAP) is a security


