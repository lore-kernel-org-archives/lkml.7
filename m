Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B4C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A912721655
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W++urFVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEGEyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 00:54:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45007 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGEyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 00:54:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so3497313plj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 21:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38RWjgCCoqTDs9WWdGrvN90MmbgyDENeZWWwktqdhr8=;
        b=W++urFVAUjLmLOLkV3WhQSOmCHTEqyZleYLFYcJS1FJFHR9VMWwE43/CQVnp7clqZJ
         0to4FXahT9R0KcfAE2AZ3Dx7hr2fppYi+cmSE03lpJwnqcUbFTNyJ4UDEb05UUdlSiOb
         y3/mI3LdK44NbhX+H6KrvLW0JGYY6V9AfZyks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38RWjgCCoqTDs9WWdGrvN90MmbgyDENeZWWwktqdhr8=;
        b=INAoqF4tW4Y77UG14ZZkWQjmKKwjjvL19bWG1MYi64bwostl/yVEPDrns+jBq7O6C7
         kDeWpuE94CW/WNfV9mkS8VsU7Fb1XMi+duFgCvH47sUlz2lg17C1zahF9yqZRQZ0gEk4
         DKB9Jztpe25qvglW4yyTRytH6JKdP5Oi022DUCRYXm5C/opLvch/vihy0MT6aRXBvzq7
         ZsSBGWnjPmt0LvMzi2sP8naHGpZAaOM1FB1Mvx8ispM8ssReZa7si8Zf6behfGOlFe48
         9AzAW61T1ckChKENeCKqhteyPjk94PkvNmRH5zo8mfzYxypZtY6QAmIicrHalDEUkggY
         K2pQ==
X-Gm-Message-State: APjAAAW3i7iqykVOAivDTf/k1BB9OoA3Vabj3M6ULOke5y6wgzVgo6Tx
        FChtOsOP6w/zeGdtyiuE2pR6uQ==
X-Google-Smtp-Source: APXvYqx/d4EzgjZah9buZEK+LtAIbXk1JKtst2Fa3PFYVbMVoteyW6i+8kXaXNoaF1nYlrVVmSIR9Q==
X-Received: by 2002:a17:902:2a26:: with SMTP id i35mr38742318plb.229.1557204879208;
        Mon, 06 May 2019 21:54:39 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id 13sm14970025pfi.172.2019.05.06.21.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 21:54:38 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] arm64: add support for rng-seed
Date:   Tue,  7 May 2019 12:54:33 +0800
Message-Id: <20190507045433.542-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a chosen node, rng-seed, which is an 64 bytes entropy
that can be passed to kernel called very early to increase device
randomness. Bootloader should provide this entropy and the value is
read from /chosen/rng-seed in DT.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

---
 Documentation/devicetree/bindings/chosen.txt | 14 +++++++++
 arch/arm64/kernel/setup.c                    |  2 ++
 drivers/of/fdt.c                             | 33 ++++++++++++++++++++
 include/linux/of_fdt.h                       |  1 +
 4 files changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646..bfd360691650 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
 the Linux EFI stub (which will populate the property itself, using
 EFI_RNG_PROTOCOL).
 
+rng-seed
+-----------
+
+This property served as an entropy to add device randomness. It is parsed
+as a 64 byte value, e.g.
+
+/ {
+	chosen {
+		rng-seed = <0x31951b3c 0xc9fab3a5 0xffdf1660 ...>
+	};
+};
+
+This random value should be provided by bootloader.
+
 stdout-path
 -----------
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 413d566405d1..ade4261516dd 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -292,6 +292,8 @@ void __init setup_arch(char **cmdline_p)
 	early_fixmap_init();
 	early_ioremap_init();
 
+	early_init_dt_rng_seed(__fdt_pointer);
+
 	setup_machine_fdt(__fdt_pointer);
 
 	parse_early_param();
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index de893c9616a1..74e2c0c80b91 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/libfdt.h>
 #include <linux/debugfs.h>
+#include <linux/random.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
 
@@ -1117,6 +1118,38 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	return 1;
 }
 
+extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
+				       pgprot_t prot);
+
+void __init early_init_dt_rng_seed(u64 dt_phys)
+{
+	void *fdt;
+	int node, size, i;
+	fdt64_t *prop;
+	u64 rng_seed[8];
+
+	fdt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
+	if (!fdt)
+		return;
+
+	node = fdt_path_offset(fdt, "/chosen");
+	if (node < 0)
+		return;
+
+	prop = fdt_getprop_w(fdt, node, "rng-seed", &size);
+	if (!prop || size != sizeof(u64) * 8)
+		return;
+
+	for (i = 0; i < 8; i++) {
+		rng_seed[i] = fdt64_to_cpu(*(prop + i));
+		/* clear seed so it won't be found. */
+		*(prop + i) = 0;
+	}
+	add_device_randomness(rng_seed, size);
+
+	return;
+}
+
 #ifndef MIN_MEMBLOCK_ADDR
 #define MIN_MEMBLOCK_ADDR	__pa(PAGE_OFFSET)
 #endif
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index a713e5d156d8..a4548dd6351e 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -71,6 +71,7 @@ extern uint32_t of_get_flat_dt_phandle(unsigned long node);
 
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
+extern void early_init_dt_rng_seed(u64 dt_phys);
 extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern int early_init_dt_scan_chosen_stdout(void);
-- 
2.20.1

