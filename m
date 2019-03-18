Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A28FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1CE20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfCRNOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:14:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbfCRNOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:14:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E92BC38E2A6F7778E402;
        Mon, 18 Mar 2019 21:14:22 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Mar 2019 21:14:16 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can work well when smmu is enabled
Date:   Mon, 18 Mar 2019 21:12:41 +0800
Message-ID: <20190318131243.20716-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
(Report abort to device, no event recorded) to suppress the event messages
caused by the unexpected devices.
2. rewrite the patch description.

v1:
This patch series include two parts:
1. Patch1-2 use dummy STE tables with "ste abort" hardware feature to abort unexpected
   devices accessing. For more details, see the description in patch 2.
2. If the "ste abort" feature is not support, force the unexpected devices in the
   secondary kernel to use the memory maps which it used in the first kernel. For more
   details, see patch 5.

Zhen Lei (2):
  iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
  iommu/arm-smmu-v3: to make smmu can be enabled in the kdump kernel

 drivers/iommu/arm-smmu-v3.c | 88 +++++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 23 deletions(-)

-- 
1.8.3


