Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04393C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D061C21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfDHMVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:21:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfDHMU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:20:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC206307EAA2;
        Mon,  8 Apr 2019 12:20:57 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BF21600C4;
        Mon,  8 Apr 2019 12:20:51 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org,
        vincent.stehle@arm.com
Subject: [PATCH v7 12/23] iommu/smmuv3: Get prepared for nested stage support
Date:   Mon,  8 Apr 2019 14:19:00 +0200
Message-Id: <20190408121911.24103-13-eric.auger@redhat.com>
In-Reply-To: <20190408121911.24103-1-eric.auger@redhat.com>
References: <20190408121911.24103-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 08 Apr 2019 12:20:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow nested stage support, we need to store both
stage 1 and stage 2 configurations (and remove the former
union).

A nested setup is characterized by both s1_cfg and s2_cfg
set.

We introduce a new ste.abort field that will be set upon
guest stage1 configuration passing. If s1_cfg is NULL and
ste.abort is set, traffic can't pass. If ste.abort is not set,
S1 is bypassed.

arm_smmu_write_strtab_ent() is modified to write both stage
fields in the STE and deal with the abort field.

In nested mode, only stage 2 is "finalized" as the host does
not own/configure the stage 1 context descriptor, guest does.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4 -> v5:
- reset ste.abort on detach

v3 -> v4:
- s1_cfg.nested_abort and nested_bypass removed.
- s/ste.nested/ste.abort
- arm_smmu_write_strtab_ent modifications with introduction
  of local abort, bypass and translate local variables
- comment updated

v1 -> v2:
- invalidate the STE before moving from a live STE config to another
- add the nested_abort and nested_bypass fields
---
 drivers/iommu/arm-smmu-v3.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 21d027695181..e22e944ffc05 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -211,6 +211,7 @@
 #define STRTAB_STE_0_CFG_BYPASS		4
 #define STRTAB_STE_0_CFG_S1_TRANS	5
 #define STRTAB_STE_0_CFG_S2_TRANS	6
+#define STRTAB_STE_0_CFG_NESTED		7
 
 #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
 #define STRTAB_STE_0_S1FMT_LINEAR	0
@@ -514,6 +515,7 @@ struct arm_smmu_strtab_ent {
 	 * configured according to the domain type.
 	 */
 	bool				assigned;
+	bool				abort;
 	struct arm_smmu_s1_cfg		*s1_cfg;
 	struct arm_smmu_s2_cfg		*s2_cfg;
 };
@@ -628,10 +630,8 @@ struct arm_smmu_domain {
 	bool				non_strict;
 
 	enum arm_smmu_domain_stage	stage;
-	union {
-		struct arm_smmu_s1_cfg	s1_cfg;
-		struct arm_smmu_s2_cfg	s2_cfg;
-	};
+	struct arm_smmu_s1_cfg	s1_cfg;
+	struct arm_smmu_s2_cfg	s2_cfg;
 
 	struct iommu_domain		domain;
 
@@ -1108,12 +1108,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 				      __le64 *dst, struct arm_smmu_strtab_ent *ste)
 {
 	/*
-	 * This is hideously complicated, but we only really care about
-	 * three cases at the moment:
+	 * We care about the following transitions:
 	 *
 	 * 1. Invalid (all zero) -> bypass/fault (init)
-	 * 2. Bypass/fault -> translation/bypass (attach)
-	 * 3. Translation/bypass -> bypass/fault (detach)
+	 * 2. Bypass/fault -> single stage translation/bypass (attach)
+	 * 3. single stage Translation/bypass -> bypass/fault (detach)
+	 * 4. S2 -> S1 + S2 (attach_pasid_table)
+	 * 5. S1 + S2 -> S2 (detach_pasid_table)
 	 *
 	 * Given that we can't update the STE atomically and the SMMU
 	 * doesn't read the thing in a defined order, that leaves us
@@ -1124,7 +1125,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	 * 3. Update Config, sync
 	 */
 	u64 val = le64_to_cpu(dst[0]);
-	bool ste_live = false;
+	bool abort, bypass, translate, ste_live = false;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
@@ -1138,11 +1139,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			break;
 		case STRTAB_STE_0_CFG_S1_TRANS:
 		case STRTAB_STE_0_CFG_S2_TRANS:
+		case STRTAB_STE_0_CFG_NESTED:
 			ste_live = true;
 			break;
 		case STRTAB_STE_0_CFG_ABORT:
-			if (disable_bypass)
-				break;
+			break;
 		default:
 			BUG(); /* STE corruption */
 		}
@@ -1152,8 +1153,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	val = STRTAB_STE_0_V;
 
 	/* Bypass/fault */
-	if (!ste->assigned || !(ste->s1_cfg || ste->s2_cfg)) {
-		if (!ste->assigned && disable_bypass)
+
+	abort = (!ste->assigned && disable_bypass) || ste->abort;
+	translate = ste->s1_cfg || ste->s2_cfg;
+	bypass = !abort && !translate;
+
+	if (abort || bypass) {
+		if (abort)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
@@ -1172,7 +1178,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	if (ste->s1_cfg) {
-		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
@@ -1191,7 +1196,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	if (ste->s2_cfg) {
-		BUG_ON(ste_live);
 		dst[2] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_2_S2VMID, ste->s2_cfg->vmid) |
 			 FIELD_PREP(STRTAB_STE_2_VTCR, ste->s2_cfg->vtcr) |
@@ -1773,6 +1777,7 @@ static void arm_smmu_detach_dev(struct device *dev)
 	}
 
 	master->ste.assigned = false;
+	master->ste.abort = false;
 	arm_smmu_install_ste_for_dev(fwspec);
 }
 
-- 
2.20.1

