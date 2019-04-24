Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617A320652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1gqlytN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfDXHYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:24:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59322 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfDXHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5WzU65g6SCpuWFYbUKR9NUMbJ9BvbyfQ83X0rhVqoIY=; b=1gqlytN1Y1gMAd8xkReHJaX6yV
        pKo9uNJk2LwCjWJaTkqWuBBvNt4G/HSzTWCOMxbgNrrDOF+/VLQ6M5+9FKmG7lEvlZwOMZQbyp2Tg
        aFTcctJCzgmdAGUPOXBWjDj127xlb4fbc7NvvNN6E2GT7+R/9+AQYoDjdC4i7zxJrjzNa/CpcrIDu
        4Cck4ItDfmpyjQZV9fvkhjU57FBmCs7P7Yy5mQfQ68he+4AnqmzUcsYsvlpZhJ/CeIGENPV3w8Bhh
        0Sdw11I2xm760OOe80PEw8m1uhsSRj+llpymkyJDwptWwOqvZVx3oGJsZIoVQ+/9bkgC+vrQqZp7W
        i2i1KXjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJCGC-0000du-3T; Wed, 24 Apr 2019 07:24:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9229D29AC07B4; Wed, 24 Apr 2019 09:24:02 +0200 (CEST)
Message-Id: <20190424072208.754094071@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 09:19:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] mm/uaccess: Use unsigned long
References: <20190424071923.275371441@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy reported objtool triggered on his (GCC-7.4) build:

  lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x315: call to __ubsan_handle_add_overflow() with UACCESS enabled
  lib/strnlen_user.o: warning: objtool: strnlen_user()+0x337: call to __ubsan_handle_sub_overflow() with UACCESS enabled

This is due to UBSAN generating signed-overflow-UB warnings where it
should not. Prior to GCC-8 UBSAN ignored -fwrapv (which the kernel
uses through -fno-strict-overflow).

Make the functions use 'unsigned long' throughout.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/strncpy_from_user.c |    5 +++--
 lib/strnlen_user.c      |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -23,10 +23,11 @@
  * hit it), 'max' is the address space maximum (and we return
  * -EFAULT if we hit it).
  */
-static inline long do_strncpy_from_user(char *dst, const char __user *src, long count, unsigned long max)
+static inline long do_strncpy_from_user(char *dst, const char __user *src,
+					unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
-	long res = 0;
+	unsigned long res = 0;
 
 	/*
 	 * Truncate 'max' to the user-specified limit, so that
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -28,7 +28,7 @@
 static inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
-	long align, res = 0;
+	unsigned long align, res = 0;
 	unsigned long c;
 
 	/*
@@ -42,7 +42,7 @@ static inline long do_strnlen_user(const
 	 * Do everything aligned. But that means that we
 	 * need to also expand the maximum..
 	 */
-	align = (sizeof(long) - 1) & (unsigned long)src;
+	align = (sizeof(unsigned long) - 1) & (unsigned long)src;
 	src -= align;
 	max += align;
 


