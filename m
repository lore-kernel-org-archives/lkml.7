Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F83CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BBE222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfJSID1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:03:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfJSID1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:03:27 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B79C9EFC12F4DEFC2045;
        Sat, 19 Oct 2019 16:03:20 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 19 Oct 2019 16:03:14 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/8] net: hns3: add some cleanups & optimizations
Date:   Sat, 19 Oct 2019 16:03:48 +0800
Message-ID: <1571472236-17401-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes some cleanups and optimizations for the HNS3
ethernet driver.

[patch 1/8] removes unused and unnecessary structures.

[patch 2/8] uses a ETH_ALEN u8 array to replace two mac_addr_*
field in struct hclge_mac_mgr_tbl_entry_cmd.

[patch 3/8] optimizes the barrier used in the IO path.

[patch 4/8] introduces macro ring_to_netdev() to get netdevive
from struct hns3_enet_ring variable.

[patch 5/8] makes struct hns3_enet_ring to be cacheline aligned

[patch 6/8] adds a minor cleanup for hns3_handle_rx_bd().

[patch 7/8] removes linear data allocating for fraglist SKB.

[patch 8/8] clears hardware error when resetting.

---
note:
In previous patchset, there are some bugfixes which needs below
new feature, which is only in 'net-next' but not in 'net' now:
net: hns3: support tx-scatter-gather-fraglist feature
net: hns3: add support for spoof check setting

So, these bugfixes will be upstreamed when the patch needed is
on 'net' tree.
---

Guojia Liao (1):
  net: hns3: optimized MAC address in management table.

Jian Shen (1):
  net: hns3: log and clear hardware error after reset complete

Yunsheng Lin (6):
  net: hns3: remove struct hns3_nic_ring_data in hns3_enet module
  net: hns3: minor optimization for barrier in IO path
  net: hns3: introduce ring_to_netdev() in enet module
  net: hns3: make struct hns3_enet_ring cacheline aligned
  net: hns3: minor cleanup for hns3_handle_rx_bd()
  net: hns3: do not allocate linear data for fraglist skb

 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  24 +--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 204 ++++++++-------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  20 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  33 ++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   6 +-
 6 files changed, 111 insertions(+), 180 deletions(-)

-- 
2.7.4

