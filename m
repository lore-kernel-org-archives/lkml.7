Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE3DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755FE2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCKJin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:38:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfCKJin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:38:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E07CFDEEE38C8976245B;
        Mon, 11 Mar 2019 17:38:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Mon, 11 Mar 2019 17:38:39 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>
Subject: [PATCH v2] serial: sh-sci: Missing uart_unregister_driver() on error in sci_probe_single()
Date:   Mon, 11 Mar 2019 17:51:15 +0800
Message-ID: <20190311095115.156774-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing uart_unregister_driver() before return
from sci_probe_single() in the error handling case.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v1->v2: add uart_unregister_driver() if mctrl_gpio_init is failed.
 drivers/tty/serial/sh-sci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 64bbeb7d7e0c..fb5034390795 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3254,12 +3254,16 @@ static int sci_probe_single(struct platform_device *dev,
 	mutex_unlock(&sci_uart_registration_lock);
 
 	ret = sci_init_single(dev, sciport, index, p, false);
-	if (ret)
+	if (ret) {
+		uart_unregister_driver(&sci_uart_driver);
 		return ret;
+	}
 
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
-	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
+	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS) {
+		uart_unregister_driver(&sci_uart_driver);
 		return PTR_ERR(sciport->gpios);
+	}
 
 	if (sciport->has_rtscts) {
 		if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
-- 
2.20.1

