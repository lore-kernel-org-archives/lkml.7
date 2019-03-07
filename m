Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B257020840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kCu4A+YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCGLxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCGLwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FOr8+UA/iSNyAMAmLJ7QDgsrEOvhjlKoD1hXMqSnguA=; b=kCu4A+YC7vi+B01qNQCiqJfxxI
        /7VIGG96SAyg5lPs42d1LGx4inSbWhN/9RmWTYJ0ZDfm7GAfUgn+0LzLpahUh0QaTgbGdjXt3d+/j
        UpybzR+XftlgNGyG3cE3nNA58SGRr9IfoEa8q/LfQy6lsNKawJSkYZ59qvHhkeyC89oKqT9o1WiCI
        NDGbvBSPjf9aKmdp/G7fRigF/QoOxcX4SJugH7BiYiG/8jg9djCEiDpUoCsCot0hCcK1H9VGJPNKG
        nE3WVgcc0ysjqbIvL8zu1IQxAQ9YYMiU7rMHWYKY7D1PJe/M0KPe/3oTc17lC/XLaxvZdPFWXKTh0
        bA8V1e6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZl-0001WT-3F; Thu, 07 Mar 2019 11:52:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 92AB720297BCA; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115159.438734452@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 04/20] x86/uaccess: Fix up the fixup
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/lib/memcpy_64.o: warning: objtool: .fixup+0x7: return with UACCESS enabled

While the code isn't wrong; it is tedious (if at all possible) to
figure out what function a particular chunk of .fixup belongs to.

This then confuses the objtool uaccess validation. Instead of
returning directly from the .fixup, jump back into the right function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/memcpy_64.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -257,6 +257,7 @@ ENTRY(__memcpy_mcsafe)
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
 	xorl %eax, %eax
+.L_done:
 	ret
 ENDPROC(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
@@ -273,7 +274,7 @@ EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 	addl	%edx, %ecx
 .E_trailing_bytes:
 	mov	%ecx, %eax
-	ret
+	jmp	.L_done
 
 	/*
 	 * For write fault handling, given the destination is unaligned,


