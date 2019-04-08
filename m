Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4E0C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EE22087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfDHMVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:21:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDHMVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:21:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7517030642AA;
        Mon,  8 Apr 2019 12:21:08 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4843A63BB5;
        Mon,  8 Apr 2019 12:20:58 +0000 (UTC)
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
Subject: [PATCH v7 13/23] iommu/smmuv3: Implement attach/detach_pasid_table
Date:   Mon,  8 Apr 2019 14:19:01 +0200
Message-Id: <20190408121911.24103-14-eric.auger@redhat.com>
In-Reply-To: <20190408121911.24103-1-eric.auger@redhat.com>
References: <20190408121911.24103-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 08 Apr 2019 12:21:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On attach_pasid_table() we program STE S1 related info set
by the guest into the actual physical STEs. At minimum
we need to program the context descriptor GPA and compute
whether the stage1 is translated/bypassed or aborted.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v6 -> v7:
- check versions and comment the fact we don't need to take
  into account s1dss and s1fmt
v3 -> v4:
- adapt to changes in iommu_pasid_table_config
- different programming convention at s1_cfg/s2_cfg/ste.abort

v2 -> v3:
- callback now is named set_pasid_table and struct fields
  are laid out differently.

v1 -> v2:
- invalidate the STE before changing them
- hold init_mutex
- handle new fields
---
 drivers/iommu/arm-smmu-v3.c | 121 ++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e22e944ffc05..1486baf53425 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2207,6 +2207,125 @@ static void arm_smmu_put_resv_regions(struct device *dev,
 		kfree(entry);
 }
 
+static int arm_smmu_attach_pasid_table(struct iommu_domain *domain,
+				       struct iommu_pasid_table_config *cfg)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master_data *entry;
+	struct arm_smmu_s1_cfg *s1_cfg;
+	struct arm_smmu_device *smmu;
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	if (cfg->format != IOMMU_PASID_FORMAT_SMMUV3)
+		return -EINVAL;
+
+	if (cfg->version != PASID_TABLE_CFG_VERSION_1 ||
+	    cfg->smmuv3.version != PASID_TABLE_SMMUV3_CFG_VERSION_1)
+		return -EINVAL;
+
+	mutex_lock(&smmu_domain->init_mutex);
+
+	smmu = smmu_domain->smmu;
+
+	if (!smmu)
+		goto out;
+
+	if (!((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
+	      (smmu->features & ARM_SMMU_FEAT_TRANS_S2))) {
+		dev_info(smmu_domain->smmu->dev,
+			 "does not implement two stages\n");
+		goto out;
+	}
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		goto out;
+
+	switch (cfg->config) {
+	case IOMMU_PASID_CONFIG_ABORT:
+		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		list_for_each_entry(entry, &smmu_domain->devices, list) {
+			entry->ste.s1_cfg = NULL;
+			entry->ste.abort = true;
+			arm_smmu_install_ste_for_dev(entry->dev->iommu_fwspec);
+		}
+		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+		ret = 0;
+		break;
+	case IOMMU_PASID_CONFIG_BYPASS:
+		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		list_for_each_entry(entry, &smmu_domain->devices, list) {
+			entry->ste.s1_cfg = NULL;
+			entry->ste.abort = false;
+			arm_smmu_install_ste_for_dev(entry->dev->iommu_fwspec);
+		}
+		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+		ret = 0;
+		break;
+	case IOMMU_PASID_CONFIG_TRANSLATE:
+		/*
+		 * we currently support a single CD so s1fmt and s1dss
+		 * fields are also ignored
+		 */
+		if (cfg->pasid_bits)
+			goto out;
+
+		s1_cfg = &smmu_domain->s1_cfg;
+		s1_cfg->cdptr_dma = cfg->base_ptr;
+
+		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		list_for_each_entry(entry, &smmu_domain->devices, list) {
+			entry->ste.s1_cfg = s1_cfg;
+			entry->ste.abort = false;
+			arm_smmu_install_ste_for_dev(entry->dev->iommu_fwspec);
+		}
+		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+out:
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
+}
+
+static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master_data *entry;
+	struct arm_smmu_device *smmu;
+	unsigned long flags;
+
+	mutex_lock(&smmu_domain->init_mutex);
+
+	smmu = smmu_domain->smmu;
+
+	if (!smmu)
+		return;
+
+	if (!((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
+	      (smmu->features & ARM_SMMU_FEAT_TRANS_S2))) {
+		dev_info(smmu_domain->smmu->dev,
+			 "does not implement two stages\n");
+		return;
+	}
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		return;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(entry, &smmu_domain->devices, list) {
+		entry->ste.s1_cfg = NULL;
+		entry->ste.abort = true;
+		arm_smmu_install_ste_for_dev(entry->dev->iommu_fwspec);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	memset(&smmu_domain->s1_cfg, 0, sizeof(struct arm_smmu_s1_cfg));
+	mutex_unlock(&smmu_domain->init_mutex);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2225,6 +2344,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.attach_pasid_table	= arm_smmu_attach_pasid_table,
+	.detach_pasid_table	= arm_smmu_detach_pasid_table,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.20.1

