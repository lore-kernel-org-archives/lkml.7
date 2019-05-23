Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E102C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129802075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfEWSHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:07:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52070 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731093AbfEWSHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:07:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8924374;
        Thu, 23 May 2019 11:07:03 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AC1A3F5AF;
        Thu, 23 May 2019 11:07:01 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org, alex.williamson@redhat.com
Cc:     jacob.jun.pan@linux.intel.com, eric.auger@redhat.com,
        ashok.raj@intel.com, yi.l.liu@linux.intel.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 0/4] iommu: Add device fault reporting API
Date:   Thu, 23 May 2019 19:06:09 +0100
Message-Id: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow device drivers and VFIO to get notifications on IOMMU translation
fault, and to handle recoverable faults (PCI PRI). These four patches
are relatively mature since they are required by three different series,
and have been under discussion for a while:

* Nested translation support for SMMUv3 [1].
* vSVA for VT-d [2].
* My generic host SVA implementation.

I reworked patch 4 according to previous discussions, and moved the page
response structure to UAPI. For the other patches I only fixed comments
and whitespaces. Please have a look and see if it works for you.

[1] [PATCH v7 00/23] SMMUv3 Nested Stage Setup
    https://lore.kernel.org/lkml/20190408121911.24103-1-eric.auger@redhat.com/
[2] [PATCH v3 00/16] Shared virtual address IOMMU and VT-d support
    https://lore.kernel.org/lkml/1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com/

Jacob Pan (3):
  driver core: Add per device iommu param
  iommu: Introduce device fault data
  iommu: Introduce device fault report API

Jean-Philippe Brucker (1):
  iommu: Add recoverable fault reporting

 drivers/iommu/iommu.c      | 218 +++++++++++++++++++++++++++++++++++++
 include/linux/device.h     |   3 +
 include/linux/iommu.h      |  91 ++++++++++++++++
 include/uapi/linux/iommu.h | 152 ++++++++++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.21.0

