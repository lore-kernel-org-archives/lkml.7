Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13339C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA4621872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jvSafae/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfHZTBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:01:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34791 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387572AbfHZTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:01:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id m10so14961245qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KCVg9aX8Ei31UqOBsuMHmMbIQ0RCV8gvQ+BUD1iKe9c=;
        b=jvSafae/Pvhx1ePY9KHCUAHQxBA0240DaYA2EEYIeJv90j9mUT/owS3v1JM2H2Fbgm
         Gz6u5l9d2paU6NUyVT7sP3J0+xSnFnzr+3EwrP/3kag9XqVwqJUPqQFRtso7/6a0l0HI
         q/R6/ebth1XnoCuJESeeYoO1XnP2X5HIG1tl+a5dPDYmj+FO2tdCtnWIu832yz+11bXP
         J9AC/S80/rSdJsITUCH2lUO4rZwcsp1g7kgxhtaYD0QHAYSqcyZIQ3+FSdFqqXSv6KiJ
         jERTTw7XIJ8w4vdbznCwiS6UtMSG6hhJ5r5DEisniwbgyz9h+GbMSj5yFTCaIUW5f9jl
         wy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCVg9aX8Ei31UqOBsuMHmMbIQ0RCV8gvQ+BUD1iKe9c=;
        b=DS4Gd45DYMZpfYbbwK8QFAVusM2SpsginT1ZmY9/n4mJV9IO8MYGycKPvc0pyXVfbm
         L3QFnQE5XKnwsSwXmM7d1oQWupzUE6oi8gPOvjQVgEeSCdPrUIE6qZ2/ojcvPMkWQaq5
         YQ3zJtGhh0/V5suk/4ct1loOuqqvr1Jx1q3/7vChsSP1nrRox758lVq9HSvLuFasFzhL
         5PgP4y3IKl1kJjPN4lD/5DYTPDUwCAh72AL96kgGQY/xDmy540BGQUMGIBCrBTj3bh9w
         AN/u4F8bHGiRhSD48Cm7aku4hGfmgI1hVdJL0K/6LKBBXYDMahm+x26NWlZHeO8zFKz0
         pZpw==
X-Gm-Message-State: APjAAAWSyBLaUW0hyHSS+RWrQ1xNljKZe8gfUz//sTcALDE0s9Tnkmzn
        T4c2gCCLxOb+cF+9bligf+JOOvMfo2s=
X-Google-Smtp-Source: APXvYqyHi/lgyXzbqvh1IW/JvUmfZeQrgzncbclhhidqt/Ua9XVbZyYnS+d2hbmlaFxUN3tJbJpaww==
X-Received: by 2002:a37:bac3:: with SMTP id k186mr17515757qkf.61.1566846064932;
        Mon, 26 Aug 2019 12:01:04 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o45sm8614377qta.65.2019.08.26.12.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:01:04 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
Subject: [PATCH v1 5/6] rqchip/gic-v3-its: move reset pending table outside of allocator
Date:   Mon, 26 Aug 2019 15:00:55 -0400
Message-Id: <20190826190056.27854-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to use reserved memory for interrupt controller tables.

Currently, it is not possible to do kexec reboots without possible memory
corruption using device tree and GICv3 interrupt controller.

GICv3 can be configured once during boot, and location of tables cannot
be changed thereafter.

The fix is to allow to reserve memory region in interrupt controller device
property, and use it to do allocations.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 82 ++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d5f3508ca11f..aeda8760cc4e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -47,6 +47,54 @@
 
 static u32 lpi_id_bits;
 
+/*
+ * Describes reserved memory region in interrupt controller.
+ * The memory reserved: [pa_start, pa_end)
+ */
+struct of_resv {
+	unsigned long pa_start;
+	unsigned long pa_end;
+};
+
+static struct page __init *get_of_page(struct of_resv *resv, unsigned long size)
+{
+	unsigned long pa = ALIGN(resv->pa_start, size);
+	unsigned long pa_next = pa + size;
+
+	/* Check if there is enough memory reserved to do another allocation */
+	if (pa_next > resv->pa_end)
+		return NULL;
+
+	resv->pa_start = pa_next;
+	memset(phys_to_virt(pa), 0, size);
+
+	return phys_to_page(pa);
+}
+
+/*
+ * Memory controller might have a reserved memory region to be used for table
+ * allocations. This is a requirement for kexec reboots.
+ */
+static void __init its_of_mem_region(struct device_node *node,
+				     struct of_resv **resv,
+				     struct of_resv *resv_buf)
+{
+	struct device_node *np = of_parse_phandle(node, "memory-region", 0);
+	struct resource mem_res;
+
+	if (!np)
+		return;
+
+	if (of_address_to_resource(np, 0, &mem_res)) {
+		pr_warn("%pOF: address to resource failed\n", np);
+		return;
+	}
+
+	resv_buf->pa_start = mem_res.start;
+	resv_buf->pa_end = mem_res.start + resource_size(&mem_res);
+	*resv = resv_buf;
+}
+
 /*
  * We allocate memory for PROPBASE to cover 2 ^ lpi_id_bits LPIs to
  * deal with (one configuration byte per interrupt). PENDBASE has to
@@ -1665,7 +1713,7 @@ static int gic_reserve_range(phys_addr_t addr, unsigned long size)
 	return 0;
 }
 
-static int __init its_setup_lpi_prop_table(void)
+static int __init its_setup_lpi_prop_table(struct of_resv *resv)
 {
 	if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
 		unsigned long pa;
@@ -1676,7 +1724,10 @@ static int __init its_setup_lpi_prop_table(void)
 		lpi_id_bits = (val & GICR_PROPBASER_IDBITS_MASK) + 1;
 
 		pa = val & GENMASK_ULL(51, 12);
-		va = memremap(pa, LPI_PROPBASE_SZ, MEMREMAP_WB);
+		if (resv)
+			va = phys_to_virt(pa);
+		else
+			va = memremap(pa, LPI_PROPBASE_SZ, MEMREMAP_WB);
 		gic_rdists->prop_table_pa = pa;
 		gic_rdists->prop_table_va = va;
 	} else {
@@ -1685,7 +1736,10 @@ static int __init its_setup_lpi_prop_table(void)
 		lpi_id_bits = min_t(u32,
 				    GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
 				    ITS_MAX_LPI_NRBITS);
-		page = its_allocate_prop_table(GFP_NOWAIT);
+		if (resv)
+			page = get_of_page(resv, LPI_PROPBASE_SZ);
+		else
+			page = its_allocate_prop_table(GFP_NOWAIT);
 		if (!page) {
 			pr_err("Failed to allocate PROPBASE\n");
 			return -ENOMEM;
@@ -2009,7 +2063,8 @@ static void its_free_pending_table(struct page *pt)
 
 /*
  * Booting with kdump and LPIs enabled is generally fine. Any other
- * case is wrong in the absence of firmware/EFI support.
+ * case is wrong in the absence of firmware/EFI support or reserve-memory
+ * in device tree for interrupt controller.
  */
 static bool enabled_lpis_allowed(void)
 {
@@ -2023,7 +2078,7 @@ static bool enabled_lpis_allowed(void)
 	return gic_check_reserved_range(addr, LPI_PROPBASE_SZ);
 }
 
-static int __init allocate_lpi_tables(void)
+static int __init allocate_lpi_tables(struct of_resv *resv)
 {
 	u64 val;
 	int err, cpu;
@@ -2039,7 +2094,7 @@ static int __init allocate_lpi_tables(void)
 		pr_info("GICv3: Using preallocated redistributor tables\n");
 	}
 
-	err = its_setup_lpi_prop_table();
+	err = its_setup_lpi_prop_table(resv);
 	if (err)
 		return err;
 
@@ -2051,7 +2106,10 @@ static int __init allocate_lpi_tables(void)
 	for_each_possible_cpu(cpu) {
 		struct page *pend_page;
 
-		pend_page = its_allocate_pending_table(GFP_NOWAIT);
+		if (resv)
+			pend_page = get_of_page(resv, LPI_PENDBASE_SZ);
+		else
+			pend_page = its_allocate_pending_table(GFP_NOWAIT);
 		if (!pend_page) {
 			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
 			return -ENOMEM;
@@ -3957,16 +4015,20 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		    struct irq_domain *parent_domain)
 {
 	struct device_node *of_node;
+	struct of_resv resv_buf;
+	struct of_resv *resv = NULL;
 	struct its_node *its;
 	bool has_v4 = false;
 	int err;
 
 	its_parent = parent_domain;
 	of_node = to_of_node(handle);
-	if (of_node)
+	if (of_node) {
 		its_of_probe(of_node);
-	else
+		its_of_mem_region(of_node, &resv, &resv_buf);
+	} else {
 		its_acpi_probe();
+	}
 
 	if (list_empty(&its_nodes)) {
 		pr_warn("ITS: No ITS available, not enabling LPIs\n");
@@ -3975,7 +4037,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 
 	gic_rdists = rdists;
 
-	err = allocate_lpi_tables();
+	err = allocate_lpi_tables(resv);
 	if (err)
 		return err;
 
-- 
2.23.0

