Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF83C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199B32087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfEPKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:08:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPKIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89C243179150;
        Thu, 16 May 2019 10:08:51 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FCDB5D6A9;
        Thu, 16 May 2019 10:08:48 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions
Date:   Thu, 16 May 2019 12:08:16 +0200
Message-Id: <20190516100817.12076-7-eric.auger@redhat.com>
In-Reply-To: <20190516100817.12076-1-eric.auger@redhat.com>
References: <20190516100817.12076-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 16 May 2019 10:08:51 +0000 (UTC)
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

Note: At the moment the sysfs ABI is not changed. However I wonder
whether it wouldn't be preferable to report the direct region as
"direct_relaxed" there. At the moment, in case the same direct
region is used by 2 devices, one USB/GFX and another not belonging
to the previous categories, the direct region will be output twice
with "direct" type.

This would unblock Shameer's series:
[PATCH v6 0/7] vfio/type1: Add support for valid iova list management
https://patchwork.kernel.org/patch/10425309/

which failed to get pulled for 4.18 merge window due to IGD
device assignment regression.

v2 -> v3:
- fix direct type check
---
 drivers/iommu/iommu.c | 12 +++++++-----
 include/linux/iommu.h |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ae4ea5c0e6f9..28c3d6351832 100644
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
+	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct",
+	[IOMMU_RESV_RESERVED]			= "reserved",
+	[IOMMU_RESV_MSI]			= "msi",
+	[IOMMU_RESV_SW_MSI]			= "msi",
 };
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
@@ -573,7 +574,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
-		if (entry->type != IOMMU_RESV_DIRECT)
+		if (entry->type != IOMMU_RESV_DIRECT &&
+		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
 		for (addr = start; addr < end; addr += pg_size) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ba91666998fb..14a521f85f14 100644
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

