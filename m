Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B21C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C77216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfENODZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:03:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:47286 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfENODC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:03:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 07:03:01 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:03:01 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wincy Van <fanwenyi0529@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFC PATCH v3 20/21] iommu/vt-d: hpet: Reserve an interrupt remampping table entry for watchdog
Date:   Tue, 14 May 2019 07:02:13 -0700
Message-Id: <1557842534-4266-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When interrupt remapping is enabled, MSI interrupt messages must follow a
special format that the IOMMU can understand. Hence, when the HPET hard
lockup detector is used with interrupt remapping, it must also follow this
specia format.

The IOMMU, given the information about a particular interrupt, already
knows how to populate the MSI message with this special format and the
corresponding entry in the interrupt remapping table. Given that this is a
special interrupt case, we want to avoid the interrupt subsystem. Add two
functions to create an entry for the HPET hard lockup detector. Perform
this process in two steps as described below.

When initializing the lockup detector, the function
hld_hpet_intremap_alloc_irq() permanently allocates a new entry in the
interrupt remapping table and populates it with the information the
IOMMU driver needs. In order to populate the table, the IOMMU needs to
know the HPET block ID as described in the ACPI table. Hence, add such
ID to the data of the hardlockup detector.

When the hardlockup detector is enabled, the function
hld_hpet_intremapactivate_irq() activates the recently created entry
in the interrupt remapping table via the modify_irte() functions. While
doing this, it specifies which CPU the interrupt must target via its APIC
ID. This function can be called every time the destination iD of the
interrupt needs to be updated; there is no need to allocate or remove
entries in the interrupt remapping table.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wincy Van <fanwenyi0529@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h         | 11 +++++++
 arch/x86/kernel/hpet.c              |  1 +
 drivers/iommu/intel_irq_remapping.c | 49 +++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index a82cbe17479d..811051fa7ade 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -119,6 +119,8 @@ struct hpet_hld_data {
 	u64		tsc_ticks_per_cpu;
 	u32		handling_cpu;
 	u32		enabled_cpus;
+	u8		blockid;
+	void		*intremap_data;
 	struct msi_msg	msi_msg;
 	unsigned long	cpu_monitored_mask[0];
 };
@@ -129,6 +131,15 @@ extern void hardlockup_detector_hpet_stop(void);
 extern void hardlockup_detector_hpet_enable(unsigned int cpu);
 extern void hardlockup_detector_hpet_disable(unsigned int cpu);
 extern void hardlockup_detector_switch_to_perf(void);
+#ifdef CONFIG_IRQ_REMAP
+extern int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata);
+extern int hld_hpet_intremap_alloc_irq(struct hpet_hld_data *hdata);
+#else
+static inline int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata)
+{ return -ENODEV; }
+static inline int hld_hpet_intremap_alloc_irq(struct hpet_hld_data *hdata)
+{ return -ENODEV; }
+#endif /* CONFIG_IRQ_REMAP */
 #else
 static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 { return NULL; }
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 44459b36d333..d911a357e98f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -191,6 +191,7 @@ struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 
 	hdata->num = HPET_WD_TIMER_NR;
 	hdata->ticks_per_second = hpet_get_ticks_per_sec(hpet_readq(HPET_ID));
+	hdata->blockid = hpet_blockid;
 
 	return hdata;
 }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 4ebf3af76589..bfa58ef5e85c 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -20,6 +20,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
 #include <asm/msidef.h>
+#include <asm/hpet.h>
 
 #include "irq_remapping.h"
 
@@ -1517,3 +1518,51 @@ int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 
 	return ret;
 }
+
+#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
+int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata)
+{
+	u32 destid = apic->calc_dest_apicid(hdata->handling_cpu);
+	struct intel_ir_data *data;
+
+	data = (struct intel_ir_data *)hdata->intremap_data;
+	data->irte_entry.dest_id = IRTE_DEST(destid);
+	return modify_irte(&data->irq_2_iommu, &data->irte_entry);
+}
+
+int hld_hpet_intremap_alloc_irq(struct hpet_hld_data *hdata)
+{
+	struct intel_ir_data *data;
+	struct irq_alloc_info info;
+	struct intel_iommu *iommu;
+	struct irq_cfg irq_cfg;
+	int index;
+
+	iommu = map_hpet_to_ir(hdata->blockid);
+	if (!iommu)
+		return -ENODEV;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	down_read(&dmar_global_lock);
+	index =  alloc_irte(iommu, 0, &data->irq_2_iommu, 1);
+	up_read(&dmar_global_lock);
+	if (index < 0)
+		return index;
+
+	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.hpet_id = hdata->blockid;
+
+	/* Vector is not relevant if NMI is the delivery mode */
+	irq_cfg.vector = 0;
+	irq_cfg.delivery_mode = dest_NMI;
+	intel_irq_remapping_prepare_irte(data, &irq_cfg, &info, index, 0);
+
+	hdata->intremap_data = data;
+	memcpy(&hdata->msi_msg, &data->msi_entry, sizeof(hdata->msi_msg));
+
+	return 0;
+}
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_HPET */
-- 
2.17.1

