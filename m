Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A4C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE02C21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfFNIxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:53:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59240 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfFNIxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:53:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D3692005F1;
        Fri, 14 Jun 2019 10:53:00 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B14702005DC;
        Fri, 14 Jun 2019 10:52:55 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A8D1F40319;
        Fri, 14 Jun 2019 16:52:46 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/5] usb :fsl: Change string format for errata property
Date:   Fri, 14 Jun 2019 16:54:33 +0800
Message-Id: <20190614085433.22344-5-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614085433.22344-1-yinbo.zhu@nxp.com>
References: <20190614085433.22344-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Remove USB errata checking code from driver. Applicability of erratum
is retrieved by reading corresponding property in device tree.
This property is written during device tree fixup.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/usb/host/fsl-mph-dr-of.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 762b97600ab0..ae8f60f6e6a5 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -226,11 +226,8 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
 	pdata->has_fsl_erratum_a006918 =
 		of_property_read_bool(np, "fsl,usb_erratum-a006918");
-
-	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
-		pdata->has_fsl_erratum_14 = 1;
-	else
-		pdata->has_fsl_erratum_14 = 0;
+	pdata->has_fsl_erratum_14 =
+		of_property_read_bool(np, "fsl,usb_erratum-14");
 
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
-- 
2.17.1

