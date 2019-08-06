Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A9BC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5F320C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfHFLfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:35:03 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:51060 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHFLfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:35:02 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id F0FFA16F1B; Tue,  6 Aug 2019 12:35:00 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Bin Liu <b-liu@ti.com>, Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH] usb: musb: sunxi: propagate devicetree node to glue pdev
Date:   Tue,  6 Aug 2019 12:34:58 +0100
Message-Id: <20190806113458.3304-1-mans@mansr.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for devicetree nodes to be correctly associated with attached
devices, the controller node needs to be propagated to the glue device.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/usb/musb/sunxi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 832a41f9ee7d..a72665fbf111 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -781,6 +781,8 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	pinfo.name	 = "musb-hdrc";
 	pinfo.id	= PLATFORM_DEVID_AUTO;
 	pinfo.parent	= &pdev->dev;
+	pinfo.fwnode	= of_fwnode_handle(pdev->dev.of_node);
+	pinfo.of_node_reused = true;
 	pinfo.res	= pdev->resource;
 	pinfo.num_res	= pdev->num_resources;
 	pinfo.data	= &pdata;
-- 
2.22.0

