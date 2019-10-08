Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9358AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7615C206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfJHMLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:11:00 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53840 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbfJHMK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:10:57 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EDFFF1A0158;
        Tue,  8 Oct 2019 14:10:55 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E13531A00FC;
        Tue,  8 Oct 2019 14:10:55 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 987EF205DB;
        Tue,  8 Oct 2019 14:10:55 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     roy.pledge@nxp.com, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 02/20] dpaa_eth: defer probing after qbman
Date:   Tue,  8 Oct 2019 15:10:23 +0300
Message-Id: <1570536641-25104-3-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1570536641-25104-1-git-send-email-madalin.bucur@nxp.com>
References: <1570536641-25104-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

If the DPAA 1 Ethernet driver gets probed before the QBMan driver it will
cause a boot crash. Add predictability in the probing order by deferring
the Ethernet driver probe after QBMan and portals by using the recently
introduced QBMan APIs.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index b4b82b9c5cd6..75eeb2ef409f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2773,6 +2773,37 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	int err = 0, i, channel;
 	struct device *dev;
 
+	err = bman_is_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev, "failing probe due to bman probe error\n");
+		return -ENODEV;
+	}
+	err = qman_is_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev, "failing probe due to qman probe error\n");
+		return -ENODEV;
+	}
+	err = bman_portals_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"failing probe due to bman portals probe error\n");
+		return -ENODEV;
+	}
+	err = qman_portals_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"failing probe due to qman portals probe error\n");
+		return -ENODEV;
+	}
+
 	/* device used for DMA mapping */
 	dev = pdev->dev.parent;
 	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(40));
-- 
2.1.0

