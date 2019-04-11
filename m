Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD5CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314C92075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccd6EU6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDKRAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:00:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfDKRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:00:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so8322878wro.5;
        Thu, 11 Apr 2019 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cbvlBAsgmPq0wjmomYJoGS+b4tJiSIC7oCGIAQBbd7c=;
        b=Ccd6EU6a5WjkuTHIFIyrlSdUhoW/I/CLfdyU535V3DX7bvrJB+JXDGNTN3mks4u0Gs
         J0RVh8jjYOw/HDIXcyD39mvYUwZ+E8Ug1YDPeOieh5EeZjnM1dZKyKG2Rq17a0Mz3wVy
         LibGy87EvYIY+hvUwXP5nfNDr+WQdvXIF5n99Vjx1Q/ItQXmJMdq1jxnuddiJSHr+nVB
         fXlUaNL1iO+/rlKERs56f+OtEPj73Vj4w+Y6dC2YYpOlMQowmK6Y/jYx9qHzifZScueN
         cqduKct7ujQ8g186ZtRFCSd5LcpDbcjkDLMoTGGJDTLD0gcgbsvOWPSnf7mlECFX7qWq
         ppJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cbvlBAsgmPq0wjmomYJoGS+b4tJiSIC7oCGIAQBbd7c=;
        b=XN69+ePlc2Oo9Kj9Wkkoah5lg+QcrWHrV9A4SC6Kb31/jbGAIyxUMQMqd42xHAWh3I
         ZFOJTmlrONHNFZVWUVSr88FC+WfxJijj3u3HxmsYGrquDjfTr7dzO/3i/tOvQVe4q3Ew
         ehVv52r+Dbw7kLCw/3zTvky0fP3zaVo5AdU9lBxFb0VyL6uLM4PeV/o0hhU1tyF8mZfe
         l+r+TMUJeXtSBo/HmcY5dnluwEcHjLplamV6KwZgYoTmsP7yzf7kvQCwWq442b5jgvQW
         PioAIv3u8JSkib9KhsBYN+RLfy81IRrLKkg6SN0pADYpYsCRHHofi8tx5J/FgdQs7+GE
         0VGQ==
X-Gm-Message-State: APjAAAXM9HG/+aj+aWMPcFijEeaG9UxDEHawSJuRPrVJsrydTULGAaYq
        LtdbyaHT3v7FDN1P4VXeMLc=
X-Google-Smtp-Source: APXvYqwrJROnJ32SBXYKya9JKylyFA28nM2YwSh7np6B+3CCVnWy3wfueDzSzw85ynI6Z5EBS5ckeQ==
X-Received: by 2002:adf:e4c2:: with SMTP id v2mr31414912wrm.124.1555002049706;
        Thu, 11 Apr 2019 10:00:49 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id r6sm5071353wmc.11.2019.04.11.10.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:00:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL writeback
Date:   Thu, 11 Apr 2019 20:00:42 +0300
Message-Id: <20190411170042.16111-1-amir73il@gmail.com>
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

Andrew,

Oops found a braino in my patch. Here is v3.

You may find the discussion on V1 here:
https://lore.kernel.org/lkml/20190409114922.30095-1-amir73il@gmail.com/

Thanks,
Amir.

Changes since v2:
- Return after filemap_write_and_wait_range()

Changes since v1:
- Remove non-guaranties of the API from commit message
- Added ACK by Jan

 fs/sync.c               | 24 +++++++++++++++++-------
 include/uapi/linux/fs.h |  3 +++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index b54e0541ad89..3a923652d720 100644
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
@@ -338,6 +341,13 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 
 	mapping = f.file->f_mapping;
 	ret = 0;
+	if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) ==
+		     SYNC_FILE_RANGE_WRITE_AND_WAIT) {
+		/* Unlike SYNC_FILE_RANGE_WRITE alone uses WB_SYNC_ALL */
+		ret = filemap_write_and_wait_range(mapping, offset, endbyte);
+		goto out_put;
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

