Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CD0C10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366F120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfDNBuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 21:50:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbfDNBtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 21:49:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D1E0FC5ED3DBA89E735;
        Sun, 14 Apr 2019 09:48:57 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Sun, 14 Apr 2019 09:48:48 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Sun, 14 Apr 2019 09:47:34 +0800
Message-ID: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set includes code optimizations and bugfixes for the HNS3
ethernet controller driver.

[patch 1/12 - 4/12] optimizes the VLAN freature and adds support for port
based VLAN, fixes some related bugs about the current implementation.

[patch 5/12 - 12/12] includes some other code optimizations for the HNS3
ethernet controller driver.

Change log:
V1->V2: modifies some patches' commint log and code.

Jian Shen (5):
  net: hns3: modify VLAN initialization to be compatible with port based
    VLAN
  net: hns3: fix VLAN offload handle for VLAN inserted by port
  net: hns3: fix set port based VLAN for PF
  net: hns3: fix set port based VLAN issue for VF
  net: hns3: do not initialize MDIO bus when PHY is inexistent

Peng Li (2):
  net: hns3: free the pending skb when clean RX ring
  net: hns3: code optimization for command queue' spin lock

Weihang Li (1):
  net: hns3: set dividual reset level for all RAS and MSI-X errors

Yunsheng Lin (4):
  net: hns3: minor refactor for hns3_rx_checksum
  net: hns3: add hns3_gro_complete for HW GRO process
  net: hns3: always assume no drop TC for performance reason
  net: hns3: divide shared buffer between TC

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   3 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   9 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 256 ++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |   4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 956 +++++++++++++--------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 378 ++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  29 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  42 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |   4 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  51 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   2 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  11 +-
 14 files changed, 1224 insertions(+), 530 deletions(-)

-- 
2.7.4

