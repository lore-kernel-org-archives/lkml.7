Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D541620835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RUHlJgm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfCGLxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfCGLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TTWxJ9USMxfU6X1WPYBY6xuhUvbmziiM3bMK04BFSAQ=; b=RUHlJgm9e96EwXjkpn/0XKhyz6
        7XqcOAvkgS7zFL3V36HMaQU6D5eC6tCJbYAmiEjUCdJgMQkYQTJkrEAbsSkPou3BcN5vrg1jSFqwT
        N9cGaT90/O1nWC0Laeg+a81ttF7DBgVj4qxjfyZeVfzGK8ETf/APNdcrF5X3tkGSz48bT8q2VQ1X/
        mqLHJTayZVcYHeSQs7OYVKYnvG+uOq9HZiqEPo1hb1XC9U6LJacm0kqlLi9++DR71G17NR18eI95V
        eBhVvlrigKOnaj8j+yMVGCXKXSrZHL6TH5/6LxsRfpaF5ZDsPDgpBudor+yTLnoxs2eBV/emi83Zn
        52ZU9V8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZm-0005PU-Lw; Thu, 07 Mar 2019 11:52:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9DA2220297BCF; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115159.617088405@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 06/20] x86/uaccess: Always inline user_access_begin()
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If GCC out-of-lines it, the STAC and CLAC are in different fuctions
and objtool gets upset.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/uaccess.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -706,7 +706,7 @@ extern struct movsl_mask {
  * checking before using them, but you have to surround them with the
  * user_access_begin/end() pair.
  */
-static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
+static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr,len)))
 		return 0;


