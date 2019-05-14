Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90388C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2A721537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfENOEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:04:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:59052 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfENOC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 07:02:56 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:02:56 -0700
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
Subject: [RFC PATCH v3 03/21] x86/hpet: Calculate ticks-per-second in a separate function
Date:   Tue, 14 May 2019 07:01:56 -0700
Message-Id: <1557842534-4266-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is easier to compute the expiration times of an HPET timer by using
its frequency (i.e., the number of times it ticks in a second) than its
period, as given in the capabilities register.

In addition to the HPET char driver, the HPET-based hardlockup detector
will also need to know the timer's frequency. Thus, create a common
function that both can use.

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
 drivers/char/hpet.c  | 31 ++++++++++++++++++++++++-------
 include/linux/hpet.h |  1 +
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d0ad85900b79..bdcbecfdb858 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -836,6 +836,29 @@ static unsigned long hpet_calibrate(struct hpets *hpetp)
 	return ret;
 }
 
+u64 hpet_get_ticks_per_sec(u64 hpet_caps)
+{
+	u64 ticks_per_sec, period;
+
+	period = (hpet_caps & HPET_COUNTER_CLK_PERIOD_MASK) >>
+		 HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
+
+	/*
+	 * The frequency is the reciprocal of the period. The period is given
+	 * femtoseconds per second. Thus, prepare a dividend to obtain the
+	 * frequency in ticks per second.
+	 */
+
+	/* 10^15 femtoseconds per second */
+	ticks_per_sec = 1000000000000000uLL;
+	ticks_per_sec += period >> 1; /* round */
+
+	/* The quotient is put in the dividend. We drop the remainder. */
+	do_div(ticks_per_sec, period);
+
+	return ticks_per_sec;
+}
+
 int hpet_alloc(struct hpet_data *hdp)
 {
 	u64 cap, mcfg;
@@ -844,7 +867,6 @@ int hpet_alloc(struct hpet_data *hdp)
 	struct hpets *hpetp;
 	struct hpet __iomem *hpet;
 	static struct hpets *last;
-	unsigned long period;
 	unsigned long long temp;
 	u32 remainder;
 
@@ -894,12 +916,7 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	last = hpetp;
 
-	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
-		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
-	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
-	temp += period >> 1; /* round */
-	do_div(temp, period);
-	hpetp->hp_tick_freq = temp; /* ticks per second */
+	hpetp->hp_tick_freq = hpet_get_ticks_per_sec(cap);
 
 	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
 		hpetp->hp_which, hdp->hd_phys_address,
diff --git a/include/linux/hpet.h b/include/linux/hpet.h
index 8604564b985d..e7b36bcf4699 100644
--- a/include/linux/hpet.h
+++ b/include/linux/hpet.h
@@ -107,5 +107,6 @@ static inline void hpet_reserve_timer(struct hpet_data *hd, int timer)
 }
 
 int hpet_alloc(struct hpet_data *);
+u64 hpet_get_ticks_per_sec(u64 hpet_caps);
 
 #endif				/* !__HPET__ */
-- 
2.17.1

