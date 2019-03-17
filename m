Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1980C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3582087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfCQRXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 13:23:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfCQRXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 13:23:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76650307CDF0;
        Sun, 17 Mar 2019 17:23:45 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E46719C71;
        Sun, 17 Mar 2019 17:23:41 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org,
        vincent.stehle@arm.com
Subject: [PATCH v6 10/22] iommu/arm-smmu-v3: Link domains and devices
Date:   Sun, 17 Mar 2019 18:22:20 +0100
Message-Id: <20190317172232.1068-11-eric.auger@redhat.com>
In-Reply-To: <20190317172232.1068-1-eric.auger@redhat.com>
References: <20190317172232.1068-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 17 Mar 2019 17:23:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

When removing a mapping from a domain, we need to send an invalidation to
all devices that might have stored it in their Address Translation Cache
(ATC). In addition with SVM, we'll need to invalidate context descriptors
of all devices attached to a live domain.

Maintain a list of devices in each domain, protected by a spinlock. It is
updated every time we attach or detach devices to and from domains.

It needs to be a spinlock because we'll invalidate ATC entries from
within hardirq-safe contexts, but it may be possible to relax the read
side with RCU later.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cf..ff998c967a0a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -594,6 +594,11 @@ struct arm_smmu_device {
 struct arm_smmu_master_data {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
+
+	struct arm_smmu_domain		*domain;
+	struct list_head		list; /* domain->devices */
+
+	struct device			*dev;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -618,6 +623,9 @@ struct arm_smmu_domain {
 	};
 
 	struct iommu_domain		domain;
+
+	struct list_head		devices;
+	spinlock_t			devices_lock;
 };
 
 struct arm_smmu_option_prop {
@@ -1493,6 +1501,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	}
 
 	mutex_init(&smmu_domain->init_mutex);
+	INIT_LIST_HEAD(&smmu_domain->devices);
+	spin_lock_init(&smmu_domain->devices_lock);
+
 	return &smmu_domain->domain;
 }
 
@@ -1713,6 +1724,16 @@ static void arm_smmu_detach_dev(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_data *master = fwspec->iommu_priv;
+	unsigned long flags;
+	struct arm_smmu_domain *smmu_domain = master->domain;
+
+	if (smmu_domain) {
+		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		list_del(&master->list);
+		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		master->domain = NULL;
+	}
 
 	master->ste.assigned = false;
 	arm_smmu_install_ste_for_dev(fwspec);
@@ -1722,6 +1743,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	unsigned long flags;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master_data *master;
@@ -1757,6 +1779,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	ste->assigned = true;
+	master->domain = smmu_domain;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_add(&master->list, &smmu_domain->devices);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
 		ste->s1_cfg = NULL;
@@ -1883,6 +1910,7 @@ static int arm_smmu_add_device(struct device *dev)
 			return -ENOMEM;
 
 		master->smmu = smmu;
+		master->dev = dev;
 		fwspec->iommu_priv = master;
 	}
 
-- 
2.20.1

