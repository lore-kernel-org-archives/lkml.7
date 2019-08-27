Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E7CC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB35B2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck9vOoT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfH0DDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:03:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34834 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfH0DDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:03:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so11793922pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 20:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skmsHZOHc0GUvyBJg6E9lWxbDB6kRwoBkgWBhnFqhKs=;
        b=Ck9vOoT9JhqS3AHBlUZ9u9RSyK9vbHUCmGHooclQYjszZjwRFyklKNdV2qJgyCfdRf
         FOECFz4w0Vi2b+NUAIxtdI2NuNYIRxGNtCM/WyOS0xDV6n/3yT2bV4abrTUj093LKKz9
         cVrWsaxjikv5aOu2UvIbGTOKJ+J8si1JWFYaJiFImR6FdtIe0KgY068hDHD94t66E5iU
         dZZip3ohNQF4alhU4GDjJ5cH7OHEnsJGePk8pi4ReV7gr+XymUQlEwdvLbVYtT2oFSiQ
         iHaQT0UHK6s9wYlUiC4ZT2titktU0QiLYsuwXKFdDSX3cRaVEu5xaGn3G6Y88uIi5xOe
         CGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skmsHZOHc0GUvyBJg6E9lWxbDB6kRwoBkgWBhnFqhKs=;
        b=T4mS+tOg8nvUResuOLBRtaVsG/9EDPB2lbA+tCkfHAfqkLIIN3zfW/2gyvVVBIkqNE
         6oyHeRyji5Pi5bkPX1RUjDRN1MSx48im2xVCT118LMA1pe7BwHq5Xn7qIfZj3zrA1sZO
         7dilS+IT7bL2iuR/jAxOeTSU2GURRTB72b/VeADR/uZ9mzlUAIowa9JHH4tPn0S/WAAk
         hwLMK3DAqzEBGy4eV1DjnAe/TmgQhr/WgBmMRtkW/yRWtydZdkJwjIC2quQGlu+OnKM9
         U8KOlmZU32RFrhR0dV7KqKUOByumQVYYVxdejPJI6PnuJxToIlhuND0nMh96FduIrOu6
         qa8g==
X-Gm-Message-State: APjAAAWHcEqr9hL8/p3mKS2JwntJeG5gt6GDA1a5zoS4ecRuz2fUPIYz
        vvqWIQ7gF4qTN6IATYiA5g==
X-Google-Smtp-Source: APXvYqzwfdPZ9oie+DoxTzkjELxMDqe6MH132qvK0r9T52mfvMxBA6NdMQUyFFPPAdqCY8dSCPIkFQ==
X-Received: by 2002:a17:90a:c08f:: with SMTP id o15mr23593215pjs.31.1566874984302;
        Mon, 26 Aug 2019 20:03:04 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s24sm11696535pgm.3.2019.08.26.20.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 20:03:03 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: [PATCHv2 2/4] x86/apic: record capped cpu in generic_processor_info()
Date:   Tue, 27 Aug 2019 11:02:21 +0800
Message-Id: <1566874943-4449-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No matter the cpu is capped by nr_cpus option, recording the mapping
between all cpus' id and apic id

Later this mapping will be used by BSP to sent SIPI to bring capped cpu to
stable state

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/include/asm/smp.h   |  2 ++
 arch/x86/kernel/apic/apic.c  | 21 +++++++++++++++------
 arch/x86/kernel/cpu/common.c |  4 ++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e1356a3..5f63399 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -196,5 +196,7 @@ extern void nmi_selftest(void);
 #define nmi_selftest() do { } while (0)
 #endif
 
+extern struct cpumask *cpu_capped_mask;
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f4f603a..6a57bad3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2296,9 +2296,10 @@ static int allocate_logical_cpuid(int apicid)
 
 int generic_processor_info(int apicid, int version)
 {
-	int cpu, max = nr_cpu_ids;
+	int thiscpu, cpu, max = nr_cpu_ids;
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
 				phys_cpu_present_map);
+	bool capped = false;
 
 	/*
 	 * boot_cpu_physical_apicid is designed to have the apicid
@@ -2322,7 +2323,7 @@ int generic_processor_info(int apicid, int version)
 	if (disabled_cpu_apicid != BAD_APICID &&
 	    disabled_cpu_apicid != read_apic_id() &&
 	    disabled_cpu_apicid == apicid) {
-		int thiscpu = num_processors + disabled_cpus;
+		thiscpu = num_processors + disabled_cpus;
 
 		pr_warning("APIC: Disabling requested cpu."
 			   " Processor %d/0x%x ignored.\n",
@@ -2338,7 +2339,7 @@ int generic_processor_info(int apicid, int version)
 	 */
 	if (!boot_cpu_detected && num_processors >= nr_cpu_ids - 1 &&
 	    apicid != boot_cpu_physical_apicid) {
-		int thiscpu = max + disabled_cpus - 1;
+		thiscpu = max + disabled_cpus - 1;
 
 		pr_warning(
 			"APIC: NR_CPUS/possible_cpus limit of %i almost"
@@ -2346,20 +2347,28 @@ int generic_processor_info(int apicid, int version)
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
 		disabled_cpus++;
-		return -EINVAL;
+		capped = true;
 	}
 
 	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
+		thiscpu = max + disabled_cpus;
 
 		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
 			   "reached. Processor %d/0x%x ignored.\n",
 			   max, thiscpu, apicid);
 
 		disabled_cpus++;
-		return -EINVAL;
+		capped = true;
 	}
 
+	if (capped) {
+		/* record the mapping between capped cpu and apicid */
+		if (thiscpu < NR_CPUS && cpu_capped_mask != NULL) {
+			cpuid_to_apicid[thiscpu] = apicid;
+			cpumask_set_cpu(thiscpu, cpu_capped_mask);
+		}
+		return -EINVAL;
+	}
 	if (apicid == boot_cpu_physical_apicid) {
 		/*
 		 * x86_bios_cpu_apicid is required to have processors listed
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1147217..b95721e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -66,6 +66,9 @@ u32 elf_hwcap2 __read_mostly;
 cpumask_var_t cpu_initialized_mask;
 cpumask_var_t cpu_callout_mask;
 cpumask_var_t cpu_callin_mask;
+/* size of NR_CPUS is required. */
+static struct cpumask __cpu_capped_mask __initdata;
+struct cpumask *cpu_capped_mask;
 
 /* representing cpus for which sibling maps can be computed */
 cpumask_var_t cpu_sibling_setup_mask;
@@ -84,6 +87,7 @@ void __init setup_cpu_local_masks(void)
 	alloc_bootmem_cpumask_var(&cpu_callin_mask);
 	alloc_bootmem_cpumask_var(&cpu_callout_mask);
 	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
+	cpu_capped_mask = &__cpu_capped_mask;
 }
 
 static void default_init(struct cpuinfo_x86 *c)
-- 
2.7.5

