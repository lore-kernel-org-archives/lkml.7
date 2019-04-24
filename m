Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68461C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3618B20684
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129422;
	bh=V6bN5prMbTdZQ2lN3ntnb/ez7g/jmfKbPwmFqI5xO70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sk1U6wRID16fVQXOglmZ6Ykj+PYAtpHJfLAUkpWtCaX9n3bULNDHNfaN4Xgk1oib0
	 VpAfQoJSFDAvD7Tq75vEJZIflmjuH6XXqyyH4W1j7gz0dE16FMq38OqLf7R+sOvcz2
	 wrruzUu507/ryZ99ep/keZRNdStfz4pJP08KRzLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfDXSKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733297AbfDXROg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:36 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAA972054F;
        Wed, 24 Apr 2019 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126075;
        bh=V6bN5prMbTdZQ2lN3ntnb/ez7g/jmfKbPwmFqI5xO70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2EquYEse+3TeQtSQ5pD5vHtEw6C6so65xdTPb1RWx6lBeEdKvf7+nVnXUW9DzxMOf
         oYINlF8aeSQw2iDv+lEBcsZzBZMZRHqJt3NITZby6iZ4Bcr//+1sGBfTxdV/312UOR
         nLr7WfgjeaXyP5wbgyAiOG1vvEmX+T+Ji1lDsLJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 029/104] cdrom: Fix race condition in cdrom_sysctl_register
Date:   Wed, 24 Apr 2019 19:08:46 +0200
Message-Id: <20190424170856.369343305@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 2bd91d4943e1..f4f93ca4bdad 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -265,6 +265,7 @@
 /* #define ERRLOGMASK (CD_WARNING|CD_OPEN|CD_COUNT_TRACKS|CD_CLOSE) */
 /* #define ERRLOGMASK (CD_WARNING|CD_REG_UNREG|CD_DO_IOCTL|CD_OPEN|CD_CLOSE|CD_COUNT_TRACKS) */
 
+#include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/major.h>
@@ -3676,9 +3677,9 @@ static struct ctl_table_header *cdrom_sysctl_header;
 
 static void cdrom_sysctl_register(void)
 {
-	static int initialized;
+	static atomic_t initialized = ATOMIC_INIT(0);
 
-	if (initialized == 1)
+	if (!atomic_add_unless(&initialized, 1, 1))
 		return;
 
 	cdrom_sysctl_header = register_sysctl_table(cdrom_root_table);
@@ -3689,8 +3690,6 @@ static void cdrom_sysctl_register(void)
 	cdrom_sysctl_settings.debug = debug;
 	cdrom_sysctl_settings.lock = lockdoor;
 	cdrom_sysctl_settings.check = check_media_type;
-
-	initialized = 1;
 }
 
 static void cdrom_sysctl_unregister(void)
-- 
2.19.1



