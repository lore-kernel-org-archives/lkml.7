Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F75C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A8C206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578525523;
	bh=q1ENe4lLdEVnjYZqJH1I18oDEtMqgJp+XWV9ZHBhBUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jRF7EeVvanOp+k/hfoo2W7YWpUbtamb5e7sX9MRpLvRM9rYUTmZcGpqKvnK42z8yL
	 +W4Fdtg9SHhH0bwskmbQzoekrXbui0awBHZ7E75NDCDdFbjg7L4QlEP3cwSOIFeh0O
	 3lY2OD9/Gj4hYyyNGBnjGSh5MapGXQAcLPo2k6Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgAHXSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgAHXSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:18:41 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEBB20692;
        Wed,  8 Jan 2020 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578525520;
        bh=q1ENe4lLdEVnjYZqJH1I18oDEtMqgJp+XWV9ZHBhBUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xRtKYFCRN3JZg9pKxw7k1COaZOH2oDBEouKYbCKb555D9DRFy2p8VMwZqTKDJyKpJ
         bp5nTDdhgYT9xRZtewxTb1vozXEmnuLYZ3ceotd9czbs1mVwQSpS7lH3E8UNhHukJJ
         Vmf+RQ2X691WtheRwbLZE7Zr8sMvAiAyy30MVtkI=
Date:   Wed, 8 Jan 2020 15:18:40 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a way to turn off ipu bio cache
Message-ID: <20200108231840.GB42219@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200107020709.73568-1-jaegeuk@kernel.org>
 <afddac87-b7c5-f68c-4e55-3705be311cf6@huawei.com>
 <20200108120444.GC28331@jaegeuk-macbookpro.roam.corp.google.com>
 <d5555fd8-736f-cc2f-1e57-d9ac01b3d012@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5555fd8-736f-cc2f-1e57-d9ac01b3d012@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08, Chao Yu wrote:
> On 2020/1/8 20:04, Jaegeuk Kim wrote:
> > On 01/08, Chao Yu wrote:
> >> On 2020/1/7 10:07, Jaegeuk Kim wrote:
> >>> Setting 0x40 in /sys/fs/f2fs/dev/ipu_policy gives a way to turn off
> >>> bio cache, which is useufl to check whether block layer using hardware
> >>> encryption engine merges IOs correctly.
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  Documentation/filesystems/f2fs.txt | 1 +
> >>>  fs/f2fs/segment.c                  | 2 +-
> >>>  fs/f2fs/segment.h                  | 1 +
> >>>  3 files changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> >>> index 41b5aa94b30f..cd93bcc34726 100644
> >>> --- a/Documentation/filesystems/f2fs.txt
> >>> +++ b/Documentation/filesystems/f2fs.txt
> >>> @@ -335,6 +335,7 @@ Files in /sys/fs/f2fs/<devname>
> >>>                                 0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
> >>>                                 0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
> >>>                                 0x10: F2FS_IPU_FSYNC.
> >>
> >> . -> ,
> > 
> > Actually, we can't do it. I revised it a bit instead.
> 
> One more question, why skipping 0x20 bit position?

It seems original patch missed to add comment.

From f9447095de55a3cda1023a37a5e1cb6dd2f54ebb Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 8 Jan 2020 15:10:02 -0800
Subject: [PATCH] f2fs: update f2fs document regarding to fsync_mode

This patch adds missing fsync_mode entry in f2fs document.

Fixes: 04485987f053 ("f2fs: introduce async IPU policy")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt | 3 ++-
 fs/f2fs/segment.h                  | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index b80a7b69f210..ee61ace30276 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -334,7 +334,8 @@ Files in /sys/fs/f2fs/<devname>
                               updates in f2fs. User can set:
                                0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
                                0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
-                               0x10: F2FS_IPU_FSYNC, 0x40: F2FS_IPU_NOCACHE.
+                               0x10: F2FS_IPU_FSYNC, 0x20: F2FS_IPU_ASYNC,
+                               0x40: F2FS_IPU_NOCACHE.
                               Refer segment.h for details.
 
  min_ipu_util                 This parameter controls the threshold to trigger
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5e6cd8d8411d..459dc3901a57 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -607,9 +607,10 @@ static inline int utilization(struct f2fs_sb_info *sbi)
  *                     threashold,
  * F2FS_IPU_FSYNC - activated in fsync path only for high performance flash
  *                     storages. IPU will be triggered only if the # of dirty
- *                     pages over min_fsync_blocks.
+ *                     pages over min_fsync_blocks. (=default option)
+ * F2FS_IPU_ASYNC - do IPU given by asynchronous write requests.
  * F2FS_IPU_NOCACHE - disable IPU bio cache.
- * F2FS_IPUT_DISABLE - disable IPU. (=default option)
+ * F2FS_IPUT_DISABLE - disable IPU. (=default option in LFS mode)
  */
 #define DEF_MIN_IPU_UTIL	70
 #define DEF_MIN_FSYNC_BLOCKS	8
-- 
2.24.0.525.g8f36a354ae-goog

