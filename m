Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A9C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7E320833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X2+iTtmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfFQOj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:39:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41585 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfFQOj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:39:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEdlsl3459401
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:39:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEdlsl3459401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782388;
        bh=hpGgpaWcxu3cD9koR2Mn3khQT0Fk97acs5UYWTjtlQ4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=X2+iTtmcCprIB7RC4BOhjIUEG77vIlBImO9JjKpPDq0NOK704HeAfjkpcC7UcQA3h
         /XdD4Etc+SMGWWXaymzAcHIewbUTKFHNn1b/lekrswku4xkOGlhNoePotGFe6Hlfui
         5IWKcriDdyq1VH7AwXDN/oJ+lE2yqTj7531YgPvShxRRPWbv+L+PtHhZrNqZ5BrFq4
         gS0mhjqo3PgvaNRmEWem+C7YDn5XPe/ckskbUJg8zFmKv5B0YFrR6Nbwt44Fc7a6CJ
         68AJXnm7XbwEM+ZzVZjZQWwVahCX4n8PE6e19STvZqsRfsd8gj8an63kX/87uZ1zYl
         OflRHmE0frp9Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEdlfK3459398;
        Mon, 17 Jun 2019 07:39:47 -0700
Date:   Mon, 17 Jun 2019 07:39:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-ee49532b38dd084650bf715eabe7e3828fb8d275@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kan.liang@linux.intel.com, hpa@zytor.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          hpa@zytor.com, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <1556672028-119221-7-git-send-email-kan.liang@linux.intel.com>
References: <1556672028-119221-7-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Add IMC uncore support for
 Snow Ridge
Git-Commit-ID: ee49532b38dd084650bf715eabe7e3828fb8d275
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

Commit-ID:  ee49532b38dd084650bf715eabe7e3828fb8d275
Gitweb:     https://git.kernel.org/tip/ee49532b38dd084650bf715eabe7e3828fb8d275
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 30 Apr 2019 17:53:48 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:22 +0200

perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge

IMC uncore unit can only be accessed via MMIO on Snow Ridge.
The MMIO space of IMC uncore is at the specified offsets from the
MEM0_BAR. Add snr_uncore_get_mc_dev() to locate the PCI device with
MMIO_BASE and MEM0_BAR register.

Add new ops to access the IMC registers via MMIO.

Add 3 new free running counters for clocks, read and write bandwidth.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: https://lkml.kernel.org/r/1556672028-119221-7-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c       |   3 +-
 arch/x86/events/intel/uncore.h       |   2 +
 arch/x86/events/intel/uncore_snbep.c | 197 +++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 8bb537143d86..3694a5d0703d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -29,7 +29,7 @@ struct event_constraint uncore_constraint_empty =
 
 MODULE_LICENSE("GPL");
 
-static int uncore_pcibus_to_physid(struct pci_bus *bus)
+int uncore_pcibus_to_physid(struct pci_bus *bus)
 {
 	struct pci2phy_map *map;
 	int phys_id = -1;
@@ -1441,6 +1441,7 @@ static const struct intel_uncore_init_fun icl_uncore_init __initconst = {
 static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 	.cpu_init = snr_uncore_cpu_init,
 	.pci_init = snr_uncore_pci_init,
+	.mmio_init = snr_uncore_mmio_init,
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index cdd9691365a1..f36f7bebbc1b 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -163,6 +163,7 @@ struct pci2phy_map {
 };
 
 struct pci2phy_map *__find_pci2phy_map(int segment);
+int uncore_pcibus_to_physid(struct pci_bus *bus);
 
 ssize_t uncore_event_show(struct kobject *kobj,
 			  struct kobj_attribute *attr, char *buf);
@@ -555,6 +556,7 @@ int skx_uncore_pci_init(void);
 void skx_uncore_cpu_init(void);
 int snr_uncore_pci_init(void);
 void snr_uncore_cpu_init(void);
+void snr_uncore_mmio_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3d8752b37413..b10a5ec79e48 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -374,6 +374,19 @@
 #define SNR_PCIE3_PCI_PMON_CTR0			0x4e8
 #define SNR_PCIE3_PCI_PMON_BOX_CTL		0x4e4
 
+/* SNR IMC */
+#define SNR_IMC_MMIO_PMON_FIXED_CTL		0x54
+#define SNR_IMC_MMIO_PMON_FIXED_CTR		0x38
+#define SNR_IMC_MMIO_PMON_CTL0			0x40
+#define SNR_IMC_MMIO_PMON_CTR0			0x8
+#define SNR_IMC_MMIO_PMON_BOX_CTL		0x22800
+#define SNR_IMC_MMIO_OFFSET			0x4000
+#define SNR_IMC_MMIO_SIZE			0x4000
+#define SNR_IMC_MMIO_BASE_OFFSET		0xd0
+#define SNR_IMC_MMIO_BASE_MASK			0x1FFFFFFF
+#define SNR_IMC_MMIO_MEM0_OFFSET		0xd8
+#define SNR_IMC_MMIO_MEM0_MASK			0x7FF
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
 DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
@@ -4370,4 +4383,188 @@ int snr_uncore_pci_init(void)
 	return 0;
 }
 
+static struct pci_dev *snr_uncore_get_mc_dev(int id)
+{
+	struct pci_dev *mc_dev = NULL;
+	int phys_id, pkg;
+
+	while (1) {
+		mc_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3451, mc_dev);
+		if (!mc_dev)
+			break;
+		phys_id = uncore_pcibus_to_physid(mc_dev->bus);
+		if (phys_id < 0)
+			continue;
+		pkg = topology_phys_to_logical_pkg(phys_id);
+		if (pkg < 0)
+			continue;
+		else if (pkg == id)
+			break;
+	}
+	return mc_dev;
+}
+
+static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = snr_uncore_get_mc_dev(box->dieid);
+	unsigned int box_ctl = uncore_mmio_box_ctl(box);
+	resource_size_t addr;
+	u32 pci_dword;
+
+	if (!pdev)
+		return;
+
+	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
+	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
+
+	pci_read_config_dword(pdev, SNR_IMC_MMIO_MEM0_OFFSET, &pci_dword);
+	addr |= (pci_dword & SNR_IMC_MMIO_MEM0_MASK) << 12;
+
+	addr += box_ctl;
+
+	box->io_addr = ioremap(addr, SNR_IMC_MMIO_SIZE);
+	if (!box->io_addr)
+		return;
+
+	writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
+}
+
+static void snr_uncore_mmio_disable_box(struct intel_uncore_box *box)
+{
+	u32 config;
+
+	if (!box->io_addr)
+		return;
+
+	config = readl(box->io_addr);
+	config |= SNBEP_PMON_BOX_CTL_FRZ;
+	writel(config, box->io_addr);
+}
+
+static void snr_uncore_mmio_enable_box(struct intel_uncore_box *box)
+{
+	u32 config;
+
+	if (!box->io_addr)
+		return;
+
+	config = readl(box->io_addr);
+	config &= ~SNBEP_PMON_BOX_CTL_FRZ;
+	writel(config, box->io_addr);
+}
+
+static void snr_uncore_mmio_enable_event(struct intel_uncore_box *box,
+					   struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	writel(hwc->config | SNBEP_PMON_CTL_EN,
+	       box->io_addr + hwc->config_base);
+}
+
+static void snr_uncore_mmio_disable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	writel(hwc->config, box->io_addr + hwc->config_base);
+}
+
+static struct intel_uncore_ops snr_uncore_mmio_ops = {
+	.init_box	= snr_uncore_mmio_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.disable_box	= snr_uncore_mmio_disable_box,
+	.enable_box	= snr_uncore_mmio_enable_box,
+	.disable_event	= snr_uncore_mmio_disable_event,
+	.enable_event	= snr_uncore_mmio_enable_event,
+	.read_counter	= uncore_mmio_read_counter,
+};
+
+static struct uncore_event_desc snr_uncore_imc_events[] = {
+	INTEL_UNCORE_EVENT_DESC(clockticks,      "event=0x00,umask=0x00"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read,  "event=0x04,umask=0x0f"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write, "event=0x04,umask=0x30"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write.unit, "MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type snr_uncore_imc = {
+	.name		= "imc",
+	.num_counters   = 4,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 48,
+	.fixed_ctr_bits	= 48,
+	.fixed_ctr	= SNR_IMC_MMIO_PMON_FIXED_CTR,
+	.fixed_ctl	= SNR_IMC_MMIO_PMON_FIXED_CTL,
+	.event_descs	= snr_uncore_imc_events,
+	.perf_ctr	= SNR_IMC_MMIO_PMON_CTR0,
+	.event_ctl	= SNR_IMC_MMIO_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl	= SNR_IMC_MMIO_PMON_BOX_CTL,
+	.mmio_offset	= SNR_IMC_MMIO_OFFSET,
+	.ops		= &snr_uncore_mmio_ops,
+	.format_group	= &skx_uncore_format_group,
+};
+
+enum perf_uncore_snr_imc_freerunning_type_id {
+	SNR_IMC_DCLK,
+	SNR_IMC_DDR,
+
+	SNR_IMC_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters snr_imc_freerunning[] = {
+	[SNR_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
+	[SNR_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
+};
+
+static struct uncore_event_desc snr_uncore_imc_freerunning_events[] = {
+	INTEL_UNCORE_EVENT_DESC(dclk,		"event=0xff,umask=0x10"),
+
+	INTEL_UNCORE_EVENT_DESC(read,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(read.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(read.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(write,		"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(write.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
+};
+
+static struct intel_uncore_ops snr_uncore_imc_freerunning_ops = {
+	.init_box	= snr_uncore_mmio_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.read_counter	= uncore_mmio_read_counter,
+	.hw_config	= uncore_freerunning_hw_config,
+};
+
+static struct intel_uncore_type snr_uncore_imc_free_running = {
+	.name			= "imc_free_running",
+	.num_counters		= 3,
+	.num_boxes		= 1,
+	.num_freerunning_types	= SNR_IMC_FREERUNNING_TYPE_MAX,
+	.freerunning		= snr_imc_freerunning,
+	.ops			= &snr_uncore_imc_freerunning_ops,
+	.event_descs		= snr_uncore_imc_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+static struct intel_uncore_type *snr_mmio_uncores[] = {
+	&snr_uncore_imc,
+	&snr_uncore_imc_free_running,
+	NULL,
+};
+
+void snr_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = snr_mmio_uncores;
+}
+
 /* end of SNR uncore support */
