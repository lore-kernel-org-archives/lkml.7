Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5D5C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DBA2245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfLEMQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:16:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729048AbfLEMQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:16:22 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B4B95CFC33B79EDECFB;
        Thu,  5 Dec 2019 20:16:18 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Dec 2019 20:16:08 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] tty: serial: 8250: remove set but unused variable
Date:   Thu, 5 Dec 2019 20:11:43 +0800
Message-ID: <1575547903-52355-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:
drivers/tty/serial/8250/serial_cs.c: In function multi_config:
drivers/tty/serial/8250/serial_cs.c:562:7: warning: variable err set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/tty/serial/8250/serial_cs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index c8186a0..eeda6a0 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -559,16 +559,13 @@ static int multi_config(struct pcmcia_device *link)
 	 */
 	if (info->manfid == MANFID_OXSEMI || (info->manfid == MANFID_POSSIO &&
 				info->prodid == PRODID_POSSIO_GCC)) {
-		int err;
-
 		if (link->config_index == 1 ||
 		    link->config_index == 3) {
-			err = setup_serial(link, info, base2,
-					link->irq);
+			setup_serial(link, info, base2, link->irq);
 			base2 = link->resource[0]->start;
 		} else {
-			err = setup_serial(link, info, link->resource[0]->start,
-					link->irq);
+			setup_serial(link, info, link->resource[0]->start,
+				     link->irq);
 		}
 		info->c950ctrl = base2;
 
-- 
1.7.12.4

