Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2FAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7854120820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfDJPQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:16:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733018AbfDJPQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:16:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DDED374;
        Wed, 10 Apr 2019 08:16:09 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4E433F59C;
        Wed, 10 Apr 2019 08:16:07 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, zhangfei.gao@foxmail.com
Subject: [PATCH v3 0/1] IOMMU SVA device driver interface
Date:   Wed, 10 Apr 2019 16:15:15 +0100
Message-Id: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the device driver API for SVA (Shared Virtual Addressing).
Since v2 I removed the set_sva_ops() IOMMU operation as suggested by
Joerg, instead doing the sva_ops assignment in iommu.c.

The four dev_feature functions are implemented by Lu Baolu's IOMMU-aware
mdev series [2].

	iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_SVA) -> true/false
	iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_SVA) -> true/false

Patch 1/1 adds the next four functions, once the SVA feature is enabled:

	iommu_sva_bind(dev, mm, drvdata) -> handle
	iommu_sva_set_ops(handle, iommu_sva_ops) -> 0/err
	iommu_sva_get_pasid(handle) -> pasid/invalid
	iommu_sva_unbind(handle)

Generic implementation and SMMUv3 support can be found at [3].

[1] https://lore.kernel.org/lkml/20190320150258.3240-1-jean-philippe.brucker@arm.com/
[2] https://lore.kernel.org/lkml/20190325013036.18400-1-baolu.lu@linux.intel.com/
[3] git://linux-arm.org/linux-jpb.git sva/current
    http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current

Jean-Philippe Brucker (1):
  iommu: Bind process address spaces to devices

 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  70 ++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

-- 
2.21.0

