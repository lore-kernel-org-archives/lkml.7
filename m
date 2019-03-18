Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E8B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bztIGuVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfCRPw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:52:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfCRPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FTAGVNI6Hb9dNTT478wc/mzluBHW5BLlnleIPj09SRw=; b=bztIGuVlW8fPRovP4QQLyyfAGv
        V0/B/IZL+WxUPWkdiufPmKk2mUXJEdARLT2g30j0Zf5vtHRqXp0kKwwpUqV9D8CsX0CB/hICGogrl
        5pAZ6wgu94HMWjmtIvsav6nYy6ExMmIY4vuziXvfOk9wj19vlFw2JKwyLGVvh1SXBviiqlmIi42Fc
        x7lzNtDuJgiLvbbU3qBgNXwTPZQZNQprHOkbte0WXgPB3nRrz9qMQPVFKUi5xsTqX6dO+kZHg4DgK
        oMPFQ6S0HcsUmvffmMsicpen8wHX4dJq0npR6EJ+dVOQ+Ba/D1pzmXoN7QEjF+/9JZSNvWXrTQAk+
        TQpK17Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ9-0006mq-6M; Mon, 18 Mar 2019 15:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C5E9225E45D7A; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155141.189741167@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 14/25] x86/uaccess,ubsan: Fix UBSAN vs SMAP
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN can insert extra code in random locations; including AC=1
sections. Typically this code is not safe and needs wrapping.

So far, only __ubsan_handle_type_mismatch* have been observed in AC=1
sections and therefore only those are annotated.

Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Makefile |    1 +
 lib/ubsan.c  |    4 ++++
 2 files changed, 5 insertions(+)

--- a/lib/Makefile
+++ b/lib/Makefile
@@ -263,6 +263,7 @@ obj-$(CONFIG_UCS2_STRING) += ucs2_string
 obj-$(CONFIG_UBSAN) += ubsan.o
 
 UBSAN_SANITIZE_ubsan.o := n
+CFLAGS_ubsan.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
 
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/uaccess.h>
 
 #include "ubsan.h"
 
@@ -313,6 +314,7 @@ static void handle_object_size_mismatch(
 static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
 				unsigned long ptr)
 {
+	unsigned long flags = user_access_save();
 
 	if (!ptr)
 		handle_null_ptr_deref(data);
@@ -320,6 +322,8 @@ static void ubsan_type_mismatch_common(s
 		handle_misaligned_access(data, ptr);
 	else
 		handle_object_size_mismatch(data, ptr);
+
+	user_access_restore(flags);
 }
 
 void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,


