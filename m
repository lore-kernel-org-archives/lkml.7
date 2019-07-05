Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68734C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460A821850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfGEGMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 02:12:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbfGEGMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 02:12:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 978DE2030F86A25F97CB;
        Fri,  5 Jul 2019 14:12:41 +0800 (CST)
Received: from huawei.com (10.67.189.167) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 5 Jul 2019
 14:12:35 +0800
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <dingtianhong@huawei.com>, <xiaojiangfeng@huawei.com>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leeyou.li@huawei.com>, <xiekunxun@huawei.com>,
        <jianping.liu@huawei.com>, <nixiaoming@huawei.com>
Subject: [PATCH 09/10] net: hisilicon: Add an rx_desc to adapt HI13X1_GMAC
Date:   Fri, 5 Jul 2019 14:12:29 +0800
Message-ID: <1562307149-103877-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.167]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI13X1 changed the offsets and bitmaps for rx_desc
registers in the same peripheral device on different
models of the hip04_eth.

Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index c578934..780fc46 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -171,11 +171,20 @@ struct tx_desc {
 } __aligned(64);
 
 struct rx_desc {
+#if defined(CONFIG_HI13X1_GMAC)
+	u32 reserved1[3];
+	u16 pkt_len;
+	u16 reserved_16;
+	u32 reserved2[6];
+	u32 pkt_err;
+	u32 reserved3[5];
+#else
 	u16 reserved_16;
 	u16 pkt_len;
 	u32 reserve1[3];
 	u32 pkt_err;
 	u32 reserve2[4];
+#endif
 };
 
 struct hip04_priv {
-- 
1.8.5.6

