Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A98C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6F20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfDDIUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:20:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727212AbfDDITM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:19:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CFCC58AFB2A714EE924A;
        Thu,  4 Apr 2019 16:19:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:19:02 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <sergei.shtylyov@cogentembedded.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Thu, 4 Apr 2019 16:17:47 +0800
Message-ID: <1554365879-7932-1-git-send-email-tanhuazhong@huawei.com>
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

Change log:
V1->V2: fixes comments from Sergei Shtylyov

Huazhong Tan (4):
  net: hns3: simplify hclgevf_cmd_csq_clean
  net: hns3: check resetting status in hns3_get_stats()
  net: hns3: prevent change MTU when resetting
  net: hns3: modify HNS3_NIC_STATE_INITED flag in
    hns3_reset_notify_uninit_enet

Jian Shen (2):
  net: hns3: add protect when handling mac addr list
  net: hns3: split function hnae3_match_n_instantiate()

Peng Li (2):
  net: hns3: check 1000M half for hns3_ethtool_ops.set_link_ksettings
  net: hns3: return 0 and print warning when hit duplicate MAC

Yonglong Liu (1):
  net: hns3: reduce resources use in kdump kernel

Yunsheng Lin (2):
  net: hns3: minor optimization for ring_space
  net: hns3: minor optimization for datapath

liuzhongzhu (1):
  net: hns3: modify the VF network port media type acquisition method

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        | 40 +++++++++++----------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 41 +++++++++++++++++-----
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    | 15 +++-----
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  9 +++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 30 ++++++++++++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 23 +++++++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   | 35 ++++++++++++------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 23 ++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  1 -
 10 files changed, 163 insertions(+), 55 deletions(-)

-- 
2.7.4

