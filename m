Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAEDC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1728B208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TDEr68RD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfF0XkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:40:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfF0XkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:40:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNdi0p500242
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:39:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNdi0p500242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678785;
        bh=UF/5RgKS3YlCbiA2098FEgjOdoW6PbBFLEYLpeCHZ8w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TDEr68RDQzrCNgybuh6gVGpGIzXGbqrK60JS2NDmp6XRV/yadneXE7g9Sr+xrP16W
         98Vo9sDGoxzKWOWFf+4Y42sVcLtjfIA3YC9/qkTmmjXBnuTuE2jGB+Ne9Gb2CkcT2x
         in7V/W3SAB5laFFe5nZQyv5LizdgxbnHyTMHWu5Ric+UzxgLgNCwViUJV2b6K1+y8r
         dmeAF/MlKM/sB9S4t1kjQV0CplHZQgh2hAt/6e1R9kbCR8F7dvjvb8epW/dq+R1WlC
         5Dl9Ch54ZSvXAKgDgQPNCw/Yh9PvXAJ5rTdvQvsKzrV2db/ZXV7n38gcsR07bBaCBT
         3MJZ0W5WU0oqA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNdhWD500237;
        Thu, 27 Jun 2019 16:39:43 -0700
Date:   Thu, 27 Jun 2019 16:39:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-8c273f2c81f0756f65b24771196c0eff7ac90e7b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Suravee.Suthikulpanit@amd.com,
        ricardo.neri-calderon@linux.intel.com, ashok.raj@intel.com,
        andi.kleen@intel.com, peterz@infradead.org,
        ravi.v.shankar@intel.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, eranian@google.com
Reply-To: peterz@infradead.org, ashok.raj@intel.com,
          ricardo.neri-calderon@linux.intel.com, andi.kleen@intel.com,
          Suravee.Suthikulpanit@amd.com, linux-kernel@vger.kernel.org,
          eranian@google.com, hpa@zytor.com, ravi.v.shankar@intel.com,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190623132434.860549134@linutronix.de>
References: <20190623132434.860549134@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Move static and global variables to one
 place
Git-Commit-ID: 8c273f2c81f0756f65b24771196c0eff7ac90e7b
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

Commit-ID:  8c273f2c81f0756f65b24771196c0eff7ac90e7b
Gitweb:     https://git.kernel.org/tip/8c273f2c81f0756f65b24771196c0eff7ac90e7b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:17 +0200

x86/hpet: Move static and global variables to one place

Having static and global variables sprinkled all over the code is just
annoying to read. Move them all to the top of the file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.860549134@linutronix.de

---
 arch/x86/kernel/hpet.c | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index cb120e412dc6..d6bd0ed6885b 100644
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
@@ -85,10 +98,6 @@ static inline void hpet_clear_mapping(void)
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
@@ -217,13 +221,7 @@ static void __init hpet_reserve_platform_timers(unsigned int id)
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
@@ -430,10 +428,6 @@ static struct clock_event_device hpet_clockevent = {
  */
 #ifdef CONFIG_PCI_MSI
 
-static DEFINE_PER_CPU(struct hpet_dev *, cpu_hpet_dev);
-static struct hpet_dev	*hpet_devs;
-static struct irq_domain *hpet_domain;
-
 void hpet_msi_unmask(struct irq_data *data)
 {
 	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
