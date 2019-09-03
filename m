Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95291C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71703206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfICMFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:05:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbfICMFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:05:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4CCB86AD5A64D6FD21B;
        Tue,  3 Sep 2019 20:05:08 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 20:04:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <pawell@cadence.com>,
        <felipe.balbi@linux.intel.com>, <yuehaibing@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: cdns3: remove set but not used variable 'priv_dev'
Date:   Tue, 3 Sep 2019 20:04:45 +0800
Message-ID: <20190903120445.22204-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/usb/cdns3/gadget.c: In function '__cdns3_gadget_init':
drivers/usb/cdns3/gadget.c:2665:23: warning:
 variable 'priv_dev' set but not used [-Wunused-but-set-variable]
drivers/usb/cdns3/gadget.c: In function cdns3_start_all_request:
drivers/usb/cdns3/gadget.c:357:24: warning:
 variable priv_req set but not used [-Wunused-but-set-variable]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/cdns3/gadget.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 3094ad6..ddac638 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -354,13 +354,11 @@ enum usb_device_speed cdns3_get_speed(struct cdns3_device *priv_dev)
 static int cdns3_start_all_request(struct cdns3_device *priv_dev,
 				   struct cdns3_endpoint *priv_ep)
 {
-	struct cdns3_request *priv_req;
 	struct usb_request *request;
 	int ret = 0;
 
 	while (!list_empty(&priv_ep->deferred_req_list)) {
 		request = cdns3_next_request(&priv_ep->deferred_req_list);
-		priv_req = to_cdns3_request(request);
 
 		ret = cdns3_ep_run_transfer(priv_ep, request);
 		if (ret)
@@ -2664,7 +2662,6 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 
 static int __cdns3_gadget_init(struct cdns3 *cdns)
 {
-	struct cdns3_device *priv_dev;
 	int ret = 0;
 
 	cdns3_drd_switch_gadget(cdns, 1);
@@ -2674,8 +2671,6 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 	if (ret)
 		return ret;
 
-	priv_dev = cdns->gadget_dev;
-
 	/*
 	 * Because interrupt line can be shared with other components in
 	 * driver it can't use IRQF_ONESHOT flag here.
-- 
2.7.4


