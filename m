Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D78CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EA027B0B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfFCO6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:58:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfFCO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:58:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A66980D;
        Mon,  3 Jun 2019 07:58:37 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AAD03F246;
        Mon,  3 Jun 2019 07:58:35 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org, alex.williamson@redhat.com
Cc:     jacob.jun.pan@linux.intel.com, eric.auger@redhat.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: [PATCH v2 0/4] iommu: Add device fault reporting API
Date:   Mon,  3 Jun 2019 15:57:45 +0100
Message-Id: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow device drivers and VFIO to get notified on IOMMU translation
fault, and handle recoverable faults (PCI PRI). Several series require
this API (Intel VT-d and Arm SMMUv3 nested support, as well as the
generic host SVA implementation).

Changes since v1 [1]:
* Allocate iommu_param earlier, in iommu_probe_device().
* Pass struct iommu_fault to fault handlers, instead of the
  iommu_fault_event wrapper.
* Removed unused iommu_fault_event::iommu_private.
* Removed unnecessary iommu_page_response::addr.
* Added iommu_page_response::version, which would allow to introduce a
  new incompatible iommu_page_response structure (as opposed to just
  adding a flag + field).

[1] [PATCH 0/4] iommu: Add device fault reporting API
    https://lore.kernel.org/lkml/20190523180613.55049-1-jean-philippe.brucker@arm.com/

Jacob Pan (3):
  driver core: Add per device iommu param
  iommu: Introduce device fault data
  iommu: Introduce device fault report API

Jean-Philippe Brucker (1):
  iommu: Add recoverable fault reporting

 drivers/iommu/iommu.c      | 236 ++++++++++++++++++++++++++++++++++++-
 include/linux/device.h     |   3 +
 include/linux/iommu.h      |  87 ++++++++++++++
 include/uapi/linux/iommu.h | 153 ++++++++++++++++++++++++
 4 files changed, 476 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.21.0

