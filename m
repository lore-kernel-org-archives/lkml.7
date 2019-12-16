Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C70C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F110821835
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520006;
	bh=v5su6fnUr8EnZiCDMpwqDj7YLp3ThB+376ZBNPvSNWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q2n48Wr7vOBDlcDN1IZykVga7bpZYtwiSgpq/NWfJ/capXOFqzfK/bCD/tE7aPOEK
	 lJ/VydKyPooeGrwetmQtQsM3TQAyj40cSvDR+b993Q3+bWKbtwgSQmCqfnkfi/hdqO
	 sWzJRx3hWnwajZ3HAndS2i6aZUN0H5ld6AysjvFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfLPSNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:13:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731078AbfLPSNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:13:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5283B2082E;
        Mon, 16 Dec 2019 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519993;
        bh=v5su6fnUr8EnZiCDMpwqDj7YLp3ThB+376ZBNPvSNWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8xpBZSVtoH0Zk+KNFa+ulrWx8+Lzh/5HTkfLeKAOnKe3UouSbDgoj3d+Dpu7EXBD
         sHOZhMrEz/BOWsjUqQJJydkrGL+0hw9Ruzppitq4dj9GTRdplS/KJp3kSQnn34kKxR
         vvWPyJ960CWM8RFJiSkE2MyXo8PDoMnGnYc2Qins=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 152/180] scsi: qla2xxx: Fix flash read for Qlogic ISPs
Date:   Mon, 16 Dec 2019 18:49:52 +0100
Message-Id: <20191216174844.337049340@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit cb92cb1657c438efe7c88c9759f40c0a9d46c353 ]

Use adapter specific callback to read flash instead of ISP adapter
specific.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Link: https://lore.kernel.org/r/20190830222402.23688-3-hmadhani@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ++--
 drivers/scsi/qla2xxx/qla_nx.c   | 1 +
 drivers/scsi/qla2xxx/qla_sup.c  | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index f4ed061b96886..fb9095179fc59 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -8385,7 +8385,7 @@ qla81xx_nvram_config(scsi_qla_host_t *vha)
 		    active_regions.aux.vpd_nvram == QLA27XX_PRIMARY_IMAGE ?
 		    "primary" : "secondary");
 	}
-	qla24xx_read_flash_data(vha, ha->vpd, faddr, ha->vpd_size >> 2);
+	ha->isp_ops->read_optrom(vha, ha->vpd, faddr << 2, ha->vpd_size);
 
 	/* Get NVRAM data into cache and calculate checksum. */
 	faddr = ha->flt_region_nvram;
@@ -8397,7 +8397,7 @@ qla81xx_nvram_config(scsi_qla_host_t *vha)
 	    "Loading %s nvram image.\n",
 	    active_regions.aux.vpd_nvram == QLA27XX_PRIMARY_IMAGE ?
 	    "primary" : "secondary");
-	qla24xx_read_flash_data(vha, ha->nvram, faddr, ha->nvram_size >> 2);
+	ha->isp_ops->read_optrom(vha, ha->nvram, faddr << 2, ha->nvram_size);
 
 	dptr = (uint32_t *)nv;
 	for (cnt = 0, chksum = 0; cnt < ha->nvram_size >> 2; cnt++, dptr++)
diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index c760ae354174c..6ce0f026debb1 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -2288,6 +2288,7 @@ qla82xx_disable_intrs(struct qla_hw_data *ha)
 	scsi_qla_host_t *vha = pci_get_drvdata(ha->pdev);
 
 	qla82xx_mbx_intr_disable(vha);
+
 	spin_lock_irq(&ha->hardware_lock);
 	if (IS_QLA8044(ha))
 		qla8044_wr_reg(ha, LEG_INTR_MASK_OFFSET, 1);
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index 1eb82384d933c..81c5d3de666b0 100644
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -680,8 +680,8 @@ qla2xxx_get_flt_info(scsi_qla_host_t *vha, uint32_t flt_addr)
 
 	ha->flt_region_flt = flt_addr;
 	wptr = (uint16_t *)ha->flt;
-	qla24xx_read_flash_data(vha, (void *)flt, flt_addr,
-	    (sizeof(struct qla_flt_header) + FLT_REGIONS_SIZE) >> 2);
+	ha->isp_ops->read_optrom(vha, (void *)flt, flt_addr << 2,
+	    (sizeof(struct qla_flt_header) + FLT_REGIONS_SIZE));
 
 	if (le16_to_cpu(*wptr) == 0xffff)
 		goto no_flash_data;
@@ -948,11 +948,11 @@ qla2xxx_get_fdt_info(scsi_qla_host_t *vha)
 	struct req_que *req = ha->req_q_map[0];
 	uint16_t cnt, chksum;
 	uint16_t *wptr = (void *)req->ring;
-	struct qla_fdt_layout *fdt = (void *)req->ring;
+	struct qla_fdt_layout *fdt = (struct qla_fdt_layout *)req->ring;
 	uint8_t	man_id, flash_id;
 	uint16_t mid = 0, fid = 0;
 
-	qla24xx_read_flash_data(vha, (void *)fdt, ha->flt_region_fdt,
+	ha->isp_ops->read_optrom(vha, fdt, ha->flt_region_fdt << 2,
 	    OPTROM_BURST_DWORDS);
 	if (le16_to_cpu(*wptr) == 0xffff)
 		goto no_flash_data;
-- 
2.20.1



