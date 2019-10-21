Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A1CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95002070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfJUKVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:21:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37208 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfJUKVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:21:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5344B2000C1;
        Mon, 21 Oct 2019 12:21:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 54E86200A4E;
        Mon, 21 Oct 2019 12:21:16 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E0BBD402E5;
        Mon, 21 Oct 2019 18:21:09 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>,
        Nikhil Badola <nikhil.badola@freescale.com>
Subject: [PATCH v1] usb: fsl: Remove unused variable
Date:   Mon, 21 Oct 2019 18:21:52 +0800
Message-Id: <20191021102153.16435-2-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021102153.16435-1-yinbo.zhu@nxp.com>
References: <20191021102153.16435-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Remove unused variable td_complete

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Reviewed-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 9a05863b2876..381fdff12d4e 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1595,14 +1595,13 @@ static int process_ep_req(struct fsl_udc *udc, int pipe,
 		struct fsl_req *curr_req)
 {
 	struct ep_td_struct *curr_td;
-	int	td_complete, actual, remaining_length, j, tmp;
+	int	actual, remaining_length, j, tmp;
 	int	status = 0;
 	int	errors = 0;
 	struct  ep_queue_head *curr_qh = &udc->ep_qh[pipe];
 	int direction = pipe % 2;
 
 	curr_td = curr_req->head;
-	td_complete = 0;
 	actual = curr_req->req.length;
 
 	for (j = 0; j < curr_req->dtd_count; j++) {
@@ -1647,11 +1646,9 @@ static int process_ep_req(struct fsl_udc *udc, int pipe,
 				status = -EPROTO;
 				break;
 			} else {
-				td_complete++;
 				break;
 			}
 		} else {
-			td_complete++;
 			VDBG("dTD transmitted successful");
 		}
 
-- 
2.17.1

