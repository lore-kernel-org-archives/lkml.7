Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA02C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5412077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfDPLlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:41:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbfDPLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:41:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBewFx3429263
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:40:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBewQe3429260;
        Tue, 16 Apr 2019 04:40:58 -0700
Date:   Tue, 16 Apr 2019 04:40:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-6e394376ee89233508fa21d006546357f8efee31@git.kernel.org>
Cc:     hpa@zytor.com, kan.liang@linux.intel.com, jolsa@redhat.com,
        torvalds@linux-foundation.org, eranian@google.com,
        vincent.weaver@maine.edu, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, mingo@kernel.org, vincent.weaver@maine.edu,
          eranian@google.com, jolsa@redhat.com,
          torvalds@linux-foundation.org, kan.liang@linux.intel.com,
          hpa@zytor.com
In-Reply-To: <20190402194509.2832-13-kan.liang@linux.intel.com>
References: <20190402194509.2832-13-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Add Intel Icelake uncore
 support
Git-Commit-ID: 6e394376ee89233508fa21d006546357f8efee31
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

Commit-ID:  6e394376ee89233508fa21d006546357f8efee31
Gitweb:     https://git.kernel.org/tip/6e394376ee89233508fa21d006546357f8efee31
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 2 Apr 2019 12:45:09 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:26:19 +0200

perf/x86/intel/uncore: Add Intel Icelake uncore support

Add Intel Icelake uncore support:

 - The init code is based on Skylake
 - Add new PCI id for IMC
 - New MSR address for CBOX
 - Get CBOX# from CNL_UNC_CBO_CONFIG MSR directly
 - Create a new PMU for fixed clocktick counter

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Link: https://lkml.kernel.org/r/20190402194509.2832-13-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c     |  6 +++
 arch/x86/events/intel/uncore.h     |  1 +
 arch/x86/events/intel/uncore_snb.c | 91 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 9fe64c01a2e5..fc40a1473058 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1367,6 +1367,11 @@ static const struct intel_uncore_init_fun skx_uncore_init __initconst = {
 	.pci_init = skx_uncore_pci_init,
 };
 
+static const struct intel_uncore_init_fun icl_uncore_init __initconst = {
+	.cpu_init = icl_uncore_cpu_init,
+	.pci_init = skl_uncore_pci_init,
+};
+
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EP,	  nhm_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM,	  nhm_uncore_init),
@@ -1393,6 +1398,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,      skx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
 	{},
 };
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 853a49a8ccf6..79eb2e21e4f0 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -512,6 +512,7 @@ int skl_uncore_pci_init(void);
 void snb_uncore_cpu_init(void);
 void nhm_uncore_cpu_init(void);
 void skl_uncore_cpu_init(void);
+void icl_uncore_cpu_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 13493f43b247..f8431819b3e1 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -34,6 +34,8 @@
 #define PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC	0x3e33
 #define PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC	0x3eca
 #define PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC	0x3e32
+#define PCI_DEVICE_ID_INTEL_ICL_U_IMC		0x8a02
+#define PCI_DEVICE_ID_INTEL_ICL_U2_IMC		0x8a12
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -93,6 +95,12 @@
 #define SKL_UNC_PERF_GLOBAL_CTL			0xe01
 #define SKL_UNC_GLOBAL_CTL_CORE_ALL		((1 << 5) - 1)
 
+/* ICL Cbo register */
+#define ICL_UNC_CBO_CONFIG			0x396
+#define ICL_UNC_NUM_CBO_MASK			0xf
+#define ICL_UNC_CBO_0_PER_CTR0			0x702
+#define ICL_UNC_CBO_MSR_OFFSET			0x8
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
@@ -280,6 +288,70 @@ void skl_uncore_cpu_init(void)
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
+static struct intel_uncore_type icl_uncore_cbox = {
+	.name		= "cbox",
+	.num_counters   = 4,
+	.perf_ctr_bits	= 44,
+	.perf_ctr	= ICL_UNC_CBO_0_PER_CTR0,
+	.event_ctl	= SNB_UNC_CBO_0_PERFEVTSEL0,
+	.event_mask	= SNB_UNC_RAW_EVENT_MASK,
+	.msr_offset	= ICL_UNC_CBO_MSR_OFFSET,
+	.ops		= &skl_uncore_msr_ops,
+	.format_group	= &snb_uncore_format_group,
+};
+
+static struct uncore_event_desc icl_uncore_events[] = {
+	INTEL_UNCORE_EVENT_DESC(clockticks, "event=0xff"),
+	{ /* end: all zeroes */ },
+};
+
+static struct attribute *icl_uncore_clock_formats_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group icl_uncore_clock_format_group = {
+	.name = "format",
+	.attrs = icl_uncore_clock_formats_attr,
+};
+
+static struct intel_uncore_type icl_uncore_clockbox = {
+	.name		= "clock",
+	.num_counters	= 1,
+	.num_boxes	= 1,
+	.fixed_ctr_bits	= 48,
+	.fixed_ctr	= SNB_UNC_FIXED_CTR,
+	.fixed_ctl	= SNB_UNC_FIXED_CTR_CTRL,
+	.single_fixed	= 1,
+	.event_mask	= SNB_UNC_CTL_EV_SEL_MASK,
+	.format_group	= &icl_uncore_clock_format_group,
+	.ops		= &skl_uncore_msr_ops,
+	.event_descs	= icl_uncore_events,
+};
+
+static struct intel_uncore_type *icl_msr_uncores[] = {
+	&icl_uncore_cbox,
+	&snb_uncore_arb,
+	&icl_uncore_clockbox,
+	NULL,
+};
+
+static int icl_get_cbox_num(void)
+{
+	u64 num_boxes;
+
+	rdmsrl(ICL_UNC_CBO_CONFIG, num_boxes);
+
+	return num_boxes & ICL_UNC_NUM_CBO_MASK;
+}
+
+void icl_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = icl_msr_uncores;
+	icl_uncore_cbox.num_boxes = icl_get_cbox_num();
+	snb_uncore_arb.ops = &skl_uncore_msr_ops;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
@@ -668,6 +740,18 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 	{ /* end: all zeroes */ },
 };
 
+static const struct pci_device_id icl_uncore_pci_ids[] = {
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICL_U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICL_U2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* end: all zeroes */ },
+};
+
 static struct pci_driver snb_uncore_pci_driver = {
 	.name		= "snb_uncore",
 	.id_table	= snb_uncore_pci_ids,
@@ -693,6 +777,11 @@ static struct pci_driver skl_uncore_pci_driver = {
 	.id_table	= skl_uncore_pci_ids,
 };
 
+static struct pci_driver icl_uncore_pci_driver = {
+	.name		= "icl_uncore",
+	.id_table	= icl_uncore_pci_ids,
+};
+
 struct imc_uncore_pci_dev {
 	__u32 pci_id;
 	struct pci_driver *driver;
@@ -732,6 +821,8 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(CFL_4S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Server */
 	IMC_DEV(CFL_6S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Server */
 	IMC_DEV(CFL_8S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Server */
+	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
+	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	{  /* end marker */ }
 };
 
