Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3993C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742E620882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfDDIrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:47:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728638AbfDDIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:47:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0EDA92F0EBF77615D19;
        Thu,  4 Apr 2019 16:47:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:46:53 +0800
From:   Yonglong Liu <liuyonglong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH net 0/6] net: hns: bugfixes for HNS Driver
Date:   Thu, 4 Apr 2019 16:46:41 +0800
Message-ID: <1554367607-130891-1-git-send-email-liuyonglong@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fix some bugs that were found in the test of
various scenarios, or identify by KASAN/sparse.

Liubin Shu (1):
  net: hns: fix KASAN: use-after-free in hns_nic_net_xmit_hw()

Yonglong Liu (5):
  net: hns: Use NAPI_POLL_WEIGHT for hns driver
  net: hns: Fix probabilistic memory overwrite when HNS driver
    initialized
  net: hns: fix ICMP6 neighbor solicitation messages discard problem
  net: hns: Fix WARNING when remove HNS driver with SMMU enabled
  net: hns: Fix sparse: some warnings in HNS drivers

 drivers/net/ethernet/hisilicon/hns/hnae.c          |  4 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h          |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |  4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 53 ++++++++++++++--------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |  2 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  6 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |  4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |  4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  | 12 ++---
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      | 12 ++---
 drivers/net/ethernet/hisilicon/hns_mdio.c          | 18 +++-----
 14 files changed, 69 insertions(+), 58 deletions(-)

-- 
2.8.1

