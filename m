Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C1ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A1B21D7F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187529;
	bh=aHwlyCp9IjV9oFMyBBlli8DL0bwlU6xUT9TEDytw3Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mtDja6Ex6izwq0T1qDd0Quly+spsbmSQ1lZv3VzcQ3tO7xKSqmnnNEaDNEUOCRhnl
	 5+94sDq6L7Mqb3mTk4fLBKWiNU5MO/iJIM/Bp5N3urKKtwCFvOntEHKmnRUBuTiR1O
	 /Vsox6s2XzwO2Ir8zxNIEYQWBKn3C+l2MRUsluUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfJ0Op2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfJ0Op1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:45:27 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E2C21850;
        Sun, 27 Oct 2019 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187527;
        bh=aHwlyCp9IjV9oFMyBBlli8DL0bwlU6xUT9TEDytw3Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTccUUNmOLgtxqH1rkFOlCA0z55dklZ6T6k5tbHAb2a6iY3+YJLBSe6bPiQdZPxlv
         rClQDcY9QlM2CZ/x7h4JctAExpAflZBPQkFRRGrUSscOE1u7tj6Vl+b+7AUfE3b5Hg
         tUmyGVbo87jcL3xDxti6obyiOs1SGZjHx2vU171Y=
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 22/36] irqchip/gic-v4.1: Advertise support v4.1 to KVM
Date:   Sun, 27 Oct 2019 14:42:20 +0000
Message-Id: <20191027144234.8395-23-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell KVM that we support v4.1. Nothing uses this information so far.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c       | 9 ++++++++-
 drivers/irqchip/irq-gic-v3.c           | 1 +
 include/linux/irqchip/arm-gic-common.h | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index df259e202482..6483f8051b3e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4580,6 +4580,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	struct device_node *of_node;
 	struct its_node *its;
 	bool has_v4 = false;
+	bool has_v4_1 = false;
 	int err;
 
 	gic_rdists = rdists;
@@ -4600,8 +4601,14 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (err)
 		return err;
 
-	list_for_each_entry(its, &its_nodes, entry)
+	list_for_each_entry(its, &its_nodes, entry) {
 		has_v4 |= is_v4(its);
+		has_v4_1 |= is_v4_1(its);
+	}
+
+	/* Don't bother with inconsistent systems */
+	if (WARN_ON(!has_v4_1 && rdists->has_rvpeid))
+		rdists->has_rvpeid = false;
 
 	if (has_v4 & rdists->has_vlpis) {
 		if (its_init_vpe_domain() ||
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f0d33ac64a99..94dddfb21076 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1758,6 +1758,7 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 		gic_v3_kvm_info.vcpu = r;
 
 	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
+	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
 	gic_set_kvm_info(&gic_v3_kvm_info);
 }
 
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index b9850f5f1906..fa8c0455c352 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -32,6 +32,8 @@ struct gic_kvm_info {
 	struct resource vctrl;
 	/* vlpi support */
 	bool		has_v4;
+	/* rvpeid support */
+	bool		has_v4_1;
 };
 
 const struct gic_kvm_info *gic_get_kvm_info(void);
-- 
2.20.1

