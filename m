Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05172C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86D8214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfFQD1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:27:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:22102 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfFQD1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:27:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 20:27:39 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2019 20:27:38 -0700
Date:   Sun, 16 Jun 2019 20:18:09 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190617031808.GA214090@romley-ivt3.sc.intel.com>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
 <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 10:24:13PM +0200, Thomas Gleixner wrote:
> On Sun, 16 Jun 2019, Fenghua Yu wrote:
> 
> > Although x86_cache_max_rmid and x86_cache_occ_scale are only read once
> > during resctrl initialization, they are always stored in cpuinfo_x86 for
> > each CPU during run time without usage. Even if resctrl is not
> > configured, they still occupy space in cpuinfo_x86.
> 
> And that's a problem because?
> 
> > To save cpuinfo_x86 space and make CPU and resctrl initialization simpler,
> > remove the two fields from cpuinfo_x86 and get max rmid and occupancy
> 
> What is simpler? The fact that more code fiddles with CPUID? That's exactly
> the wrong direction.
> 
> The storage size of struct cpuinfo is largely uninteresting especially as
> long as we keep num_online_cpus copies of the same information around.
> 
> Just grep for places which invoke CPUID and then look how many of them do
> it over and over and even the code in arch/x86/kernel/cpu/ is an
> unpenetrable mess for exactly this reason.
> 
> The right thing to do is to have one instance of the CPUID information
> which is
> 
>   - a proper data structure with named fields and named bits
> 
>   - a single master instance which can be mapped to all CPUs
> 
> This data structure is filled in in one go by reading out all leaves and
> not by the maze we have today which puts together selected parts piecewise
> and never exposes a full and consistent picture.
> 
> This allows to remove all these custom copies of CPUID leaf readouts and
> allows proper filtering/disabling at a central place.
> 
> Making it a proper data structure with fields and bits gets rid of all that
> hex masking/shifting nonsense which is used to decode parts of those
> fields.
> 
> That's not a performance issue because all performance critical code should
> use static_cpu_has() anyway. For non critical code boot_cpu_has() is
> sufficient.
> 
> Upcoming secondary CPUs would do a sanity check on their CPUID content to
> check whether everything is symmetric. We should do that actually today
> because not detecting asymetric features early leads to exactly the issue
> which was fixed recently with loading the micro code earlier than perf.
> But we can't because the information retrieval is done in a gazillion of
> places.
>   
> Now you might argue that the upcoming asymetric processors (SIGH!) will
> require per CPU instances of the feature leafs. Sure that needs some
> thought, but it needs thought even with the current code and I'm absolutely
> not interested to duct tape that stuff into the current code.
> 
> The solution for this with the above scheme is to utilize the feature
> mismatch detection and have a proper classification which features are
> allowed to deviate and which are not. For those which can deviate, we can
> provide separate storage as this information needs to be propagated to
> other entities (fault handlers, placement code, xsave variants etc.). But
> that's a limited amount of information and the bulk will still be the same.
> 
> This mismatch detection is essential for dealing with future asymetric
> CPUs proper. When the kernel detects it, it can disable mismatching
> features which are not yet handled by code which has to be aware of them.
> 
> And disabling them means that with that scheme we can actually trap CPUID
> in userspace and provide it consistent and filtered information instead
> of having the mismatch between kernel view and user space view.
> 
> Borislav has experimented with that already, but thanks to the marvelous
> security features built into Intel (and other) CPUs this is still mostly a
> drawing board exercise.
> 
> Just for the record. Before this cleanup takes place, I'm not even looking
> at any patches which attempt to support asymetric processors. The current
> supply of duct tape engineering horrors is sufficient for bad mood. No need
> for more of that.

I see. Then this patch #1 doesn't make sense.

So in the next version, can I remove the patch #1, change the patch #2 as
follows, and keep the patch #3?

It's a waste for the four X86_FEATURE_CQM_* features to occupy two
pure feature bits words. To better utilize feature words, re-define
word 11 to host scattered features and move the four X86_FEATURE_CQM_*
features into Linux defined word 11. More scattered features can be added
in word 11 in the future.

Leaf 11 in cpuid_leafs is renamed as CPUID_LNX_4 to reflect it's a Linux
defined leaf.

Although word 12 doesn't have any feature now, leaf 12 in cpuid_leafs
still needs to be kept because cpuid_leafs must have NCAPINTS leafs.
Rename leaf 12 as CPUID_DUMMY which will be replaced by a meaningful name
in the next patch when CPUID.7.1:EAX occupies world 12.

KVM doesn't support resctrl now. So it's safe to move the
X86_FEATURE_CQM_* features to scattered features word 11 for KVM.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpufeature.h  |  4 +--
 arch/x86/include/asm/cpufeatures.h | 17 ++++++----
 arch/x86/kernel/cpu/common.c       | 53 +++++++++++++++---------------
 arch/x86/kernel/cpu/cpuid-deps.c   |  3 ++
 arch/x86/kernel/cpu/scattered.c    |  4 +++
 arch/x86/kvm/cpuid.h               |  2 --
 6 files changed, 45 insertions(+), 38 deletions(-)

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
index 75f27ee2c263..4f0a3d093794 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -269,13 +269,16 @@
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
+ * Extended auxiliary flags: Linux defined - For features scattered in various
+ * CPUID levels like 0xf, word 11.
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
index 2c57fffebf9b..f080be35da41 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -801,6 +801,31 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	}
 }
 
+static void get_cqm_info(struct cpuinfo_x86 *c)
+{
+	if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
+		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
+		/* will be overridden if occupancy monitoring exists */
+		c->x86_cache_max_rmid = ebx;
+
+		if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
+		    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
+		    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
+			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
+
+			c->x86_cache_max_rmid = ecx;
+			c->x86_cache_occ_scale = ebx;
+		}
+	} else {
+		c->x86_cache_max_rmid = -1;
+		c->x86_cache_occ_scale = -1;
+	}
+}
+
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -832,33 +857,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
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
@@ -889,6 +887,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
+	get_cqm_info(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
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
2.19.1


Thanks.

-Fenghua
