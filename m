Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049ECC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC15820859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbfFJHhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:37:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388000AbfFJHhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:37:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76FD97FDEE;
        Mon, 10 Jun 2019 07:37:11 +0000 (UTC)
Received: from kasong-rh-laptop.pek2.redhat.com (wlc-trust-16.pek2.redhat.com [10.72.3.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70DA960565;
        Mon, 10 Jun 2019 07:37:04 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>
Cc:     Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
Date:   Mon, 10 Jun 2019 15:36:17 +0800
Message-Id: <20190610073617.19767-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 10 Jun 2019 07:37:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent addition of RSDP parsing in decompression stage, kexec
kernel now needs ACPI tables to be covered by the identity mapping.
And in commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and
ACPI tables to the ident map"), ACPI tables memory region was added to
the ident map.

But on some machines, there is only ACPI NVS memory region, and the ACPI
tables is located in the NVS region instead. In such case second kernel
will still fail when trying to access ACPI tables.

So, to fix the problem, add NVS memory region in the ident map as well.

Fixes: 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI tables to the ident map")
Suggested-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---

Tested with my laptop and VM, on top of current tip:x86/boot.

 arch/x86/kernel/machine_kexec_64.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3c77bdf7b32a..a406602fdb3c 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -54,14 +54,26 @@ static int mem_region_callback(struct resource *res, void *arg)
 static int
 map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 {
-	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	int ret;
+	unsigned long flags;
 	struct init_pgtable_data data;
 
 	data.info = info;
 	data.level4p = level4p;
 	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
-				   &data, mem_region_callback);
+
+	ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
+				  &data, mem_region_callback);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	/* ACPI tables could be located in ACPI Non-volatile Storage region */
+	ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
+				  &data, mem_region_callback);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	return 0;
 }
 #else
 static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
-- 
2.21.0

