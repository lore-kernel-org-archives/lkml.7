Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2027120B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDZTk6Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfHEI7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:59:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33643 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfHEI7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:59:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so4250238pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FIbiHcGDYSov0UE7VA5uO1KbDNgvOwrKf/S6d4sgUvg=;
        b=EDZTk6FnPwJnYHzVY2dB6l0getqsLnh2GZ70TOet6d1NN2FYg19k31wxZpmVhbRZOI
         OmmLeqAxuSFO2qg8o1gRqMoQHjRH1oL3WLUvTsIInFb+tFJBPhg7aww5pW5UR+tGIIrH
         Ti7W2MfJmUfw84YYcaLBHWFjgwPDjmKpU9t8gwKnE+vmQ+FMzEfbfLpuxIxWtBYTW6S8
         loMM9VHYGN2EnX6cU7IAa6PW80sSdWwGlaR2KXZvoL2g/OeHgADcZm7CuH1EHavNLYaq
         73cssw1P7SLpKmsMNMcv1tcq5sEblqYjlfhOaOXAqH3NLAtYJ8+0RLf0Z65LEa9ajLDY
         ++HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIbiHcGDYSov0UE7VA5uO1KbDNgvOwrKf/S6d4sgUvg=;
        b=VeG6AxTQZalwO4yegvymDZ8P5GCyr6BRGP7ktllqaRaQZsTi832DSfeIbw4WHbompG
         N+Q+XyW/YdPFRZyXd+adr4iFGMOr0S5oTnWWdzmqF0x5ac5JyZ67Z9PcKOl6tOWe+C5R
         z83FIQOjjwlC7zj2tlgratlZ6JGSg+wf/5m6y80rMxMSE49eAfKjdojhxQM9bhXP3OCb
         l7oR1qyww96MF2z32tfDIlFgKG4PDoXD/g20rkuAxZzV9iCmJOi1/Om+HpURpXeVu+oe
         WKTHgltVw8MWoM+JspdBCxpwPLBjMtd3cbPEIlhP7zv5so0TygnDakV+2KwMtO+8aVeG
         Cq2w==
X-Gm-Message-State: APjAAAWVw4SLon1+lwnbic8OVOG2rhF2OFwC62M2dJeZGz+/SwbWgGDZ
        cv3cSzRXHVGNEAXblr/PjQ==
X-Google-Smtp-Source: APXvYqxzK4bknrl6FhPLuz+tGHkR7LApM/9uwty0Ya3DxRCeJxpJA+oBwJ1i6hIMnyWrfDw/J0Ki0w==
X-Received: by 2002:a63:6f81:: with SMTP id k123mr138151417pgc.12.1564995593254;
        Mon, 05 Aug 2019 01:59:53 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v184sm82428375pfb.82.2019.08.05.01.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 01:59:52 -0700 (PDT)
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
Subject: [PATCH 2/4] x86/apic: record capped cpu in generic_processor_info()
Date:   Mon,  5 Aug 2019 16:58:57 +0800
Message-Id: <1564995539-29609-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
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
index 1147217..4d87df5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -66,6 +66,9 @@ u32 elf_hwcap2 __read_mostly;
 cpumask_var_t cpu_initialized_mask;
 cpumask_var_t cpu_callout_mask;
 cpumask_var_t cpu_callin_mask;
+/* size of NR_CPUS is required. */
+struct cpumask __cpu_capped_mask __initdata;
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

