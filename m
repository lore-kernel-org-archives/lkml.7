Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC06C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9A32465E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfLMDOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 22:14:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfLMDOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 22:14:55 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FD2FB1B068FFFE16816;
        Fri, 13 Dec 2019 11:14:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 13 Dec 2019 11:14:45 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <axboe@kernel.dk>
CC:     <yaohongbo@huawei.com>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] ata: acard-ahci: removeset but not used variable 'n_elem'
Date:   Fri, 13 Dec 2019 11:11:57 +0800
Message-ID: <20191213031157.52115-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/ata/acard-ahci.c: In function acard_ahci_qc_prep:
drivers/ata/acard-ahci.c:268:15: warning: variable n_elem set but not
used [-Wunused-but-set-variable]

It is never used so can be removed. acard_ahci_fill_sg() is called only
in one place, use 'void' instead of 'int'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/ata/acard-ahci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 46dc54d18f0b..0613c1269292 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -179,7 +179,7 @@ static void acard_ahci_pci_print_info(struct ata_host *host)
 	ahci_print_info(host, scc_s);
 }
 
-static unsigned int acard_ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
+static void acard_ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 {
 	struct scatterlist *sg;
 	struct acard_sg *acard_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
@@ -206,8 +206,6 @@ static unsigned int acard_ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 	}
 
 	acard_sg[last_si].size |= cpu_to_le32(1 << 31);	/* set EOT */
-
-	return si;
 }
 
 static enum ata_completion_errors acard_ahci_qc_prep(struct ata_queued_cmd *qc)
@@ -218,7 +216,6 @@ static enum ata_completion_errors acard_ahci_qc_prep(struct ata_queued_cmd *qc)
 	void *cmd_tbl;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
-	unsigned int n_elem;
 
 	/*
 	 * Fill in command table information.  First, the header,
@@ -232,9 +229,8 @@ static enum ata_completion_errors acard_ahci_qc_prep(struct ata_queued_cmd *qc)
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
 	}
 
-	n_elem = 0;
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-		n_elem = acard_ahci_fill_sg(qc, cmd_tbl);
+		acard_ahci_fill_sg(qc, cmd_tbl);
 
 	/*
 	 * Fill in command slot information.
-- 
2.20.1

