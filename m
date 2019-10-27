Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64451CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DAC21D80
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187412;
	bh=C4FDQHQ2P/qLssIv220gHJaZD+U15wQlgrkBAm1xpgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cVVO38xufohk7dCWIxkc+l28AfTrBS0wmc1fIwL5Fgy2V9yVzQFL0gkD98d62EyBz
	 cxe2lk2UAAeJUBxlWjn37eF0sNfTPTTyuvvp2Mkkm9mj1XWp/+nSug5ZwT56J5Tukz
	 kwKCyHD5+8VyB4+6ORv34+78XwBslflOCNRQk5HM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfJ0Ona (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfJ0Ona (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:43:30 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA09222BD;
        Sun, 27 Oct 2019 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187409;
        bh=C4FDQHQ2P/qLssIv220gHJaZD+U15wQlgrkBAm1xpgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lr3fRD+WKqKce3oYA8JlYL5SrY72Wy0cqOXZSesGymwElCqfpBuBLJzjJ+9De6GsJ
         Cr51ATxF7K2Bo4ZBKQAVoSa86Jf+LnlJCvdduj+9FuDcyTZ6OXERgu3Ax5CHTdp2am
         LtMVxsEbdwbk/cFbHXYBYfmexx0JViLHQItKscLo=
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
Subject: [PATCH v2 05/36] irqchip/gic-v3-its: Kill its->ite_size and use TYPER copy instead
Date:   Sun, 27 Oct 2019 14:42:03 +0000
Message-Id: <20191027144234.8395-6-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a copy of TYPER in the ITS structure, rely on this
to provide the same service as its->ite_size, which gets axed.
Errata workarounds are now updating the cached fields instead of
requiring a separate field in the ITS structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 8 ++++----
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b3c9bc0c3ecd..3b046181ddfc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -6,6 +6,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/crash_dump.h>
@@ -108,7 +109,6 @@ struct its_node {
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
-	u32			ite_size;
 	u32			device_ids;
 	int			numa_node;
 	unsigned int		msi_domain_flags;
@@ -2435,7 +2435,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 * sized as a power of two (and you need at least one bit...).
 	 */
 	nr_ites = max(2, nvecs);
-	sz = nr_ites * its->ite_size;
+	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kzalloc_node(sz, GFP_KERNEL, its->numa_node);
 	if (alloc_lpis) {
@@ -3250,7 +3250,8 @@ static bool __maybe_unused its_enable_quirk_qdf2400_e0065(void *data)
 	struct its_node *its = data;
 
 	/* On QDF2400, the size of the ITE is 16Bytes */
-	its->ite_size = 16;
+	its->typer &= ~GITS_TYPER_ITT_ENTRY_SIZE;
+	its->typer |= FIELD_PREP(GITS_TYPER_ITT_ENTRY_SIZE, 16 - 1);
 
 	return true;
 }
@@ -3619,7 +3620,6 @@ static int __init its_probe_one(struct resource *res,
 	its->typer = typer;
 	its->base = its_base;
 	its->phys_base = res->start;
-	its->ite_size = GITS_TYPER_ITT_ENTRY_SIZE(typer);
 	its->device_ids = GITS_TYPER_DEVBITS(typer);
 	if (is_v4(its)) {
 		if (!(typer & GITS_TYPER_VMOVP)) {
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 5cc10cf7cb3e..4bce7a904075 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -334,7 +334,7 @@
 #define GITS_TYPER_PLPIS		(1UL << 0)
 #define GITS_TYPER_VLPIS		(1UL << 1)
 #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
-#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0xf) + 1)
+#define GITS_TYPER_ITT_ENTRY_SIZE	GENMASK_ULL(7, 4)
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
-- 
2.20.1

