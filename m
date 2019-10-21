Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D6ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D132020656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfJUKVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:21:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37094 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfJUKVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:21:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2ACF5200527;
        Mon, 21 Oct 2019 12:21:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E79B200509;
        Mon, 21 Oct 2019 12:21:15 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BA8F8402E3;
        Mon, 21 Oct 2019 18:21:08 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>,
        Nikhil Badola <nikhil.badola@freescale.com>
Subject: [PATCH v1] usb: fsl: Check memory resource before releasing it
Date:   Mon, 21 Oct 2019 18:21:51 +0800
Message-Id: <20191021102153.16435-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Check memory resource existence before releasing it to avoid NULL
pointer dereference

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Reviewed-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 20141c3096f6..9a05863b2876 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2576,7 +2576,7 @@ static int fsl_udc_remove(struct platform_device *pdev)
 	dma_pool_destroy(udc_controller->td_pool);
 	free_irq(udc_controller->irq, udc_controller);
 	iounmap(dr_regs);
-	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
+	if (res && (pdata->operating_mode == FSL_USB2_DR_DEVICE))
 		release_mem_region(res->start, resource_size(res));
 
 	/* free udc --wait for the release() finished */
-- 
2.17.1

