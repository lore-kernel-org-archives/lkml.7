Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84572085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FeuM+VW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfCRPyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:54:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCRPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FOr8+UA/iSNyAMAmLJ7QDgsrEOvhjlKoD1hXMqSnguA=; b=FeuM+VW6cW4f9HZctzK/7DmIA1
        wVQ8WBwUyj/8GxqpdwpNCDdW/tV0j0oOPosMYashRQ80wuN+PvBQdv/8/4n0wDXTKoPlp1C4g3MoA
        yU2X7Pgm4IIxtn/IVNjF0/jai2NVO/KzOZODxUPewjPNTrjWJTOM9VI5pIh92C98oiqxJk1wV5wsA
        KGfByM3hyg4YaAjrFGaji1gSSnhKA89owkXZL96EXR4tvl4NEIrH55xNvEZ+lGkfMeFsPksKoFKRe
        lD8NhtNXdCWrVPZtK1BLYJE4C0O9ceMbKRvK8mxxeDHhVEHA5eP/tYsvfdv3uTD7W7OfR1ZBOfI4b
        AzhUeLOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ7-0005Uv-G3; Mon, 18 Mar 2019 15:52:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9BDB025E45D70; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155140.441339649@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 06/25] x86/uaccess: Fix up the fixup
References: <20190318153840.906404905@infradead.org>
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


