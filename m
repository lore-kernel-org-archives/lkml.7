Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B2FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061D021D80
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187474;
	bh=wvraHwVr8++hSr5kwJalnecU6a8VgNiBf6HxT+p5zVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RAvlktdh8ZIM+Ns4VBgkC2/uhZhai8Ut/EpH/bAQrc0W9rjjifhVFaVVtk16thp2V
	 K1MgSU5nKOK7fJD5jPNip7joesIat232mF4j4qYOQbNOYRDPDqnLAj4qD0mM7LT4W+
	 nxU7upH8yNeKrQtlSh02SCLeEk3B9hYD5G+/zocQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfJ0Ood (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfJ0Oob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:44:31 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB36621E6F;
        Sun, 27 Oct 2019 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187470;
        bh=wvraHwVr8++hSr5kwJalnecU6a8VgNiBf6HxT+p5zVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/cnvDdkvx2avkzyyBqeJhT++Z3O8boXc5+ThuwCsZm0GnNkB9SVLsvewFzNB8gbp
         0Mx03Wd3SqNhEH0bpccraYFtotiC9pu0rSaGHzkuNVpdNKJe+RSbW9FChFq39eroGI
         Yf5WDMQDiFYvw5WdwprWGWTOEnCSVGBhHEmqo654=
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
Subject: [PATCH v2 13/36] irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID is set
Date:   Sun, 27 Oct 2019 14:42:11 +0000
Message-Id: <20191027144234.8395-14-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infamous VPE proxy device isn't used with GICv4.1 because:
- we can invalidate any LPI from the DirectLPI MMIO interface
- the ITS and redistributors understand the life cycle of
  the doorbell, so we don't need to enable/disable it all
  the time

So let's escape early from the proxy related functions.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 220d490d516e..999e61a9b2c3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3069,7 +3069,7 @@ static const struct irq_domain_ops its_domain_ops = {
 /*
  * This is insane.
  *
- * If a GICv4 doesn't implement Direct LPIs (which is extremely
+ * If a GICv4.0 doesn't implement Direct LPIs (which is extremely
  * likely), the only way to perform an invalidate is to use a fake
  * device to issue an INV command, implying that the LPI has first
  * been mapped to some event on that device. Since this is not exactly
@@ -3077,9 +3077,18 @@ static const struct irq_domain_ops its_domain_ops = {
  * only issue an UNMAP if we're short on available slots.
  *
  * Broken by design(tm).
+ *
+ * GICv4.1 actually mandates that we're able to invalidate by writing to a
+ * MMIO register. It doesn't implement the whole of DirectLPI, but that's
+ * good enough. And most of the time, we don't even have to invalidate
+ * anything, so that's actually pretty good!
  */
 static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already unmapped? */
 	if (vpe->vpe_proxy_event == -1)
 		return;
@@ -3102,6 +3111,10 @@ static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (!gic_rdists->has_direct_lpi) {
 		unsigned long flags;
 
@@ -3113,6 +3126,10 @@ static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_map_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already mapped? */
 	if (vpe->vpe_proxy_event != -1)
 		return;
@@ -3135,6 +3152,10 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 	unsigned long flags;
 	struct its_collection *target_col;
 
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (gic_rdists->has_direct_lpi) {
 		void __iomem *rdbase;
 
-- 
2.20.1

