Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952EC10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83448206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfCKH0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:26:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37600 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfCKH0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:26:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 61C0C1A026A;
        Mon, 11 Mar 2019 08:26:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DF9B1A0251;
        Mon, 11 Mar 2019 08:26:41 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BAC7E402EE;
        Mon, 11 Mar 2019 15:26:32 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     axboe@kernel.dk, robh+dt@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        andy.tang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 3/3] ahci: qoriq: add ls1028a platforms support
Date:   Mon, 11 Mar 2019 15:20:14 +0800
Message-Id: <20190311072014.36565-3-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190311072014.36565-1-peng.ma@nxp.com>
References: <20190311072014.36565-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ls1028a is a new introduced soc which supports ATA3.0

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
depends on:
	- http://patchwork.ozlabs.org/patch/1045218/

 drivers/ata/ahci_qoriq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 08dbb86..ea1175f 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -53,6 +53,7 @@
 
 enum ahci_qoriq_type {
 	AHCI_LS1021A,
+	AHCI_LS1028A,
 	AHCI_LS1043A,
 	AHCI_LS2080A,
 	AHCI_LS1046A,
@@ -72,6 +73,7 @@ struct ahci_qoriq_priv {
 
 static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1021a-ahci", .data = (void *)AHCI_LS1021A},
+	{ .compatible = "fsl,ls1028a-ahci", .data = (void *)AHCI_LS1028A},
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
 	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
@@ -223,6 +225,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
+	case AHCI_LS1028A:
 	case AHCI_LS1088A:
 	case AHCI_LX2160A:
 		if (!(qpriv->ecc_addr || ecc_initialized))
-- 
1.7.1

