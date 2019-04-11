Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C86C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC71A2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzUaWrS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDKLWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:22:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41614 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDKLWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:22:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so6803576wrq.8;
        Thu, 11 Apr 2019 04:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oB8WVm0U30VgaAgSIfIcoQ43KEp9ofOnz5AKOBoqL9Q=;
        b=dzUaWrS7cPOeBeEewgm4b4/7FkQjDR5/n28/v+0u0PZFtyYdg+MazGNykSuiKEVJQI
         uqjICHM8mso6HJ4t+kKsH7AHztuFbESqqTQtpJkWoIrZ9IGlE2Ehs59zPAo683F06F4/
         fuFu4Wd1ViQLaERA6aR+hCLq/SouttZt08mi8NAwBLD5JBRVoIXbSEOyLtDzF/UIN/mk
         bFUzq7ID1aiRzg9x/KiWpf6W5LY9KEou+IUeGoE0/EBRWqwX1jR4Ke6AGXRUiw6oQFLw
         NbQsVeulf31vsU3v+8qGy11s3+7qUn6M0ruTu58eOA9pYzOYcuZIXZcR6a6j3DPF9W1W
         UXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oB8WVm0U30VgaAgSIfIcoQ43KEp9ofOnz5AKOBoqL9Q=;
        b=Ga5PL8Kt1MAqaQ2+ZwzRBjo9xOeeiFyVEMjj9iFjWfxCnQlhUGGFfsM6UMJ71FedAh
         Yz/rLCe00JKUpGUVSmIThDErXxSnXzxciStv7a2YH55T/s5j+C7AIPTTmEBeZJJFCuSg
         3hKPJ2sze2d/jknzX6hg5nwezgLW6ToyMWk+ovO9HRgB2WCMk0swn/BPlH1oDFUUDxAt
         8IDf+7qK1ZFQlypW/HwjWlwap7Z3z3/8obVrXsIfcyIpDSwmkkNHxcvfdb/nx/EJHfPx
         Z0fLo189MZihQGc49jrwRYXAs//yvJOOL90r4I7oWEK4VoD3cWwJYs6xIICXCBEQyujz
         8T5g==
X-Gm-Message-State: APjAAAXphi8CaCsyQcTp1ThSKycHG5iav355IfrLw2WUTwyUPh1G8fK8
        ZaFo8G5oj5nDRATPIsm4rCSzyce9
X-Google-Smtp-Source: APXvYqztyzKtf+Ci2S9cRUMlUpdQD2ffSUboqKvZFrRpQOdyWaY2njO98vCPHKXsMAO/FtYvRCrW8Q==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr30183182wrv.296.1554981720409;
        Thu, 11 Apr 2019 04:22:00 -0700 (PDT)
Received: from localhost.localdomain (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s2sm5711931wmc.7.2019.04.11.04.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:21:59 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL writeback
Date:   Thu, 11 Apr 2019 14:21:52 +0300
Message-Id: <20190411112152.32151-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 23d0127096cb ("fs/sync.c: make sync_file_range(2) use WB_SYNC_NONE
writeback") claims that sync_file_range(2) syscall was "created for
userspace to be able to issue background writeout and so waiting for
in-flight IO is undesirable there" and changes the writeback (back) to
WB_SYNC_NONE.

This claim is only partially true. It is true for users that use the flag
SYNC_FILE_RANGE_WRITE by itself, as does PostgreSQL, the user that was
the reason for changing to WB_SYNC_NONE writeback.

However, that claim is not true for users that use that flag combination
SYNC_FILE_RANGE_{WAIT_BEFORE|WRITE|_WAIT_AFTER}.
Those users explicitly requested to wait for in-flight IO as well as to
writeback of dirty pages.

Re-brand that flag combination as SYNC_FILE_RANGE_WRITE_AND_WAIT
and use the helper filemap_write_and_wait_range(), that uses WB_SYNC_ALL
writeback, to perform the full range sync request.

Fixes: 23d0127096cb ("fs/sync.c: make sync_file_range(2) use WB_SYNC_NONE")
Acked-by: Jan Kara <jack@suse.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/sync.c               | 25 ++++++++++++++++++-------
 include/uapi/linux/fs.h |  3 +++
 2 files changed, 21 insertions(+), 7 deletions(-)

Andrew,

Since you were the one to merge Jan's patch that this Fixes,
I figured it would be best to send the fix through your tree.

You may find the discussion on V1 here:
https://lore.kernel.org/lkml/20190409114922.30095-1-amir73il@gmail.com/

Thanks,
Amir.

Changes since v1:
- Remove non-guaranties of the API from commit message
- Added ACK by Jan

diff --git a/fs/sync.c b/fs/sync.c
index b54e0541ad89..5cf6fdbae4de 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -18,8 +18,8 @@
 #include <linux/backing-dev.h>
 #include "internal.h"
 
-#define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
-			SYNC_FILE_RANGE_WAIT_AFTER)
+#define VALID_FLAGS (SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WRITE_AND_WAIT | \
+		     SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WAIT_AFTER)
 
 /*
  * Do the filesystem syncing work. For simple filesystems
@@ -235,9 +235,9 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
 }
 
 /*
- * sys_sync_file_range() permits finely controlled syncing over a segment of
+ * ksys_sync_file_range() permits finely controlled syncing over a segment of
  * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
- * zero then sys_sync_file_range() will operate from offset out to EOF.
+ * zero then ksys_sync_file_range() will operate from offset out to EOF.
  *
  * The flag bits are:
  *
@@ -254,7 +254,7 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
  * Useful combinations of the flag bits are:
  *
  * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE: ensures that all pages
- * in the range which were dirty on entry to sys_sync_file_range() are placed
+ * in the range which were dirty on entry to ksys_sync_file_range() are placed
  * under writeout.  This is a start-write-for-data-integrity operation.
  *
  * SYNC_FILE_RANGE_WRITE: start writeout of all dirty pages in the range which
@@ -266,10 +266,13 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
  * earlier SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE operation to wait
  * for that operation to complete and to return the result.
  *
- * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER:
+ * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER
+ * (a.k.a. SYNC_FILE_RANGE_WRITE_AND_WAIT):
  * a traditional sync() operation.  This is a write-for-data-integrity operation
  * which will ensure that all pages in the range which were dirty on entry to
- * sys_sync_file_range() are committed to disk.
+ * ksys_sync_file_range() are written to disk.  It should be noted that disk
+ * caches are not flushed by this call, so there are no guarantees here that the
+ * data will be available on disk after a crash.
  *
  *
  * SYNC_FILE_RANGE_WAIT_BEFORE and SYNC_FILE_RANGE_WAIT_AFTER will detect any
@@ -338,6 +341,14 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 
 	mapping = f.file->f_mapping;
 	ret = 0;
+	if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) ==
+		     SYNC_FILE_RANGE_WRITE_AND_WAIT) {
+		/* Unlike SYNC_FILE_RANGE_WRITE alone uses WB_SYNC_ALL */
+		ret = filemap_write_and_wait_range(mapping, offset, endbyte);
+		if (ret < 0)
+			goto out_put;
+	}
+
 	if (flags & SYNC_FILE_RANGE_WAIT_BEFORE) {
 		ret = file_fdatawait_range(f.file, offset, endbyte);
 		if (ret < 0)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 121e82ce296b..59c71fa8c553 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -320,6 +320,9 @@ struct fscrypt_key {
 #define SYNC_FILE_RANGE_WAIT_BEFORE	1
 #define SYNC_FILE_RANGE_WRITE		2
 #define SYNC_FILE_RANGE_WAIT_AFTER	4
+#define SYNC_FILE_RANGE_WRITE_AND_WAIT	(SYNC_FILE_RANGE_WRITE | \
+					 SYNC_FILE_RANGE_WAIT_BEFORE | \
+					 SYNC_FILE_RANGE_WAIT_AFTER)
 
 /*
  * Flags for preadv2/pwritev2:
-- 
2.17.1

