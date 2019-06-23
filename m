Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352E1C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFD821738
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfFWN1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33439 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:43 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wz-0001ji-8z; Sun, 23 Jun 2019 15:27:41 +0200
Message-Id: <20190623132434.860549134@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 09/29] x86/hpet: Move static and global variables to one place
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having static and global variables sprinkled all over the code is just
annoying to read. Move them all to the top of the file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   50 +++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -23,6 +23,15 @@
 #undef  pr_fmt
 #define pr_fmt(fmt) "hpet: " fmt
 
+struct hpet_dev {
+	struct clock_event_device	evt;
+	unsigned int			num;
+	int				cpu;
+	unsigned int			irq;
+	unsigned int			flags;
+	char				name[10];
+};
+
 #define HPET_MASK			CLOCKSOURCE_MASK(32)
 
 #define HPET_DEV_USED_BIT		2
@@ -43,18 +52,22 @@ bool					hpet_msi_disable;
 
 #ifdef CONFIG_PCI_MSI
 static unsigned int			hpet_num_timers;
+static struct hpet_dev			*hpet_devs;
+static DEFINE_PER_CPU(struct hpet_dev *, cpu_hpet_dev);
+static struct irq_domain		*hpet_domain;
 #endif
+
 static void __iomem			*hpet_virt_address;
 static u32				*hpet_boot_cfg;
 
-struct hpet_dev {
-	struct clock_event_device	evt;
-	unsigned int			num;
-	int				cpu;
-	unsigned int			irq;
-	unsigned int			flags;
-	char				name[10];
-};
+static bool				hpet_legacy_int_enabled;
+static unsigned long			hpet_freq;
+
+bool					boot_hpet_disable;
+bool					hpet_force_user;
+static bool				hpet_verbose;
+
+static struct clock_event_device	hpet_clockevent;
 
 static inline struct hpet_dev *EVT_TO_HPET_DEV(struct clock_event_device *evtdev)
 {
@@ -85,10 +98,6 @@ static inline void hpet_clear_mapping(vo
 /*
  * HPET command line enable / disable
  */
-bool boot_hpet_disable;
-bool hpet_force_user;
-static bool hpet_verbose;
-
 static int __init hpet_setup(char *str)
 {
 	while (str) {
@@ -120,11 +129,6 @@ static inline int is_hpet_capable(void)
 	return !boot_hpet_disable && hpet_address;
 }
 
-/*
- * HPET timer interrupt enable / disable
- */
-static bool hpet_legacy_int_enabled;
-
 /**
  * is_hpet_enabled - check whether the hpet timer interrupt is enabled
  */
@@ -217,13 +221,7 @@ static void __init hpet_reserve_platform
 static void hpet_reserve_platform_timers(unsigned int id) { }
 #endif
 
-/*
- * Common hpet info
- */
-static unsigned long hpet_freq;
-
-static struct clock_event_device hpet_clockevent;
-
+/* Common hpet functions */
 static void hpet_stop_counter(void)
 {
 	u32 cfg = hpet_readl(HPET_CFG);
@@ -430,10 +428,6 @@ static struct clock_event_device hpet_cl
  */
 #ifdef CONFIG_PCI_MSI
 
-static DEFINE_PER_CPU(struct hpet_dev *, cpu_hpet_dev);
-static struct hpet_dev	*hpet_devs;
-static struct irq_domain *hpet_domain;
-
 void hpet_msi_unmask(struct irq_data *data)
 {
 	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);


