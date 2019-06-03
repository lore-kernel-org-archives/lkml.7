Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2668AC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991827C4F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfFCGyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:54:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFCGyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:54:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1BFC81DF5;
        Mon,  3 Jun 2019 06:54:12 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89E8F100164A;
        Mon,  3 Jun 2019 06:54:10 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
Subject: [PATCH v6 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions
Date:   Mon,  3 Jun 2019 08:53:35 +0200
Message-Id: <20190603065336.10524-7-eric.auger@redhat.com>
In-Reply-To: <20190603065336.10524-1-eric.auger@redhat.com>
References: <20190603065336.10524-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 03 Jun 2019 06:54:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new type for reserved region. This corresponds
to directly mapped regions which are known to be relaxable
in some specific conditions, such as device assignment use
case. Well known examples are those used by USB controllers
providing PS/2 keyboard emulation for pre-boot BIOS and
early BOOT or RMRRs associated to IGD working in legacy mode.

Since commit c875d2c1b808 ("iommu/vt-d: Exclude devices using RMRRs
from IOMMU API domains") and commit 18436afdc11a ("iommu/vt-d: Allow
RMRR on graphics devices too"), those regions are currently
considered "safe" with respect to device assignment use case
which requires a non direct mapping at IOMMU physical level
(RAM GPA -> HPA mapping).

Those RMRRs currently exist and sometimes the device is
attempting to access it but this has not been considered
an issue until now.

However at the moment, iommu_get_group_resv_regions() is
not able to make any difference between directly mapped
regions: those which must be absolutely enforced and those
like above ones which are known as relaxable.

This is a blocker for reporting severe conflicts between
non relaxable RMRRs (like MSI doorbells) and guest GPA space.

With this new reserved region type we will be able to use
iommu_get_group_resv_regions() to enumerate the IOVA space
that is usable through the IOMMU API without introducing
regressions with respect to existing device assignment
use cases (USB and IGD).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- expose the relaxable regions as "direct-relaxable" in the sysfs
- update ABI documentation

v2 -> v3:
- fix direct type check
---
 Documentation/ABI/testing/sysfs-kernel-iommu_groups |  9 +++++++++
 drivers/iommu/iommu.c                               | 12 +++++++-----
 include/linux/iommu.h                               |  6 ++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 35c64e00b35c..017f5bc3920c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -24,3 +24,12 @@ Description:    /sys/kernel/iommu_groups/reserved_regions list IOVA
 		region is described on a single line: the 1st field is
 		the base IOVA, the second is the end IOVA and the third
 		field describes the type of the region.
+
+What:		/sys/kernel/iommu_groups/reserved_regions
+Date: 		June 2019
+KernelVersion:  v5.3
+Contact: 	Eric Auger <eric.auger@redhat.com>
+Description:    In case an RMRR is used only by graphics or USB devices
+		it is now exposed as "direct-relaxable" instead of "direct".
+		In device assignment use case, for instance, those RMRR
+		are considered to be relaxable and safe.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f961f71e4ff8..276eae9822f2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -73,10 +73,11 @@ struct iommu_group_attribute {
 };
 
 static const char * const iommu_group_resv_type_string[] = {
-	[IOMMU_RESV_DIRECT]	= "direct",
-	[IOMMU_RESV_RESERVED]	= "reserved",
-	[IOMMU_RESV_MSI]	= "msi",
-	[IOMMU_RESV_SW_MSI]	= "msi",
+	[IOMMU_RESV_DIRECT]			= "direct",
+	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct-relaxable",
+	[IOMMU_RESV_RESERVED]			= "reserved",
+	[IOMMU_RESV_MSI]			= "msi",
+	[IOMMU_RESV_SW_MSI]			= "msi",
 };
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
@@ -575,7 +576,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
-		if (entry->type != IOMMU_RESV_DIRECT)
+		if (entry->type != IOMMU_RESV_DIRECT &&
+		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
 		for (addr = start; addr < end; addr += pg_size) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a815cf6f6f47..d7d1c8de9bbc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -135,6 +135,12 @@ enum iommu_attr {
 enum iommu_resv_type {
 	/* Memory regions which must be mapped 1:1 at all times */
 	IOMMU_RESV_DIRECT,
+	/*
+	 * Memory regions which are advertised to be 1:1 but are
+	 * commonly considered relaxable in some conditions,
+	 * for instance in device assignment use case (USB, Graphics)
+	 */
+	IOMMU_RESV_DIRECT_RELAXABLE,
 	/* Arbitrary "never map this or give it to a device" address ranges */
 	IOMMU_RESV_RESERVED,
 	/* Hardware MSI region (untranslated) */
-- 
2.20.1

