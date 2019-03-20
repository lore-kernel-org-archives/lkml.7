Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEFFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D361D206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120940;
	bh=qbr+Bt+W4T0ZhYPaZqmpi0REwenCcR2B/2cl2884Ric=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hu9yGTy0gH/vqykfmgPMMPyEkHQbF6CLl4EltgZaES17JiJ8EdbnpizKjAwxQokGN
	 hVBoI7WTAxd5ehKZ+q1dLWEhJaNWq1foUO4rFwLpHos0gqlBM80umbw/w42suTaa5P
	 6LhaSxzkCq6x+Ml5zJWZBVWAZlEHuPo7zGYLS9bY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCTW3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:29:00 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39883 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfCTW26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:28:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id z191so3339196ywa.6;
        Wed, 20 Mar 2019 15:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7em68x27KVg9+yc6N9BqQ31VLJPqpShkJ9qkC4J32Y=;
        b=NtmmrQ3m8umoh52dsjo6xZFolBeJsI5ZE5l1hWpSYboTc7+IxZbFsBWY8bMHqEWIOA
         6MtY6xnzWcbguzHZERG0pVzSeF+N1BjlFPOq4pa8bfdbzKHXkMJwv1J6Xjovk9YeirDJ
         OSTL6fbWG/lRV4NdyC2GDgIufcjc7wbFGTNlfUD2Xc0FOho89frPD/+q9Vh6IhMWsXXT
         zMlaXY3hyJtZ+6O11XEln5wVAA51zZtzWErYoETvXBlCody5KNyHrq4Hu047Dxaz7skn
         57Tajcf5jjtlcPLY8lzkOPB9OOUBbTyaClJhqP/SKLKpdpT6XkORCzZ+zK4rQtq2ClyN
         xukg==
X-Gm-Message-State: APjAAAVXuXbm3Wi2A2/KGgdK5qbpy4e9LvcjUczwNPq9LZoXcmQ9NxXV
        6gK8mpcPTLINDCxoZYIK2B4=
X-Google-Smtp-Source: APXvYqy/mlD2puc8urYPUmdhhZXPc1hHSwMvCMLYYr7oSUYm3tkrry4r76PeMXDh5RzItfotl0gYiQ==
X-Received: by 2002:a81:9bc6:: with SMTP id s189mr417713ywg.431.1553120936434;
        Wed, 20 Mar 2019 15:28:56 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i126sm1102971ywa.29.2019.03.20.15.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:28:55 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Wed, 20 Mar 2019 22:28:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     sandeen@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/6] test_sysctl: allow graceful use on older kernels
Date:   Wed, 20 Mar 2019 22:28:29 +0000
Message-Id: <20190320222831.8243-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320222831.8243-1-mcgrof@kernel.org>
References: <20190320222831.8243-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On old kernels older new test knobs implemented on the test_sysctl
module may not be available. This is expected, and the selftests test
scripts should be able to run without failures on older kernels.

Generalize a solution so that we test for each required test target
file for each test by requiring each test description to annotate their
respective test target file. If the target file does not exist, we skip
the test gracefully.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 78 ++++++++++++++++--------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index f51987d0d32d..4eb019068e24 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -24,19 +24,20 @@ TEST_FILE=$(mktemp)
 
 # This represents
 #
-# TEST_ID:TEST_COUNT:ENABLED
+# TEST_ID:TEST_COUNT:ENABLED:TARGET
 #
 # TEST_ID: is the test id number
 # TEST_COUNT: number of times we should run the test
 # ENABLED: 1 if enabled, 0 otherwise
+# TARGET: test target file required on the test_sysctl module
 #
 # Once these are enabled please leave them as-is. Write your own test,
 # we have tons of space.
-ALL_TESTS="0001:1:1"
-ALL_TESTS="$ALL_TESTS 0002:1:1"
-ALL_TESTS="$ALL_TESTS 0003:1:1"
-ALL_TESTS="$ALL_TESTS 0004:1:1"
-ALL_TESTS="$ALL_TESTS 0005:3:1"
+ALL_TESTS="0001:1:1:int_0001"
+ALL_TESTS="$ALL_TESTS 0002:1:1:string_0001"
+ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002"
+ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
+ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
 
 test_modprobe()
 {
@@ -157,8 +158,10 @@ reset_vals()
 
 set_orig()
 {
-	if [ ! -z $TARGET ]; then
-		echo "${ORIG}" > "${TARGET}"
+	if [ ! -z $TARGET ] && [ ! -z $ORIG ]; then
+		if [ -f ${TARGET} ]; then
+			echo "${ORIG}" > "${TARGET}"
+		fi
 	fi
 }
 
@@ -600,9 +603,21 @@ run_stringtests()
 	test_rc
 }
 
+target_exists()
+{
+	TARGET="${SYSCTL}/$1"
+	TEST_ID="$2"
+
+	if [ ! -f ${TARGET} ] ; then
+		echo "Target for test $TEST_ID: $TARGET not exist, skipping test ..."
+		return 0
+	fi
+	return 1
+}
+
 sysctl_test_0001()
 {
-	TARGET="${SYSCTL}/int_0001"
+	TARGET="${SYSCTL}/$(get_test_target 0001)"
 	reset_vals
 	ORIG=$(cat "${TARGET}")
 	TEST_STR=$(( $ORIG + 1 ))
@@ -614,7 +629,7 @@ sysctl_test_0001()
 
 sysctl_test_0002()
 {
-	TARGET="${SYSCTL}/string_0001"
+	TARGET="${SYSCTL}/$(get_test_target 0002)"
 	reset_vals
 	ORIG=$(cat "${TARGET}")
 	TEST_STR="Testing sysctl"
@@ -627,7 +642,7 @@ sysctl_test_0002()
 
 sysctl_test_0003()
 {
-	TARGET="${SYSCTL}/int_0002"
+	TARGET="${SYSCTL}/$(get_test_target 0003)"
 	reset_vals
 	ORIG=$(cat "${TARGET}")
 	TEST_STR=$(( $ORIG + 1 ))
@@ -640,7 +655,7 @@ sysctl_test_0003()
 
 sysctl_test_0004()
 {
-	TARGET="${SYSCTL}/uint_0001"
+	TARGET="${SYSCTL}/$(get_test_target 0004)"
 	reset_vals
 	ORIG=$(cat "${TARGET}")
 	TEST_STR=$(( $ORIG + 1 ))
@@ -653,7 +668,7 @@ sysctl_test_0004()
 
 sysctl_test_0005()
 {
-	TARGET="${SYSCTL}/int_0003"
+	TARGET="${SYSCTL}/$(get_test_target 0005)"
 	reset_vals
 	ORIG=$(cat "${TARGET}")
 
@@ -722,25 +737,36 @@ function get_test_count()
 {
 	test_num $1
 	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
-	LAST_TWO=${TEST_DATA#*:*}
-	echo ${LAST_TWO%:*}
+	echo ${TEST_DATA} | awk -F":" '{print $2}'
 }
 
 function get_test_enabled()
 {
 	test_num $1
 	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
-	echo ${TEST_DATA#*:*:}
+	echo ${TEST_DATA} | awk -F":" '{print $3}'
+}
+
+function get_test_target()
+{
+	test_num $1
+	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	echo ${TEST_DATA} | awk -F":" '{print $4}'
 }
 
 function run_all_tests()
 {
 	for i in $ALL_TESTS ; do
-		TEST_ID=${i%:*:*}
+		TEST_ID=${i%:*:*:*}
 		ENABLED=$(get_test_enabled $TEST_ID)
 		TEST_COUNT=$(get_test_count $TEST_ID)
+		TEST_TARGET=$(get_test_target $TEST_ID)
+		target_exists $TEST_TARGET $TEST_ID
+		if [ $? -ne 1 ]; then
+			continue
+		fi
 		if [[ $ENABLED -eq "1" ]]; then
-			test_case $TEST_ID $TEST_COUNT
+			test_case $TEST_ID $TEST_COUNT $TEST_TARGET
 		fi
 	done
 }
@@ -773,12 +799,14 @@ function watch_case()
 
 function test_case()
 {
-	NUM_TESTS=$DEFAULT_NUM_TESTS
-	if [ $# -eq 2 ]; then
-		NUM_TESTS=$2
-	fi
+	NUM_TESTS=$2
 
 	i=0
+
+	if target_exists $3 $1; then
+		continue
+	fi
+
 	while [ $i -lt $NUM_TESTS ]; do
 		test_num $1
 		watch_log $i ${TEST_NAME}_test_$1 noclear
@@ -801,15 +829,15 @@ function parse_args()
 		elif [[ "$1" = "-t" ]]; then
 			shift
 			test_num $1
-			test_case $1 $(get_test_count $1)
+			test_case $1 $(get_test_count $1) $(get_test_target $1)
 		elif [[ "$1" = "-c" ]]; then
 			shift
 			test_num $1
 			test_num $2
-			test_case $1 $2
+			test_case $1 $2 $(get_test_target $1)
 		elif [[ "$1" = "-s" ]]; then
 			shift
-			test_case $1 1
+			test_case $1 1 $(get_test_target $1)
 		elif [[ "$1" = "-l" ]]; then
 			list_tests
 		elif [[ "$1" = "-h" || "$1" = "--help" ]]; then
-- 
2.18.0

