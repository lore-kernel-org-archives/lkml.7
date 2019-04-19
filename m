Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B2C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF63217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfDSWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:45:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfDSWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:45:45 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hHTLB-0000lR-Gq
        for linux-kernel@vger.kernel.org; Fri, 19 Apr 2019 13:14:05 +0000
Received: by mail-pl1-f198.google.com with SMTP id cs14so3497866plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 06:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=SPiOATHkrMMnUx67pKh21vyf1b7lB56BAZR8qeSPr7E=;
        b=mdO9xAFgX9jtNHc9OTQ/5OCl1VGd0R6dsbo9q1qI8PRoXMeBXaYPr7cYfDzaSzgl18
         q/XNVDt7O5LnLDnm3rOcfbQKUQdEhP30fVgarkpKo4ne6c0nSb3DWO4cuoWfsLSOdnsE
         QZdzW78l+z+omlCI1VTnWzK5Sz2eO4r3II5Wb6btx6i9VhSQb2bFs/Jlvtdw+1C/n91r
         tUz++H9ZxIqFyWtf8AZ/O33FZkcRgfBgSGtUNch5uXxlm0tFUUpbx9GDL0aSKQfVmZJg
         DPBBd2uuln+f++UvU+3yz/ND4cEBzJvVs8ByJEEJBp6NCcZ3AAYvzZaqMfbkiwLXCecT
         wNjw==
X-Gm-Message-State: APjAAAWApA3d6sDncO7mlInvG85h8rdW7HowCJ8boJU3S4FUsI18lUyk
        PRYZF8RmuFIPuzt5lU3cngN1VZqcG+km80vRiV+8TtH6CldatvFY9VeWflAJJvaFVWL2gv2sS+U
        yAHisDVI8AIXz8Eh5YFfm373i22xq7js3ApOMisar
X-Received: by 2002:a63:1912:: with SMTP id z18mr3890616pgl.115.1555679644254;
        Fri, 19 Apr 2019 06:14:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0GB1M0HDFDfBEMng3VKh+Pd3BpUBRp9OQy3Bw54Nv4FcicRc9vmal37gajDA2/ACmFMIGZw==
X-Received: by 2002:a63:1912:: with SMTP id z18mr3890595pgl.115.1555679644005;
        Fri, 19 Apr 2019 06:14:04 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id 6sm7112758pfp.143.2019.04.19.06.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 06:14:02 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2] selftests/efivarfs: clean up test files from test_create*()
Date:   Fri, 19 Apr 2019 21:12:21 +0800
Message-Id: <20190419131221.28297-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test files created by test_create*() tests will stay in the
$efivarfs_mount directory unless the system was rebooted.

When the tester tries to run this efivarfs test again on the same
system, the immutable characteristics in that directory will cause some
"Operation not permitted" noises and a false-positve test result to the
test_create_read() test.

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
    running test_create_read
    --------------------
    open(O_WRONLY): Operation not permitted
     [FAIL]
    --------------------

Create a file_cleanup() to remove those test files in the end of each
test to solve this issue.

Also, use this function to replace the existing file removal code.

Link: https://bugs.launchpad.net/bugs/1809704

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/efivarfs/efivarfs.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
 mode change 100755 => 100644 tools/testing/selftests/efivarfs/efivarfs.sh

diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
old mode 100755
new mode 100644
index a47029a..14fa6fe
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -7,6 +7,12 @@ test_guid=210be57c-9849-4fc7-a635-e6382d1aec27
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+file_cleanup()
+{
+	chattr -i $1
+	rm $1
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
@@ -72,12 +80,14 @@ test_create_empty()
 		echo "$file can not be created without writing" >&2
 		exit 1
 	fi
+	file_cleanup $file
 }
 
 test_create_read()
 {
 	local file=$efivarfs_mount/$FUNCNAME-$test_guid
 	./create-read $file
+	file_cleanup $file
 }
 
 test_delete()
@@ -94,8 +104,7 @@ test_delete()
 
 	rm $file 2>/dev/null
 	if [ $? -ne 0 ]; then
-		chattr -i $file
-		rm $file
+		file_cleanup $file
 	fi
 
 	if [ -e $file ]; then
@@ -152,8 +161,7 @@ test_valid_filenames()
 		else
 			rm $file 2>/dev/null
 			if [ $? -ne 0 ]; then
-				chattr -i $file
-				rm $file
+				file_cleanup $file
 			fi
 		fi
 	done
@@ -189,8 +197,7 @@ test_invalid_filenames()
 			echo "Creating $file should have failed" >&2
 			rm $file 2>/dev/null
 			if [ $? -ne 0 ]; then
-				chattr -i $file
-				rm $file
+				file_cleanup $file
 			fi
 			ret=1
 		fi
-- 
2.7.4

