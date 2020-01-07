Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AC1C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF57D2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578362833;
	bh=YcE7t3XTXnWAd1OgFRbOFUYls33MgydieLk49V9wlMo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rCyRIqUWwdClC50JxdSksQF7fVXcBwgyZdq4/zDwEX6dgWxzaTWpBwn6/KRlXhjWS
	 qnyldET3Yoiwve5etPcVtCNf+bs+tCfhKIH63I5ru8xlfqRGeISnLIGZmiP7gtYdaO
	 C+y4PoA2J/FAX3/GWVL6BBb9ZtFB7KNT+rC5Y8Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgAGCHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgAGCHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:07:11 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3698220715;
        Tue,  7 Jan 2020 02:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578362831;
        bh=YcE7t3XTXnWAd1OgFRbOFUYls33MgydieLk49V9wlMo=;
        h=From:To:Cc:Subject:Date:From;
        b=vezTOWd0ixvoWWuFn6wO4gzSDKGJRXQvt1n2BqRAjS8PVfRmy0K8SnTvPzk9CaTXw
         xQza6b7eSgZWexdMy5yb6m1KH7ZsjPIN6ljLDCOcDSjIzMuxtJWXNew12Bh3xusjbO
         fooTSb3l4VsR17zcbyftv/q16FxjU+TEDedPzOjY=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add a way to turn off ipu bio cache
Date:   Mon,  6 Jan 2020 18:07:09 -0800
Message-Id: <20200107020709.73568-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting 0x40 in /sys/fs/f2fs/dev/ipu_policy gives a way to turn off
bio cache, which is useufl to check whether block layer using hardware
encryption engine merges IOs correctly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt | 1 +
 fs/f2fs/segment.c                  | 2 +-
 fs/f2fs/segment.h                  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 41b5aa94b30f..cd93bcc34726 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -335,6 +335,7 @@ Files in /sys/fs/f2fs/<devname>
                                0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
                                0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
                                0x10: F2FS_IPU_FSYNC.
+			       0x40: F2FS_IPU_NOCACHE disables bio caches.
 
  min_ipu_util                 This parameter controls the threshold to trigger
                               in-place-updates. The number indicates percentage
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a9519532c029..311fe4937f6a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3289,7 +3289,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 
 	stat_inc_inplace_blocks(fio->sbi);
 
-	if (fio->bio)
+	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 << F2FS_IPU_NOCACHE)))
 		err = f2fs_merge_page_bio(fio);
 	else
 		err = f2fs_submit_page_bio(fio);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index a1b3951367cd..02e620470eef 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -623,6 +623,7 @@ enum {
 	F2FS_IPU_SSR_UTIL,
 	F2FS_IPU_FSYNC,
 	F2FS_IPU_ASYNC,
+	F2FS_IPU_NOCACHE,
 };
 
 static inline unsigned int curseg_segno(struct f2fs_sb_info *sbi,
-- 
2.24.0.525.g8f36a354ae-goog

