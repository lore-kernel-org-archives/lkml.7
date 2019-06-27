Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529EC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F328021783
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfF0SoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:44:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:56448 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0Snx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:43:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 11:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="313893967"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga004.jf.intel.com with ESMTP; 27 Jun 2019 11:43:52 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Alan Cox <alan.cox@intel.com>, Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordan Borgner <mail@jordan-borgner.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Mohammad Etemadi <mohammad.etemadi@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Feiner <pfeiner@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/2] x86/cpu/intel: Clear cache self-snoop capability in CPUs with known errata
Date:   Thu, 27 Jun 2019 11:43:16 -0700
Message-Id: <1561660997-21562-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561660997-21562-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1561660997-21562-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Processors which have self-snooping capability can handle conflicting
memory type across CPUs by snooping its own cache. However, there exists
CPU models in which having conflicting memory types still leads to
unpredictable behavior, machine check errors, or hangs. Clear this feature
to prevent its use. For instance, the algorithm to program the Memory Type
Region Registers and the Page Attribute Table MSR can skip expensive cache
flushes if self-snooping is supported.

Cc: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Alan Cox <alan.cox@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f17c1a714779..8684c66e71e0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -66,6 +66,34 @@ void check_mpx_erratum(struct cpuinfo_x86 *c)
 	}
 }
 
+/*
+ * Processors which have self-snooping capability can handle conflicting
+ * memory type across CPUs by snooping its own cache. However, there exists
+ * CPU models in which having conflicting memory types still leads to
+ * unpredictable behavior, machine check errors, or hangs. Clear this feature
+ * to prevent its use. For instance, the algorithm to program the Memory Type
+ * Region Registers and the Page Attribute Table MSR can skip expensive cache
+ * flushes if self-snooping is supported.
+ */
+static void check_memory_type_self_snoop_errata(struct cpuinfo_x86 *c)
+{
+	switch (c->x86_model) {
+	case INTEL_FAM6_CORE_YONAH:
+	case INTEL_FAM6_CORE2_MEROM:
+	case INTEL_FAM6_CORE2_MEROM_L:
+	case INTEL_FAM6_CORE2_PENRYN:
+	case INTEL_FAM6_CORE2_DUNNINGTON:
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_NEHALEM_G:
+	case INTEL_FAM6_NEHALEM_EP:
+	case INTEL_FAM6_NEHALEM_EX:
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_WESTMERE_EP:
+	case INTEL_FAM6_SANDYBRIDGE:
+		setup_clear_cpu_cap(X86_FEATURE_SELFSNOOP);
+	}
+}
+
 static bool ring3mwait_disabled __read_mostly;
 
 static int __init ring3mwait_disable(char *__unused)
@@ -311,6 +339,8 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 */
 	if (detect_extended_topology_early(c) < 0)
 		detect_ht_early(c);
+
+	check_memory_type_self_snoop_errata(c);
 }
 
 #ifdef CONFIG_X86_32
-- 
2.17.1

