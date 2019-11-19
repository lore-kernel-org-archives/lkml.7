Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3A2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B972231A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKSRwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:52:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:17665 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfKSRwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:52:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 09:51:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,218,1571727600"; 
   d="scan'208";a="209488266"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 19 Nov 2019 09:51:58 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 0/8] VT-d Native Shared virtual memory cleanup and fixes
Date:   Tue, 19 Nov 2019 09:56:24 -0800
Message-Id: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly extracted from nested SVA/SVM series based on review comments of v7.
https://lkml.org/lkml/2019/10/24/852

This series also adds a few important fixes for native use of SVA. Nested
SVA new code will be submitted separately as a smaller set. Based on the
core branch of IOMMU tree staged for v5.5, where common APIs for vSVA were
applied.
git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core

Changelog:
V3
	- Squashed 1/10 & 2/10
	- Deleted "8/10 Fix PASID cache flush" from this series
	- Addressed reviews from Eric Auger and Baolu
V2
	- Coding style fixes based on Baolu's input, no functional change
	- Added Acked-by tags.

Thanks,

Jacob


Jacob Pan (8):
  iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks
  iommu/vt-d: Match CPU and IOMMU paging mode
  iommu/vt-d: Reject SVM bind for failed capability check
  iommu/vt-d: Avoid duplicated code for PASID setup
  iommu/vt-d: Fix off-by-one in PASID allocation
  iommu/vt-d: Replace Intel specific PASID allocator with IOASID
  iommu/vt-d: Avoid sending invalid page response
  iommu/vt-d: Misc macro clean up for SVM

 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/intel-iommu.c |  23 +++----
 drivers/iommu/intel-pasid.c |  96 ++++++++------------------
 drivers/iommu/intel-svm.c   | 162 +++++++++++++++++++++++++-------------------
 include/linux/intel-iommu.h |   5 +-
 5 files changed, 134 insertions(+), 153 deletions(-)

-- 
2.7.4

