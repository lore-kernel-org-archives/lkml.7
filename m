Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A11C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC81D2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GxHvjKDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfFQOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:37:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:37:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEaupm3458713
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:36:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEaupm3458713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782217;
        bh=Ozew7VS1S42tDTgT+zBZB9ED0PpWceFMvqJmPvuWAPw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GxHvjKDzcb2QEExXILiilouUbF4b9Lhq0eWmPFkGLZaiwh01+pMMTnIhedS9Q1jaH
         cRhCXZRExYfOfCkcxrLkC8qzO4H6outofEYf/AShXv1MDGpSYKVxAK4Z6KZlxz8N73
         q303AcST3wcl5P2/TIcUVqWlhzL3HqtrLEHYB2hNZmaVVmhJhU7hu1c5Uo0vq2qlV1
         0wcm/7Y3MUfr0otVbekMZU8R/oFxGGu4xArKllGBzb48X7n9+UG6dCwH9dzz+zQ5nO
         cXEUYtZqKp0o37k4ORkiP6VUoqNBscHObIUM0PJ0dFDfkFu2r64+j9djVt6beg8REk
         LylAU8q4gbQyg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEauug3458710;
        Mon, 17 Jun 2019 07:36:56 -0700
Date:   Mon, 17 Jun 2019 07:36:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-210cc5f9db7a5c66b7ca6290b7d35cc7db7e9dbd@git.kernel.org>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: kan.liang@linux.intel.com, peterz@infradead.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <1556672028-119221-3-git-send-email-kan.liang@linux.intel.com>
References: <1556672028-119221-3-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Add uncore support for Snow
 Ridge server
Git-Commit-ID: 210cc5f9db7a5c66b7ca6290b7d35cc7db7e9dbd
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

Commit-ID:  210cc5f9db7a5c66b7ca6290b7d35cc7db7e9dbd
Gitweb:     https://git.kernel.org/tip/210cc5f9db7a5c66b7ca6290b7d35cc7db7e9dbd
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 30 Apr 2019 17:53:44 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:18 +0200

perf/x86/intel/uncore: Add uncore support for Snow Ridge server

The uncore subsystem on Snow Ridge is similar as previous SKX server.
The uncore units on Snow Ridge include Ubox, Chabox, IIO, IRP, M2PCIE,
PCU, M2M, PCIE3 and IMC.

- The config register encoding and pci device IDs are changed.
- For CHA, the umask_ext and filter_tid fields are changed.
- For IIO, the ch_mask and fc_mask fields are changed.
- For M2M, the mask_ext field is changed.
- Add new PCIe3 unit for PCIe3 root port which provides the interface
  between PCIe devices, plugged into the PCIe port, and the components
  (in M2IOSF).
- IMC can only be accessed via MMIO on Snow Ridge now. Current common
  code doesn't support it yet. IMC will be supported in following
  patches.
- There are 9 free running counters for IIO CLOCKS and bandwidth In.
- Full uncore event list is not published yet. Event constrain is not
  included in this patch. It will be added later separately.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: https://lkml.kernel.org/r/1556672028-119221-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c       |   6 +
 arch/x86/events/intel/uncore.h       |   2 +
 arch/x86/events/intel/uncore_snbep.c | 403 +++++++++++++++++++++++++++++++++++
 3 files changed, 411 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d37bb2c657b0..342c323e0f6a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1375,6 +1375,11 @@ static const struct intel_uncore_init_fun icl_uncore_init __initconst = {
 	.pci_init = skl_uncore_pci_init,
 };
 
+static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
+	.cpu_init = snr_uncore_cpu_init,
+	.pci_init = snr_uncore_pci_init,
+};
+
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EP,	  nhm_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM,	  nhm_uncore_init),
@@ -1404,6 +1409,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI, icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_X, snr_uncore_init),
 	{},
 };
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index b3cad2b65766..b444ed35d6f7 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -538,6 +538,8 @@ int knl_uncore_pci_init(void);
 void knl_uncore_cpu_init(void);
 int skx_uncore_pci_init(void);
 void skx_uncore_cpu_init(void);
+int snr_uncore_pci_init(void);
+void snr_uncore_cpu_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index fdb1a57ee1e5..3d8752b37413 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -324,12 +324,64 @@
 #define SKX_M2M_PCI_PMON_CTR0		0x200
 #define SKX_M2M_PCI_PMON_BOX_CTL	0x258
 
+/* SNR Ubox */
+#define SNR_U_MSR_PMON_CTR0			0x1f98
+#define SNR_U_MSR_PMON_CTL0			0x1f91
+#define SNR_U_MSR_PMON_UCLK_FIXED_CTL		0x1f93
+#define SNR_U_MSR_PMON_UCLK_FIXED_CTR		0x1f94
+
+/* SNR CHA */
+#define SNR_CHA_RAW_EVENT_MASK_EXT		0x3ffffff
+#define SNR_CHA_MSR_PMON_CTL0			0x1c01
+#define SNR_CHA_MSR_PMON_CTR0			0x1c08
+#define SNR_CHA_MSR_PMON_BOX_CTL		0x1c00
+#define SNR_C0_MSR_PMON_BOX_FILTER0		0x1c05
+
+
+/* SNR IIO */
+#define SNR_IIO_MSR_PMON_CTL0			0x1e08
+#define SNR_IIO_MSR_PMON_CTR0			0x1e01
+#define SNR_IIO_MSR_PMON_BOX_CTL		0x1e00
+#define SNR_IIO_MSR_OFFSET			0x10
+#define SNR_IIO_PMON_RAW_EVENT_MASK_EXT		0x7ffff
+
+/* SNR IRP */
+#define SNR_IRP0_MSR_PMON_CTL0			0x1ea8
+#define SNR_IRP0_MSR_PMON_CTR0			0x1ea1
+#define SNR_IRP0_MSR_PMON_BOX_CTL		0x1ea0
+#define SNR_IRP_MSR_OFFSET			0x10
+
+/* SNR M2PCIE */
+#define SNR_M2PCIE_MSR_PMON_CTL0		0x1e58
+#define SNR_M2PCIE_MSR_PMON_CTR0		0x1e51
+#define SNR_M2PCIE_MSR_PMON_BOX_CTL		0x1e50
+#define SNR_M2PCIE_MSR_OFFSET			0x10
+
+/* SNR PCU */
+#define SNR_PCU_MSR_PMON_CTL0			0x1ef1
+#define SNR_PCU_MSR_PMON_CTR0			0x1ef8
+#define SNR_PCU_MSR_PMON_BOX_CTL		0x1ef0
+#define SNR_PCU_MSR_PMON_BOX_FILTER		0x1efc
+
+/* SNR M2M */
+#define SNR_M2M_PCI_PMON_CTL0			0x468
+#define SNR_M2M_PCI_PMON_CTR0			0x440
+#define SNR_M2M_PCI_PMON_BOX_CTL		0x438
+#define SNR_M2M_PCI_PMON_UMASK_EXT		0xff
+
+/* SNR PCIE3 */
+#define SNR_PCIE3_PCI_PMON_CTL0			0x508
+#define SNR_PCIE3_PCI_PMON_CTR0			0x4e8
+#define SNR_PCIE3_PCI_PMON_BOX_CTL		0x4e4
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
 DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
 DEFINE_UNCORE_FORMAT_ATTR(use_occ_ctr, use_occ_ctr, "config:7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
@@ -343,11 +395,14 @@ DEFINE_UNCORE_FORMAT_ATTR(occ_invert, occ_invert, "config:30");
 DEFINE_UNCORE_FORMAT_ATTR(occ_edge, occ_edge, "config:14-51");
 DEFINE_UNCORE_FORMAT_ATTR(occ_edge_det, occ_edge_det, "config:31");
 DEFINE_UNCORE_FORMAT_ATTR(ch_mask, ch_mask, "config:36-43");
+DEFINE_UNCORE_FORMAT_ATTR(ch_mask2, ch_mask, "config:36-47");
 DEFINE_UNCORE_FORMAT_ATTR(fc_mask, fc_mask, "config:44-46");
+DEFINE_UNCORE_FORMAT_ATTR(fc_mask2, fc_mask, "config:48-50");
 DEFINE_UNCORE_FORMAT_ATTR(filter_tid, filter_tid, "config1:0-4");
 DEFINE_UNCORE_FORMAT_ATTR(filter_tid2, filter_tid, "config1:0");
 DEFINE_UNCORE_FORMAT_ATTR(filter_tid3, filter_tid, "config1:0-5");
 DEFINE_UNCORE_FORMAT_ATTR(filter_tid4, filter_tid, "config1:0-8");
+DEFINE_UNCORE_FORMAT_ATTR(filter_tid5, filter_tid, "config1:0-9");
 DEFINE_UNCORE_FORMAT_ATTR(filter_cid, filter_cid, "config1:5");
 DEFINE_UNCORE_FORMAT_ATTR(filter_link, filter_link, "config1:5-8");
 DEFINE_UNCORE_FORMAT_ATTR(filter_link2, filter_link, "config1:6-8");
@@ -3968,3 +4023,351 @@ int skx_uncore_pci_init(void)
 }
 
 /* end of SKX uncore support */
+
+/* SNR uncore support */
+
+static struct intel_uncore_type snr_uncore_ubox = {
+	.name			= "ubox",
+	.num_counters		= 2,
+	.num_boxes		= 1,
+	.perf_ctr_bits		= 48,
+	.fixed_ctr_bits		= 48,
+	.perf_ctr		= SNR_U_MSR_PMON_CTR0,
+	.event_ctl		= SNR_U_MSR_PMON_CTL0,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.fixed_ctr		= SNR_U_MSR_PMON_UCLK_FIXED_CTR,
+	.fixed_ctl		= SNR_U_MSR_PMON_UCLK_FIXED_CTL,
+	.ops			= &ivbep_uncore_msr_ops,
+	.format_group		= &ivbep_uncore_format_group,
+};
+
+static struct attribute *snr_uncore_cha_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext2.attr,
+	&format_attr_edge.attr,
+	&format_attr_tid_en.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	&format_attr_filter_tid5.attr,
+	NULL,
+};
+static const struct attribute_group snr_uncore_chabox_format_group = {
+	.name = "format",
+	.attrs = snr_uncore_cha_formats_attr,
+};
+
+static int snr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
+
+	reg1->reg = SNR_C0_MSR_PMON_BOX_FILTER0 +
+		    box->pmu->type->msr_offset * box->pmu->pmu_idx;
+	reg1->config = event->attr.config1 & SKX_CHA_MSR_PMON_BOX_FILTER_TID;
+	reg1->idx = 0;
+
+	return 0;
+}
+
+static void snr_cha_enable_event(struct intel_uncore_box *box,
+				   struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
+
+	if (reg1->idx != EXTRA_REG_NONE)
+		wrmsrl(reg1->reg, reg1->config);
+
+	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
+}
+
+static struct intel_uncore_ops snr_uncore_chabox_ops = {
+	.init_box		= ivbep_uncore_msr_init_box,
+	.disable_box		= snbep_uncore_msr_disable_box,
+	.enable_box		= snbep_uncore_msr_enable_box,
+	.disable_event		= snbep_uncore_msr_disable_event,
+	.enable_event		= snr_cha_enable_event,
+	.read_counter		= uncore_msr_read_counter,
+	.hw_config		= snr_cha_hw_config,
+};
+
+static struct intel_uncore_type snr_uncore_chabox = {
+	.name			= "cha",
+	.num_counters		= 4,
+	.num_boxes		= 6,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= SNR_CHA_MSR_PMON_CTL0,
+	.perf_ctr		= SNR_CHA_MSR_PMON_CTR0,
+	.box_ctl		= SNR_CHA_MSR_PMON_BOX_CTL,
+	.msr_offset		= HSWEP_CBO_MSR_OFFSET,
+	.event_mask		= HSWEP_S_MSR_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SNR_CHA_RAW_EVENT_MASK_EXT,
+	.ops			= &snr_uncore_chabox_ops,
+	.format_group		= &snr_uncore_chabox_format_group,
+};
+
+static struct attribute *snr_uncore_iio_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh9.attr,
+	&format_attr_ch_mask2.attr,
+	&format_attr_fc_mask2.attr,
+	NULL,
+};
+
+static const struct attribute_group snr_uncore_iio_format_group = {
+	.name = "format",
+	.attrs = snr_uncore_iio_formats_attr,
+};
+
+static struct intel_uncore_type snr_uncore_iio = {
+	.name			= "iio",
+	.num_counters		= 4,
+	.num_boxes		= 5,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= SNR_IIO_MSR_PMON_CTL0,
+	.perf_ctr		= SNR_IIO_MSR_PMON_CTR0,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
+	.box_ctl		= SNR_IIO_MSR_PMON_BOX_CTL,
+	.msr_offset		= SNR_IIO_MSR_OFFSET,
+	.ops			= &ivbep_uncore_msr_ops,
+	.format_group		= &snr_uncore_iio_format_group,
+};
+
+static struct intel_uncore_type snr_uncore_irp = {
+	.name			= "irp",
+	.num_counters		= 2,
+	.num_boxes		= 5,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= SNR_IRP0_MSR_PMON_CTL0,
+	.perf_ctr		= SNR_IRP0_MSR_PMON_CTR0,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl		= SNR_IRP0_MSR_PMON_BOX_CTL,
+	.msr_offset		= SNR_IRP_MSR_OFFSET,
+	.ops			= &ivbep_uncore_msr_ops,
+	.format_group		= &ivbep_uncore_format_group,
+};
+
+static struct intel_uncore_type snr_uncore_m2pcie = {
+	.name		= "m2pcie",
+	.num_counters	= 4,
+	.num_boxes	= 5,
+	.perf_ctr_bits	= 48,
+	.event_ctl	= SNR_M2PCIE_MSR_PMON_CTL0,
+	.perf_ctr	= SNR_M2PCIE_MSR_PMON_CTR0,
+	.box_ctl	= SNR_M2PCIE_MSR_PMON_BOX_CTL,
+	.msr_offset	= SNR_M2PCIE_MSR_OFFSET,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.ops		= &ivbep_uncore_msr_ops,
+	.format_group	= &ivbep_uncore_format_group,
+};
+
+static int snr_pcu_hw_config(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
+	int ev_sel = hwc->config & SNBEP_PMON_CTL_EV_SEL_MASK;
+
+	if (ev_sel >= 0xb && ev_sel <= 0xe) {
+		reg1->reg = SNR_PCU_MSR_PMON_BOX_FILTER;
+		reg1->idx = ev_sel - 0xb;
+		reg1->config = event->attr.config1 & (0xff << reg1->idx);
+	}
+	return 0;
+}
+
+static struct intel_uncore_ops snr_uncore_pcu_ops = {
+	IVBEP_UNCORE_MSR_OPS_COMMON_INIT(),
+	.hw_config		= snr_pcu_hw_config,
+	.get_constraint		= snbep_pcu_get_constraint,
+	.put_constraint		= snbep_pcu_put_constraint,
+};
+
+static struct intel_uncore_type snr_uncore_pcu = {
+	.name			= "pcu",
+	.num_counters		= 4,
+	.num_boxes		= 1,
+	.perf_ctr_bits		= 48,
+	.perf_ctr		= SNR_PCU_MSR_PMON_CTR0,
+	.event_ctl		= SNR_PCU_MSR_PMON_CTL0,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl		= SNR_PCU_MSR_PMON_BOX_CTL,
+	.num_shared_regs	= 1,
+	.ops			= &snr_uncore_pcu_ops,
+	.format_group		= &skx_uncore_pcu_format_group,
+};
+
+enum perf_uncore_snr_iio_freerunning_type_id {
+	SNR_IIO_MSR_IOCLK,
+	SNR_IIO_MSR_BW_IN,
+
+	SNR_IIO_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters snr_iio_freerunning[] = {
+	[SNR_IIO_MSR_IOCLK]	= { 0x1eac, 0x1, 0x10, 1, 48 },
+	[SNR_IIO_MSR_BW_IN]	= { 0x1f00, 0x1, 0x10, 8, 48 },
+};
+
+static struct uncore_event_desc snr_uncore_iio_freerunning_events[] = {
+	/* Free-Running IIO CLOCKS Counter */
+	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
+	/* Free-Running IIO BANDWIDTH IN Counters */
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type snr_uncore_iio_free_running = {
+	.name			= "iio_free_running",
+	.num_counters		= 9,
+	.num_boxes		= 5,
+	.num_freerunning_types	= SNR_IIO_FREERUNNING_TYPE_MAX,
+	.freerunning		= snr_iio_freerunning,
+	.ops			= &skx_uncore_iio_freerunning_ops,
+	.event_descs		= snr_uncore_iio_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+static struct intel_uncore_type *snr_msr_uncores[] = {
+	&snr_uncore_ubox,
+	&snr_uncore_chabox,
+	&snr_uncore_iio,
+	&snr_uncore_irp,
+	&snr_uncore_m2pcie,
+	&snr_uncore_pcu,
+	&snr_uncore_iio_free_running,
+	NULL,
+};
+
+void snr_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = snr_msr_uncores;
+}
+
+static void snr_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	int box_ctl = uncore_pci_box_ctl(box);
+
+	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
+	pci_write_config_dword(pdev, box_ctl, IVBEP_PMON_BOX_CTL_INT);
+}
+
+static struct intel_uncore_ops snr_m2m_uncore_pci_ops = {
+	.init_box	= snr_m2m_uncore_pci_init_box,
+	.disable_box	= snbep_uncore_pci_disable_box,
+	.enable_box	= snbep_uncore_pci_enable_box,
+	.disable_event	= snbep_uncore_pci_disable_event,
+	.enable_event	= snbep_uncore_pci_enable_event,
+	.read_counter	= snbep_uncore_pci_read_counter,
+};
+
+static struct attribute *snr_m2m_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext3.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	NULL,
+};
+
+static const struct attribute_group snr_m2m_uncore_format_group = {
+	.name = "format",
+	.attrs = snr_m2m_uncore_formats_attr,
+};
+
+static struct intel_uncore_type snr_uncore_m2m = {
+	.name		= "m2m",
+	.num_counters   = 4,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= SNR_M2M_PCI_PMON_CTR0,
+	.event_ctl	= SNR_M2M_PCI_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext	= SNR_M2M_PCI_PMON_UMASK_EXT,
+	.box_ctl	= SNR_M2M_PCI_PMON_BOX_CTL,
+	.ops		= &snr_m2m_uncore_pci_ops,
+	.format_group	= &snr_m2m_uncore_format_group,
+};
+
+static struct intel_uncore_type snr_uncore_pcie3 = {
+	.name		= "pcie3",
+	.num_counters	= 4,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= SNR_PCIE3_PCI_PMON_CTR0,
+	.event_ctl	= SNR_PCIE3_PCI_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl	= SNR_PCIE3_PCI_PMON_BOX_CTL,
+	.ops		= &ivbep_uncore_pci_ops,
+	.format_group	= &ivbep_uncore_format_group,
+};
+
+enum {
+	SNR_PCI_UNCORE_M2M,
+	SNR_PCI_UNCORE_PCIE3,
+};
+
+static struct intel_uncore_type *snr_pci_uncores[] = {
+	[SNR_PCI_UNCORE_M2M]		= &snr_uncore_m2m,
+	[SNR_PCI_UNCORE_PCIE3]		= &snr_uncore_pcie3,
+	NULL,
+};
+
+static const struct pci_device_id snr_uncore_pci_ids[] = {
+	{ /* M2M */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(12, 0, SNR_PCI_UNCORE_M2M, 0),
+	},
+	{ /* PCIe3 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x334a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(4, 0, SNR_PCI_UNCORE_PCIE3, 0),
+	},
+	{ /* end: all zeroes */ }
+};
+
+static struct pci_driver snr_uncore_pci_driver = {
+	.name		= "snr_uncore",
+	.id_table	= snr_uncore_pci_ids,
+};
+
+int snr_uncore_pci_init(void)
+{
+	/* SNR UBOX DID */
+	int ret = snbep_pci2phy_map_init(0x3460, SKX_CPUNODEID,
+					 SKX_GIDNIDMAP, true);
+
+	if (ret)
+		return ret;
+
+	uncore_pci_uncores = snr_pci_uncores;
+	uncore_pci_driver = &snr_uncore_pci_driver;
+	return 0;
+}
+
+/* end of SNR uncore support */
