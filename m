Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4E8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229532081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eRT3KtDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfCGLwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:52:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cJfJ05GJ0MEbvcruOO33BoC58/tAKr1fycBBflzH54U=; b=eRT3KtDzhNnNrLraHMb75QEC+4
        ZJmfSHm7RZzG3TQyGSOA86y2S2qTKhY63c0i9x/IcsOQ9wnFrU7YCvTXpHzbegYkdy+xzYxW/9DfU
        vx5TVUT/X8QG68quihLmiqOJuhrH5i3/GbrQDvX/amzrkmuykxn/t2Ep28BPQTPP/zw3i0eaQ+H2u
        gh8tt8Kx1YQxo/qJugFiHuv7xopmj0Ytox87L0lUXpK+GLC8XrCCzVOMDxE72jiLy+u0OcFBfx0je
        S9IWa7gtp+Vs7LoW8O9nO39IKJvex9r+AE9MwQZqHfDe1+brKvKrQ6wHDjJLTOI8WZKmupaK5caNx
        6D3VNnFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZm-0001Wg-Va; Thu, 07 Mar 2019 11:52:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A26FB20297BD1; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115159.708180729@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 07/20] x86/uaccess: Always inline force_valid_ss()
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x3cc: call to force_valid_ss.isra.5() with UACCESS enabled

XXX: move the callsite out of te AC=1 region instead?

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -71,7 +71,7 @@
  * alone.  Using this generally makes no sense unless
  * user_64bit_mode(regs) would return true.
  */
-static void force_valid_ss(struct pt_regs *regs)
+static __always_inline void force_valid_ss(struct pt_regs *regs)
 {
 	u32 ar;
 	asm volatile ("lar %[old_ss], %[ar]\n\t"


