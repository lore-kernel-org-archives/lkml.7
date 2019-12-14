Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E5C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 02:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6322073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 02:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLNCGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 21:06:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfLNCGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 21:06:42 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8E31C32B7B9D8CF3B86;
        Sat, 14 Dec 2019 10:06:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 14 Dec 2019 10:06:29 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/5] net: hns3: some optimizaions related to work task
Date:   Sat, 14 Dec 2019 10:06:36 +0800
Message-ID: <1576289201-57017-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refactors the work task of the HNS3 ethernet driver.

[patch 1/5] uses delayed workqueue to replace the timer for
hclgevf_service task, make the code simpler.

[patch 2/5] & [patch 3/5] unifies current mailbox, reset and
service work into one.

[patch 4/5] allocates a private work queue with WQ_MEM_RECLAIM
for the HNS3 driver.

[patch 5/5] adds a new flag to indicate whether reset fails,
and prevent scheduling service task to handle periodic task
when this flag has been set.

Guojia Liao (1):
  net: hns3: do not schedule the periodic task when reset fail

Yunsheng Lin (4):
  net: hns3: schedule hclgevf_service by using delayed workqueue
  net: hns3: remove mailbox and reset work in hclge_main
  net: hns3: remove unnecessary work in hclgevf_main
  net: hns3: allocate WQ with WQ_MEM_RECLAIM flag

 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  10 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 179 ++++++++++++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  18 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   1 -
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 209 ++++++++++-----------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  13 +-
 6 files changed, 242 insertions(+), 188 deletions(-)

-- 
2.7.4

