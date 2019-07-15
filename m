Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D195BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF18205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YnuCl4uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfGOScu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:32:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39821 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbfGOScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:32:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id w190so12430260qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/9dGOutZ6iIa0I5pX8oVUaOB8a4FW9N7Q/1Fl5lsZDw=;
        b=YnuCl4uWvT+BavOsYUN3Vq2CUKPlQvHgMD4rL89D7H7A/q2f5s2X4kkA5fE/NmlRbS
         EIwH0Nx8ykMfN4CdZ+HvP/NNbVI6xMkPcutdcTk5hZVovwD8qCBML3KOPoKrmG2leG8G
         GmubNZYScPkollKet7DvhOXRd8bB7truDUZse05Rq0p4gi2VxdD0LLmQgPQ57FiYfRZS
         isq79iWHIa5rMjDpzWDWuAPJFhGHLc85MClS8hGN3fovWOuaOp5vjZunyaP5f8NkXqLx
         Ofozqr3D5LHjEgbow2BORFWRyjRQWBaDPS72ONQrM99LEEiVA2/B6HM6EF3jrV9RGSke
         oLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/9dGOutZ6iIa0I5pX8oVUaOB8a4FW9N7Q/1Fl5lsZDw=;
        b=G2NEoVDR0HbwqKAyEVv72BMIrNT0GJUZ8nNSdag7oKtNqATgCzMmkJo64ILOKbAgxj
         LukdBFo2yY/vKpVq7y/nwnyHvlE2IfnZOeKR1d1MSb07neWRoFvSE3HSvhOz2CkSy8AC
         BbUJ9ZdI+Vit6tL0KEgLnUJ+Os/1aTZNsx5SMq/YOTGVvXqrMDlFYTjUSEVYVhj08F+L
         MiN+eFs3aFwLCren+MfronCa3Kc97gZVEOi7bguWfycfyDBZSHAuTYRhIvgfjtg4Tlcm
         T2EtCc0thMvR+0LahZeC9zHYaI7oQOYKi5fC1ucXmBrVvE4GtN28EHAQ4dSA9TjNGnnY
         Ql7Q==
X-Gm-Message-State: APjAAAV0I7M0nafC334PdAQx5iV6f9xLZKcUCHq1RIXmXnBYw+J2YFXl
        uJ8bGEjR1RnLAgJMsmSdBcWPRA==
X-Google-Smtp-Source: APXvYqxZVrebOg7BtHtOT0oTwZYnfRiFN9WjO+Qnxkx5tb4wmUsfFFNlxwQlSjqeHc410Jsbr2N6mg==
X-Received: by 2002:a05:620a:1519:: with SMTP id i25mr18378954qkk.331.1563215568667;
        Mon, 15 Jul 2019 11:32:48 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 39sm8979990qts.41.2019.07.15.11.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 11:32:47 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        tyreld@linux.vnet.ibm.com, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v4] powerpc/setup_64: fix -Wempty-body warnings
Date:   Mon, 15 Jul 2019 14:32:32 -0400
Message-Id: <1563215552-8166-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of setup_64.c, it has,

  #ifdef DEBUG
  #define DBG(fmt...) udbg_printf(fmt)
  #else
  #define DBG(fmt...)
  #endif

where DBG() could be compiled away, and generate warnings,

arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
empty body in an 'if' statement [-Wempty-body]
    DBG("Argh, can't find dcache properties !\n");
                                                 ^
arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
empty body in an 'if' statement [-Wempty-body]
    DBG("Argh, can't find icache properties !\n");

Fix it by using the suggestions from Michael:

"Neither of those sites should use DBG(), that's not really early boot
code, they should just use pr_warn().

And the other uses of DBG() in initialize_cache_info() should just be
removed.

In smp_release_cpus() the entry/exit DBG's should just be removed, and
the spinning_secondaries line should just be pr_debug().

That would just leave the two calls in early_setup(). If we taught
udbg_printf() to return early when udbg_putc is NULL, then we could just
call udbg_printf() unconditionally and get rid of the DBG macro
entirely."

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v4: Use the suggestions from Michael and __func__ per checkpatch.
v3: Use no_printk() macro, and make sure that format and argument are always
    verified by the compiler using a more generic form ##__VA_ARGS__ per Joe.
v2: Fix it by using a NOP while loop per Tyrel.

 arch/powerpc/kernel/setup_64.c | 26 ++++++--------------------
 arch/powerpc/kernel/udbg.c     | 14 ++++++++------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 44b4c432a273..d2af4c228970 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,12 +68,6 @@
 
 #include "setup.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 int spinning_secondaries;
 u64 ppc64_pft_size;
 
@@ -305,7 +299,7 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
- 	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
+	udbg_printf(" -> %s(), dt_ptr: 0x%lx\n", __func__, dt_ptr);
 
 	/*
 	 * Do early initialization using the flattened device
@@ -362,11 +356,11 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	this_cpu_enable_ftrace();
 
-	DBG(" <- early_setup()\n");
+	udbg_printf(" <- %s()\n", __func__);
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
 	/*
-	 * This needs to be done *last* (after the above DBG() even)
+	 * This needs to be done *last* (after the above udbg_printf() even)
 	 *
 	 * Right after we return from this function, we turn on the MMU
 	 * which means the real-mode access trick that btext does will
@@ -436,8 +430,6 @@ void smp_release_cpus(void)
 	if (!use_spinloop())
 		return;
 
-	DBG(" -> smp_release_cpus()\n");
-
 	/* All secondary cpus are spinning on a common spinloop, release them
 	 * all now so they can start to spin on their individual paca
 	 * spinloops. For non SMP kernels, the secondary cpus never get out
@@ -456,9 +448,7 @@ void smp_release_cpus(void)
 			break;
 		udelay(1);
 	}
-	DBG("spinning_secondaries = %d\n", spinning_secondaries);
-
-	DBG(" <- smp_release_cpus()\n");
+	pr_debug("spinning_secondaries = %d\n", spinning_secondaries);
 }
 #endif /* CONFIG_SMP || CONFIG_KEXEC_CORE */
 
@@ -551,8 +541,6 @@ void __init initialize_cache_info(void)
 	struct device_node *cpu = NULL, *l2, *l3 = NULL;
 	u32 pvr;
 
-	DBG(" -> initialize_cache_info()\n");
-
 	/*
 	 * All shipping POWER8 machines have a firmware bug that
 	 * puts incorrect information in the device-tree. This will
@@ -576,10 +564,10 @@ void __init initialize_cache_info(void)
 	 */
 	if (cpu) {
 		if (!parse_cache_info(cpu, false, &ppc64_caches.l1d))
-			DBG("Argh, can't find dcache properties !\n");
+			pr_warn("Argh, can't find dcache properties !\n");
 
 		if (!parse_cache_info(cpu, true, &ppc64_caches.l1i))
-			DBG("Argh, can't find icache properties !\n");
+			pr_warn("Argh, can't find icache properties !\n");
 
 		/*
 		 * Try to find the L2 and L3 if any. Assume they are
@@ -604,8 +592,6 @@ void __init initialize_cache_info(void)
 
 	cur_cpu_spec->dcache_bsize = dcache_bsize;
 	cur_cpu_spec->icache_bsize = icache_bsize;
-
-	DBG(" <- initialize_cache_info()\n");
 }
 
 /*
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index a384e7c8b01c..01595e8cafe7 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -120,13 +120,15 @@ int udbg_write(const char *s, int n)
 #define UDBG_BUFSIZE 256
 void udbg_printf(const char *fmt, ...)
 {
-	char buf[UDBG_BUFSIZE];
-	va_list args;
+	if (udbg_putc) {
+		char buf[UDBG_BUFSIZE];
+		va_list args;
 
-	va_start(args, fmt);
-	vsnprintf(buf, UDBG_BUFSIZE, fmt, args);
-	udbg_puts(buf);
-	va_end(args);
+		va_start(args, fmt);
+		vsnprintf(buf, UDBG_BUFSIZE, fmt, args);
+		udbg_puts(buf);
+		va_end(args);
+	}
 }
 
 void __init udbg_progress(char *s, unsigned short hex)
-- 
1.8.3.1

