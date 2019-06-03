Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7122FC28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384A527AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFCCK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 22:10:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfFCCK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:10:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B539C219D2BD07B5B9AF;
        Mon,  3 Jun 2019 10:10:55 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 3 Jun 2019 10:10:50 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 00/10] code optimizations & bugfixes for HNS3 driver
Date:   Mon, 3 Jun 2019 10:09:12 +0800
Message-ID: <1559527762-22931-1-git-send-email-tanhuazhong@huawei.com>
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

[patch 1/10] removes the redundant core reset type

[patch 2/10 - 3/10] fixes two VLAN related issues

[patch 4/10] fixes a TM issue

[patch 5/10 - 10/10] includes some patches related to RAS & MSI-X error

Change log:
V1->V2: removes two patches which needs to change HNS's infiniband
	driver as well, they will be upstreamed later with the
	infiniband's one.

Huazhong Tan (1):
  net: hns3: remove redundant core reset

Jian Shen (2):
  net: hns3: don't configure new VLAN ID into VF VLAN table when it's
    full
  net: hns3: fix VLAN filter restore issue after reset

Weihang Li (6):
  net: hns3: add a check to pointer in error_detected and slot_reset
  net: hns3: set ops to null when unregister ad_dev
  net: hns3: add handling of two bits in MAC tunnel interrupts
  net: hns3: remove setting bit of reset_requests when handling mac
    tunnel interrupts
  net: hns3: add opcode about query and clear RAS & MSI-X to special
    opcode
  net: hns3: delay and separate enabling of NIC and ROCE HW errors

Yunsheng Lin (1):
  net: hns3: set the port shaper according to MAC speed

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  41 ++-----
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   1 -
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |   6 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |  50 +++------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   9 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 123 +++++++++++++--------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   2 +-
 11 files changed, 117 insertions(+), 124 deletions(-)

-- 
2.7.4

