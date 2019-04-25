Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7167C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3CC205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfDYMoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:44:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731331AbfDYMoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:44:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2ED60CD98E484F0AA5ED;
        Thu, 25 Apr 2019 20:44:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 25 Apr 2019 20:44:02 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V3 net-next 00/11] code optimizations & bugfixes for HNS3 driver
Date:   Thu, 25 Apr 2019 20:42:44 +0800
Message-ID: <1556196175-65389-1-git-send-email-tanhuazhong@huawei.com>
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

[patch 1/11 - 3/11] fixes some bugs about the IO path

[patch 4/11 - 6/11] includes some optimization and bugfixes
about mailbox handling

[patch 7/11 - 11/11] adds misc code optimizations and bugfixes.

Change log:
V2->V3: fixes comments from Neil Horman, removes [patch 8/12]
V1->V2: adds modification on [patch 8/12]

Huazhong Tan (6):
  net: hns3: stop sending keep alive msg when VF command queue needs
    reinit
  net: hns3: use atomic_t replace u32 for arq's count
  net: hns3: use a reserved byte to identify need_resp flag
  net: hns3: not reset TQP in the DOWN while VF resetting
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
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  7 +--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  5 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  8 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  9 ++-
 10 files changed, 69 insertions(+), 55 deletions(-)

-- 
2.7.4

