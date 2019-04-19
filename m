Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DB0C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68798217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfDSWph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:45:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:45:35 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hHU8R-0005jD-5p
        for linux-kernel@vger.kernel.org; Fri, 19 Apr 2019 14:04:59 +0000
Received: by mail-pf1-f200.google.com with SMTP id f67so3555550pfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 07:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=lMAujf26FHR5J5s/vTp3XaTt+DwmocRMaUpglBlnuGA=;
        b=hzpZ+MWpXj8GkQd3xdTVKcVnPsszj3fl23XMaGDQhrWUgjZvHhdSey8Iw1YT/tWhnQ
         9TUVn7aqkqpbKvzH2Yjbq9p9RfK3w9oJogyDZKPNLGNB/zxddE4L2CZtxQiA8U4lyua5
         9KP+jeW0zN3JP4vt0ttsC0uzaUECgrUQbH6EWcK3e4UYZ6UcB0c0ySHgwjC+FRxcKvjP
         c9bRF80wJCL3K1tx5ZDeaY1jpmeqFlDVoY6KyTIZAQVoaAS4ILB3IPaxqHbneK7ioMI0
         5mgYFlOqL81MAtE46CUtRKkLKkG+MvYfI7Pj02FRehfD1lH2KLRA6DJsT/pYs2JlPljE
         ZgSA==
X-Gm-Message-State: APjAAAWozM+KboZO+50KPmAvly4Z+1z5xOoqJsRzMqgD1kv/KDi18hpQ
        5vmBxK3MSBnE2iK93vOYYjXXWrjcAIQQ4Jy+M3GGOK+V7Hvsu0jJV4bnMxHqy/Wta4RLXSDRFmi
        5pBkuz8N7S8j2jBwvP69zDWLz367qdeeblpcOHblu
X-Received: by 2002:a65:5286:: with SMTP id y6mr3958623pgp.79.1555682697485;
        Fri, 19 Apr 2019 07:04:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxua4yzSBhQWEDfBc/5SPy9AETjb+1xDyJ5Q5XBifmwqMVKhpPVzKtpdCopq6EmvY9AqmRfBg==
X-Received: by 2002:a65:5286:: with SMTP id y6mr3958574pgp.79.1555682696973;
        Fri, 19 Apr 2019 07:04:56 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id h16sm7642922pgj.85.2019.04.19.07.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 07:04:56 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     shuah@kernel.org, zhangxiaoxu5@huawei.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3] selftests/efivarfs: clean up test files from test_create*()
Date:   Fri, 19 Apr 2019 22:04:49 +0800
Message-Id: <20190419140449.31259-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test files created by test_create() and test_create_empty() tests will
stay in the $efivarfs_mount directory until the system was rebooted.

When the tester tries to run this efivarfs test again on the same
system, the immutable characteristics in that directory will cause some
"Operation not permitted" noises, and a false-positve test result as the
file was created in previous run.
    --------------------
    running test_create
    --------------------
    ./efivarfs.sh: line 59: /sys/firmware/efi/efivars/test_create-210be57c-9849-4fc7-a635-e6382d1aec27: Operation not permitted
      [PASS]
    --------------------
    running test_create_empty
    --------------------
    ./efivarfs.sh: line 78: /sys/firmware/efi/efivars/test_create_empty-210be57c-9849-4fc7-a635-e6382d1aec27: Operation not permitted
     [PASS]
    --------------------

Create a file_cleanup() to remove those test files in the end of each
test to solve this issue.

For the test_create_read, we can move the clean up task to the end of
the test to ensure the system is clean.

Also, use this function to replace the existing file removal code.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/efivarfs/efivarfs.sh | 32 +++++++++++-----------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index d386610..a90f394 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -7,6 +7,12 @@ test_guid=210be57c-9849-4fc7-a635-e6382d1aec27
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+file_cleanup()
+{
+	chattr -i $1
+	rm -f $1
+}
+
 check_prereqs()
 {
 	local msg="skip all tests:"
@@ -58,8 +64,10 @@ test_create()
 
 	if [ $(stat -c %s $file) -ne 5 ]; then
 		echo "$file has invalid size" >&2
+		file_cleanup $file
 		exit 1
 	fi
+	file_cleanup $file
 }
 
 test_create_empty()
@@ -72,16 +80,14 @@ test_create_empty()
 		echo "$file can not be created without writing" >&2
 		exit 1
 	fi
+	file_cleanup $file
 }
 
 test_create_read()
 {
 	local file=$efivarfs_mount/$FUNCNAME-$test_guid
-	if [ -f $file]; then
-		chattr -i $file
-		rm -rf $file
-	fi
 	./create-read $file
+	file_cleanup $file
 }
 
 test_delete()
@@ -96,11 +102,7 @@ test_delete()
 		exit 1
 	fi
 
-	rm $file 2>/dev/null
-	if [ $? -ne 0 ]; then
-		chattr -i $file
-		rm $file
-	fi
+	file_cleanup $file
 
 	if [ -e $file ]; then
 		echo "$file couldn't be deleted" >&2
@@ -154,11 +156,7 @@ test_valid_filenames()
 			echo "$file could not be created" >&2
 			ret=1
 		else
-			rm $file 2>/dev/null
-			if [ $? -ne 0 ]; then
-				chattr -i $file
-				rm $file
-			fi
+			file_cleanup $file
 		fi
 	done
 
@@ -191,11 +189,7 @@ test_invalid_filenames()
 
 		if [ -e $file ]; then
 			echo "Creating $file should have failed" >&2
-			rm $file 2>/dev/null
-			if [ $? -ne 0 ]; then
-				chattr -i $file
-				rm $file
-			fi
+			file_cleanup $file
 			ret=1
 		fi
 	done
-- 
2.7.4

