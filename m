Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F1C31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F682147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ScMAd1wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfFSRgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:36:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39666 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfFSRgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:36:35 -0400
Received: from zn.tnic (p200300EC2F109900C181231BF4D53555.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:9900:c181:231b:f4d5:3555])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 166BD1EC066F;
        Wed, 19 Jun 2019 19:36:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560965793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MpQLrbAp1UVcOtMP70WZ0ez5872olDqTULyQUYOf8E=;
        b=ScMAd1wIdMWxrZWeVfPuOPYU/yg68q9qYm0VoKaTs5/t5El5j16+MT7E9yjGOyxsZFCyK0
        qIIe7ta1mIkQfifgItYld9J/s6Hn6dz9LOH0sWg0WwAKoVw+BqixXnpAQFJ1e7iUiZZgma
        sziBRv2lXulzQxvtT620iR0XkKyojAc=
Date:   Wed, 19 Jun 2019 19:36:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/2] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190619173628.GI9574@zn.tnic>
References: <1560794416-217638-1-git-send-email-fenghua.yu@intel.com>
 <1560794416-217638-2-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560794416-217638-2-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:00:15AM -0700, Fenghua Yu wrote:
> @@ -832,33 +857,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  		c->x86_capability[CPUID_D_1_EAX] = eax;
>  	}
>  
> -	/* Additional Intel-defined flags: level 0x0000000F */
> -	if (c->cpuid_level >= 0x0000000F) {
> -
> -		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
> -		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
> -		c->x86_capability[CPUID_F_0_EDX] = edx;
> -
> -		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
> -			/* will be overridden if occupancy monitoring exists */
> -			c->x86_cache_max_rmid = ebx;
> -
> -			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
> -			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
> -			c->x86_capability[CPUID_F_1_EDX] = edx;
> -
> -			if ((cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC)) ||
> -			      ((cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL)) ||
> -			       (cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)))) {
> -				c->x86_cache_max_rmid = ecx;
> -				c->x86_cache_occ_scale = ebx;
> -			}
> -		} else {
> -			c->x86_cache_max_rmid = -1;
> -			c->x86_cache_occ_scale = -1;
> -		}
> -	}
> -
>  	/* AMD-defined flags: level 0x80000001 */
>  	eax = cpuid_eax(0x80000000);
>  	c->extended_cpuid_level = eax;

What I meant with having a separate patch doing the carve out is to have
a single patch doing *only* code movement - no changes, no nothing. So
that it is clear what happens. Intermixing code movement and changes is
a bad idea and hard to review.

IOW, I did this:

---
From cef4f58a3da0465bbff33b2d669cc600b775f3ba Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@suse.de>
Date: Wed, 19 Jun 2019 17:24:34 +0200
Subject: [PATCH] x86/cpufeatures: Carve out CQM features retrieval

... into a separate function for better readability. Split out from a
patch from Fenghua Yu <fenghua.yu@intel.com> to keep the mechanical,
sole code movement separate for easy review.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/common.c | 60 ++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2c57fffebf9b..fe6ed9696467 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -801,6 +801,38 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	}
 }
 
+static void init_cqm(struct cpuinfo_x86 *c)
+{
+	u32 eax, ebx, ecx, edx;
+
+	/* Additional Intel-defined flags: level 0x0000000F */
+	if (c->cpuid_level >= 0x0000000F) {
+
+		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
+		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
+		c->x86_capability[CPUID_F_0_EDX] = edx;
+
+		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
+			/* will be overridden if occupancy monitoring exists */
+			c->x86_cache_max_rmid = ebx;
+
+			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
+			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
+			c->x86_capability[CPUID_F_1_EDX] = edx;
+
+			if ((cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC)) ||
+			      ((cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL)) ||
+			       (cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)))) {
+				c->x86_cache_max_rmid = ecx;
+				c->x86_cache_occ_scale = ebx;
+			}
+		} else {
+			c->x86_cache_max_rmid = -1;
+			c->x86_cache_occ_scale = -1;
+		}
+	}
+}
+
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -832,33 +864,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_D_1_EAX] = eax;
 	}
 
-	/* Additional Intel-defined flags: level 0x0000000F */
-	if (c->cpuid_level >= 0x0000000F) {
-
-		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
-		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
-		c->x86_capability[CPUID_F_0_EDX] = edx;
-
-		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
-			/* will be overridden if occupancy monitoring exists */
-			c->x86_cache_max_rmid = ebx;
-
-			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
-			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
-			c->x86_capability[CPUID_F_1_EDX] = edx;
-
-			if ((cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC)) ||
-			      ((cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL)) ||
-			       (cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)))) {
-				c->x86_cache_max_rmid = ecx;
-				c->x86_cache_occ_scale = ebx;
-			}
-		} else {
-			c->x86_cache_max_rmid = -1;
-			c->x86_cache_occ_scale = -1;
-		}
-	}
-
 	/* AMD-defined flags: level 0x80000001 */
 	eax = cpuid_eax(0x80000000);
 	c->extended_cpuid_level = eax;
@@ -889,6 +894,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
+	init_cqm(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
-- 
2.21.0

---

This way you have *pure* code movement only.

And then your second patch turns into this, which shows *exactly* what
has been changed in init_cqm().

Please have a look and send me only the now third patch with corrected
commit message.

Thx.

---
From e33527b8cde8bef84cdc90651d1a1c7a9a5234d7 Mon Sep 17 00:00:00 2001
From: Fenghua Yu <fenghua.yu@intel.com>
Date: Wed, 19 Jun 2019 18:51:09 +0200
Subject: [PATCH] x86/cpufeatures: Combine word 11 and 12 into a new
 scattered features word
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's a waste for the four X86_FEATURE_CQM_* feature bits to occupy two
whole feature bits words. To better utilize feature words, re-define
word 11 to host scattered features and move the four X86_FEATURE_CQM_*
features into Linux defined word 11. More scattered features can be
added in word 11 in the future.

Rename leaf 11 in cpuid_leafs to CPUID_LNX_4 to reflect it's a
Linux-defined leaf.

Rename leaf 12 as CPUID_DUMMY which will be replaced by a meaningful
name in the next patch when CPUID.7.1:EAX occupies world 12.

Maximum number of RMID and cache occupancy scale are retrieved from
CPUID.0xf.1 after scattered CQM features are enumerated. Carve out the
code into a separate function.

KVM doesn't support resctrl now. So it's safe to move the
X86_FEATURE_CQM_* features to scattered features word 11 for KVM.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Aaron Lewis <aaronlewis@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Babu Moger <babu.moger@amd.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: "Sean J Christopherson" <sean.j.christopherson@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: x86 <x86@kernel.org>
Link: https://lkml.kernel.org/r/1560794416-217638-2-git-send-email-fenghua.yu@intel.com
---
 arch/x86/include/asm/cpufeature.h  |  4 ++--
 arch/x86/include/asm/cpufeatures.h | 17 +++++++------
 arch/x86/kernel/cpu/common.c       | 38 ++++++++++++------------------
 arch/x86/kernel/cpu/cpuid-deps.c   |  3 +++
 arch/x86/kernel/cpu/scattered.c    |  4 ++++
 arch/x86/kvm/cpuid.h               |  2 --
 6 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1d337c51f7e6..403f70c2e431 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -22,8 +22,8 @@ enum cpuid_leafs
 	CPUID_LNX_3,
 	CPUID_7_0_EBX,
 	CPUID_D_1_EAX,
-	CPUID_F_0_EDX,
-	CPUID_F_1_EDX,
+	CPUID_LNX_4,
+	CPUID_DUMMY,
 	CPUID_8000_0008_EBX,
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1017b9c7dfe0..be858b86023a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -271,13 +271,16 @@
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
 
-/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:0 (EDX), word 11 */
-#define X86_FEATURE_CQM_LLC		(11*32+ 1) /* LLC QoS if 1 */
-
-/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:1 (EDX), word 12 */
-#define X86_FEATURE_CQM_OCCUP_LLC	(12*32+ 0) /* LLC occupancy monitoring */
-#define X86_FEATURE_CQM_MBM_TOTAL	(12*32+ 1) /* LLC Total MBM monitoring */
-#define X86_FEATURE_CQM_MBM_LOCAL	(12*32+ 2) /* LLC Local MBM monitoring */
+/*
+ * Extended auxiliary flags: Linux defined - for features scattered in various
+ * CPUID levels like 0xf, etc.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_CQM_LLC		(11*32+ 0) /* LLC QoS if 1 */
+#define X86_FEATURE_CQM_OCCUP_LLC	(11*32+ 1) /* LLC occupancy monitoring */
+#define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
+#define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fe6ed9696467..efb114298cfb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -803,33 +803,25 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 
 static void init_cqm(struct cpuinfo_x86 *c)
 {
-	u32 eax, ebx, ecx, edx;
-
-	/* Additional Intel-defined flags: level 0x0000000F */
-	if (c->cpuid_level >= 0x0000000F) {
+	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
+		c->x86_cache_max_rmid  = -1;
+		c->x86_cache_occ_scale = -1;
+		return;
+	}
 
-		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
-		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
-		c->x86_capability[CPUID_F_0_EDX] = edx;
+	/* will be overridden if occupancy monitoring exists */
+	c->x86_cache_max_rmid = cpuid_ebx(0xf);
 
-		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
-			/* will be overridden if occupancy monitoring exists */
-			c->x86_cache_max_rmid = ebx;
+	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+		u32 eax, ebx, ecx, edx;
 
-			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
-			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
-			c->x86_capability[CPUID_F_1_EDX] = edx;
+		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
+		cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
 
-			if ((cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC)) ||
-			      ((cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL)) ||
-			       (cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)))) {
-				c->x86_cache_max_rmid = ecx;
-				c->x86_cache_occ_scale = ebx;
-			}
-		} else {
-			c->x86_cache_max_rmid = -1;
-			c->x86_cache_occ_scale = -1;
-		}
+		c->x86_cache_max_rmid  = ecx;
+		c->x86_cache_occ_scale = ebx;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..fa07a224e7b9 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -59,6 +59,9 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_4VNNIW,	X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_4FMAPS,	X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VPOPCNTDQ, X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_CQM_OCCUP_LLC,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_CQM_MBM_TOTAL,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_CQM_MBM_LOCAL,	X86_FEATURE_CQM_LLC   },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 94aa1c72ca98..adf9b71386ef 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -26,6 +26,10 @@ struct cpuid_bit {
 static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
+	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
+	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
+	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
+	{ X86_FEATURE_CQM_MBM_LOCAL,	CPUID_EDX,  2, 0x0000000f, 1 },
 	{ X86_FEATURE_CAT_L3,		CPUID_EBX,  1, 0x00000010, 0 },
 	{ X86_FEATURE_CAT_L2,		CPUID_EBX,  2, 0x00000010, 0 },
 	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 9a327d5b6d1f..d78a61408243 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -47,8 +47,6 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
 	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
 	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
-	[CPUID_F_0_EDX]       = {       0xf, 0, CPUID_EDX},
-	[CPUID_F_1_EDX]       = {       0xf, 1, CPUID_EDX},
 	[CPUID_8000_0008_EBX] = {0x80000008, 0, CPUID_EBX},
 	[CPUID_6_EAX]         = {         6, 0, CPUID_EAX},
 	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
