Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67887C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 00:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AC02187F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 00:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfGTADz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 20:03:55 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:21686 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbfGTADy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 20:03:54 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C762AA1050;
        Sat, 20 Jul 2019 02:03:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id GTv2JeZDgEMV; Sat, 20 Jul 2019 02:03:46 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH] kselftest: save-and-restore errno to allow for %m formatting
Date:   Sat, 20 Jul 2019 10:03:32 +1000
Message-Id: <20190720000332.4701-1-cyphar@cyphar.com>
In-Reply-To: <b32d95a1-8a49-65ef-4ddd-fe86a7ca01d5@kernel.org>
References: <b32d95a1-8a49-65ef-4ddd-fe86a7ca01d5@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, using "%m" in a ksft_* format string can result in strange
output because the errno value wasn't saved before calling other libc
functions. The solution is to simply save and restore the errno before
we format the user-supplied format string.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/kselftest.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index ec15c4f6af55..0ac49d91a260 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -10,6 +10,7 @@
 #ifndef __KSELFTEST_H
 #define __KSELFTEST_H
 
+#include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
@@ -81,58 +82,68 @@ static inline void ksft_print_cnts(void)
 
 static inline void ksft_print_msg(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	va_start(args, msg);
 	printf("# ");
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
 static inline void ksft_test_result_pass(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	ksft_cnt.ksft_pass++;
 
 	va_start(args, msg);
 	printf("ok %d ", ksft_test_num());
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
 static inline void ksft_test_result_fail(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	ksft_cnt.ksft_fail++;
 
 	va_start(args, msg);
 	printf("not ok %d ", ksft_test_num());
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
 static inline void ksft_test_result_skip(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	ksft_cnt.ksft_xskip++;
 
 	va_start(args, msg);
 	printf("not ok %d # SKIP ", ksft_test_num());
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
 static inline void ksft_test_result_error(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	ksft_cnt.ksft_error++;
 
 	va_start(args, msg);
 	printf("not ok %d # error ", ksft_test_num());
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
@@ -152,10 +163,12 @@ static inline int ksft_exit_fail(void)
 
 static inline int ksft_exit_fail_msg(const char *msg, ...)
 {
+	int saved_errno = errno;
 	va_list args;
 
 	va_start(args, msg);
 	printf("Bail out! ");
+	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 
@@ -178,10 +191,12 @@ static inline int ksft_exit_xpass(void)
 static inline int ksft_exit_skip(const char *msg, ...)
 {
 	if (msg) {
+		int saved_errno = errno;
 		va_list args;
 
 		va_start(args, msg);
 		printf("not ok %d # SKIP ", 1 + ksft_test_num());
+		errno = saved_errno;
 		vprintf(msg, args);
 		va_end(args);
 	} else {
-- 
2.22.0

