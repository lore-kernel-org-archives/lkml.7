Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB33C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245B02175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfDXLGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:06:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfDXLGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:06:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2C3F2B0484622EEEA8B9;
        Wed, 24 Apr 2019 19:06:47 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 19:06:40 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Wed, 24 Apr 2019 19:05:19 +0800
Message-ID: <1556103931-64031-1-git-send-email-tanhuazhong@huawei.com>
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

[patch 1/12 - 3/12] fixes some bugs about the IO path

[patch 4/12 - 6/12] includes some optimization and bugfixes
about mailbox message handling

[patch 7/12 - 12/12] adds misc code optimizations and bugfixes.

Change log:
V1->V2: adds modification on [patch 8/12]

Huazhong Tan (7):
  net: hns3: stop sending keep alive msg when VF command queue needs
    reinit
  net: hns3: use atomic_t replace u32 for arq's count
  net: hns3: use a reserved byte to identify need_resp flag
  net: hns3: not reset TQP in the DOWN while VF resetting
  net: hns3: stop schedule reset service while unloading driver
  net: hns3: fix pause configure fail problem
  net: hns3: prevent double free in hns3_put_ring_config()

Weihang Li (1):
  net: hns3: remove reset after command send failed

Yunsheng Lin (3):
  net: hns3: fix data race between ring->next_to_clean
  net: hns3: fix for TX clean num when cleaning TX BD
  net: hns3: handle the BD info on the last BD of the packet

liuzhongzhu (1):
  net: hns3: extend the loopback state acquisition time

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  7 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 65 +++++++++++++---------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  7 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 10 ----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  8 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  7 +--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  5 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 12 ++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  9 ++-
 11 files changed, 76 insertions(+), 57 deletions(-)

-- 
2.7.4

