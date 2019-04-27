Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47764C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1343F208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556376183;
	bh=jNV/e4YhYBinB097bju95I0CnoakFJ7NOkDiSFdkxKM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QskFG5nDtHOGKuZC7VAZ3ZH21orM0V6tcMmqSVA+qh9CSK7L0SXeLxqdu2duS2Q9X
	 Gdcs5p2h224bvbX8PxyRlI7Ld7FMxVHIEJQ6EpmZ563PlUZ4zaZMUEEbPAIy70Lez5
	 sFaMl7ORakhoqr8riSeWfoZ6amVx9n2qGSwe3sTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfD0OnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:43:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33537 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD0OnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:43:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so5925107wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ro9f5UB44L1pIXeRbmUj2sUEKHrY418sXD2wKzNvNuo=;
        b=fgLwsu2JxY62+KGYv0ns8ENgWzs/GLmTuhthrt4LpPBbEoerBynjJZ3DJd2S+vpgyc
         9HB1b7hrhK2n7RhdVuB7B3elcSWI/cjfQ3vcHZp34DNDNeK8p5EBcGY4PfB1RZrlNQMr
         or+vmrcsBpJfNlqWQFx0Pk60rxNeQliwbqDLyqOfwlz2NrvYYK9APOxyRb1L/d74ivb+
         OTDhPCjOxvnPczh7jZhRI8/aZtiY3uEDsIR+eKH0RUCG+zxzqmsvSVvyNIklR9lu/3Lh
         uOrzw1UC7pn5wO+6ngbmT0AbRuAYuexLmnnVrU8gs2/h09drbzWD5by9hKSEFCroxZGb
         m2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ro9f5UB44L1pIXeRbmUj2sUEKHrY418sXD2wKzNvNuo=;
        b=hZ+QYaeEngi0vgXh7fjcvWLzUmTpz2anB595u1AXZJ++JHpZc9C6B6zKg9ygj1TVFD
         X/RTVt/rAEcO2op5FXuvH766fGSEauaXgxS03WMNbHVkljsCElw7kZ/R4k6vdgMhaTqC
         IEm+bnEDgpCN+89dNXoN3HnhysuVz8/Ox+mKazjilg0/10Tuzk/hM2soSM3+3C0Xm+Cp
         R3SO7woz5yS1XbRHj7E093dvlny4y9uneh0Vp/igEp8KnSIyI0lrunj51V3bSETbMwG1
         em7n1x4j2kp7FViSQ23aluhvQ3hPev23lSkSJWKk2Kky3o+q1uw5SG3t47qyA6kF5WVg
         k7qg==
X-Gm-Message-State: APjAAAVU3DfjgQNE9DuzYwO2Y9NdgVMp/ru5xaIPHUjefE7LpXuB+Sdq
        kCMZhW+7a5qXTV0VJiwarMI=
X-Google-Smtp-Source: APXvYqyfFPiUgnD+jS+PSWh2E2hu9ZipiiaqdriASKf9b4DEjvguTLsoD1VxrChUdnYzWUOhPZq3/A==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr11221983wml.80.1556376179805;
        Sat, 27 Apr 2019 07:42:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a11sm21523105wmm.35.2019.04.27.07.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 07:42:59 -0700 (PDT)
Date:   Sat, 27 Apr 2019 16:42:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190427144256.GA75188@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 0d02113b31b2017dd349ec9df2314e798a90fa6e x86/mm: Fix a crash with kmemleak_scan()

Two fixes:

 - Fix an early boot crash in the RSDP parsing code by effectively 
   turning off the parsing call - we ran out of time but want to fix the
   regression. The more involved fix is being worked on.

 - Fix a crash that can trigger in the kmemlek code.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/boot: Disable RSDP parsing temporarily

Qian Cai (1):
      x86/mm: Fix a crash with kmemleak_scan()


 arch/x86/boot/compressed/misc.c | 2 +-
 arch/x86/mm/init.c              | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..5a237e8dbf8d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
 	/* Save RSDP address for later use. */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+	/* boot_params->acpi_rsdp_addr = get_rsdp_addr(); */
 
 	sanitize_boot_params(boot_params);
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index f905a2371080..8dacdb96899e 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -5,6 +5,7 @@
 #include <linux/memblock.h>
 #include <linux/swapfile.h>
 #include <linux/swapops.h>
+#include <linux/kmemleak.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -766,6 +767,11 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 	if (debug_pagealloc_enabled()) {
 		pr_info("debug: unmapping init [mem %#010lx-%#010lx]\n",
 			begin, end - 1);
+		/*
+		 * Inform kmemleak about the hole in the memory since the
+		 * corresponding pages will be unmapped.
+		 */
+		kmemleak_free_part((void *)begin, end - begin);
 		set_memory_np(begin, (end - begin) >> PAGE_SHIFT);
 	} else {
 		/*
