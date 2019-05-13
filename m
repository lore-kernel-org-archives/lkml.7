Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 00:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EB4208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 00:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahcAC2+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEMAjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 20:39:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41772 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfEMAjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 20:39:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so5835060pgp.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 17:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbMbvlKHRDKPF33fkDdqZosCX8TlLi6L2lIp8AEgfEI=;
        b=ahcAC2+7tRqSmf9Sq99vuJtmBgerjrkeU5hvbO9VJcojV+ouWXEK2WeqLWILjwlbdt
         Wi53Y/OQI6YLkTJgy3lPLJJPk5CF8eddpc9pRhuK7JQ+wEabCM8KLJhCp5aFSUa4RvWI
         Qlz1Lwoz3OiB7nRfGUHgjdqktnzFo+efzXEbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbMbvlKHRDKPF33fkDdqZosCX8TlLi6L2lIp8AEgfEI=;
        b=tZBDKh/pC8UETSQYBEuczYVsHyEOfCBNt6lcll4oD/AgJA7s1oT8jhjYj/QmgX5lfK
         ooF5FcXIwd45q6csX9nvzM9Vihtqwac3bxK8PXWANxBv0NiYWIv2Q5nB4VPWb2+egGP0
         B/b5sggh5V48HFVMPK+zpYfrdeARw8z7i/TTE4d+yorkKj9yXKZ+nAUf7Vj8vOcLenWC
         +LoBqXXvu1XQbASEwZBlXH1/KkqrzUyfSZOLkaacl7Gz678PbjKfGy8ddnMhcWIkWwR4
         +AIqpHfdab8sAq7JuOKHmvNoNjRGjJFHaSuRPXbRXZK7G2FxsbD30CU9inoZA0RJ5EPI
         UkAA==
X-Gm-Message-State: APjAAAXeFnS/XqK922HFDdC/+fN003DZ0dI6w/sZ0fu2oDbhA5E0Nxqg
        ADwI+jNUc2w4fHeQMbE6m0qa/g==
X-Google-Smtp-Source: APXvYqwvJ+s42h/ZoVPUfChayYtwKVcwlby7x/lX5fwmShnyI1xrkZYSHRWHIJyOpTadffshc3b6qg==
X-Received: by 2002:a63:3dcf:: with SMTP id k198mr28317089pga.60.1557707956264;
        Sun, 12 May 2019 17:39:16 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id a9sm14619577pgw.72.2019.05.12.17.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 17:39:15 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        boot-architecture@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH v2 2/2] amr64: map FDT as RW for early_init_dt_scan()
Date:   Mon, 13 May 2019 08:38:19 +0800
Message-Id: <20190513003819.356-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513003819.356-1-hsinyi@chromium.org>
References: <20190513003819.356-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in arm64, FDT is mapped to RO before it's passed to
early_init_dt_scan(). However, there might be some code that needs
to modify FDT during init. Map FDT to RW until unflatten DT.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/kernel/setup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 413d566405d1..08b22c1e72a9 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -179,9 +179,13 @@ static void __init smp_build_mpidr_hash(void)
 		pr_warn("Large number of MPIDR hash buckets detected\n");
 }
 
+extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
+				       pgprot_t prot);
+
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
-	void *dt_virt = fixmap_remap_fdt(dt_phys);
+	int size;
+	void *dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
 	const char *name;
 
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
@@ -320,6 +324,9 @@ void __init setup_arch(char **cmdline_p)
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
+	/* remap fdt to RO */
+	fixmap_remap_fdt(__fdt_pointer);
+
 	if (acpi_disabled)
 		unflatten_device_tree();
 
-- 
2.20.1

