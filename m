Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC889C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B05218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="nh59hCcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfDWUis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:38:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45213 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDWUir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:38:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id d5so7210330qko.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=If9b8Hhg6rb9qfMxJ/D8pVjl9Kc21wX/xW/OU60oUvo=;
        b=nh59hCcuNy+/enpUAvjmC5tL0AH4ZTxKbIs40ewzwMpIXhaHejxqetkdbduolHyW85
         OrJJauDYMJuthPLeEwRqnqKS6E2KvoU/T/wV7tQVwJGM5pLdhhgpXUzIqbYsPXBsG63/
         nVrBl4eQhwbLdyyPAsmLw67TSjZr+YrTdB4J4kr9Yodd2Ndr0WG+yst7PIZGhDpVDLaO
         MjP/5QPGwkw8RFqYRvnkqyorAlRul9eR8bBYQ3k2YnJ3W9d6/bEosMKWO8+zYoP0znUY
         9agdqwJInYYuUt98tt94D4YK+RdBG+sXgXzZDDMRNw/g944Xd89BI8x0AVG43h036KkX
         7awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=If9b8Hhg6rb9qfMxJ/D8pVjl9Kc21wX/xW/OU60oUvo=;
        b=eXygWLM0sSy36x6+zh/trv5bLUlvEE6R8rSJx6d1vgeBPx5zaypSGoqnIrApi8pUS3
         hiNM8hhBp97mvs7tGEGjYxGGnrMzP3TQajaTfIDlAXfyIW0En7XrbzgGzj5qy0hLauLV
         JP/oILXyVxwrceew1KDe4xYb3trV0q2UcWR4JsmVkGgqu+6/BCNeaddDGWuj3Gvp9Ipv
         g2mr2xn7zJRkYXbmH7ptCuo/X2Fvc5s7kS5/6If1IhOrcjpT4C6hL/ZqwL5lgjuz92WX
         Y2k6kk8w5WItCfIvxX39I41kOqqR+bZ1M37kT0GGbbqdpNRV2oVthyrpKsEoQTXdIXOD
         IP6w==
X-Gm-Message-State: APjAAAXL2OgUarCZnaUSfuhoWuVX6GqaTlSl4s0b5mMCfAAmVLGjavzG
        bwL36xpOI8qSe7alC20+iLCw/A==
X-Google-Smtp-Source: APXvYqykWYZqHb2524ThL5IEsi/KMdqhj/ZzHVclC22Op4Z56+nOuuGZD3hYblG8+xPiTnn/YtlTfw==
X-Received: by 2002:ae9:c005:: with SMTP id u5mr10795603qkk.179.1556051926698;
        Tue, 23 Apr 2019 13:38:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 6sm11296020qtt.8.2019.04.23.13.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:38:45 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        rppt@linux.vnet.ibm.com, ard.biesheuvel@linaro.org,
        andrew.murray@arm.com, james.morse@arm.com, marc.zyngier@arm.com,
        sboyd@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: configurable sparsemem section size
Date:   Tue, 23 Apr 2019 16:38:43 -0400
Message-Id: <20190423203843.2898-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparsemem section size determines the maximum size and alignment that
is allowed to offline/online memory block. The bigger the size the less
the clutter in /sys/devices/system/memory/*. On the other hand, however,
there is less flexability in what granules of memory can be added and
removed.

Recently, it was enabled in Linux to hotadd persistent memory that
can be either real NV device, or reserved from regular System RAM
and has identity of devdax.

The problem is that because ARM64's section size is 1G, and devdax must
have 2M label section, the first 1G is always missed when device is
attached, because it is not 1G aligned.

Allow, better flexibility by making section size configurable.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/Kconfig                 | 10 ++++++++++
 arch/arm64/include/asm/sparsemem.h |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5d8cf57e220..a0c5b9d13a7f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -801,6 +801,16 @@ config ARM64_PA_BITS
 	default 48 if ARM64_PA_BITS_48
 	default 52 if ARM64_PA_BITS_52
 
+config ARM64_SECTION_SIZE_BITS
+	int "sparsemem section size shift"
+	range 27 30
+	default "30"
+	depends on SPARSEMEM
+	help
+	  Specify section size in bits. Section size determines the hotplug
+	  hotremove granularity. The current size can be determined from
+	  /sys/devices/system/memory/block_size_bytes
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index b299929fe56c..810db34d7038 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -18,7 +18,7 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
-#define SECTION_SIZE_BITS	30
+#define SECTION_SIZE_BITS	CONFIG_ARM64_SECTION_SIZE_BITS
 #endif
 
 #endif
-- 
2.21.0

