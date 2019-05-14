Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0CCC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0AC21537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfENOEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:04:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:47286 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfENOC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 07:02:57 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:02:57 -0700
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
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFC PATCH v3 06/21] x86/hpet: Configure the timer used by the hardlockup detector
Date:   Tue, 14 May 2019 07:01:59 -0700
Message-Id: <1557842534-4266-7-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the initial configuration of the timer to be used by the
hardlockup detector. Return a data structure with a description of the
timer; this information is subsequently used by the hardlockup detector.

Only provide the timer if it supports Front Side Bus interrupt delivery.
This condition greatly simplifies the implementation of the detector.
Specifically, it helps to avoid the complexities of routing the interrupt
via the IO-APIC (e.g., potential race conditions that arise from re-
programming the IO-APIC in NMI context).

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h | 13 +++++++++++++
 arch/x86/kernel/hpet.c      | 25 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 6f099e2781ce..20abdaa5372d 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -109,6 +109,19 @@ extern void hpet_set_comparator(int num, unsigned int cmp, unsigned int period);
 
 #endif /* CONFIG_HPET_EMULATE_RTC */
 
+#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
+struct hpet_hld_data {
+	bool		has_periodic;
+	u32		num;
+	u64		ticks_per_second;
+};
+
+extern struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void);
+#else
+static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
+{ return NULL; }
+#endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
+
 #else /* CONFIG_HPET_TIMER */
 
 static inline int hpet_enable(void) { return 0; }
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index ba0a5cc075d5..20a16a304f89 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -170,6 +170,31 @@ do {								\
 		_hpet_print_config(__func__, __LINE__);	\
 } while (0)
 
+#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
+struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
+{
+	struct hpet_hld_data *hdata;
+	unsigned int cfg;
+
+	cfg = hpet_readl(HPET_Tn_CFG(HPET_WD_TIMER_NR));
+
+	if (!(cfg & HPET_TN_FSB_CAP))
+		return NULL;
+
+	hdata = kzalloc(sizeof(*hdata), GFP_KERNEL);
+	if (!hdata)
+		return NULL;
+
+	if (cfg & HPET_TN_PERIODIC_CAP)
+		hdata->has_periodic = true;
+
+	hdata->num = HPET_WD_TIMER_NR;
+	hdata->ticks_per_second = hpet_get_ticks_per_sec(hpet_readq(HPET_ID));
+
+	return hdata;
+}
+#endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
+
 /*
  * When the hpet driver (/dev/hpet) is enabled, we need to reserve
  * timer 0 and timer 1 in case of RTC emulation. Timer 2 is reserved in case
-- 
2.17.1

