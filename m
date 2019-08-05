Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9047C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9984F21738
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfHEOGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:06:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728518AbfHEOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:06:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DA7E7AD371BCBBB924D8;
        Mon,  5 Aug 2019 21:50:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:11 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 00/15] hisi_sas: Misc patches
Date:   Mon, 5 Aug 2019 21:47:57 +0800
Message-ID: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset incldues a set of misc changes for the driver.

Nothing particularly stands out. Here's a quick overview:
- minor optimisation in delivery path
- some debugfs fixes and new minor features
- some other very minor optimisations
- and generally the rest are tidy-up patches

Thanks!

John Garry (4):
  scsi: hisi_sas: Make max IPTT count equal for all hw revisions
  scsi: hisi_sas: Drop hisi_sas_hw.get_free_slot
  scsi: hisi_sas: Drop kmap_atomic() in SMP command completion
  scsi: hisi_sas: Drop SMP resp frame DMA mapping

Luo Jiaxing (6):
  scsi: hisi_sas: Fix pointer usage error in show debugfs IOST/ITCT
  scsi: hisi_sas: Snapshot HW cache of IOST and ITCT at debugfs
  scsi: hisi_sas: Snapshot AXI and RAS register at debugfs
  scsi: hisi_sas: Fix out of bound at debug_I_T_nexus_reset()
  scsi: hisi_sas: Modify return type of debugfs functions
  scsi: hisi_sas: Consolidate internal abort calls in LU reset operation

Xiang Chen (5):
  scsi: hisi_sas: Don't bother clearing status buffer IU in task prep
  scsi: hisi_sas: Make slot buf minimum allocation of PAGE_SIZE
  scsi: hisi_sas: Drop free_irq() when devm_request_irq() failed
  scsi: hisi_sas: Remove some unnecessary code
  scsi: hisi_sas: replace "%p" with "%pK"

 drivers/scsi/hisi_sas/hisi_sas.h       |  36 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 438 +++++++++++++++++--------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  43 +--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  75 +----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 148 +++++----
 5 files changed, 426 insertions(+), 314 deletions(-)

-- 
2.17.1

