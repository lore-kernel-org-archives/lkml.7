Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D73C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 12:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D7321726
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 12:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390444AbfHCMcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 08:32:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390353AbfHCMcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 08:32:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 890D4767DC1D811C6EAB;
        Sat,  3 Aug 2019 20:31:58 +0800 (CST)
Received: from huawei.com (10.67.189.167) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sat, 3 Aug 2019
 20:31:50 +0800
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <xiaojiangfeng@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leeyou.li@huawei.com>, <xiaowei774@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH v1 0/3] net: hisilicon: Fix a few problems with hip04_eth
Date:   Sat, 3 Aug 2019 20:31:38 +0800
Message-ID: <1564835501-90257-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.167]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the use of the hip04_eth driver,
several problems were found,
which solved the hip04_tx_reclaim reentry problem,
fixed the problem that hip04_mac_start_xmit never
returns NETDEV_TX_BUSY
and the dma_map_single failed on the arm64 platform.

Jiangfeng Xiao (3):
  net: hisilicon: make hip04_tx_reclaim non-reentrant
  net: hisilicon: fix hip04-xmit never return TX_BUSY
  net: hisilicon: Fix dma_map_single failed on arm64

 drivers/net/ethernet/hisilicon/hip04_eth.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

-- 
1.8.5.6

