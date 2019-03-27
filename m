Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42009C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D862075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712530;
	bh=tb8OruciGvVLbDeJB3kI449kU4bSbn9E+WCZX6FL2zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHJfx6Jbb4q7UI6wlaMdUNb4IWiatcjggkUhYz557/UE/b3PiX7yF34wSlHoYYFfX
	 mGvjWHAKFx+O/mxS8ElMmPJLS6nNaB1+jaBZVhNaCTQEY8GHH0Q6dbfeuI4Yl7tJCc
	 tjRMtBEkQzOWvV+BFhI7hrZrqxO6DMrMNgUs+ENw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390644AbfC0STC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390042AbfC0STA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7675F21738;
        Wed, 27 Mar 2019 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710739;
        bh=tb8OruciGvVLbDeJB3kI449kU4bSbn9E+WCZX6FL2zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7FpVoE2dFnyo+h/XE4CzzCXSSYm+ehUoSQ/xa+JHAWOnHdlkgME7rc3FozmoccgA
         i2c3SOjsQIhylfiSO6YCTdJ0EiACETJ6pPRz049LRItJTrlmPr5JEP+hNqwQsvFUVx
         ERNx7JYnM5VlKPTxthbp/mjkeunEjNhoqMfbaEGE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 081/123] cdrom: Fix race condition in cdrom_sysctl_register
Date:   Wed, 27 Mar 2019 14:15:45 -0400
Message-Id: <20190327181628.15899-81-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit f25191bb322dec8fa2979ecb8235643aa42470e1 ]

The following traceback is sometimes seen when booting an image in qemu:

[   54.608293] cdrom: Uniform CD-ROM driver Revision: 3.20
[   54.611085] Fusion MPT base driver 3.04.20
[   54.611877] Copyright (c) 1999-2008 LSI Corporation
[   54.616234] Fusion MPT SAS Host driver 3.04.20
[   54.635139] sysctl duplicate entry: /dev/cdrom//info
[   54.639578] CPU: 0 PID: 266 Comm: kworker/u4:5 Not tainted 5.0.0-rc5 #1
[   54.639578] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   54.641273] Workqueue: events_unbound async_run_entry_fn
[   54.641273] Call Trace:
[   54.641273]  dump_stack+0x67/0x90
[   54.641273]  __register_sysctl_table+0x50b/0x570
[   54.641273]  ? rcu_read_lock_sched_held+0x6f/0x80
[   54.641273]  ? kmem_cache_alloc_trace+0x1c7/0x1f0
[   54.646814]  __register_sysctl_paths+0x1c8/0x1f0
[   54.646814]  cdrom_sysctl_register.part.7+0xc/0x5f
[   54.646814]  register_cdrom.cold.24+0x2a/0x33
[   54.646814]  sr_probe+0x4bd/0x580
[   54.646814]  ? __driver_attach+0xd0/0xd0
[   54.646814]  really_probe+0xd6/0x260
[   54.646814]  ? __driver_attach+0xd0/0xd0
[   54.646814]  driver_probe_device+0x4a/0xb0
[   54.646814]  ? __driver_attach+0xd0/0xd0
[   54.646814]  bus_for_each_drv+0x73/0xc0
[   54.646814]  __device_attach+0xd6/0x130
[   54.646814]  bus_probe_device+0x9a/0xb0
[   54.646814]  device_add+0x40c/0x670
[   54.646814]  ? __pm_runtime_resume+0x4f/0x80
[   54.646814]  scsi_sysfs_add_sdev+0x81/0x290
[   54.646814]  scsi_probe_and_add_lun+0x888/0xc00
[   54.646814]  ? scsi_autopm_get_host+0x21/0x40
[   54.646814]  __scsi_add_device+0x116/0x130
[   54.646814]  ata_scsi_scan_host+0x93/0x1c0
[   54.646814]  async_run_entry_fn+0x34/0x100
[   54.646814]  process_one_work+0x237/0x5e0
[   54.646814]  worker_thread+0x37/0x380
[   54.646814]  ? rescuer_thread+0x360/0x360
[   54.646814]  kthread+0x118/0x130
[   54.646814]  ? kthread_create_on_node+0x60/0x60
[   54.646814]  ret_from_fork+0x3a/0x50

The only sensible explanation is that cdrom_sysctl_register() is called
twice, once from the module init function and once from register_cdrom().
cdrom_sysctl_register() is not mutex protected and may happily execute
twice if the second call is made before the first call is complete.

Use a static atomic to ensure that the function is executed exactly once.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cdrom/cdrom.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 930b49606a8c..ea6558d4864c 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -265,6 +265,7 @@
 /* #define ERRLOGMASK (CD_WARNING|CD_OPEN|CD_COUNT_TRACKS|CD_CLOSE) */
 /* #define ERRLOGMASK (CD_WARNING|CD_REG_UNREG|CD_DO_IOCTL|CD_OPEN|CD_CLOSE|CD_COUNT_TRACKS) */
 
+#include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/major.h>
@@ -3689,9 +3690,9 @@ static struct ctl_table_header *cdrom_sysctl_header;
 
 static void cdrom_sysctl_register(void)
 {
-	static int initialized;
+	static atomic_t initialized = ATOMIC_INIT(0);
 
-	if (initialized == 1)
+	if (!atomic_add_unless(&initialized, 1, 1))
 		return;
 
 	cdrom_sysctl_header = register_sysctl_table(cdrom_root_table);
@@ -3702,8 +3703,6 @@ static void cdrom_sysctl_register(void)
 	cdrom_sysctl_settings.debug = debug;
 	cdrom_sysctl_settings.lock = lockdoor;
 	cdrom_sysctl_settings.check = check_media_type;
-
-	initialized = 1;
 }
 
 static void cdrom_sysctl_unregister(void)
-- 
2.19.1

