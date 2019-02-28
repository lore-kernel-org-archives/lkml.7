Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D89218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366558;
	bh=d1jOna7EByFdXjWqCP6js7dwo09R7v0GccAQ46xVO8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WNe5O8s7R+Rb8ArdiXiAkTEyms9pjnZ+6eq32xLtZisn98189pWBPz79lOWqiSnyl
	 dTDScI97+tjAunxBBkz4f/kSTqNpNng9LcleaCrUQb12pojXfJN544yWs7oqNWB9HR
	 V5D1tki+6N/XuCCfYw+PMc/0m/LTH7WMA3PrNol8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbfB1PJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732609AbfB1PJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC27D218B0;
        Thu, 28 Feb 2019 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366548;
        bh=d1jOna7EByFdXjWqCP6js7dwo09R7v0GccAQ46xVO8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NCTV9qzfuAZPEmEJ3887sbLuHXf7UNByfKuWkohSCigjMUkV0Y5NldvXqixVhG7O4
         LUkHb5NOLoQP3eOPJs7Z6mQIqZc3kgKBlJ4wWwXWcHa2z0WMycL93XSwlUcmfbQvtx
         c1amXTI9MI0Ch0+bQlnLV5ohA87ynqyZe2qGQy4M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        Martijn Coenen <maco@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.20 36/81] binder: fix CONFIG_ANDROID_BINDER_DEVICES
Date:   Thu, 28 Feb 2019 10:07:28 -0500
Message-Id: <20190228150813.10256-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian@brauner.io>

[ Upstream commit 793c8232937610ae00bc174b87d7fc324346eaea ]

Several users have tried to only rely on binderfs to provide binder devices
and set CONFIG_ANDROID_BINDER_DEVICES="" empty. This is a great use-case of
binderfs and one that was always intended to work. However, this is
currently not possible since setting CONFIG_ANDROID_BINDER_DEVICES="" emtpy
will simply panic the kernel:

kobject: (00000000028c2f79): attempted to be registered with empty name!
WARNING: CPU: 7 PID: 1703 at lib/kobject.c:228 kobject_add_internal+0x288/0x2b0
Modules linked in: binder_linux(+) bridge stp llc ipmi_ssif gpio_ich dcdbas coretemp kvm_intel kvm irqbypass serio_raw input_leds lpc_ich i5100_edac mac_hid ipmi_si ipmi_devintf ipmi_msghandler sch_fq_codel ib_i
CPU: 7 PID: 1703 Comm: modprobe Not tainted 5.0.0-rc2-brauner-binderfs #263
Hardware name: Dell      DCS XS24-SC2          /XS24-SC2              , BIOS S59_3C20 04/07/2011
RIP: 0010:kobject_add_internal+0x288/0x2b0
Code: 12 95 48 c7 c7 78 63 3b 95 e8 77 35 71 ff e9 91 fe ff ff 0f 0b eb a7 0f 0b eb 9a 48 89 de 48 c7 c7 00 63 3b 95 e8 f8 95 6a ff <0f> 0b 41 bc ea ff ff ff e9 6d fe ff ff 41 bc fe ff ff ff e9 62 fe
RSP: 0018:ffff973f84237a30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8b53e2472010 RCX: 0000000000000006
RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff8b53edbd63a0
RBP: ffff973f84237a60 R08: 0000000000000342 R09: 0000000000000004
R10: ffff973f84237af0 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8b53e9f1a1e0 R14: 00000000e9f1a1e0 R15: 0000000000a00037
FS:  00007fbac36f7540(0000) GS:ffff8b53edbc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbac364cfa7 CR3: 00000004a6d48000 CR4: 00000000000406e0
Call Trace:
 kobject_add+0x71/0xd0
 ? _cond_resched+0x19/0x40
 ? mutex_lock+0x12/0x40
 device_add+0x12e/0x6b0
 device_create_groups_vargs+0xe4/0xf0
 device_create_with_groups+0x3f/0x60
 ? _cond_resched+0x19/0x40
 misc_register+0x140/0x180
 binder_init+0x1ed/0x2d4 [binder_linux]
 ? trace_event_define_fields_binder_transaction_fd_send+0x8e/0x8e [binder_linux]
 do_one_initcall+0x4a/0x1c9
 ? _cond_resched+0x19/0x40
 ? kmem_cache_alloc_trace+0x151/0x1c0
 do_init_module+0x5f/0x216
 load_module+0x223d/0x2b20
 __do_sys_finit_module+0xfc/0x120
 ? __do_sys_finit_module+0xfc/0x120
 __x64_sys_finit_module+0x1a/0x20
 do_syscall_64+0x5a/0x120
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fbac3202839
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd1494a908 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055b629ebec60 RCX: 00007fbac3202839
RDX: 0000000000000000 RSI: 000055b629c20d2e RDI: 0000000000000003
RBP: 000055b629c20d2e R08: 0000000000000000 R09: 000055b629ec2310
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 000055b629ebed70 R14: 0000000000040000 R15: 000055b629ebec60

So check for the empty string since strsep() will otherwise return the
emtpy string which will cause kobject_add_internal() to panic when trying
to add a kobject with an emtpy name.

Fixes: ac4812c5ffbb ("binder: Support multiple /dev instances")
Cc: Martijn Coenen <maco@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b834ee335d9a8..1d70f94037fa6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5877,21 +5877,23 @@ static int __init binder_init(void)
 				    &binder_transaction_log_fops);
 	}
 
-	/*
-	 * Copy the module_parameter string, because we don't want to
-	 * tokenize it in-place.
-	 */
-	device_names = kstrdup(binder_devices_param, GFP_KERNEL);
-	if (!device_names) {
-		ret = -ENOMEM;
-		goto err_alloc_device_names_failed;
-	}
+	if (strcmp(binder_devices_param, "") != 0) {
+		/*
+		* Copy the module_parameter string, because we don't want to
+		* tokenize it in-place.
+		 */
+		device_names = kstrdup(binder_devices_param, GFP_KERNEL);
+		if (!device_names) {
+			ret = -ENOMEM;
+			goto err_alloc_device_names_failed;
+		}
 
-	device_tmp = device_names;
-	while ((device_name = strsep(&device_tmp, ","))) {
-		ret = init_binder_device(device_name);
-		if (ret)
-			goto err_init_binder_device_failed;
+		device_tmp = device_names;
+		while ((device_name = strsep(&device_tmp, ","))) {
+			ret = init_binder_device(device_name);
+			if (ret)
+				goto err_init_binder_device_failed;
+		}
 	}
 
 	return ret;
-- 
2.19.1

