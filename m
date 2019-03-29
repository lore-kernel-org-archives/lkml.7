Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D72C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CF62173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfC2EO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:14:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5761 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfC2EO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:14:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0CCF78BE5F7916DBEE3E;
        Fri, 29 Mar 2019 12:14:25 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Fri, 29 Mar 2019 12:14:17 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 03/13] usb: dwc3: dwc3-of-simple: Add support for dwc3 of Hisilicon Soc Platform
Date:   Fri, 29 Mar 2019 12:13:59 +0800
Message-ID: <20190329041409.70138-4-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20190329041409.70138-1-chenyu56@huawei.com>
References: <20190329041409.70138-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the poweron and shutdown of dwc3 core
on Hisilicon Soc Platform.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 4c2771c5e727..0ed09d876542 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -98,7 +98,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	 * Some controllers need to toggle the usb3-otg reset before trying to
 	 * initialize the PHY, otherwise the PHY times out.
 	 */
-	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
+	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") ||
+			of_device_is_compatible(np, "hisilicon,hi3660-dwc3"))
 		simple->need_reset = true;
 
 	if (of_device_is_compatible(np, "amlogic,meson-axg-dwc3") ||
@@ -243,6 +244,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "amlogic,meson-axg-dwc3" },
 	{ .compatible = "amlogic,meson-gxl-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
+	{ .compatible = "hisilicon,hi3660-dwc3" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);
-- 
2.15.0-rc2

