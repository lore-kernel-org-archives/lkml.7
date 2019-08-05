Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E912C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34353208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565020606;
	bh=AGR+k9EXaiKrUx8gMbAiV8cGPWwCuJdDKTpvhqDT+oE=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=PLlFk7wiF3ktfZF6UuFeAfwqy4UGRqw3vAnSDXjNIxQ/+YlqiUIylLScdayY81m4V
	 JrVRbI381Yd2CYGYQE8juxV1UT8vb37JwknHcdfd7NRlBdkUkZt4y8WNqy5oOlCQq7
	 TmOjFoT2yTL1q+5U/1U0vXsaEWtyMPM4qetbzGW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfHEP4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:56:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36050 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfHEP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:56:44 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so64752722iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=Ziw6mwSfqa9vsijLhPQQUYp+6JF6qRZa2WYbS0DsNbg=;
        b=UZgtrcS5LStTsP9sDGDF6wjA3ML6tWBvDJGhuaY64BQrjgxxcJOcxRqEQyN2yTkGbY
         K9mQ5+sbdf+N8Lku6/uJeaTUF9I3E+SXtOYTO5hxreQCU6zpGmreq055AHv9m76ugKPl
         iFEkWeioHvA2wnqKfHhOSLsTLDwdwxFxUCt80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=Ziw6mwSfqa9vsijLhPQQUYp+6JF6qRZa2WYbS0DsNbg=;
        b=B6INGDnfc4RMsK7+aWuLL3rNavqKJtBlgveVHIuxDpVzrX272Gi7wZ3IvP9y/9iyUT
         Vum6F2dqz/dWyxCST5uM+wKdfff+GFbEnt2jOsk+oganoWhOTS1qljId4UYM+MxqOaKi
         KDkLXchEKI8qKZe7k2sh5LpJRvFwtveUk9B3rxurY1KqiKhnNjlNGdegbxHHkdUnyPQw
         A79ZMBENTVwCwDZnY/fhRv9bjHK7UFW4wLBNT7Sp+8qN3ioEDEx2l0XoIo3JNEA4CQKN
         +aQ2Qcq0FSeJvIZ11z8OKoYXgSYCbdKOIbMZL5QwuQ3jj9uJUjBolqFTXdxISi7S8qa9
         05qQ==
X-Gm-Message-State: APjAAAWdcgqB+Go3j9tiKdhb156ufcnxVOt3SxJXSKdKVPMYcD2gflDR
        ReUbvCXekwbZTKzikymygIjtjg==
X-Google-Smtp-Source: APXvYqxvmGhfOfmlBmspNb6OVpCdZE/qp5Yzjo8FLhK1Kvsrpme8yzFNq8vK0NrGHRoZnqtA2Wijmg==
X-Received: by 2002:a02:c550:: with SMTP id g16mr23084896jaj.49.1565020603667;
        Mon, 05 Aug 2019 08:56:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i4sm106883456iog.31.2019.08.05.08.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 08:56:42 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com, Aleksa Sarai <cyphar@cyphar.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.3-rc4
Message-ID: <288074f1-9d9c-0795-9ec9-e0d78a5715a4@linuxfoundation.org>
Date:   Mon, 5 Aug 2019 09:56:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1476F0B6A8D2ED801A650C90"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1476F0B6A8D2ED801A650C90
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.3-rc4.

This Kselftest update for Linux 5.3-rc4 consists of fix to Kselftest
framework to save and restore errno and a fix to livepatch to push
and pop dynamic debug config.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 527d37e9e575bc0e9024de9b499385e7bb31f1ad:

   selftests/livepatch: add test skip handling (2019-07-24 14:17:46 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.3-rc4

for you to fetch changes up to fbb01c52471c8fb4ec2422c0ab26c134bd90bbff:

   selftests/livepatch: push and pop dynamic debug config (2019-07-30 
15:47:10 -0600)

----------------------------------------------------------------
linux-kselftest-5.3-rc4

This Kselftest update for Linux 5.3-rc4 consists of fix to Kselftest
framework to save and restore errno and a fix to livepatch to push
and pop dynamic debug config.

----------------------------------------------------------------
Aleksa Sarai (1):
       kselftest: save-and-restore errno to allow for %m formatting

Joe Lawrence (1):
       selftests/livepatch: push and pop dynamic debug config

  tools/testing/selftests/kselftest.h            | 15 +++++++++++++++
  tools/testing/selftests/livepatch/functions.sh | 26 
++++++++++++++++++++------
  2 files changed, 35 insertions(+), 6 deletions(-)

----------------------------------------------------------------

--------------1476F0B6A8D2ED801A650C90
Content-Type: text/x-patch;
 name="linux-kselftest-5.3-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.3-rc4.diff"

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
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index edcfeace4655..79b0affd21fb 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -29,13 +29,27 @@ function die() {
 	exit 1
 }
 
-# set_dynamic_debug() - setup kernel dynamic debug
-#	TODO - push and pop this config?
+function push_dynamic_debug() {
+        DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
+                awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
+}
+
+function pop_dynamic_debug() {
+	if [[ -n "$DYNAMIC_DEBUG" ]]; then
+		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
+	fi
+}
+
+# set_dynamic_debug() - save the current dynamic debug config and tweak
+# 			it for the self-tests.  Set a script exit trap
+#			that restores the original config.
 function set_dynamic_debug() {
-	cat << EOF > /sys/kernel/debug/dynamic_debug/control
-file kernel/livepatch/* +p
-func klp_try_switch_task -p
-EOF
+        push_dynamic_debug
+        trap pop_dynamic_debug EXIT INT TERM HUP
+        cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
+		file kernel/livepatch/* +p
+		func klp_try_switch_task -p
+		EOF
 }
 
 # loop_until(cmd) - loop a command until it is successful or $MAX_RETRIES,

--------------1476F0B6A8D2ED801A650C90--
