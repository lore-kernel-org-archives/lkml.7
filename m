Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A817C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B5E21841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfFOMoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 08:44:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfFOMoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:44:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1293B78A29872D6DE2C8;
        Sat, 15 Jun 2019 20:44:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sat, 15 Jun 2019
 20:44:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <s-anna@ti.com>, <santosh.shilimkar@oracle.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] firmware: ti_sci: remove set but not used variable 'dev'
Date:   Sat, 15 Jun 2019 20:38:23 +0800
Message-ID: <20190615123823.15708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190614154421.17556-1-yuehaibing@huawei.com>
References: <20190614154421.17556-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/firmware/ti_sci.c: In function ti_sci_cmd_ring_config:
drivers/firmware/ti_sci.c:2035:17: warning: variable dev set but not used [-Wunused-but-set-variable]
drivers/firmware/ti_sci.c: In function ti_sci_cmd_ring_get_config:
drivers/firmware/ti_sci.c:2104:17: warning: variable dev set but not used [-Wunused-but-set-variable]
drivers/firmware/ti_sci.c: In function ti_sci_cmd_rm_udmap_tx_ch_cfg:
drivers/firmware/ti_sci.c:2287:17: warning: variable dev set but not used [-Wunused-but-set-variable]
drivers/firmware/ti_sci.c: In function ti_sci_cmd_rm_udmap_rx_ch_cfg:
drivers/firmware/ti_sci.c:2357:17: warning: variable dev set but not used [-Wunused-but-set-variable]

Use the 'dev' variable instead of 'info->dev' to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use the 'dev' variable as Suman Anna's suggestion
---
 drivers/firmware/ti_sci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 86b2727..c8da6e2 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2046,7 +2046,7 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
 				   sizeof(*req), sizeof(*resp));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
-		dev_err(info->dev, "RM_RA:Message config failed(%d)\n", ret);
+		dev_err(dev, "RM_RA:Message config failed(%d)\n", ret);
 		return ret;
 	}
 	req = (struct ti_sci_msg_rm_ring_cfg_req *)xfer->xfer_buf;
@@ -2062,7 +2062,7 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
 
 	ret = ti_sci_do_xfer(info, xfer);
 	if (ret) {
-		dev_err(info->dev, "RM_RA:Mbox config send fail %d\n", ret);
+		dev_err(dev, "RM_RA:Mbox config send fail %d\n", ret);
 		goto fail;
 	}
 
@@ -2071,7 +2071,7 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
 
 fail:
 	ti_sci_put_one_xfer(&info->minfo, xfer);
-	dev_dbg(info->dev, "RM_RA:config ring %u ret:%d\n", index, ret);
+	dev_dbg(dev, "RM_RA:config ring %u ret:%d\n", index, ret);
 	return ret;
 }
 
@@ -2115,7 +2115,7 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
 				   sizeof(*req), sizeof(*resp));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
-		dev_err(info->dev,
+		dev_err(dev,
 			"RM_RA:Message get config failed(%d)\n", ret);
 		return ret;
 	}
@@ -2125,7 +2125,7 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
 
 	ret = ti_sci_do_xfer(info, xfer);
 	if (ret) {
-		dev_err(info->dev, "RM_RA:Mbox get config send fail %d\n", ret);
+		dev_err(dev, "RM_RA:Mbox get config send fail %d\n", ret);
 		goto fail;
 	}
 
@@ -2150,7 +2150,7 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
 
 fail:
 	ti_sci_put_one_xfer(&info->minfo, xfer);
-	dev_dbg(info->dev, "RM_RA:get config ring %u ret:%d\n", index, ret);
+	dev_dbg(dev, "RM_RA:get config ring %u ret:%d\n", index, ret);
 	return ret;
 }
 
@@ -2298,7 +2298,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
 				   sizeof(*req), sizeof(*resp));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
-		dev_err(info->dev, "Message TX_CH_CFG alloc failed(%d)\n", ret);
+		dev_err(dev, "Message TX_CH_CFG alloc failed(%d)\n", ret);
 		return ret;
 	}
 	req = (struct ti_sci_msg_rm_udmap_tx_ch_cfg_req *)xfer->xfer_buf;
@@ -2323,7 +2323,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
 
 	ret = ti_sci_do_xfer(info, xfer);
 	if (ret) {
-		dev_err(info->dev, "Mbox send TX_CH_CFG fail %d\n", ret);
+		dev_err(dev, "Mbox send TX_CH_CFG fail %d\n", ret);
 		goto fail;
 	}
 
@@ -2332,7 +2332,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
 
 fail:
 	ti_sci_put_one_xfer(&info->minfo, xfer);
-	dev_dbg(info->dev, "TX_CH_CFG: chn %u ret:%u\n", params->index, ret);
+	dev_dbg(dev, "TX_CH_CFG: chn %u ret:%u\n", params->index, ret);
 	return ret;
 }
 
@@ -2368,7 +2368,7 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
 				   sizeof(*req), sizeof(*resp));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
-		dev_err(info->dev, "Message RX_CH_CFG alloc failed(%d)\n", ret);
+		dev_err(dev, "Message RX_CH_CFG alloc failed(%d)\n", ret);
 		return ret;
 	}
 	req = (struct ti_sci_msg_rm_udmap_rx_ch_cfg_req *)xfer->xfer_buf;
@@ -2392,7 +2392,7 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
 
 	ret = ti_sci_do_xfer(info, xfer);
 	if (ret) {
-		dev_err(info->dev, "Mbox send RX_CH_CFG fail %d\n", ret);
+		dev_err(dev, "Mbox send RX_CH_CFG fail %d\n", ret);
 		goto fail;
 	}
 
@@ -2401,7 +2401,7 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
 
 fail:
 	ti_sci_put_one_xfer(&info->minfo, xfer);
-	dev_dbg(info->dev, "RX_CH_CFG: chn %u ret:%d\n", params->index, ret);
+	dev_dbg(dev, "RX_CH_CFG: chn %u ret:%d\n", params->index, ret);
 	return ret;
 }
 
-- 
2.7.4


