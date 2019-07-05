Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F946C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8AA218A4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfGEGLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 02:11:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbfGEGLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 02:11:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7FFC1CF4EB6D5BD339E6;
        Fri,  5 Jul 2019 14:11:31 +0800 (CST)
Received: from huawei.com (10.67.189.167) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 5 Jul 2019
 14:11:25 +0800
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <dingtianhong@huawei.com>, <xiaojiangfeng@huawei.com>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leeyou.li@huawei.com>, <xiekunxun@huawei.com>,
        <jianping.liu@huawei.com>, <nixiaoming@huawei.com>
Subject: [PATCH 04/10] net: hisilicon: HI13X1_GMAX skip write LOCAL_PAGE_REG
Date:   Fri, 5 Jul 2019 14:11:13 +0800
Message-ID: <1562307073-103681-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.167]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI13X1_GMAC changed the offsets and bitmaps for
GE_TX_LOCAL_PAGE_REG registers in the same peripheral
device on different models of the hip04_eth. With the
default configuration, HI13X1_GMAC can also work without
any writes to the GE_TX_LOCAL_PAGE_REG register.

Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index d8f0619..fe61b01 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -308,8 +308,10 @@ static void hip04_config_fifo(struct hip04_priv *priv)
 	val |= GE_RX_STRIP_PAD | GE_RX_PAD_EN;
 	writel_relaxed(val, priv->base + GE_RECV_CONTROL_REG);
 
+#ifndef CONFIG_HI13X1_GMAC
 	val = GE_AUTO_NEG_CTL;
 	writel_relaxed(val, priv->base + GE_TX_LOCAL_PAGE_REG);
+#endif
 }
 
 static void hip04_mac_enable(struct net_device *ndev)
-- 
1.8.5.6

