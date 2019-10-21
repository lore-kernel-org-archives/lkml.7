Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B64FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29DD2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfJUKV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:21:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37272 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfJUKVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:21:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7689C200123;
        Mon, 21 Oct 2019 12:21:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A129200A5F;
        Mon, 21 Oct 2019 12:21:17 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1190D402F0;
        Mon, 21 Oct 2019 18:21:10 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>,
        Nikhil Badola <nikhil.badola@freescale.com>
Subject: [PATCH v1] usb: gadget: Correct NULL pointer checking in fsl gadget
Date:   Mon, 21 Oct 2019 18:21:53 +0800
Message-Id: <20191021102153.16435-3-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021102153.16435-1-yinbo.zhu@nxp.com>
References: <20191021102153.16435-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Correct NULL pointer checking for endpoint descriptor
before it gets dereferenced

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 381fdff12d4e..980cb1382851 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1052,10 +1052,11 @@ static int fsl_ep_fifo_status(struct usb_ep *_ep)
 	u32 bitmask;
 	struct ep_queue_head *qh;
 
-	ep = container_of(_ep, struct fsl_ep, ep);
-	if (!_ep || (!ep->ep.desc && ep_index(ep) != 0))
+	if (!_ep || _ep->desc || !(_ep->desc->bEndpointAddress&0xF))
 		return -ENODEV;
 
+	ep = container_of(_ep, struct fsl_ep, ep);
+
 	udc = (struct fsl_udc *)ep->udc;
 
 	if (!udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN)
-- 
2.17.1

