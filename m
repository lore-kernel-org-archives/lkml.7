Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C6D213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCTOS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:18:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726611AbfCTOS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:18:29 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3E8A44EE8DB1A727BB53;
        Wed, 20 Mar 2019 22:18:27 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 22:18:17 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <andre.przywara@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] KVM: arm: vgic: Make two functions static
Date:   Wed, 20 Mar 2019 22:18:13 +0800
Message-ID: <20190320141813.10380-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1732:5: warning:
 symbol 'vgic_its_has_attr_regs' was not declared. Should it be static?
arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1753:5: warning:
 symbol 'vgic_its_attr_regs_access' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index ab3f477..a97db69 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1729,8 +1729,8 @@ static void vgic_its_destroy(struct kvm_device *kvm_dev)
 	kfree(its);
 }
 
-int vgic_its_has_attr_regs(struct kvm_device *dev,
-			   struct kvm_device_attr *attr)
+static int vgic_its_has_attr_regs(struct kvm_device *dev,
+				  struct kvm_device_attr *attr)
 {
 	const struct vgic_register_region *region;
 	gpa_t offset = attr->attr;
@@ -1750,9 +1750,9 @@ int vgic_its_has_attr_regs(struct kvm_device *dev,
 	return 0;
 }
 
-int vgic_its_attr_regs_access(struct kvm_device *dev,
-			      struct kvm_device_attr *attr,
-			      u64 *reg, bool is_write)
+static int vgic_its_attr_regs_access(struct kvm_device *dev,
+				     struct kvm_device_attr *attr,
+				     u64 *reg, bool is_write)
 {
 	const struct vgic_register_region *region;
 	struct vgic_its *its;
-- 
2.7.0


