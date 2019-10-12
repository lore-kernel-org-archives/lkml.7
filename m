Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D2CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599FC2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570886364;
	bh=TdkeLC0qbUX5u+yH9UV/fxCg3nKWrSy7KrIQXi7PFhA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0mVJCliucZPxNx05BL2RRkJ+r6zW4b6rnjVUTR48C2Rt1djZXvQMb/uRr4wOtDuMm
	 j5hZiKP1n3HmMLR00Q02A/looE8iINVI2ZNL+IGOL4KP2/5uL0W93PYG87N2iH/U7u
	 AScAiDyR9cU+LeG17b6myYmrcW7MG1ySidUAunHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfJLNTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 09:19:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50579 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfJLNTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 09:19:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so12900193wmg.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rxHrJ/JpCRNsDy9V0LejjC9vWznRZlLfOv0/K8fe7r8=;
        b=mD3xPYzG/Ane2VrfdWSaVrJIO6ZETvdaSI4bpkkjbBlFkyg/jVbZydb86kpCoRf/FJ
         MUvvQT+fES01PQzbFIwg8usVFCF0YZrliDLHLAEMuMQMrvbjnyv15JiSygAMFM7Bu800
         qjKxBCXJUWMHj4mhxfvZ3rg14b+Fs9Fd7hX7lo0iqx94m8REur8a3EbkgqjnMBzfZauK
         +4QqhHDlqvWKlfwF3WQw1dFq75346cdeLe2BbVFOtJtIije9UN0yyMhBosLBUFeNG29S
         pRC3L8nElFKJbJ/pFxHJZzzVg5XmuuJRi10qdJUlxtiiCka73V0yKv6VlkKWkGY/e78h
         2eYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=rxHrJ/JpCRNsDy9V0LejjC9vWznRZlLfOv0/K8fe7r8=;
        b=QWTBdswuLvoyCm5CEbbXUNXvGZ6wZqTm2cgpGQXwUEDnNgKU/EIulTT+4+bV2hWq7z
         kTDxqW5XmVbMrT4NLLtoKq6EittVobiZi+rELyhypWzflS850LbHf01WrdQg6MrSGawx
         Gz2q0qMYS01osXkpZPq9e6wz192+xZk7BVPXA977a1H2E3yShyt1iseAdHVx8WlDg4G+
         R7k+ylAmt+HehpkLF0fg7jhgzOgSfUrtTxH9wYU7vAeZMpc7DVyXUtDvB3eCEjYsEsVX
         FAhYyweu/at7FMXpoUIgG8/NRy4V0t09OsJgk2BF0gWb82sg7hkyB7LBoMbOeR4Rleju
         RS1g==
X-Gm-Message-State: APjAAAUM2jjuRHWtGWIalCTfciK6vynexAFMgFChINprok/0dqws8qS8
        nSCKhR3Yv/FSyBV3vvEZdcA=
X-Google-Smtp-Source: APXvYqxhpsZdQy8DkIy4CBzm8R2X1KmsOwlcMYVqFSHnRjv+TGQbv2Hrk77OrggjKuF5jvwLQcNSxw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr7770972wmj.52.1570886359504;
        Sat, 12 Oct 2019 06:19:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e9sm19800697wme.3.2019.10.12.06.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 06:19:18 -0700 (PDT)
Date:   Sat, 12 Oct 2019 15:19:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20191012131916.GA26964@gmail.com>
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

   # HEAD: 8d7c6ac3b2371eb1cbc9925a88f4d10efff374de x86/cpu: Add Comet Lake to the Intel CPU models header

A handful of fixes: a kexec linking fix, an AMD MWAITX fix, a vmware 
guest support fix when built under Clang, and new CPU model number 
definitions.


  out-of-topic modifications in x86-urgent-for-linus:
  -----------------------------------------------------
  include/linux/string.h             # bec500777089: lib/string: Make memzero_exp
  lib/string.c                       # bec500777089: lib/string: Make memzero_exp

 Thanks,

	Ingo

------------------>
Arvind Sankar (1):
      lib/string: Make memzero_explicit() inline instead of external

Janakarajan Natarajan (1):
      x86/asm: Fix MWAITX C-state hint value

Kan Liang (1):
      x86/cpu: Add Comet Lake to the Intel CPU models header

Sami Tolvanen (1):
      x86/cpu/vmware: Use the full form of INL in VMWARE_PORT


 arch/x86/include/asm/intel-family.h |  3 +++
 arch/x86/include/asm/mwait.h        |  2 +-
 arch/x86/kernel/cpu/vmware.c        |  2 +-
 arch/x86/lib/delay.c                |  4 ++--
 include/linux/string.h              | 21 ++++++++++++++++++++-
 lib/string.c                        | 21 ---------------------
 6 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f04622500da3..c606c0b70738 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -83,6 +83,9 @@
 #define INTEL_FAM6_TIGERLAKE_L		0x8C
 #define INTEL_FAM6_TIGERLAKE		0x8D
 
+#define INTEL_FAM6_COMETLAKE		0xA5
+#define INTEL_FAM6_COMETLAKE_L		0xA6
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index e28f8b723b5c..9d5252c9685c 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -21,7 +21,7 @@
 #define MWAIT_ECX_INTERRUPT_BREAK	0x1
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
 #define MWAITX_MAX_LOOPS		((u32)-1)
-#define MWAITX_DISABLE_CSTATES		0xf
+#define MWAITX_DISABLE_CSTATES		0xf0
 
 static inline void __monitor(const void *eax, unsigned long ecx,
 			     unsigned long edx)
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 9735139cfdf8..46d732696c1c 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -49,7 +49,7 @@
 #define VMWARE_CMD_VCPU_RESERVED 31
 
 #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
-	__asm__("inl (%%dx)" :						\
+	__asm__("inl (%%dx), %%eax" :					\
 		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
 		"a"(VMWARE_HYPERVISOR_MAGIC),				\
 		"c"(VMWARE_CMD_##cmd),					\
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index b7375dc6898f..c126571e5e2e 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -113,8 +113,8 @@ static void delay_mwaitx(unsigned long __loops)
 		__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
 
 		/*
-		 * AMD, like Intel, supports the EAX hint and EAX=0xf
-		 * means, do not enter any deep C-state and we use it
+		 * AMD, like Intel's MWAIT version, supports the EAX hint and
+		 * EAX=0xf0 means, do not enter any deep C-state and we use it
 		 * here in delay() to minimize wakeup latency.
 		 */
 		__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);
diff --git a/include/linux/string.h b/include/linux/string.h
index b2f9df7f0761..b6ccdc2c7f02 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -227,7 +227,26 @@ static inline bool strstarts(const char *str, const char *prefix)
 }
 
 size_t memweight(const void *ptr, size_t bytes);
-void memzero_explicit(void *s, size_t count);
+
+/**
+ * memzero_explicit - Fill a region of memory (e.g. sensitive
+ *		      keying data) with 0s.
+ * @s: Pointer to the start of the area.
+ * @count: The size of the area.
+ *
+ * Note: usually using memset() is just fine (!), but in cases
+ * where clearing out _local_ data at the end of a scope is
+ * necessary, memzero_explicit() should be used instead in
+ * order to prevent the compiler from optimising away zeroing.
+ *
+ * memzero_explicit() doesn't need an arch-specific version as
+ * it just invokes the one of memset() implicitly.
+ */
+static inline void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+	barrier_data(s);
+}
 
 /**
  * kbasename - return the last part of a pathname.
diff --git a/lib/string.c b/lib/string.c
index cd7a10c19210..08ec58cc673b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -748,27 +748,6 @@ void *memset(void *s, int c, size_t count)
 EXPORT_SYMBOL(memset);
 #endif
 
-/**
- * memzero_explicit - Fill a region of memory (e.g. sensitive
- *		      keying data) with 0s.
- * @s: Pointer to the start of the area.
- * @count: The size of the area.
- *
- * Note: usually using memset() is just fine (!), but in cases
- * where clearing out _local_ data at the end of a scope is
- * necessary, memzero_explicit() should be used instead in
- * order to prevent the compiler from optimising away zeroing.
- *
- * memzero_explicit() doesn't need an arch-specific version as
- * it just invokes the one of memset() implicitly.
- */
-void memzero_explicit(void *s, size_t count)
-{
-	memset(s, 0, count);
-	barrier_data(s);
-}
-EXPORT_SYMBOL(memzero_explicit);
-
 #ifndef __HAVE_ARCH_MEMSET16
 /**
  * memset16() - Fill a memory area with a uint16_t
