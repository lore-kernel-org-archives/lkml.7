Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A37AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B92218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120945;
	bh=wYSXsyW/EDrMwiE06TLliK4rbWDN1SpM+WbbMezan3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uug3IERObrTgrBdz4NyhF70zn2SAYWxWR4rtB7DPGsEByDNROifimZc0LE4Y4Fb+j
	 gHSuXgD2CetKqIlBgdr+hYAzczHvA/9RzvrRcDsgYAHv57kPdP4kSC4vwf32VWyYqN
	 mfcn4ySKsAQxJTBkO9FUPPMiTD8MhosvPQfSvgEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfCTW3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:29:04 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35556 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfCTW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:29:01 -0400
Received: by mail-yw1-f66.google.com with SMTP id d132so3364221ywa.2;
        Wed, 20 Mar 2019 15:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXLEDnmHDPhD+gAeHfoEQ/h6E/FKMiQK/iYleyKhCCg=;
        b=CUOTovZRb9aTz3mlJAiVVBkSPpfmd1D70JSrUqf0hJ6dUUxMcKL31D9i9bg20blEnP
         JBrsGGmYYaIVVbwMsOojRrlKrRva7yctMGAcSDCcgbuu8lW5a7u2gpmhZb2fZJFv5wD/
         PE5bAQrOqSEA+OGqBExqGW6DkNxAm7X96NyU8vdgnkVc+idlkOo9xGIbamlp8wpCRQ1I
         ySXNraZGBfLuPA58PTOqcpI1VIChLwM3IdVCV0nFLL4vYN+tiqm8nHF9/WY6OjvRCkHc
         flPIe/IIv5DFGFtmuUPZorp6Fw3+0OcVG+Yg0bMaNHF5dFUSb8kMu3npN5Ewx73p8LCq
         CqnA==
X-Gm-Message-State: APjAAAXxBrsGqSk4OW1PsspPgaEbCxq1/jEylmEYuYcnL71Cti6J8CpW
        BkSOr4BmVmoHs+Hymgpd7IpqWYOkMpI=
X-Google-Smtp-Source: APXvYqy2t64uvpm8RLDbiTH2OpkWwAEagDUms01DjKKGPh1uyIIO84hnnjp/IeafqLWANGwHlOFljw==
X-Received: by 2002:a25:9a41:: with SMTP id r1mr295370ybo.295.1553120940137;
        Wed, 20 Mar 2019 15:29:00 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r19sm1108210ywg.70.2019.03.20.15.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:28:58 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Wed, 20 Mar 2019 22:28:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     sandeen@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5/6] test_sysctl: add proc_do_large_bitmap() test case
Date:   Wed, 20 Mar 2019 22:28:30 +0000
Message-Id: <20190320222831.8243-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320222831.8243-1-mcgrof@kernel.org>
References: <20190320222831.8243-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@sandeen.net>

The kernel has only two users of proc_do_large_bitmap(), the kernel
CPU watchdog, and the ip_local_reserved_ports. Refer to watchdog_cpumask
and ip_local_reserved_ports in Documentation for further details on
these. When you input a large buffer into these, when it is larger than
PAGE_SIZE - 1, the input data gets misparsed, and the user get
incorrectly informed that the desired input value was set. This commit
implements a test which mimics and exploits that use case, it uses a
bitmap size, as in the watchdog case. The bitmap is used to test the
bitmap proc handler, proc_do_large_bitmap().

The next commit fixes this issue.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
[mcgrof: use new target description for backward compatibility]
[mcgrof: augment test number to 50, ran into issues with bash
         string comparisons when testing up to 50 cases.]
[mcgrof: introduce and use verify_diff_proc_file() to use diff]
[mcgrof: use mktemp for tmp file]
[mcgrof: merge shell test and C code]
[mcgrof: commit log love]
[mcgrof: export proc_do_large_bitmap() to allow for the test
[mcgrof: check for the return value when writing to the proc file]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/sysctl.c                          |  1 +
 lib/test_sysctl.c                        | 18 +++++-
 tools/testing/selftests/sysctl/sysctl.sh | 81 +++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b3df3ab7ac28..e1a8d785b839 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3263,6 +3263,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 	kfree(tmp_bitmap);
 	return err;
 }
+EXPORT_SYMBOL_GPL(proc_do_large_bitmap);
 
 #else /* CONFIG_PROC_SYSCTL */
 
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 3dd801c1c85b..566dad3f4196 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -47,6 +47,9 @@ struct test_sysctl_data {
 	unsigned int uint_0001;
 
 	char string_0001[65];
+
+#define SYSCTL_TEST_BITMAP_SIZE	65536
+	unsigned long *bitmap_0001;
 };
 
 static struct test_sysctl_data test_data = {
@@ -102,6 +105,13 @@ static struct ctl_table test_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dostring,
 	},
+	{
+		.procname	= "bitmap_0001",
+		.data		= &test_data.bitmap_0001,
+		.maxlen		= SYSCTL_TEST_BITMAP_SIZE,
+		.mode		= 0644,
+		.proc_handler	= proc_do_large_bitmap,
+	},
 	{ }
 };
 
@@ -129,15 +139,21 @@ static struct ctl_table_header *test_sysctl_header;
 
 static int __init test_sysctl_init(void)
 {
+	test_data.bitmap_0001 = kzalloc(SYSCTL_TEST_BITMAP_SIZE/8, GFP_KERNEL);
+	if (!test_data.bitmap_0001)
+		return -ENOMEM;
 	test_sysctl_header = register_sysctl_table(test_sysctl_root_table);
-	if (!test_sysctl_header)
+	if (!test_sysctl_header) {
+		kfree(test_data.bitmap_0001);
 		return -ENOMEM;
+	}
 	return 0;
 }
 late_initcall(test_sysctl_init);
 
 static void __exit test_sysctl_exit(void)
 {
+	kfree(test_data.bitmap_0001);
 	if (test_sysctl_header)
 		unregister_sysctl_table(test_sysctl_header);
 }
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 4eb019068e24..6a970b127c9b 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -38,6 +38,7 @@ ALL_TESTS="$ALL_TESTS 0002:1:1:string_0001"
 ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002"
 ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
 ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
+ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
 
 test_modprobe()
 {
@@ -150,6 +151,9 @@ reset_vals()
 		string_0001)
 			VAL="(none)"
 			;;
+		bitmap_0001)
+			VAL=""
+			;;
 		*)
 			;;
 	esac
@@ -180,6 +184,22 @@ verify()
 	return 0
 }
 
+# proc files get read a page at a time, which can confuse diff,
+# and get you incorrect results on proc files with long data. To use
+# diff against them you must first extract the output to a file, and
+# then compare against that file.
+verify_diff_proc_file()
+{
+	TMP_DUMP_FILE=$(mktemp)
+	cat $1 > $TMP_DUMP_FILE
+
+	if ! diff -w -q $TMP_DUMP_FILE $2; then
+		return 1
+	else
+		return 0
+	fi
+}
+
 verify_diff_w()
 {
 	echo "$TEST_STR" | diff -q -w -u - $1 > /dev/null
@@ -615,6 +635,55 @@ target_exists()
 	return 1
 }
 
+run_bitmaptest() {
+	# Total length of bitmaps string to use, a bit under
+	# the maximum input size of the test node
+	LENGTH=$((RANDOM % 65000))
+
+	# First bit to set
+	BIT=$((RANDOM % 1024))
+
+	# String containing our list of bits to set
+	TEST_STR=$BIT
+
+	# build up the string
+	while [ "${#TEST_STR}" -le "$LENGTH" ]; do
+		# Make sure next entry is discontiguous,
+		# skip ahead at least 2
+		BIT=$((BIT + $((2 + RANDOM % 10))))
+
+		# Add new bit to the list
+		TEST_STR="${TEST_STR},${BIT}"
+
+		# Randomly make it a range
+		if [ "$((RANDOM % 2))" -eq "1" ]; then
+			RANGE_END=$((BIT + $((1 + RANDOM % 10))))
+			TEST_STR="${TEST_STR}-${RANGE_END}"
+			BIT=$RANGE_END
+		fi
+	done
+
+	echo -n "Checking bitmap handler... "
+	TEST_FILE=$(mktemp)
+	echo -n "$TEST_STR" > $TEST_FILE
+
+	cat $TEST_FILE > $TARGET 2> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "FAIL" >&2
+		rc=1
+		test_rc
+	fi
+
+	if ! verify_diff_proc_file "$TARGET" "$TEST_FILE"; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "ok"
+		rc=0
+	fi
+	test_rc
+}
+
 sysctl_test_0001()
 {
 	TARGET="${SYSCTL}/$(get_test_target 0001)"
@@ -675,6 +744,14 @@ sysctl_test_0005()
 	run_limit_digit_int_array
 }
 
+sysctl_test_0006()
+{
+	TARGET="${SYSCTL}/bitmap_0001"
+	reset_vals
+	ORIG=""
+	run_bitmaptest
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -688,6 +765,7 @@ list_tests()
 	echo "0003 x $(get_test_count 0003) - tests proc_dointvec()"
 	echo "0004 x $(get_test_count 0004) - tests proc_douintvec()"
 	echo "0005 x $(get_test_count 0005) - tests proc_douintvec() array"
+	echo "0006 x $(get_test_count 0006) - tests proc_do_large_bitmap()"
 }
 
 usage()
@@ -761,8 +839,7 @@ function run_all_tests()
 		ENABLED=$(get_test_enabled $TEST_ID)
 		TEST_COUNT=$(get_test_count $TEST_ID)
 		TEST_TARGET=$(get_test_target $TEST_ID)
-		target_exists $TEST_TARGET $TEST_ID
-		if [ $? -ne 1 ]; then
+		if target_exists $TEST_TARGET $TEST_ID; then
 			continue
 		fi
 		if [[ $ENABLED -eq "1" ]]; then
-- 
2.18.0

