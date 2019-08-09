Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8221C32757
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 02:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CF52054F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 02:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405228AbfHICdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 22:33:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733258AbfHICdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 22:33:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EABEE274636517B80210;
        Fri,  9 Aug 2019 10:33:31 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 10:33:21 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] net: hns3: add some bugfixes & optimizations & cleanups for HNS3 driver
Date:   Fri, 9 Aug 2019 10:31:06 +0800
Message-ID: <1565317878-31806-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set includes code optimizations, bugfixes and cleanups for
the HNS3 ethernet controller driver.

[patch 01/12] fixes a GFP flag error.

[patch 02/12] fixes a VF interrupt error.

[patch 03/12] adds a cleanup for VLAN handling.

[patch 04/12] fixes a bug in debugfs.

[patch 05/12] modifies pause displaying format.

[patch 06/12] adds more DFX information for ethtool -d.

[patch 07/12] adds more TX statistics information.

[patch 08/12] adds a check for TX BD number.

[patch 09/12] adds a cleanup for dumping NCL_CONFIG.

[patch 10/12] refines function for querying MAC pause statistics.

[patch 11/12] adds a handshake with VF when doing PF reset.

[patch 12/12] refines some macro definitions.

Guangbin Huang (1):
  net: hns3: add DFX registers information for ethtool -d

Guojia Liao (1):
  net: hns3: refine some macro definitions

Huazhong Tan (2):
  net: hns3: fix interrupt clearing error for VF
  net: hns3: add handshake with VF for PF reset

Yonglong Liu (1):
  net: hns3: modify how pause options is displayed

Yufeng Mo (3):
  net: hns3: add input length check for debugfs write function
  net: hns3: add function display NCL_CONFIG info
  net: hns3: refine MAC pause statistics querying function

Yunsheng Lin (3):
  net: hns3: clean up for vlan handling in hns3_fill_desc_vtags
  net: hns3: add some statitics info to tx process
  net: hns3: add check for max TX BD num for tso and non-tso case

Zhongzhu Liu (1):
  net: hns3: fix GFP flag error in hclge_mac_update_stats()

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  15 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   4 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 268 ++++++------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   7 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   7 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  64 +--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 454 +++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   2 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  28 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   4 +-
 11 files changed, 615 insertions(+), 242 deletions(-)

-- 
2.7.4

