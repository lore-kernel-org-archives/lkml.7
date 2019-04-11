Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B765C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63AE2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDKM0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:26:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbfDKM0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:26:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2333595516A75313C933;
        Thu, 11 Apr 2019 20:26:43 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:26:32 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Thu, 11 Apr 2019 20:25:19 +0800
Message-ID: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for
the HNS3 ethernet controller driver.

Jian Shen (5):
  net: hns3: fix VLAN initialization to be compatible with port base
    insert VLAN
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
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 266 ++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |   4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 956 +++++++++++++--------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 341 ++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  29 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  41 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |   4 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  51 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   2 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  11 +-
 14 files changed, 1205 insertions(+), 521 deletions(-)

-- 
2.7.4

