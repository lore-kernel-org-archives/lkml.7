Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28FCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAB52084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NhCqjev2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfDBW0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:26:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32789 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBW0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:26:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so7077120pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=elmvZmEkYTC6U+keL4nYfg5GaFomehZ93h8XSMMJlD4=;
        b=NhCqjev2U2aNHIElbzNZrW02GIEhnuZGFN18Hy4rHpvvJHaeiMbzWo4CNclkhuq1jF
         50l2gT5hz1NUqmfRW3+iAisSxf+VDyQh1IJJJ57IwX2GGtuUbvWu8ghpkJaJWZHNUyu1
         gSnAAUnKVlt4VvlXIhYUmKeIi/yM6gE+JptJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=elmvZmEkYTC6U+keL4nYfg5GaFomehZ93h8XSMMJlD4=;
        b=WtxAyDvDgglOGJq8fQGlBumO2fsodLAUuizs76DTvCvfiWTkqCR4EhF4FE07W51f86
         azy7kzVriCZEyTshLHecI0zWPTlXh+VnMGEhwPvf9/ULdkDJ3T/zH4QDzzmvwlBlvLEt
         dejvTLZRKGsnheb5EBAsREKrjeb60IN8O0zmrob6X0t2e8OQ8edsqOy1FwZk1rTMgPrc
         pXjnlXS+BZnprlDUBmffBX0clusl78nvy2X3C9uBtA5KJFswa08OfD4WcER9ZXWOYMOQ
         Q+Dh0QqS6BKmSv+5Y93K9i7nEVarPVPjSryr4rvUtkXiHb8J61accUZvtFbKLNzT3tqd
         BXTw==
X-Gm-Message-State: APjAAAVaI4DVY4cBrNz3SjzJSFXeUcwNm9dlzSD32Rkp8dI709SlIDyt
        t7Sy+bE1s4UF5bDUvmTSlwuNnA==
X-Google-Smtp-Source: APXvYqzQr7CEn3E+xqPJELWcw9r4GvSfz6BuX6LJXgsXtIS/tHsuUP1fNvL+LKZ6oabnP0xP59Uk2A==
X-Received: by 2002:a63:2f44:: with SMTP id v65mr68442585pgv.141.1554243972854;
        Tue, 02 Apr 2019 15:26:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r24sm1775549pfd.120.2019.04.02.15.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 15:26:11 -0700 (PDT)
Date:   Tue, 2 Apr 2019 15:26:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3.1] selftests: Clean up module testing shell script
Message-ID: <20190402222610.GA15100@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adjusts kselftest_module.sh to take an option "args" argument for
modprobe arguments, removes bash-isms (since some system's /bin/sh may
not be bash), and refactors the lib/ scripts into a shorter calling
convention.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is my suggested clean-up for the module testing script for the
strscpy_pad() series...
---
 tools/testing/selftests/kselftest_module.sh  | 24 ++++++++++++--------
 tools/testing/selftests/lib/bitmap.sh        | 17 +-------------
 tools/testing/selftests/lib/prime_numbers.sh | 17 ++------------
 tools/testing/selftests/lib/printf.sh        | 16 +------------
 tools/testing/selftests/lib/strscpy.sh       | 17 ++------------
 5 files changed, 20 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest_module.sh
index b5d446738614..20a897d21fde 100755
--- a/tools/testing/selftests/kselftest_module.sh
+++ b/tools/testing/selftests/kselftest_module.sh
@@ -2,19 +2,20 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 #
-# Runs an individual test module.  kselftest expects a separate
-# executable for each test.  So test should each have an individial
+# Runs an individual test module. kselftest expects a separate
+# executable for each test. So test should each have an individial
 # script that can call this script.
 #
 
 # Individual test scrits should define these:
 module=""			# filename (without the .ko).
 desc=""				# Output prefix.
+args=""				# modprobe arguments
 
 modprobe="/sbin/modprobe"
 
 main() {
-    parse_args $@
+    parse_args "$@"
     assert_root
     assert_have_module
     run_module
@@ -23,17 +24,20 @@ main() {
 parse_args() {
     script=${0##*/}
 
-    if [[ ! $# -eq 2 ]]; then
-	echo "Usage: $script <module_name> <description> [FAIL]"
+    if [ $# -lt 2 ]; then
+	echo "Usage: $script <description> <module_name> [FAIL]"
 	exit 1
     fi
 
-    module=$1
-    desc=$2
+    desc="$1"
+    shift || true
+    module="$1"
+    shift || true
+    args="$@"
 }
 
 assert_root() {
-    if [[ $EUID -ne 0 ]]; then
+    if [ ! -w /dev ]; then
 	skip "please run as root"
     fi
 }
@@ -45,7 +49,7 @@ assert_have_module() {
 }
 
 run_module() {
-    if $modprobe -q $module; then
+    if $modprobe -q $module $args; then
 	$modprobe -q -r $module
 	say "ok"
     else
@@ -72,4 +76,4 @@ skip() {
 #
 # Main script
 #
-main $@
+main "$@"
diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
index ed4180ea0021..5511dddc5c2d 100755
--- a/tools/testing/selftests/lib/bitmap.sh
+++ b/tools/testing/selftests/lib/bitmap.sh
@@ -1,18 +1,3 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-
-module=test_bitmap
-description="bitmap"
-
-#
-# Shouldn't need to edit anything below here.
-#
-
-file="kselftest_module.sh"
-path="../$file"
-if [[ ! $KBUILD_SRC == "" ]]; then
-    path="${KBUILD_SRC}/tools/testing/selftests/$file"
-fi
-
-$path $module $description
-
+$(dirname $0)/../kselftest_module.sh "bitmap" test_bitmap
diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
index 6f782386d897..2b6be0308a6d 100755
--- a/tools/testing/selftests/lib/prime_numbers.sh
+++ b/tools/testing/selftests/lib/prime_numbers.sh
@@ -1,18 +1,5 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Checks fast/slow prime_number generation for inconsistencies
-
-module=prime_numbers
-description="prime_numbers"
-
-#
-# Shouldn't need to edit anything below here.
-#
-
-file="kselftest_module.sh"
-path="../$file"
-if [[ ! $KBUILD_SRC == "" ]]; then
-    path="${KBUILD_SRC}/tools/testing/selftests/$file"
-fi
-
-$path $module $description
+$(dirname $0)/../kselftest_module.sh "prime numbers" prime_numbers \
+					selftest=65536
diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
index 89717915d028..2ffa61da0296 100755
--- a/tools/testing/selftests/lib/printf.sh
+++ b/tools/testing/selftests/lib/printf.sh
@@ -1,18 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Tests the printf infrastructure using test_printf kernel module.
-
-module=test_printf
-description="printf"
-
-#
-# Shouldn't need to edit anything below here.
-#
-
-file="kselftest_module.sh"
-path="../$file"
-if [[ ! $KBUILD_SRC == "" ]]; then
-    path="${KBUILD_SRC}/tools/testing/selftests/$file"
-fi
-
-$path $module $description
+$(dirname $0)/../kselftest_module.sh "printf" test_printf
diff --git a/tools/testing/selftests/lib/strscpy.sh b/tools/testing/selftests/lib/strscpy.sh
index f3ba4b90e602..1f26dac74896 100755
--- a/tools/testing/selftests/lib/strscpy.sh
+++ b/tools/testing/selftests/lib/strscpy.sh
@@ -1,17 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
-
-module=test_strscpy
-description="strscpy"
-
-#
-# Shouldn't need to edit anything below here.
-#
-
-file="kselftest_module.sh"
-path="../$file"
-if [[ ! $KBUILD_SRC == "" ]]; then
-    path="${KBUILD_SRC}/tools/testing/selftests/$file"
-fi
-
-$path $module $description
+# Test corner cases of the strscpy()-family of functions.
+$(dirname $0)/../kselftest_module.sh "strscpy" test_strscpy
-- 
2.17.1


-- 
Kees Cook
