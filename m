Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E8EC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FE7217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbfEXBRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:17:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:14788 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388768AbfEXBQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:16:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 18:16:39 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:39 -0700
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
Subject: [RFC PATCH v4 21/21] x86/watchdog/hardlockup/hpet: Support interrupt remapping
Date:   Thu, 23 May 2019 18:16:23 -0700
Message-Id: <1558660583-28561-22-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When interrupt remapping is enabled in the system, the MSI interrupt
message must follow a special format the IOMMU can understand. Hence,
utilize the functionality provided by the IOMMU driver for such purpose.

The first step is to determine whether interrupt remapping is enabled
by looking for the existence of an interrupt remapping domain. If it
exists, let the IOMMU driver compose the MSI message for us. The hard-
lockup detector is still responsible of writing the message in the
HPET FSB route register.

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
 arch/x86/kernel/watchdog_hld_hpet.c | 33 ++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 76eed714a1cb..a266439fdb9e 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -20,6 +20,7 @@
 #include <linux/hpet.h>
 #include <linux/slab.h>
 #include <asm/msidef.h>
+#include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 
 static struct hpet_hld_data *hld_data;
@@ -117,6 +118,25 @@ static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
 	return false;
 }
 
+/** irq_remapping_enabled() - Detect if interrupt remapping is enabled
+ * @hdata:	A data structure with the HPET block id
+ *
+ * Determine if the HPET block that the hardlockup detector is under
+ * the remapped interrupt domain.
+ *
+ * Returns: True interrupt remapping is enabled. False otherwise.
+ */
+static bool irq_remapping_enabled(struct hpet_hld_data *hdata)
+{
+	struct irq_alloc_info info;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.hpet_id = hdata->blockid;
+
+	return !!irq_remapping_get_ir_irq_domain(&info);
+}
+
 /**
  * compose_msi_msg() - Populate address and data fields of an MSI message
  * @hdata:	A data strucure with the message to populate
@@ -161,6 +181,9 @@ static int update_msi_destid(struct hpet_hld_data *hdata)
 {
 	u32 destid;
 
+	if (irq_remapping_enabled(hdata))
+		return hld_hpet_intremap_activate_irq(hdata);
+
 	hdata->msi_msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
 	destid = apic->calc_dest_apicid(hdata->handling_cpu);
 	hdata->msi_msg.address_lo |= MSI_ADDR_DEST_ID(destid);
@@ -217,9 +240,17 @@ static int hardlockup_detector_nmi_handler(unsigned int type,
  */
 static int setup_irq_msi_mode(struct hpet_hld_data *hdata)
 {
+	s32 ret;
 	u32 v;
 
-	compose_msi_msg(hdata);
+	if (irq_remapping_enabled(hdata)) {
+		ret = hld_hpet_intremap_alloc_irq(hdata);
+		if (ret)
+			return ret;
+	} else {
+		compose_msi_msg(hdata);
+	}
+
 	hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->num));
 	hpet_writel(hdata->msi_msg.address_lo, HPET_Tn_ROUTE(hdata->num) + 4);
 
-- 
2.17.1

