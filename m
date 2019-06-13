Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E399C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ECB21473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Op23Dvp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbfFMPJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:09:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbfFMN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bd69/laib4ueRDoZQxDoYXylA7gMlrMbtlENzcoL9jQ=; b=Op23Dvp56wQdaroDRYr1A84rcU
        t+TGZeORM7+U+jB5nkmAfG87tgn8/N7O5dIrHFyNHc2/7EsPv0q1nSlVn9wXNJgRCjdemVX8rH1Xf
        vDMu2f6oFkbFo7NlFml6PUMeQyO7067xPG+EiaK2Zxk7YszJxLL0UFkxNx8rfMCTorDF/8Jsri/jD
        95CjvztcTeYvUWYbFWi3yldIWHWiqTs8gTGObfQr5Xd2LWtAgp4LoTBEmh1M7W11F2sF9ZcUFKrrv
        74P/3ilmh4vatIO8cJH30A87n7o3VCZq6hWBihCI+zdvbl12/q2kmlyI2NV1k8X0QlaCGV3QjYK7M
        eRjKCdww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQE0-0005la-0t; Thu, 13 Jun 2019 13:57:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1F2DE20435AA9; Thu, 13 Jun 2019 15:57:05 +0200 (CEST)
Message-Id: <20190613135653.623354057@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:54:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] x86/percpu: Optimize raw_cpu_xchg()
References: <20190613135445.318096781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since raw_cpu_xchg() doesn't need to be IRQ-safe, like
this_cpu_xchg(), we can use a simple load-store instead of the cmpxchg
loop.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -407,9 +407,21 @@ do {									\
 #define raw_cpu_or_1(pcp, val)		percpu_to_op(, "or", (pcp), val)
 #define raw_cpu_or_2(pcp, val)		percpu_to_op(, "or", (pcp), val)
 #define raw_cpu_or_4(pcp, val)		percpu_to_op(, "or", (pcp), val)
-#define raw_cpu_xchg_1(pcp, val)	percpu_xchg_op(, pcp, val)
-#define raw_cpu_xchg_2(pcp, val)	percpu_xchg_op(, pcp, val)
-#define raw_cpu_xchg_4(pcp, val)	percpu_xchg_op(, pcp, val)
+
+/*
+ * raw_cpu_xchg() can use a load-store since it is not required to be
+ * IRQ-safe.
+ */
+#define raw_percpu_xchg_op(var, nval)					\
+({									\
+	typeof(var) pxo_ret__ = raw_cpu_read(var);			\
+	raw_cpu_write(var, (nval));					\
+	pxo_ret__;							\
+})
+
+#define raw_cpu_xchg_1(pcp, val)	raw_percpu_xchg_op(pcp, val)
+#define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
+#define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
 
 #define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
@@ -472,7 +484,7 @@ do {									\
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(, "and", (pcp), val)
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(, "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
-#define raw_cpu_xchg_8(pcp, nval)		percpu_xchg_op(, pcp, nval)
+#define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)


