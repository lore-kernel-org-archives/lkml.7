Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F29C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFD4204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+1qD9in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfDSTOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:14:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45591 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfDSTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:14:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so2910151pfi.12;
        Fri, 19 Apr 2019 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CXshfHJtKJBB6RqEy0dCa+LvOEJLdnOQQ3VtYxqDG/Q=;
        b=m+1qD9inpy98UNWdyPrH41Vv6SnLyKdbHpGjQgNBywjaLXYrYFWY8JWoha9TI702ey
         9KjrGLavWbVU+nW5V4lfoP/5GloKcxZbQCwWKvJdYQhAUZMyzt2pDleT8WKN2W9N+SJj
         E3ZkBJr3oFTYkHSXhYFFTvnPOz+Wvy5Gf8C9CxRiGEZMH4JzfjXuGMuNedYBzk0hanop
         /6XgNVoaAKuy3QOpKOljbI6/wFH5CH8zRjZeHdG2GzIk4m35hNafeoDowTFh6PXvHnEl
         UpPJ8kGZGazdqef+w5z4Oq7Lw/6V88tF0pf+o1tJYhXf7ZJnJu2UINO8JId9gLLtCSQv
         P8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CXshfHJtKJBB6RqEy0dCa+LvOEJLdnOQQ3VtYxqDG/Q=;
        b=htBA9ZufXMejRzAcmj41xNwVq+QxlgqP+ltV7LrjDeFqN2SwvLrdfas0Lygj2Pvw3C
         rER9U+siTRpf+ysPVezXxYTmTFdUoVS5aeSZZvCCEnuGzvN5tcXGrzp5o0e/n3t/puWw
         W0N4JhBuJ0YpODeyiJYlHaE8Fha4E+qS7hDghPIErI5/hI5zT4ECRQP0ey2EclRhVMcT
         S71xta4i/Bh5lbyhkWbLwXcWiIVJkD14EGWXW5EmAFYNGBlRp8Zi81OMbPKx0FnuWxAg
         Jfy445+o+zJBLC40o+byK6mcLBpQu6LWrTu3HlyfwcxOI1RyPXd07n2vXIRIk1vNv4US
         Cx0Q==
X-Gm-Message-State: APjAAAVJqgAVkYBTmI27yleXqCQu1RMGsNFXlHWhiqTe2GOt77nIOpqu
        qohA9cY/DJaytWpycZWx6EYqvSnby1GsZNI=
X-Google-Smtp-Source: APXvYqxFW63Fu4eIqRYM7gy4ONzAzxxoT/2sTzVYmEUMdFtfIrWJPhW/PY6EH1932JyZE7+yaVfzaw==
X-Received: by 2002:aa7:8b08:: with SMTP id f8mr2551028pfd.146.1555660795554;
        Fri, 19 Apr 2019 00:59:55 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:782a:91d0:d21b:f3c4:1cf5:d5f7])
        by smtp.gmail.com with ESMTPSA id u8sm2250574pgc.10.2019.04.19.00.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 00:59:54 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Hackmann <ghackmann@android.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: [PATCH] kernel/crash: make parse_crashkernel()'s return value more indicant
Date:   Fri, 19 Apr 2019 15:58:37 +0800
Message-Id: <1555660717-18731-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, both return and crash_size should be checked to guarantee the
success of parse_crashkernel().
Simplify the way by returning negative if fail, positive if success. In
case of failure, -EINVAL for bad syntax, -1 for the parsing results in
crash_size=0.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Hackmann <ghackmann@android.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 arch/arm/kernel/setup.c             |  2 +-
 arch/arm64/mm/init.c                |  2 +-
 arch/ia64/kernel/setup.c            |  2 +-
 arch/mips/kernel/setup.c            |  2 +-
 arch/powerpc/kernel/fadump.c        |  2 +-
 arch/powerpc/kernel/machine_kexec.c |  2 +-
 arch/s390/kernel/setup.c            |  2 +-
 arch/sh/kernel/machine_kexec.c      |  2 +-
 arch/x86/kernel/setup.c             |  4 ++--
 kernel/crash_core.c                 | 12 ++++++++++--
 10 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 5d78b6a..2feab13 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -997,7 +997,7 @@ static void __init reserve_crashkernel(void)
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base);
-	if (ret)
+	if (ret < 0)
 		return;
 
 	if (crash_base <= 0) {
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6bc1350..240918c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -79,7 +79,7 @@ static void __init reserve_crashkernel(void)
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
 	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
+	if (ret < 0)
 		return;
 
 	crash_size = PAGE_ALIGN(crash_size);
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 583a374..99cae33 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
 
 	ret = parse_crashkernel(boot_command_line, total,
 			&size, &base);
-	if (ret == 0 && size > 0) {
+	if (ret >= 0) {
 		if (!base) {
 			sort_regions(rsvd_region, *n);
 			*n = merge_regions(rsvd_region, *n);
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8d1dc6c..168571b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -715,7 +715,7 @@ static void __init mips_parse_crashkernel(void)
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0)
+	if (ret < 0)
 		return;
 
 	if (!memory_region_available(crash_base, crash_size)) {
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 45a8d0b..0b626e2 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -376,7 +376,7 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 	 */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&size, &base);
-	if (ret == 0 && size > 0) {
+	if (ret >= 0) {
 		unsigned long max_size;
 
 		if (fw_dump.reserve_bootvar)
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 63f5a93..9f3e61a 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -122,7 +122,7 @@ void __init reserve_crashkernel(void)
 	/* use common parsing */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 			&crash_size, &crash_base);
-	if (ret == 0 && crash_size > 0) {
+	if (ret >= 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
 	}
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 2c642af..d4bd61b 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -671,7 +671,7 @@ static void __init reserve_crashkernel(void)
 
 	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
 	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
-	if (rc || crash_size == 0)
+	if (rc < 0)
 		return;
 
 	if (memblock.memory.regions[0].size < crash_size) {
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 63d63a3..612b21e 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -157,7 +157,7 @@ void __init reserve_crashkernel(void)
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 			&crash_size, &crash_base);
-	if (ret == 0 && crash_size > 0) {
+	if (ret >= 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
 	}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a5..62d07d4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -526,11 +526,11 @@ static void __init reserve_crashkernel(void)
 
 	/* crashkernel=XM */
 	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0) {
+	if (ret == -EINVAL) {
 		/* crashkernel=X,high */
 		ret = parse_crashkernel_high(boot_command_line, total_mem,
 					     &crash_size, &crash_base);
-		if (ret != 0 || crash_size <= 0)
+		if (ret < 0)
 			return;
 		high = true;
 	}
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 093c9f9..563d86d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -87,7 +87,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
 		cur = tmp;
 		if (size >= system_ram) {
 			pr_warn("crashkernel: invalid size\n");
-			return -EINVAL;
+			return -1;
 		}
 
 		/* match ? */
@@ -108,8 +108,10 @@ static int __init parse_crashkernel_mem(char *cmdline,
 				return -EINVAL;
 			}
 		}
-	} else
+	} else {
 		pr_info("crashkernel size resulted in zero bytes\n");
+		return -1;
+	}
 
 	return 0;
 }
@@ -139,6 +141,8 @@ static int __init parse_crashkernel_simple(char *cmdline,
 		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
 		return -EINVAL;
 	}
+	if (*crash_size == 0)
+		return -1;
 
 	return 0;
 }
@@ -181,6 +185,8 @@ static int __init parse_crashkernel_suffix(char *cmdline,
 		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
 		return -EINVAL;
 	}
+	if (*crash_size == 0)
+		return -1;
 
 	return 0;
 }
@@ -266,6 +272,8 @@ static int __init __parse_crashkernel(char *cmdline,
 /*
  * That function is the entry point for command line parsing and should be
  * called from the arch-specific code.
+ * On success 0 or 1 if @offset is given. On error -EINVAL if bad syntax,
+ * or -1 if the parsing results in crash_size=0.
  */
 int __init parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
-- 
2.7.4

