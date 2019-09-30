Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187F0C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA938218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfI3Og4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:36:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730780AbfI3Ogz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:36:55 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4FC4CFE66C605F3E5AC5;
        Mon, 30 Sep 2019 22:36:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 22:36:46 +0800
From:   John Garry <john.garry@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 0/6] SMMUv3 PMCG IMP DEF event support
Date:   Mon, 30 Sep 2019 22:33:45 +0800
Message-ID: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds IMP DEF event support for the SMMUv3 PMCG.

It is marked as an RFC as the method to identify the PMCG implementation
may be a quite disliked. And, in general, the series is somewhat
incomplete.

So the background is that the PMCG supports IMP DEF events, yet we have no
method to identify the PMCG to know the IMP DEF events.

A method for identifying the PMCG implementation could be using
PMDEVARCH, but we cannot rely on this being set properly, as whether this
is implemented is not defined in SMMUv3 spec.

Another method would be perf event aliasing, but this method of event
matching is based on CPU id, which would not guarantee same
uniqueness as PMCG implementation.

Yet another method could be to continue using ACPI OEM ID in the IORT
code, but this does not scale. And it is not suitable if we ever add DT
support to the PMCG driver.

The method used in this series is based on matching on the parent SMMUv3
IIDR. We store this IIDR contents in the arm smmu structure as the first
element, which means that we don't have to expose SMMU APIs - this is
the part which may be disliked.

The final two patches switch the pre-existing PMCG model identification
from ACPI OEM ID to the same parent SMMUv3 IIDR matching.

For now, we only consider SMMUv3' nodes being the associated node for
PMCG.

John Garry (6):
  ACPI/IORT: Set PMCG device parent
  iommu/arm-smmu-v3: Record IIDR in arm_smmu_device structure
  perf/smmuv3: Retrieve parent SMMUv3 IIDR
  perf/smmuv3: Support HiSilicon hip08 (hi1620) IMP DEF events
  perf/smmuv3: Match implementation options based on parent SMMU IIDR
  ACPI/IORT: Drop code to set the PMCG software-defined model

 drivers/acpi/arm64/iort.c     | 69 ++++++++++++++--------------
 drivers/iommu/arm-smmu-v3.c   |  5 +++
 drivers/perf/arm_smmuv3_pmu.c | 84 ++++++++++++++++++++++++++++++-----
 include/linux/acpi_iort.h     |  8 ----
 4 files changed, 112 insertions(+), 54 deletions(-)

-- 
2.17.1

