Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F47C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA0F21906
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDKMrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:47:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfDKMra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:47:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 944132723EBD9AB4C874;
        Thu, 11 Apr 2019 20:47:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:47:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/9] hisi_sas: Some misc patches
Date:   Thu, 11 Apr 2019 20:46:35 +0800
Message-ID: <1554986804-233706-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patchset introduces improvements, more minor fixes, and new features
for the driver, including:
- Host reset interface
- Switch all HW error handling to MSI
- Give SATA disk unique (fake) SAS address for v3 hw
- Some error handling fixes
- Some tidy-up

It is based on Martin's 5.2/scsi-queue branch plus patch 0e83fc61eee6
("scsi: hisi_sas: Add softreset in hisi_sas_I_T_nexus_reset()").

John Garry (1):
  scsi: hisi_sas: Fix for setting the PHY linkrate when disconnected

Luo Jiaxing (2):
  scsi: hisi_sas: Don't hard reset disk during controller reset
  scsi: hisi_sas: Don't fail IT nexus reset for Open Reject timeout

Xiang Chen (5):
  scsi: hisi_sas: add host reset interface for test
  scsi: hisi_sas: Remedy inconsistent PHY down state in software
  scsi: hisi_sas: Adjust the printk format of functions
    hisi_sas_init_device()
  scsi: hisi_sas: allocate different SAS address for directly attached
    situation
  scsi: hisi_sas: Some misc tidy-up

Xiaofei Tan (1):
  scsi: hisi_sas: Support all RAS events with MSI interrupts

 drivers/scsi/hisi_sas/hisi_sas.h       |   3 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 104 ++++--
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  21 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  49 ++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 473 +++++++++++++++----------
 5 files changed, 380 insertions(+), 270 deletions(-)

-- 
2.17.1

