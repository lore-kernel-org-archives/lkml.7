Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD54CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AB020659
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHuS14uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbfJWVsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:48:46 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39002 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbfJWVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:48:46 -0400
Received: by mail-qk1-f202.google.com with SMTP id s3so21470098qkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rte1LI7gsEnCpLsjKUPN6sEToMW8HVqJ6tMkdqjGPvE=;
        b=SHuS14uZQY4CXL776ZVo2zPZBOmK+K6z6XBilMfLb/8ACGUNO2VwiIQZ30EvKskx3a
         oTxt8Z4otQMlpahbHgwEXJMtp9iGIobg+4vie+FLqlcW0mwM6KHYyiOKrOMaAhmHsrMs
         O1jntQIgmtK1zBHIaBrD9fgMjbbUa5QXlnkaH7E4kcxKVUeLf2LEOyB30HvtJSJbxM6y
         d3XVw7o5gEalgH+tTHS839WIoNYS7a/FGiT/jPdZ+o2+t3S4IHfFJsIiGzfbY7S9q3WI
         //syA4qb3rOTMOCG+gHQQvKY4U9pb0d3idH8gL5hPMUlS7T5r2hBGKmJ+MNwxqmzrQGd
         hcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rte1LI7gsEnCpLsjKUPN6sEToMW8HVqJ6tMkdqjGPvE=;
        b=BLUZOFQ8s1U1lYLswZP0hB7QMVM4rXZmmAUFK5dwsIDXsiJgogtjd2/ttBPrYTRjY3
         vUREasJU16rCfhpB7zYqfliTS2pakqfLGC07nJcKPLfMlUAYoK+3TDTeVjr3iZwo2cQK
         KX9VaN1Ptq0EEGvuowAnidU3rZ7+XaDFmK9mNM9YTOxoyUS6Qq3zUQPflLKMhtnu4l1o
         8Ccg2VoPWgwTnv+FMrV9f3kHS5nhJq7ciiMCLRvXQNnmJgY+iWEgNXiEVzM+KzKH+wEF
         gBTWC3/NGvxAhFxNZQ4+2UfkE2JKkhHWqtd/6uMAiS9BttAQAzld/O+eE1nzBrZxw/P0
         /Liw==
X-Gm-Message-State: APjAAAUw5cQGBGXdxR2aAm2grr4drgIBDv1PzzL+I/HuvuG2s5/gNtp1
        Y0fGgO2TkZgWwYxvSKH/gletrZkaOBM=
X-Google-Smtp-Source: APXvYqzcj/zRpuxYjj19U9tEuR1/HwVQMlgihmfoe8Bozg02yFq4Y5lj+Q81DnmEdw1EvJM8hok5szU0Ojo=
X-Received: by 2002:a37:66d4:: with SMTP id a203mr11204342qkc.369.1571867324106;
 Wed, 23 Oct 2019 14:48:44 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:48:19 -0700
Message-Id: <20191023214821.107615-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 1/2] f2fs: delete duplicate information on sysfs nodes
From:   Hridya Valsaraju <hridya@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges the sysfs node documentation present in
Documentation/filesystems/f2fs.txt and
Documentation/ABI/testing/sysfs-fs-f2fs
and deletes the duplicate information from
Documentation/filesystems/f2fs.txt. This is to prevent having to update
both files when a new sysfs node is added for f2fs.
The patch also makes minor formatting changes to
Documentation/ABI/testing/sysfs-fs-f2fs.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 220 ++++++++++++------------
 Documentation/filesystems/f2fs.txt      | 163 +-----------------
 2 files changed, 113 insertions(+), 270 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index dca326e0ee3e..8f79a9acefcf 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1,253 +1,255 @@
 What:		/sys/fs/f2fs/<disk>/gc_max_sleep_time
 Date:		July 2013
 Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
-Description:
-		 Controls the maximun sleep time for gc_thread. Time
-		 is in milliseconds.
+Description:	Controls the maximum sleep time for gc_thread. Time
+		is in milliseconds.
 
 What:		/sys/fs/f2fs/<disk>/gc_min_sleep_time
 Date:		July 2013
 Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
-Description:
-		 Controls the minimum sleep time for gc_thread. Time
-		 is in milliseconds.
+Description:	Controls the minimum sleep time for gc_thread. Time
+		is in milliseconds.
 
 What:		/sys/fs/f2fs/<disk>/gc_no_gc_sleep_time
 Date:		July 2013
 Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
-Description:
-		 Controls the default sleep time for gc_thread. Time
-		 is in milliseconds.
+Description:	Controls the default sleep time for gc_thread. Time
+		is in milliseconds.
 
 What:		/sys/fs/f2fs/<disk>/gc_idle
 Date:		July 2013
 Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
-Description:
-		 Controls the victim selection policy for garbage collection.
+Description:	Controls the victim selection policy for garbage collection.
+		Setting gc_idle = 0(default) will disable this option. Setting
+		gc_idle = 1 will select the Cost Benefit approach & setting
+		gc_idle = 2 will select the greedy approach.
 
 What:		/sys/fs/f2fs/<disk>/reclaim_segments
 Date:		October 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
-Description:
-		 Controls the issue rate of segment discard commands.
+Description:	This parameter controls the number of prefree segments to be
+		reclaimed. If the number of prefree segments is larger than
+		the number of segments in the proportion to the percentage
+		over total volume size, f2fs tries to conduct checkpoint to
+		reclaim the prefree segments to free segments.
+		By default, 5% over total # of segments.
 
 What:		/sys/fs/f2fs/<disk>/ipu_policy
 Date:		November 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
-Description:
-		 Controls the in-place-update policy.
+Description:	Controls the in-place-update policy.
+		There are five policies:
+		0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
+		0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
+		0x10: F2FS_IPU_FSYNC.
 
 What:		/sys/fs/f2fs/<disk>/min_ipu_util
 Date:		November 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
-Description:
-		 Controls the FS utilization condition for the in-place-update
-		 policies.
+Description:	Controls the FS utilization condition for the in-place-update
+		policies. It is used by F2FS_IPU_UTIL and F2FS_IPU_SSR_UTIL policies.
 
 What:		/sys/fs/f2fs/<disk>/min_fsync_blocks
 Date:		September 2014
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Controls the dirty page count condition for the in-place-update
-		 policies.
+Description:	Controls the dirty page count condition for the in-place-update
+		policies.
 
 What:		/sys/fs/f2fs/<disk>/min_seq_blocks
 Date:		August 2018
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Controls the dirty page count condition for batched sequential
-		 writes in ->writepages.
-
+Description:	Controls the dirty page count condition for batched sequential
+		writes in writepages.
 
 What:		/sys/fs/f2fs/<disk>/min_hot_blocks
 Date:		March 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Controls the dirty page count condition for redefining hot data.
+Description:	Controls the dirty page count condition for redefining hot data.
 
 What:		/sys/fs/f2fs/<disk>/min_ssr_sections
 Date:		October 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Description:
-		 Controls the fee section threshold to trigger SSR allocation.
+Description:	Controls the free section threshold to trigger SSR allocation.
+		If this is large, SSR mode will be enabled early.
 
 What:		/sys/fs/f2fs/<disk>/max_small_discards
 Date:		November 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
-Description:
-		 Controls the issue rate of small discard commands.
-
-What:          /sys/fs/f2fs/<disk>/discard_granularity
-Date:          July 2017
-Contact:       "Chao Yu" <yuchao0@huawei.com>
-Description:
-		Controls discard granularity of inner discard thread, inner thread
+Description:	Controls the issue rate of discard commands that consist of small
+		blocks less than 2MB. The candidates to be discarded are cached until
+		checkpoint is triggered, and issued during the checkpoint.
+		By default, it is disabled with 0.
+
+What:		/sys/fs/f2fs/<disk>/discard_granularity
+Date:		July 2017
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:	Controls discard granularity of inner discard thread. Inner thread
 		will not issue discards with size that is smaller than granularity.
-		The unit size is one block, now only support configuring in range
-		of [1, 512].
+		The unit size is one block(4KB), now only support configuring
+		in range of [1, 512]. Default value is 4(=16KB).
 
-What:          /sys/fs/f2fs/<disk>/umount_discard_timeout
-Date:          January 2019
-Contact:       "Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		Set timeout to issue discard commands during umount.
-		Default: 5 secs
+What:		/sys/fs/f2fs/<disk>/umount_discard_timeout
+Date:		January 2019
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Set timeout to issue discard commands during umount.
+	        Default: 5 secs
 
 What:		/sys/fs/f2fs/<disk>/max_victim_search
 Date:		January 2014
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
-Description:
-		 Controls the number of trials to find a victim segment.
+Description:	Controls the number of trials to find a victim segment
+		when conducting SSR and cleaning operations. The default value
+		is 4096 which covers 8GB block address range.
 
 What:		/sys/fs/f2fs/<disk>/migration_granularity
 Date:		October 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Description:
-		 Controls migration granularity of garbage collection on large
-		 section, it can let GC move partial segment{s} of one section
-		 in one GC cycle, so that dispersing heavy overhead GC to
-		 multiple lightweight one.
+Description:	Controls migration granularity of garbage collection on large
+		section, it can let GC move partial segment{s} of one section
+		in one GC cycle, so that dispersing heavy overhead GC to
+		multiple lightweight one.
 
 What:		/sys/fs/f2fs/<disk>/dir_level
 Date:		March 2014
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
-Description:
-		 Controls the directory level for large directory.
+Description:	Controls the directory level for large directory. If a
+		directory has a number of files, it can reduce the file lookup
+		latency by increasing this dir_level value. Otherwise, it
+		needs to decrease this value to reduce the space overhead.
+		The default value is 0.
 
 What:		/sys/fs/f2fs/<disk>/ram_thresh
 Date:		March 2014
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
-Description:
-		 Controls the memory footprint used by f2fs.
+Description:	Controls the memory footprint used by free nids and cached
+		nat entries. By default, 10 is set, which indicates
+		10 MB / 1 GB RAM.
 
 What:		/sys/fs/f2fs/<disk>/batched_trim_sections
 Date:		February 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Controls the trimming rate in batch mode.
-		 <deprecated>
+Description:	Controls the trimming rate in batch mode.
+		<deprecated>
 
 What:		/sys/fs/f2fs/<disk>/cp_interval
 Date:		October 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Controls the checkpoint timing.
+Description:	Controls the checkpoint timing, set to 60 seconds by default.
 
 What:		/sys/fs/f2fs/<disk>/idle_interval
 Date:		January 2016
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Controls the idle timing for all paths other than
-		 discard and gc path.
+Description:	Controls the idle timing for all paths other than
+		discard and gc path. Set to 5 seconds by default.
 
 What:		/sys/fs/f2fs/<disk>/discard_idle_interval
 Date:		September 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
-Description:
-		 Controls the idle timing for discard path.
+Description:	Controls the idle timing for discard path.
 
 What:		/sys/fs/f2fs/<disk>/gc_idle_interval
 Date:		September 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
-Description:
-		 Controls the idle timing for gc path.
+Description:    Controls the idle timing for gc path. Set to 5 seconds by default.
 
 What:		/sys/fs/f2fs/<disk>/iostat_enable
 Date:		August 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Description:
-		 Controls to enable/disable IO stat.
+Description:	Controls to enable/disable IO stat.
 
 What:		/sys/fs/f2fs/<disk>/ra_nid_pages
 Date:		October 2015
 Contact:	"Chao Yu" <chao2.yu@samsung.com>
-Description:
-		 Controls the count of nid pages to be readaheaded.
+Description:	Controls the count of nid pages to be readaheaded.
+		When building free nids, F2FS reads NAT blocks ahead for
+		speed up. Default is 0.
 
 What:		/sys/fs/f2fs/<disk>/dirty_nats_ratio
 Date:		January 2016
 Contact:	"Chao Yu" <chao2.yu@samsung.com>
-Description:
-		 Controls dirty nat entries ratio threshold, if current
-		 ratio exceeds configured threshold, checkpoint will
-		 be triggered for flushing dirty nat entries.
+Description:	Controls dirty nat entries ratio threshold, if current
+		ratio exceeds configured threshold, checkpoint will
+		be triggered for flushing dirty nat entries.
 
 What:		/sys/fs/f2fs/<disk>/lifetime_write_kbytes
 Date:		January 2016
 Contact:	"Shuoran Liu" <liushuoran@huawei.com>
-Description:
-		 Shows total written kbytes issued to disk.
+Description:	Shows total written kbytes issued to disk.
 
 What:		/sys/fs/f2fs/<disk>/features
 Date:		July 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Shows all enabled features in current device.
+Description:	Shows all enabled features in current device.
 
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
 Contact:	"Sheng Yong" <shengyong1@huawei.com>
-Description:
-		 Controls the injection rate.
+Description:	Controls the injection rate of arbitrary faults.
 
 What:		/sys/fs/f2fs/<disk>/inject_type
 Date:		May 2016
 Contact:	"Sheng Yong" <shengyong1@huawei.com>
-Description:
-		 Controls the injection type.
+Description:	Controls the injection type of arbitrary faults.
+
+What:		/sys/fs/f2fs/<disk>/dirty_segments
+Date:		October 2017
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Shows the number of dirty segments.
 
 What:		/sys/fs/f2fs/<disk>/reserved_blocks
 Date:		June 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Description:
-		 Controls target reserved blocks in system, the threshold
-		 is soft, it could exceed current available user space.
+Description:	Controls target reserved blocks in system, the threshold
+		is soft, it could exceed current available user space.
 
 What:		/sys/fs/f2fs/<disk>/current_reserved_blocks
 Date:		October 2017
 Contact:	"Yunlong Song" <yunlong.song@huawei.com>
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Description:
-		 Shows current reserved blocks in system, it may be temporarily
-		 smaller than target_reserved_blocks, but will gradually
-		 increase to target_reserved_blocks when more free blocks are
-		 freed by user later.
+Description:	Shows current reserved blocks in system, it may be temporarily
+		smaller than target_reserved_blocks, but will gradually
+		increase to target_reserved_blocks when more free blocks are
+		freed by user later.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent
 Date:		August 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Do background GC agressively
+Description:	Do background GC agressively when set. When gc_urgent = 1,
+		background thread starts to do GC by given gc_urgent_sleep_time
+		interval. It is set to 0 by default.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent_sleep_time
 Date:		August 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Controls sleep time of GC urgent mode
+Description:	Controls sleep time of GC urgent mode. Set to 500ms by default.
 
 What:		/sys/fs/f2fs/<disk>/readdir_ra
 Date:		November 2017
 Contact:	"Sheng Yong" <shengyong1@huawei.com>
-Description:
-		 Controls readahead inode block in readdir.
+Description:	Controls readahead inode block in readdir. Enabled by default.
+
+What:		/sys/fs/f2fs/<disk>/gc_pin_file_thresh
+Date:		January 2018
+Contact:	Jaegeuk Kim <jaegeuk@kernel.org>
+Description:	This indicates how many GC can be failed for the pinned
+		file. If it exceeds this, F2FS doesn't guarantee its pinning
+		state. 2048 trials is set by default.
 
 What:		/sys/fs/f2fs/<disk>/extension_list
 Date:		Feburary 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Description:
-		 Used to control configure extension list:
-		 - Query: cat /sys/fs/f2fs/<disk>/extension_list
-		 - Add: echo '[h/c]extension' > /sys/fs/f2fs/<disk>/extension_list
-		 - Del: echo '[h/c]!extension' > /sys/fs/f2fs/<disk>/extension_list
-		 - [h] means add/del hot file extension
-		 - [c] means add/del cold file extension
+Description:	Used to control configure extension list:
+		- Query: cat /sys/fs/f2fs/<disk>/extension_list
+		- Add: echo '[h/c]extension' > /sys/fs/f2fs/<disk>/extension_list
+		- Del: echo '[h/c]!extension' > /sys/fs/f2fs/<disk>/extension_list
+		- [h] means add/del hot file extension
+		- [c] means add/del cold file extension
 
 What:		/sys/fs/f2fs/<disk>/unusable
 Date		April 2019
 Contact:	"Daniel Rosenberg" <drosen@google.com>
-Description:
-		If checkpoint=disable, it displays the number of blocks that are unusable.
-                If checkpoint=enable it displays the enumber of blocks that would be unusable
-                if checkpoint=disable were to be set.
+Description:	If checkpoint=disable, it displays the number of blocks that are unusable.
+		If checkpoint=enable it displays the enumber of blocks that would be unusable
+		if checkpoint=disable were to be set.
diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 496fa28b2492..36db80cca271 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -250,168 +250,9 @@ SYSFS ENTRIES
 Information about mounted f2fs file systems can be found in
 /sys/fs/f2fs.  Each mounted filesystem will have a directory in
 /sys/fs/f2fs based on its device name (i.e., /sys/fs/f2fs/sda).
-The files in each per-device directory are shown in table below.
-
-Files in /sys/fs/f2fs/<devname>
-(see also Documentation/ABI/testing/sysfs-fs-f2fs)
-..............................................................................
- File                         Content
-
- gc_urgent_sleep_time         This parameter controls sleep time for gc_urgent.
-                              500 ms is set by default. See above gc_urgent.
-
- gc_min_sleep_time            This tuning parameter controls the minimum sleep
-                              time for the garbage collection thread. Time is
-                              in milliseconds.
-
- gc_max_sleep_time            This tuning parameter controls the maximum sleep
-                              time for the garbage collection thread. Time is
-                              in milliseconds.
-
- gc_no_gc_sleep_time          This tuning parameter controls the default sleep
-                              time for the garbage collection thread. Time is
-                              in milliseconds.
-
- gc_idle                      This parameter controls the selection of victim
-                              policy for garbage collection. Setting gc_idle = 0
-                              (default) will disable this option. Setting
-                              gc_idle = 1 will select the Cost Benefit approach
-                              & setting gc_idle = 2 will select the greedy approach.
-
- gc_urgent                    This parameter controls triggering background GCs
-                              urgently or not. Setting gc_urgent = 0 [default]
-                              makes back to default behavior, while if it is set
-                              to 1, background thread starts to do GC by given
-                              gc_urgent_sleep_time interval.
-
- reclaim_segments             This parameter controls the number of prefree
-                              segments to be reclaimed. If the number of prefree
-			      segments is larger than the number of segments
-			      in the proportion to the percentage over total
-			      volume size, f2fs tries to conduct checkpoint to
-			      reclaim the prefree segments to free segments.
-			      By default, 5% over total # of segments.
-
- max_small_discards	      This parameter controls the number of discard
-			      commands that consist small blocks less than 2MB.
-			      The candidates to be discarded are cached until
-			      checkpoint is triggered, and issued during the
-			      checkpoint. By default, it is disabled with 0.
-
- discard_granularity	      This parameter controls the granularity of discard
-			      command size. It will issue discard commands iif
-			      the size is larger than given granularity. Its
-			      unit size is 4KB, and 4 (=16KB) is set by default.
-			      The maximum value is 128 (=512KB).
 
- reserved_blocks	      This parameter indicates the number of blocks that
-			      f2fs reserves internally for root.
-
- batched_trim_sections	      This parameter controls the number of sections
-                              to be trimmed out in batch mode when FITRIM
-                              conducts. 32 sections is set by default.
-
- ipu_policy                   This parameter controls the policy of in-place
-                              updates in f2fs. There are five policies:
-                               0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
-                               0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
-                               0x10: F2FS_IPU_FSYNC.
-
- min_ipu_util                 This parameter controls the threshold to trigger
-                              in-place-updates. The number indicates percentage
-                              of the filesystem utilization, and used by
-                              F2FS_IPU_UTIL and F2FS_IPU_SSR_UTIL policies.
-
- min_fsync_blocks             This parameter controls the threshold to trigger
-                              in-place-updates when F2FS_IPU_FSYNC mode is set.
-			      The number indicates the number of dirty pages
-			      when fsync needs to flush on its call path. If
-			      the number is less than this value, it triggers
-			      in-place-updates.
-
- min_seq_blocks		      This parameter controls the threshold to serialize
-			      write IOs issued by multiple threads in parallel.
-
- min_hot_blocks		      This parameter controls the threshold to allocate
-			      a hot data log for pending data blocks to write.
-
- min_ssr_sections	      This parameter adds the threshold when deciding
-			      SSR block allocation. If this is large, SSR mode
-			      will be enabled early.
-
- ram_thresh                   This parameter controls the memory footprint used
-			      by free nids and cached nat entries. By default,
-			      10 is set, which indicates 10 MB / 1 GB RAM.
-
- ra_nid_pages		      When building free nids, F2FS reads NAT blocks
-			      ahead for speed up. Default is 0.
-
- dirty_nats_ratio	      Given dirty ratio of cached nat entries, F2FS
-			      determines flushing them in background.
-
- max_victim_search	      This parameter controls the number of trials to
-			      find a victim segment when conducting SSR and
-			      cleaning operations. The default value is 4096
-			      which covers 8GB block address range.
-
- migration_granularity	      For large-sized sections, F2FS can stop GC given
-			      this granularity instead of reclaiming entire
-			      section.
-
- dir_level                    This parameter controls the directory level to
-			      support large directory. If a directory has a
-			      number of files, it can reduce the file lookup
-			      latency by increasing this dir_level value.
-			      Otherwise, it needs to decrease this value to
-			      reduce the space overhead. The default value is 0.
-
- cp_interval		      F2FS tries to do checkpoint periodically, 60 secs
-			      by default.
-
- idle_interval		      F2FS detects system is idle, if there's no F2FS
-			      operations during given interval, 5 secs by
-			      default.
-
- discard_idle_interval	      F2FS detects the discard thread is idle, given
-			      time interval. Default is 5 secs.
-
- gc_idle_interval	      F2FS detects the GC thread is idle, given time
-			      interval. Default is 5 secs.
-
- umount_discard_timeout       When unmounting the disk, F2FS waits for finishing
-			      queued discard commands which can take huge time.
-			      This gives time out for it, 5 secs by default.
-
- iostat_enable		      This controls to enable/disable iostat in F2FS.
-
- readdir_ra		      This enables/disabled readahead of inode blocks
-			      in readdir, and default is enabled.
-
- gc_pin_file_thresh	      This indicates how many GC can be failed for the
-			      pinned file. If it exceeds this, F2FS doesn't
-			      guarantee its pinning state. 2048 trials is set
-			      by default.
-
- extension_list		      This enables to change extension_list for hot/cold
-			      files in runtime.
-
- inject_rate		      This controls injection rate of arbitrary faults.
-
- inject_type		      This controls injection type of arbitrary faults.
-
- dirty_segments 	      This shows # of dirty segments.
-
- lifetime_write_kbytes	      This shows # of data written to the disk.
-
- features		      This shows current features enabled on F2FS.
-
- current_reserved_blocks      This shows # of blocks currently reserved.
-
- unusable                     If checkpoint=disable, this shows the number of
-                              blocks that are unusable.
-                              If checkpoint=enable it shows the number of blocks
-                              that would be unusable if checkpoint=disable were
-                              to be set.
+Documentation for files in /sys/fs/f2fs/<devname> can be found in
+Documentation/ABI/testing/sysfs-fs-f2fs
 
 ================================================================================
 USAGE
-- 
2.23.0.866.gb869b98d4c-goog

