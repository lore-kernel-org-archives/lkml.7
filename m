Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E13EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F272075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfC0JDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:03:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60699 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfC0JDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:03:02 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h94SZ-0000QZ-Na; Wed, 27 Mar 2019 09:03:00 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH] libata: Return correct rc status in sata_pmp_eh_recover_pm() pwhen ATA_DFLAG_DETACH is set
Date:   Wed, 27 Mar 2019 17:02:54 +0800
Message-Id: <20190327090254.10365-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During system resume from suspend, this can be observed on ASM1062 PMP
controller:
<6>[12007.593358] ata10.01: SATA link down (SStatus 0 SControl 330)
<6>[12007.593469] ata10.02: hard resetting link
<6>[12007.908353] ata10.02: SATA link down (SStatus 0 SControl 330)
<6>[12007.911149] ata10.00: configured for UDMA/133
<0>[12007.972508] Kernel panic - not syncing: stack-protector: Kernel
stack is corrupted in: sata_pmp_eh_recover+0xa2b/0xa40
<0>[12007.972508]
<4>[12007.972515] CPU: 2 PID: 230 Comm: scsi_eh_9 Tainted: P OE
4.15.0-46-generic #49-Ubuntu
<4>[12007.972517] Hardware name: System manufacturer System Product
Name/A320M-C, BIOS 1001 12/10/2017
<4>[12007.972518] Call Trace:
<4>[12007.972525] dump_stack+0x63/0x8b
<4>[12007.972530] panic+0xe4/0x244
<4>[12007.972533] ? sata_pmp_eh_recover+0xa2b/0xa40
<4>[12007.972536] __stack_chk_fail+0x19/0x20
<4>[12007.972538] sata_pmp_eh_recover+0xa2b/0xa40
<4>[12007.972543] ? ahci_do_softreset+0x260/0x260 [libahci]
<4>[12007.972545] ? ahci_do_hardreset+0x140/0x140 [libahci]
<4>[12007.972547] ? ata_phys_link_offline+0x60/0x60
<4>[12007.972549] ? ahci_stop_engine+0xc0/0xc0 [libahci]
<4>[12007.972552] sata_pmp_error_handler+0x22/0x30
<4>[12007.972554] ahci_error_handler+0x45/0x80 [libahci]
<4>[12007.972556] ata_scsi_port_error_handler+0x29b/0x770
<4>[12007.972558] ? ata_scsi_cmd_error_handler+0x101/0x140
<4>[12007.972559] ata_scsi_error+0x95/0xd0
<4>[12007.972562] ? scsi_try_target_reset+0x90/0x90
<4>[12007.972563] scsi_error_handler+0xd0/0x5b0
<4>[12007.972566] kthread+0x121/0x140
<4>[12007.972567] ? scsi_eh_get_sense+0x200/0x200
<4>[12007.972569] ? kthread_create_worker_on_cpu+0x70/0x70
<4>[12007.972572] ret_from_fork+0x22/0x40
<0>[12007.972591] Kernel Offset: 0xcc00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Since sata_pmp_eh_recover_pmp() doens't set rc when ATA_DFLAG_DETACH is
set, sata_pmp_eh_recover() continues to run. During retry it triggers
the stack protector.

Set correct rc in sata_pmp_eh_recover_pmp() to let sata_pmp_eh_recover()
jump to pmp_fail directly.

BugLink: https://bugs.launchpad.net/bugs/1821434
Cc: stable@vger.kernel.org
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/ata/libata-pmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 2ae1799f4992..51eeaea65833 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -764,6 +764,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 
 	if (dev->flags & ATA_DFLAG_DETACH) {
 		detach = 1;
+		rc = -ENODEV;
 		goto fail;
 	}
 
-- 
2.17.1

