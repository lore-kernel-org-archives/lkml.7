Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647E6C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF7121736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfDSDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727284AbfDSDHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BE0C6D45FB6480206468;
        Fri, 19 Apr 2019 11:07:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Apr 2019 11:06:57 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] net: hns3: add some DFX info for HNS3 driver
Date:   Fri, 19 Apr 2019 11:05:35 +0800
Message-ID: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds some DFX information to HNS3 driver, for easily
debug some problems, and fixes some related bugs.

[patch 1/12 - 4/12] adds debug info about reset & interrupt events

[patch 5/12 - 7/12] adds debug info about TX time out & fixes
related bugs

[patch 8/12] adds support for setting netif message level

[patch 9/12 - 10/12] adds debugfs command to dump NCL & MAC info

[patch 11/12] adds VF's queue statistics info updating

[patch 12/12] adds a check for debugfs help function to decide which
commands are supportable

Huazhong Tan (4):
  net: hns3: add reset statistics info for PF
  net: hns3: add reset statistics for VF
  net: hns3: add some debug information for hclge_check_event_cause
  net: hns3: add some debug info for hclgevf_get_mbx_resp()

Jian Shen (3):
  net: hns3: refine tx timeout count handle
  net: hns3: fix loop condition of hns3_get_tx_timeo_queue_info()
  net: hns3: dump more information when tx timeout happens

Weihang Li (2):
  net: hns3: add support for dump ncl config by debugfs
  net: hns3: Add handling of MAC tunnel interruption

Yonglong Liu (1):
  net: hns3: Add support for netif message level settings

Yufeng Mo (1):
  net: hns3: add function type check for debugfs help information

liuzhongzhu (1):
  net: hns3: add queue's statistics update to service task

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   6 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   9 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 104 ++++++++++++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   5 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  18 ++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   6 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 110 +++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |  51 ++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   4 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  64 +++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  24 ++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  38 ++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  14 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   9 +-
 14 files changed, 437 insertions(+), 25 deletions(-)

-- 
2.7.4

