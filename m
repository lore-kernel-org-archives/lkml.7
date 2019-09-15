Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BC7C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE06214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfIOOFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 10:05:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfIOOFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:05:16 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B66F8ED16131DCAC250C;
        Sun, 15 Sep 2019 22:05:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sun, 15 Sep 2019 22:05:05 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <valentina.manea.m@gmail.com>, <shuah@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH v2] usbip: vhci_hcd indicate failed message
Date:   Sun, 15 Sep 2019 22:22:23 +0800
Message-ID: <20190915142223.158404-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <5D7E3D1A.5070906@bfs.de>
References: <5D7E3D1A.5070906@bfs.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the return value of vhci_init_attr_group and
sysfs_create_group is non-zero, which mean they failed
to init attr_group and create sysfs group, so it would
better add 'failed' message to indicate that.
This patch also change pr_err to dev_err to trace which
device is failed.

Fixes: 0775a9cbc694 ("usbip: vhci extension: modifications to vhci driver")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v2: change pr_err to dev_err.
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 000ab7225717..bea28ec846ee 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1185,12 +1185,12 @@ static int vhci_start(struct usb_hcd *hcd)
 	if (id == 0 && usb_hcd_is_primary_hcd(hcd)) {
 		err = vhci_init_attr_group();
 		if (err) {
-			pr_err("init attr group\n");
+			dev_err(hcd_dev(hcd), "init attr group failed\n");
 			return err;
 		}
 		err = sysfs_create_group(&hcd_dev(hcd)->kobj, &vhci_attr_group);
 		if (err) {
-			pr_err("create sysfs files\n");
+			dev_err(hcd_dev(hcd), "create sysfs files failed\n");
 			vhci_finish_attr_group();
 			return err;
 		}
-- 
2.20.1

