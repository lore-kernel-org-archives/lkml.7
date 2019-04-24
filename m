Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F8CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25D0218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KnPdEYYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfDXLLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:11:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39095 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfDXLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:11:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3OBAnuK2549222
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 04:10:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3OBAnuK2549222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556104250;
        bh=kEkNYGlUhakZs8n0q/McYq5CzPWzvB1DFG7c1OBFs8Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KnPdEYYj2kN8UuIJI7D2TwANd8+u008SABHpNLnCbHp+WaExOferrFhQqOS4nFbjy
         qjlaCGKImWatkbJQuswrzlzJEOtsE6i1jd0/uuafjdDqn0O2sw9K8daBl740z5gmhS
         +iEBkqvBRexmymGLHH5F4ZmnMfFTmXTq9zmihXkamVMsvdFq+bwMsT/l/EYQUH+s92
         DLxWu5csj3kt83N3blpPZbFpJfI261LTuC1UZqO3SsEjeY5NiSf+V3B6RYKpg8vrTg
         2FbvkRbWEDViGL1HlJCbTI/w3djNi1j3/glLvzz2ZZfLCjvP3iFHMOIN9R4ddPBYik
         nrVGQf4Szh00A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3OBAnYS2549216;
        Wed, 24 Apr 2019 04:10:49 -0700
Date:   Wed, 24 Apr 2019 04:10:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-29da93fea3ea39ab9b12270cc6be1b70ef201c9e@git.kernel.org>
Cc:     rdunlap@infradead.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          rdunlap@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190424072208.754094071@infradead.org>
References: <20190424072208.754094071@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/objtool] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings on older GCC versions
Git-Commit-ID: 29da93fea3ea39ab9b12270cc6be1b70ef201c9e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  29da93fea3ea39ab9b12270cc6be1b70ef201c9e
Gitweb:     https://git.kernel.org/tip/29da93fea3ea39ab9b12270cc6be1b70ef201c9e
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 24 Apr 2019 09:19:25 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 24 Apr 2019 12:19:45 +0200

mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions

Randy reported objtool triggered on his (GCC-7.4) build:

  lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x315: call to __ubsan_handle_add_overflow() with UACCESS enabled
  lib/strnlen_user.o: warning: objtool: strnlen_user()+0x337: call to __ubsan_handle_sub_overflow() with UACCESS enabled

This is due to UBSAN generating signed-overflow-UB warnings where it
should not. Prior to GCC-8 UBSAN ignored -fwrapv (which the kernel
uses through -fno-strict-overflow).

Make the functions use 'unsigned long' throughout.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@kernel.org
Link: http://lkml.kernel.org/r/20190424072208.754094071@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/strncpy_from_user.c | 5 +++--
 lib/strnlen_user.c      | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 58eacd41526c..023ba9f3b99f 100644
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
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 1c1a1b0e38a5..7f2db3fe311f 100644
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
@@ -42,7 +42,7 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
 	 * Do everything aligned. But that means that we
 	 * need to also expand the maximum..
 	 */
-	align = (sizeof(long) - 1) & (unsigned long)src;
+	align = (sizeof(unsigned long) - 1) & (unsigned long)src;
 	src -= align;
 	max += align;
 
