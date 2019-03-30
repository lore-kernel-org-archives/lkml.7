Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA48C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C622218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907096;
	bh=akUO58pM/qQt/Cm3XICfUbDTd5CKCo5UjS8m8sV8IdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v9CqQdvzZz3tGkF1lq69mlobbADJJeczLfLLEJKw0hVu8l8zK0sBOY157JQrx41+K
	 h2Lx/Fc7HtyfGVr/y9niR1o24s0QfoCff8lpIBjbYbL+K9+5xRZTtcyQVPT/+4wY2C
	 4uzA8jCVJv6S9yt68iOhkIatFc43CEZmZ6WM/mUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfC3Avf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbfC3Ava (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D1E218D0;
        Sat, 30 Mar 2019 00:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907089;
        bh=akUO58pM/qQt/Cm3XICfUbDTd5CKCo5UjS8m8sV8IdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQtx0FvGDL23b0HAaSug2xa61mQZOqTvZWdI7a5UaPoIg1v2yPA29plhKEuf/UY6W
         wyT7BxW7PKKTOI4T28yS94EB0wbEsES8soAb6JdSsuDArfrGuMxPxQnKyVw5iNOefk
         U7/PYwNog4vy6I5NptCFO53J1G9TOHf3hFQME2b4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 26/67] scsi: iscsi: flush running unbind operations when removing a session
Date:   Fri, 29 Mar 2019 20:50:06 -0400
Message-Id: <20190330005047.25998-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 165aa2bfb42904b1bec4bf2fa257c8c603c14a06 ]

In some cases, the iscsi_remove_session() function is called while an
unbind_work operation is still running.  This may cause a situation where
sysfs objects are removed in an incorrect order, triggering a kernel
warning.

[  605.249442] ------------[ cut here ]------------
[  605.259180] sysfs group 'power' not found for kobject 'target2:0:0'
[  605.321371] WARNING: CPU: 1 PID: 26794 at fs/sysfs/group.c:235 sysfs_remove_group+0x76/0x80
[  605.341266] Modules linked in: dm_service_time target_core_user target_core_pscsi target_core_file target_core_iblock iscsi_target_mod target_core_mod nls_utf8 isofs ppdev bochs_drm nfit ttm libnvdimm drm_kms_helper syscopyarea sysfillrect sysimgblt joydev pcspkr fb_sys_fops drm i2c_piix4 sg parport_pc parport xfs libcrc32c dm_multipath sr_mod sd_mod cdrom ata_generic 8021q garp mrp ata_piix stp crct10dif_pclmul crc32_pclmul llc libata crc32c_intel virtio_net net_failover ghash_clmulni_intel serio_raw failover sunrpc dm_mirror dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi
[  605.627479] CPU: 1 PID: 26794 Comm: kworker/u32:2 Not tainted 4.18.0-60.el8.x86_64 #1
[  605.721401] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
[  605.823651] Workqueue: scsi_wq_2 __iscsi_unbind_session [scsi_transport_iscsi]
[  605.830940] RIP: 0010:sysfs_remove_group+0x76/0x80
[  605.922907] Code: 48 89 df 5b 5d 41 5c e9 38 c4 ff ff 48 89 df e8 e0 bf ff ff eb cb 49 8b 14 24 48 8b 75 00 48 c7 c7 38 73 cb a7 e8 24 77 d7 ff <0f> 0b 5b 5d 41 5c c3 0f 1f 00 0f 1f 44 00 00 41 56 41 55 41 54 55
[  606.122304] RSP: 0018:ffffbadcc8d1bda8 EFLAGS: 00010286
[  606.218492] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  606.326381] RDX: ffff98bdfe85eb40 RSI: ffff98bdfe856818 RDI: ffff98bdfe856818
[  606.514498] RBP: ffffffffa7ab73e0 R08: 0000000000000268 R09: 0000000000000007
[  606.529469] R10: 0000000000000000 R11: ffffffffa860d9ad R12: ffff98bdf978e838
[  606.630535] R13: ffff98bdc2cd4010 R14: ffff98bdc2cd3ff0 R15: ffff98bdc2cd4000
[  606.824707] FS:  0000000000000000(0000) GS:ffff98bdfe840000(0000) knlGS:0000000000000000
[  607.018333] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  607.117844] CR2: 00007f84b78ac024 CR3: 000000002c00a003 CR4: 00000000003606e0
[  607.117844] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  607.420926] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  607.524236] Call Trace:
[  607.530591]  device_del+0x56/0x350
[  607.624393]  ? ata_tlink_match+0x30/0x30 [libata]
[  607.727805]  ? attribute_container_device_trigger+0xb4/0xf0
[  607.829911]  scsi_target_reap_ref_release+0x39/0x50
[  607.928572]  scsi_remove_target+0x1a2/0x1d0
[  608.017350]  __iscsi_unbind_session+0xb3/0x160 [scsi_transport_iscsi]
[  608.117435]  process_one_work+0x1a7/0x360
[  608.132917]  worker_thread+0x30/0x390
[  608.222900]  ? pwq_unbound_release_workfn+0xd0/0xd0
[  608.323989]  kthread+0x112/0x130
[  608.418318]  ? kthread_bind+0x30/0x30
[  608.513821]  ret_from_fork+0x35/0x40
[  608.613909] ---[ end trace 0b98c310c8a6138c ]---

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Acked-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_transport_iscsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 0508831d6fb9..0a82e93566dc 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2200,6 +2200,8 @@ void iscsi_remove_session(struct iscsi_cls_session *session)
 	scsi_target_unblock(&session->dev, SDEV_TRANSPORT_OFFLINE);
 	/* flush running scans then delete devices */
 	flush_work(&session->scan_work);
+	/* flush running unbind operations */
+	flush_work(&session->unbind_work);
 	__iscsi_unbind_session(&session->unbind_work);
 
 	/* hw iscsi may not have removed all connections from session */
-- 
2.19.1

