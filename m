Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B65C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA72520B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfHEVVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:21:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:62828 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbfHEVVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:21:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 14:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="192503883"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2019 14:21:36 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/apic: Annotate global config variables as "read-only after init"
Date:   Mon,  5 Aug 2019 14:21:34 -0700
Message-Id: <20190805212134.12001-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the APIC's global config variables that are constant after boot as
__ro_after_init to help document that the majority of the APIC config is
not changed at runtime, and to harden the kernel a smidge.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

This applies on tip/x86/apic, which is currently:

  43931d350f30 ("x86/apic/x2apic: Implement IPI shorthands support")

Let me know if this patch should be based on a different tree.

 arch/x86/kernel/apic/apic.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 831274e3c09f..3a31875bd0a3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -65,10 +65,10 @@ unsigned int num_processors;
 unsigned disabled_cpus;
 
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid = -1U;
+unsigned int boot_cpu_physical_apicid __ro_after_init = -1U;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
-u8 boot_cpu_apic_version;
+u8 boot_cpu_apic_version __ro_after_init;
 
 /*
  * The highest APIC ID seen during enumeration.
@@ -85,13 +85,13 @@ physid_mask_t phys_cpu_present_map;
  * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
  * avoid undefined behaviour caused by sending INIT from AP to BSP.
  */
-static unsigned int disabled_cpu_apicid __read_mostly = BAD_APICID;
+static unsigned int disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
  * external NMIs are delivered only to the BSP.
  */
-static int apic_extnmi = APIC_EXTNMI_BSP;
+static int apic_extnmi __ro_after_init = APIC_EXTNMI_BSP;
 
 /*
  * Map cpu index to physical APIC ID
@@ -114,7 +114,7 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid, BAD_APICID);
 
 /* Local APIC was disabled by the BIOS and enabled by the kernel */
-static int enabled_via_apicbase;
+static int enabled_via_apicbase __ro_after_init;
 
 /*
  * Handle interrupt mode configuration register (IMCR).
@@ -172,23 +172,23 @@ static __init int setup_apicpmtimer(char *s)
 __setup("apicpmtimer", setup_apicpmtimer);
 #endif
 
-unsigned long mp_lapic_addr;
-int disable_apic;
+unsigned long mp_lapic_addr __ro_after_init;
+int disable_apic __ro_after_init;
 /* Disable local APIC timer from the kernel commandline or via dmi quirk */
 static int disable_apic_timer __initdata;
 /* Local APIC timer works in C2 */
-int local_apic_timer_c2_ok;
+int local_apic_timer_c2_ok __ro_after_init;
 EXPORT_SYMBOL_GPL(local_apic_timer_c2_ok);
 
 /*
  * Debug level, exported for io_apic.c
  */
-int apic_verbosity;
+int apic_verbosity __ro_after_init;
 
-int pic_mode;
+int pic_mode __ro_after_init;
 
 /* Have we found an MP table */
-int smp_found_config;
+int smp_found_config __ro_after_init;
 
 static struct resource lapic_resource = {
 	.name = "Local APIC",
@@ -199,7 +199,7 @@ unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
-static unsigned long apic_phys;
+static unsigned long apic_phys __ro_after_init;
 
 /*
  * Get the LAPIC version
@@ -1278,7 +1278,7 @@ void __init sync_Arb_IDs(void)
 			APIC_INT_LEVELTRIG | APIC_DM_INIT);
 }
 
-enum apic_intr_mode_id apic_intr_mode;
+enum apic_intr_mode_id apic_intr_mode __ro_after_init;
 
 static int __init apic_intr_mode_select(void)
 {
-- 
2.22.0

