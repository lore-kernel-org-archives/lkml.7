Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F979C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3287F20645
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711039;
	bh=Xp2+2Ns4GK2mbLtmWa3iAqm5SO/xTp3eJH8UaqPvuFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NrQ/AzR6iNC8czMuaHJnFvAislz2EkYkf/+JVlji4yqLP5/EKNkBSINxw+7l2gjgU
	 LxAwpOxpM+7gQqP0qFaAMB+Nh076P9JG4A6ypxrXuy1aRPqKTws0AFjUAyqFPovQWI
	 jm6+AJjydQJbWpu/y+5fo3oX7mBGe85+hCuL/YbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403947AbfC0SX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403920AbfC0SXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FBE2082F;
        Wed, 27 Mar 2019 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711032;
        bh=Xp2+2Ns4GK2mbLtmWa3iAqm5SO/xTp3eJH8UaqPvuFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foMrwW6tg0ESazFU7q/zEsP/WDF0vHzrM9rfPZ/F/my/m6f0kks0rXJGE0HsPzswH
         gbKekqV4+dQorebbOdXKXdm20K3m+TAo6wVcWxyYeimjFZRC8OV8UCsQWqLb6F9MS7
         5bMkKYrK22cY3pz6XRO7srsf85i8uHTv++MK7xnw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Jason Cai (Xiang Feng)" <jason.cai.kern@gmail.com>,
        Jason Cai <jason.cai@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 16/63] dm thin: add sanity checks to thin-pool and external snapshot creation
Date:   Wed, 27 Mar 2019 14:22:36 -0400
Message-Id: <20190327182323.18577-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason Cai (Xiang Feng)" <jason.cai.kern@gmail.com>

[ Upstream commit 70de2cbda8a5d788284469e755f8b097d339c240 ]

Invoking dm_get_device() twice on the same device path with different
modes is dangerous.  Because in that case, upgrade_mode() will alloc a
new 'dm_dev' and free the old one, which may be referenced by a previous
caller.  Dereferencing the dangling pointer will trigger kernel NULL
pointer dereference.

The following two cases can reproduce this issue.  Actually, they are
invalid setups that must be disallowed, e.g.:

1. Creating a thin-pool with read_only mode, and the same device as
both metadata and data.

dmsetup create thinp --table \
    "0 41943040 thin-pool /dev/vdb /dev/vdb 128 0 1 read_only"

BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
...
Call Trace:
 new_read+0xfb/0x110 [dm_bufio]
 dm_bm_read_lock+0x43/0x190 [dm_persistent_data]
 ? kmem_cache_alloc_trace+0x15c/0x1e0
 __create_persistent_data_objects+0x65/0x3e0 [dm_thin_pool]
 dm_pool_metadata_open+0x8c/0xf0 [dm_thin_pool]
 pool_ctr.cold.79+0x213/0x913 [dm_thin_pool]
 ? realloc_argv+0x50/0x70 [dm_mod]
 dm_table_add_target+0x14e/0x330 [dm_mod]
 table_load+0x122/0x2e0 [dm_mod]
 ? dev_status+0x40/0x40 [dm_mod]
 ctl_ioctl+0x1aa/0x3e0 [dm_mod]
 dm_ctl_ioctl+0xa/0x10 [dm_mod]
 do_vfs_ioctl+0xa2/0x600
 ? handle_mm_fault+0xda/0x200
 ? __do_page_fault+0x26c/0x4f0
 ksys_ioctl+0x60/0x90
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x55/0x150
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

2. Creating a external snapshot using the same thin-pool device.

dmsetup create thinp --table \
    "0 41943040 thin-pool /dev/vdc /dev/vdb 128 0 2 ignore_discard"
dmsetup message /dev/mapper/thinp 0 "create_thin 0"
dmsetup create snap --table \
            "0 204800 thin /dev/mapper/thinp 0 /dev/mapper/thinp"

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
...
Call Trace:
? __alloc_pages_nodemask+0x13c/0x2e0
retrieve_status+0xa5/0x1f0 [dm_mod]
? dm_get_live_or_inactive_table.isra.7+0x20/0x20 [dm_mod]
 table_status+0x61/0xa0 [dm_mod]
 ctl_ioctl+0x1aa/0x3e0 [dm_mod]
 dm_ctl_ioctl+0xa/0x10 [dm_mod]
 do_vfs_ioctl+0xa2/0x600
 ksys_ioctl+0x60/0x90
 ? ksys_write+0x4f/0xb0
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x55/0x150
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Jason Cai (Xiang Feng) <jason.cai@linux.alibaba.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-thin.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 07eaa9f90712..d52ea584e0bc 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -3210,6 +3210,13 @@ static int pool_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	as.argc = argc;
 	as.argv = argv;
 
+	/* make sure metadata and data are different devices */
+	if (!strcmp(argv[0], argv[1])) {
+		ti->error = "Error setting metadata or data device";
+		r = -EINVAL;
+		goto out_unlock;
+	}
+
 	/*
 	 * Set default pool features.
 	 */
@@ -4092,6 +4099,12 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	tc->sort_bio_list = RB_ROOT;
 
 	if (argc == 3) {
+		if (!strcmp(argv[0], argv[2])) {
+			ti->error = "Error setting origin device";
+			r = -EINVAL;
+			goto bad_origin_dev;
+		}
+
 		r = dm_get_device(ti, argv[2], FMODE_READ, &origin_dev);
 		if (r) {
 			ti->error = "Error opening origin device";
-- 
2.19.1

