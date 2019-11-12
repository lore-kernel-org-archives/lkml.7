Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8A7C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C0421D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKLWgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:36:37 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:33140 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726932AbfKLWgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:36:37 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACMaWHn030543
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:36:32 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACMaRvU011474
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:36:32 -0500
Received: by mail-qk1-f200.google.com with SMTP id 125so189664qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=b3SMezw3KJOVVm/niCddVCl0DjKIk3OgqaEONN074B8=;
        b=sjkufI9UewLuZBZ7HNhgNXMGxa4dWEhalqssG+jEEsgPDwCOVaqv50QbHM21OwzKHl
         UvYWXc8cWYr/vWvJAQ0pGYQXXWNd0ibMdbV6fpJz0P6TvFfZtmgaLJngVDWjwfuq98I/
         +yg+1pCqNLQZVZgy+o7DEarf6EYIsxsw8iVKmZ3JVmPFji9DopCXhao0e/a/K/soH3kZ
         hPlwNuCPlBoVSv/IwOJXnHyXYgPzUSH158Kje0gFSTRno6pDQc+WHE/r316aCPJfu96k
         q7ebc2OsG8rK01LP9E9Fjx/bAPUEA6EZvg4w+1PALI8Dqc8n2a3MGTBNGuJa0ae7NWHl
         KdIA==
X-Gm-Message-State: APjAAAVxLxJmDWowlJgOwdvelIEwvw6sKJIdJqsD4gmDrDgt0pSlL4XO
        VR1LI62UZkg0I/MbaMY/Etxwqmk19yeH/zagIenTJmEPyK9ujf01WnAFll8sXERhJdGk4C0fhwk
        RHtcQSEYiVZosH4mKTOF0gPakfcMfP/U2t3E=
X-Received: by 2002:aed:2821:: with SMTP id r30mr34335461qtd.367.1573598186911;
        Tue, 12 Nov 2019 14:36:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVvq+wLMcWArLPgLTwIJ6gQIvDSAdqsKAyHrdpnSw7IXvoWUvqwWchRSSn79IkIOrXxMCf9Q==
X-Received: by 2002:aed:2821:: with SMTP id r30mr34335437qtd.367.1573598186582;
        Tue, 12 Nov 2019 14:36:26 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id l132sm41647qke.38.2019.11.12.14.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:36:25 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: Update the TODO file
Date:   Tue, 12 Nov 2019 17:36:08 -0500
Message-Id: <20191112223609.163501-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating with the current laundry list of things that need attention.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/TODO | 70 ++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/TODO b/drivers/staging/exfat/TODO
index b60e50b9cf4e..a283ce534cf4 100644
--- a/drivers/staging/exfat/TODO
+++ b/drivers/staging/exfat/TODO
@@ -1,17 +1,22 @@
+A laundry list of things that need looking at, most of which will
+require more work than the average checkpatch cleanup...
+
+Note that some of these entries may not be bugs - they're things
+that need to be looked at, and *possibly* fixed.
+
+Clean up the ffsCamelCase function names.
+
+Fix (thing)->flags to not use magic numbers - multiple offenders
+
+Sort out all the s32/u32/u8 nonsense - most of these should be plain int.
+
 exfat_core.c - ffsReadFile - the goto err_out seem to leak a brelse().
 same for ffsWriteFile.
 
-exfat_core.c - fs_sync(sb,0) all over the place looks fishy as hell.
-There's only one place that calls it with a non-zero argument.
-Randomly removing fs_sync() calls is *not* the right answer, especially
-if the removal then leaves a call to fs_set_vol_flags(VOL_CLEAN), as that
-says the file system is clean and synced when we *know* it isn't.
-The proper fix here is to go through and actually analyze how DELAYED_SYNC
-should work, and any time we're setting VOL_CLEAN, ensure the file system
-has in fact been synced to disk.  In other words, changing the 'false' to
-'true' is probably more correct. Also, it's likely that the one current
-place where it actually does an bdev_sync isn't sufficient in the DELAYED_SYNC
-case.
+All the calls to fs_sync() need to be looked at, particularly in the
+context of EXFAT_DELAYED_SYNC. Currently, if that's defined, we only
+flush to disk when sync() gets called.  We should be doing at least
+metadata flushes at appropriate times.
 
 ffsTruncateFile -  if (old_size <= new_size) {
 That doesn't look right. How did it ever work? Are they relying on lazy
@@ -19,3 +24,46 @@ block allocation when actual writes happen? If nothing else, it never
 does the 'fid->size = new_size' and do the inode update....
 
 ffsSetAttr() is just dangling in the breeze, not wired up at all...
+
+Convert global mutexes to a per-superblock mutex.
+
+Right now, we load exactly one UTF-8 table. Check to see
+if that plays nice with different codepage and iocharset values
+for simultanous mounts of different devices
+
+exfat_rmdir() checks for -EBUSY but ffsRemoveDir() doesn't return it.
+In fact, there's a complete lack of -EBUSY testing anywhere.
+
+There's probably a few missing checks for -EEXIST
+
+check return codes of sync_dirty_buffer()
+
+Why is remove_file doing a num_entries++??
+
+Double check a lot of can't-happen parameter checks (for null pointers for
+things that have only one call site and can't pass a null, etc).
+
+All the DEBUG stuff can probably be tossed, including the ioctl(). Either
+that, or convert to a proper fault-injection system.
+
+exfat_remount does exactly one thing.  Fix to actually deal with remount
+options, particularly handling R/O correctly.  For that matter, allow
+R/O mounts in the first place.
+
+Figure out why the VFAT code used multi_sector_(read|write) but the
+exfat code doesn't use it. The difference matters on SSDs with wear leveling.
+
+exfat_fat_sync(), exfat_buf_sync(), and sync_alloc_bitmap()
+aren't called anyplace....
+
+Create helper function for exfat_set_entry_time() and exfat_set_entry_type()
+because it's sort of ugly to be calling the same functionn directly and
+other code calling through the fs_func struc ponters...
+
+clean up the remaining vol_type checks, which are of two types:
+some are ?: operators with magic numbers, and the rest are places
+where we're doing stuff with '.' and '..'.
+
+Patches to:
+	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+	Valdis Kletnieks <valdis.kletnieks@vt.edu>
-- 
2.24.0

