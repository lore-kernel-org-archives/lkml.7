Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40329C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F43E2238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfGZD1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:27:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2761 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfGZD1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:27:06 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D66A6B923C7304F05653;
        Fri, 26 Jul 2019 11:27:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 26 Jul 2019 11:26:57 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 00/11] net: hns3: some code optimizations & bugfixes & features
Date:   Fri, 26 Jul 2019 11:24:51 +0800
Message-ID: <1564111502-15504-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set includes code optimizations, bugfixes and features for
the HNS3 ethernet controller driver.

[patch 1/11] checks reset status before setting channel.

[patch 2/11] adds a NULL pointer checking.

[patch 3/11] removes reset level upgrading when current reset fails.

[patch 4/11] fixes a bug related to IRQ vector number initialization.

[patch 5/11] fixes a GFP flags errors when holding spin_lock.

[patch 6/11] modifies firmware version format.

[patch 7/11] adds some print information which is off by default.

[patch 8/11 - 9/11] adds two code optimizations about interrupt handler
and work task.

[patch 10/11] adds support for using order 1 pages with a 4K buffer.

[patch 11/11] modifies messages prints with dev_info() instead of
pr_info().

Change log:
V1->V2: fixes comments from Saeed Mahameed and
	removes previous [patch 11/11] which needs further discussion,
	adds a new patch [11/11] suggested by Saeed Mahameed.

Guangbin Huang (1):
  net: hns3: add a check for get_reset_level

Huazhong Tan (2):
  net: hns3: remove upgrade reset level when reset fail
  net: hns3: use dev_info() instead of pr_info()

Jian Shen (1):
  net: hns3: add reset checking before set channels

Yonglong Liu (2):
  net: hns3: fix mis-counting IRQ vector numbers issue
  net: hns3: adds debug messages to identify eth down cause

Yufeng Mo (2):
  net: hns3: change GFP flag during lock period
  net: hns3: modify firmware version display format

Yunsheng Lin (3):
  net: hns3: make hclge_service use delayed workqueue
  net: hns3: add interrupt affinity support for misc interrupt
  net: hns3: Add support for using order 1 pages with a 4K buffer

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   9 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  39 +++++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  15 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  41 +++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  10 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  14 +++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 137 ++++++++++++---------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  10 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  15 ++-
 10 files changed, 223 insertions(+), 74 deletions(-)

-- 
2.7.4

