Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE784C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB21214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SsDdKaP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfGVKER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:04:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfGVKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:04:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6MA48Oi3773745
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 03:04:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6MA48Oi3773745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563789848;
        bh=ydd/k2NghIO46RWjDDmFFrdHyN80kCE91uk0pbGwPxs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SsDdKaP7ZOrk2v1xYVv93hrrTcpRAwlxknbVh2yFfckxKjhprAiXACcp1rSWPTEm6
         nckxlehEf/l4P02MPykM0QOWuuqIjeGRKNAR5CbzjsM5vj7ieD844NY3ybSQiOexIZ
         1xtTm8S3WmGb6x3B7kNGtRQMNpxoW6OclXlFkisdNZ9OZS+DM7hgzHyJLAiY7VeF3h
         2t9fQ85yhvnfaNcV1nurfogMPIYbkFRNVj/Kg6rcXEYXzMfM6WwhOgLqoMtC8kZzyI
         OqoLCbjVNedMAVg++SgBcMOO256IpzA2ai2khjFcrA830j8gb/eZYygn89i6vfjPPd
         gAth7tuwuU3yQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6MA48Jj3773742;
        Mon, 22 Jul 2019 03:04:08 -0700
Date:   Mon, 22 Jul 2019 03:04:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-be261ffce6f13229dad50f59c5e491f933d3167f@git.kernel.org>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, jpoimboe@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <d990aa51e40063acb9888e8c1b688e41355a9588.1562255067.git.jpoimboe@redhat.com>
References: <d990aa51e40063acb9888e8c1b688e41355a9588.1562255067.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86: Remove X86_FEATURE_MFENCE_RDTSC
Git-Commit-ID: be261ffce6f13229dad50f59c5e491f933d3167f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  be261ffce6f13229dad50f59c5e491f933d3167f
Gitweb:     https://git.kernel.org/tip/be261ffce6f13229dad50f59c5e491f933d3167f
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 4 Jul 2019 10:46:37 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 12:00:51 +0200

x86: Remove X86_FEATURE_MFENCE_RDTSC

AMD and Intel both have serializing lfence (X86_FEATURE_LFENCE_RDTSC).
They've both had it for a long time, and AMD has had it enabled in Linux
since Spectre v1 was announced.

Back then, there was a proposal to remove the serializing mfence feature
bit (X86_FEATURE_MFENCE_RDTSC), since both AMD and Intel have
serializing lfence.  At the time, it was (ahem) speculated that some
hypervisors might not yet support its removal, so it remained for the
time being.

Now a year-and-a-half later, it should be safe to remove.

I asked Andrew Cooper about whether it's still needed:

  So if you're virtualised, you've got no choice in the matter.  lfence
  is either dispatch-serialising or not on AMD, and you won't be able to
  change it.

  Furthermore, you can't accurately tell what state the bit is in, because
  the MSR might not be virtualised at all, or may not reflect the true
  state in hardware.  Worse still, attempting to set the bit may not be
  successful even if there isn't a fault for doing so.

  Xen sets the DE_CFG bit unconditionally, as does Linux by the looks of
  things (see MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT).  ISTR other hypervisor
  vendors saying the same, but I don't have any information to hand.

  If you are running under a hypervisor which has been updated, then
  lfence will almost certainly be dispatch-serialising in practice, and
  you'll almost certainly see the bit already set in DE_CFG.  If you're
  running under a hypervisor which hasn't been patched since Spectre,
  you've already lost in many more ways.

  I'd argue that X86_FEATURE_MFENCE_RDTSC is not worth keeping.

So remove it.  This will reduce some code rot, and also make it easier
to hook barrier_nospec() up to a cmdline disable for performance
raisins, without having to need an alternative_3() macro.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/d990aa51e40063acb9888e8c1b688e41355a9588.1562255067.git.jpoimboe@redhat.com

---
 arch/x86/include/asm/barrier.h           |  3 +--
 arch/x86/include/asm/cpufeatures.h       |  1 -
 arch/x86/include/asm/msr.h               |  3 +--
 arch/x86/kernel/cpu/amd.c                | 21 +++------------------
 arch/x86/kernel/cpu/hygon.c              | 21 +++------------------
 tools/arch/x86/include/asm/cpufeatures.h |  1 -
 6 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 84f848c2541a..7f828fe49797 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -49,8 +49,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #define array_index_mask_nospec array_index_mask_nospec
 
 /* Prevent speculative execution past this barrier. */
-#define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
-					   "lfence", X86_FEATURE_LFENCE_RDTSC)
+#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
 
 #define dma_rmb()	barrier()
 #define dma_wmb()	barrier()
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 56f53bf3bbbf..fcc70ffd88c2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -96,7 +96,6 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-#define X86_FEATURE_MFENCE_RDTSC	( 3*32+17) /* "" MFENCE synchronizes RDTSC */
 #define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 5cc3930cb465..86f20d520a07 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -233,8 +233,7 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	 * Thus, use the preferred barrier on the respective CPU, aiming for
 	 * RDTSCP as the default.
 	 */
-	asm volatile(ALTERNATIVE_3("rdtsc",
-				   "mfence; rdtsc", X86_FEATURE_MFENCE_RDTSC,
+	asm volatile(ALTERNATIVE_2("rdtsc",
 				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
 				   "rdtscp", X86_FEATURE_RDTSCP)
 			: EAX_EDX_RET(val, low, high)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8d4e50428b68..3afe07d602dd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -879,12 +879,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 	init_amd_cacheinfo(c);
 
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
-		unsigned long long val;
-		int ret;
-
 		/*
-		 * A serializing LFENCE has less overhead than MFENCE, so
-		 * use it for execution serialization.  On families which
+		 * Use LFENCE for execution serialization.  On families which
 		 * don't have that MSR, LFENCE is already serializing.
 		 * msr_set_bit() uses the safe accessors, too, even if the MSR
 		 * is not present.
@@ -892,19 +888,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 		msr_set_bit(MSR_F10H_DECFG,
 			    MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT);
 
-		/*
-		 * Verify that the MSR write was successful (could be running
-		 * under a hypervisor) and only then assume that LFENCE is
-		 * serializing.
-		 */
-		ret = rdmsrl_safe(MSR_F10H_DECFG, &val);
-		if (!ret && (val & MSR_F10H_DECFG_LFENCE_SERIALIZE)) {
-			/* A serializing LFENCE stops RDTSC speculation */
-			set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
-		} else {
-			/* MFENCE stops RDTSC speculation */
-			set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
-		}
+		/* A serializing LFENCE stops RDTSC speculation */
+		set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 	}
 
 	/*
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 415621ddb8a2..4e28c1fc8749 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -330,12 +330,8 @@ static void init_hygon(struct cpuinfo_x86 *c)
 	init_hygon_cacheinfo(c);
 
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
-		unsigned long long val;
-		int ret;
-
 		/*
-		 * A serializing LFENCE has less overhead than MFENCE, so
-		 * use it for execution serialization.  On families which
+		 * Use LFENCE for execution serialization.  On families which
 		 * don't have that MSR, LFENCE is already serializing.
 		 * msr_set_bit() uses the safe accessors, too, even if the MSR
 		 * is not present.
@@ -343,19 +339,8 @@ static void init_hygon(struct cpuinfo_x86 *c)
 		msr_set_bit(MSR_F10H_DECFG,
 			    MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT);
 
-		/*
-		 * Verify that the MSR write was successful (could be running
-		 * under a hypervisor) and only then assume that LFENCE is
-		 * serializing.
-		 */
-		ret = rdmsrl_safe(MSR_F10H_DECFG, &val);
-		if (!ret && (val & MSR_F10H_DECFG_LFENCE_SERIALIZE)) {
-			/* A serializing LFENCE stops RDTSC speculation */
-			set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
-		} else {
-			/* MFENCE stops RDTSC speculation */
-			set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
-		}
+		/* A serializing LFENCE stops RDTSC speculation */
+		set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 	}
 
 	/*
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 998c2cc08363..9b98edb6b2d3 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -96,7 +96,6 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-#define X86_FEATURE_MFENCE_RDTSC	( 3*32+17) /* "" MFENCE synchronizes RDTSC */
 #define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
