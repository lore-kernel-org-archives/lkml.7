Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ECBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9062146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfCTPD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:03:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41580 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfCTPD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:03:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844D91650;
        Wed, 20 Mar 2019 08:03:56 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B69713F614;
        Wed, 20 Mar 2019 08:03:54 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, alex.williamson@redhat.com,
        zhangfei.gao@foxmail.com
Subject: [PATCH v2 0/1] IOMMU SVA device driver interface
Date:   Wed, 20 Mar 2019 15:02:57 +0000
Message-Id: <20190320150258.3240-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the device driver API for SVA (Shared Virtual Addressing).
Changes since v1 [1]:

* Following comments, return a handle rather than a PASID. I agree that
  it makes things easier for device drivers as well, because they don't
  need to worry about the unbind()/mm_exit() race as much. Previously
  they couldn't issue an unbind() if the mm exited since the PASID could
  have been reallocated.

* If a handle already exists, reuse it and take a reference instead of
  returning EEXIST. As noted by Zhangfei and myself during development,
  it can make things a bit easier for device drivers that need to handle
  multiple threads in a process issuing bind() for the same dev and mm.

The four dev_feature functions are implemented by Lu Baolu's IOMMU-aware
mdev series [2].

	iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_SVA) -> true/false
	iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_SVA) -> true/false

Patch 1/1 adds the next four functions, once the SVA feature is enabled:

	iommu_sva_bind(dev, mm, drvdata) -> handle

	/*
	 * Only exit_mm() for now, but later callbacks to deal with
	 * unhandled PRI faults and possible others:
	 */
	iommu_sva_set_ops(handle, iommu_sva_ops) -> 0/err

	iommu_sva_get_pasid(handle) -> pasid/invalid

	iommu_sva_unbind(handle)

Full support for the SMMUv3 can be found at [3]

[1] https://lore.kernel.org/lkml/20190220142759.33308-1-jean-philippe.brucker@arm.com/
[2] https://lore.kernel.org/lkml/20190213040301.23021-10-baolu.lu@linux.intel.com/T/
[3] git://linux-arm.org/linux-jpb.git sva/current
    http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current

Jean-Philippe Brucker (1):
  iommu: Bind process address spaces to devices

 drivers/iommu/iommu.c | 105 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  71 ++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

-- 
2.21.0

