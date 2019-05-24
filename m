Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55943C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04824217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbfEXBQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:16:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:14788 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388730AbfEXBQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:16:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 18:16:38 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:38 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
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
        Jan Kiszka <jan.kiszka@siemens.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH v4 18/21] x86/apic: Add a parameter for the APIC delivery mode
Date:   Thu, 23 May 2019 18:16:20 -0700
Message-Id: <1558660583-28561-19-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the delivery mode of APIC interrupts is set to the default
mode set in the APIC driver. However, there are no restrictions in hardware
to configure each interrupt with a different delivery mode. Specifying the
delivery mode per interrupt is useful when one is interested in changing
the delivery mode of a particular interrupt. For instance, this can be used
to deliver an interrupt as non-maskable.

Add a new member, delivery_mode, to struct irq_cfg. This new member, can
be used to update the configuration of the delivery mode in each interrupt
domain. Likewise, add equivalent macros to populate MSI messages.

Currently, all interrupt domains set the delivery mode of interrupts using
the APIC setting. Interrupt domains use an irq_cfg data structure to
configure their own data structures and hardware resources. Thus, in order
to keep the current behavior, set the delivery mode of the irq
configuration that as the APIC setting. In this manner, irq domains can
obtain the delivery mode from the irq configuration data instead of the
APIC setting, if needed.

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
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hw_irq.h |  5 +++--
 arch/x86/include/asm/msidef.h |  3 +++
 arch/x86/kernel/apic/vector.c | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 32e666e1231e..c024e5976b78 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -117,8 +117,9 @@ struct irq_alloc_info {
 };
 
 struct irq_cfg {
-	unsigned int		dest_apicid;
-	unsigned int		vector;
+	unsigned int				dest_apicid;
+	unsigned int				vector;
+	enum ioapic_irq_destination_types	delivery_mode;
 };
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
diff --git a/arch/x86/include/asm/msidef.h b/arch/x86/include/asm/msidef.h
index 38ccfdc2d96e..6d666c90f057 100644
--- a/arch/x86/include/asm/msidef.h
+++ b/arch/x86/include/asm/msidef.h
@@ -16,6 +16,9 @@
 					 MSI_DATA_VECTOR_MASK)
 
 #define MSI_DATA_DELIVERY_MODE_SHIFT	8
+#define MSI_DATA_DELIVERY_MODE_MASK	0x00000700
+#define MSI_DATA_DELIVERY_MODE(dm)	(((dm) << MSI_DATA_DELIVERY_MODE_SHIFT) & \
+					 MSI_DATA_DELIVERY_MODE_MASK)
 #define  MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_MODE_SHIFT)
 #define  MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_MODE_SHIFT)
 #define  MSI_DATA_DELIVERY_NMI		(4 << MSI_DATA_DELIVERY_MODE_SHIFT)
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3173e07d3791..99436fe7e932 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -548,6 +548,16 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irqd->chip_data = apicd;
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
+
+		/*
+		 * Initialize the delivery mode of this irq to match the
+		 * default delivery mode of the APIC. This is useful for
+		 * children irq domains which want to take the delivery
+		 * mode from the individual irq configuration rather
+		 * than from the APIC.
+		 */
+		 apicd->hw_irq_cfg.delivery_mode = apic->irq_delivery_mode;
+
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
-- 
2.17.1

