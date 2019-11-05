Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC0C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8F821929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572971021;
	bh=Yfviy47BV2b0XwEmW1CtprNcLymuD/i1VjMZ/3xeASA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oMBG1wyNaC8s8xdawB1weosdMnJb7t9nnca96cdcPkYrJMgsIwmbm0ihlNuhOE3yP
	 P9Vepgb0Q+JQKwqkhVPwiP4cyqfEpMC0cBLhCe5k6YGJvKJ1IIqeNWw9K6eNslDWBN
	 NfM13ZnrfGn/mmjL9xaKilZcppu/B34THTdraozw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbfKEQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:23:14 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:41291 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390063AbfKEQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:23:13 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iS1bs-0001q9-Ji; Tue, 05 Nov 2019 17:23:12 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH 05/11] irqchip/gic-v3-its: Kill its->ite_size and use TYPER copy instead
Date:   Tue,  5 Nov 2019 16:22:52 +0000
Message-Id: <20191105162258.22214-6-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105162258.22214-1-maz@kernel.org>
References: <20191105162258.22214-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a copy of TYPER in the ITS structure, rely on this
to provide the same service as its->ite_size, which gets axed.
Errata workarounds are now updating the cached fields instead of
requiring a separate field in the ITS structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 8 ++++----
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a5d947b243f2..161831e2b7ac 100644
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
@@ -2450,7 +2450,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 * sized as a power of two (and you need at least one bit...).
 	 */
 	nr_ites = max(2, nvecs);
-	sz = nr_ites * its->ite_size;
+	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kzalloc_node(sz, GFP_KERNEL, its->numa_node);
 	if (alloc_lpis) {
@@ -3266,7 +3266,8 @@ static bool __maybe_unused its_enable_quirk_qdf2400_e0065(void *data)
 	struct its_node *its = data;
 
 	/* On QDF2400, the size of the ITE is 16Bytes */
-	its->ite_size = 16;
+	its->typer &= ~GITS_TYPER_ITT_ENTRY_SIZE;
+	its->typer |= FIELD_PREP(GITS_TYPER_ITT_ENTRY_SIZE, 16 - 1);
 
 	return true;
 }
@@ -3635,7 +3636,6 @@ static int __init its_probe_one(struct resource *res,
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

