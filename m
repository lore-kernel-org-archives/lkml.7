Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4DEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6702133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfFXHVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:21:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55488 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbfFXHU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:20:28 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9248E1A056C;
        Mon, 24 Jun 2019 09:20:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 579C51A056D;
        Mon, 24 Jun 2019 09:20:21 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 014374031F;
        Mon, 24 Jun 2019 15:20:14 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/5] usb: fsl: Set USB_EN bit to select ULPI phy
Date:   Mon, 24 Jun 2019 15:22:15 +0800
Message-Id: <20190624072219.15258-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Set USB_EN bit to select ULPI phy for USB controller version 2.5

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		replace Yinbo.Zhu with Yinbo Zhu. 
Change in v3:
		Code base already has patch[5/6], so remove it.
Change in v4:
		Incorrect indentation of the continuation line.

 drivers/usb/host/ehci-fsl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index e3d0c1c25160..38674b7aa51e 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -122,6 +122,12 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
 		tmp |= 0x4;
 		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
 	}
+
+	/* Set USB_EN bit to select ULPI phy for USB controller version 2.5 */
+	if (pdata->controller_ver == FSL_USB_VER_2_5 &&
+	    pdata->phy_mode == FSL_USB2_PHY_ULPI)
+		iowrite32be(USB_CTRL_USB_EN, hcd->regs + FSL_SOC_USB_CTRL);
+
 	/*
 	 * Enable UTMI phy and program PTS field in UTMI mode before asserting
 	 * controller reset for USB Controller version 2.5
-- 
2.17.1

