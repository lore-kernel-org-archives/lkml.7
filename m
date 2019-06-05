Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02418C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D521720866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFEFs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 01:48:28 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56540 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfFEFsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 01:48:16 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 032EF1A00E7;
        Wed,  5 Jun 2019 07:48:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1942E1A079A;
        Wed,  5 Jun 2019 07:48:09 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C6B42402E8;
        Wed,  5 Jun 2019 13:48:02 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com
Subject: [PATCH v6 4/5] usb: host: Stops USB controller init if PLL fails to lock
Date:   Wed,  5 Jun 2019 13:49:51 +0800
Message-Id: <20190605054952.34687-4-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605054952.34687-1-yinbo.zhu@nxp.com>
References: <20190605054952.34687-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramneek Mehresh <ramneek.mehresh@freescale.com>

USB erratum-A006918 workaround tries to start internal PHY inside
uboot (when PLL fails to lock). However, if the workaround also
fails, then USB initialization is also stopped inside Linux.
Erratum-A006918 workaround failure creates "fsl,erratum_a006918"
node in device-tree. Presence of this node in device-tree is
used to stop USB controller initialization in Linux

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v6:
		add a "Fall through" comment 	

 drivers/usb/host/ehci-fsl.c      | 10 +++++++++-
 drivers/usb/host/fsl-mph-dr-of.c |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 8f3bf3efb038..86ae37086a74 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -234,8 +234,16 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		break;
 	case FSL_USB2_PHY_UTMI_WIDE:
 		portsc |= PORT_PTS_PTW;
-		/* fall through */
 	case FSL_USB2_PHY_UTMI:
+		/* Presence of this node "has_fsl_erratum_a006918"
+		 * in device-tree is used to stop USB controller
+		 * initialization in Linux
+		 */
+		if (pdata->has_fsl_erratum_a006918) {
+			dev_warn(dev, "USB PHY clock invalid\n");
+			return -EINVAL;
+		}
+
 	case FSL_USB2_PHY_UTMI_DUAL:
 		/* PHY_CLK_VALID bit is de-featured from all controller
 		 * versions below 2.4 and is to be checked only for
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 4f8b8a08c914..762b97600ab0 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -224,13 +224,14 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 		of_property_read_bool(np, "fsl,usb-erratum-a005275");
 	pdata->has_fsl_erratum_a005697 =
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
+	pdata->has_fsl_erratum_a006918 =
+		of_property_read_bool(np, "fsl,usb_erratum-a006918");
 
 	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
 		pdata->has_fsl_erratum_14 = 1;
 	else
 		pdata->has_fsl_erratum_14 = 0;
 
-
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
 	 * by reading property in device tree
-- 
2.17.1

