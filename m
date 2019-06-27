Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F1C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E27B2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF0Sn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:43:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:56448 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0Sny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:43:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 11:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="313893973"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga004.jf.intel.com with ESMTP; 27 Jun 2019 11:43:53 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Alan Cox <alan.cox@intel.com>, Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordan Borgner <mail@jordan-borgner.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Mohammad Etemadi <mohammad.etemadi@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Feiner <pfeiner@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/2] x86, mtrr: generic: Skip cache flushes on CPUs with cache self-snooping
Date:   Thu, 27 Jun 2019 11:43:17 -0700
Message-Id: <1561660997-21562-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561660997-21562-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1561660997-21562-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Programming MTRR registers in multi-processor systems is a rather lengthy
process. Furthermore, all processors must program these registers in lock
step and with interrupts disabled; the process also involves flushing
caches and TLBs twice. As a result, the process may take a considerable
amount of time.

In some platforms, this can lead to a large skew of the refined-jiffies
clock source. Early when booting, if no other clock is available (e.g.,
booting with hpet=disabled), the refined-jiffies clock source is used to
monitor the TSC clock source. If the skew of refined-jiffies is too large,
Linux wrongly assumes that the TSC is unstable:

  clocksource: timekeeping watchdog on CPU1: Marking clocksource
               'tsc-early' as unstable because the skew is too large:
  clocksource: 'refined-jiffies' wd_now: fffedc10 wd_last:
               fffedb90 mask: ffffffff
  clocksource: 'tsc-early' cs_now: 5eccfddebc cs_last: 5e7e3303d4
               mask: ffffffffffffffff
  tsc: Marking TSC unstable due to clocksource watchdog

As per my measurements, around 98% of the time needed by the procedure to
program MTRRs in multi-processor systems is spent flushing caches with
wbinvd(). As per the Section 11.11.8 of the Intel 64 and IA 32
Architectures Software Developer's Manual, it is not necessary to flush
caches if the CPU supports cache self-snooping. Thus, skipping the cache
flushes can reduce by several tens of milliseconds the time needed to
complete the programming of the MTRR registers.

Cc: Alan Cox <alan.cox@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Reported-by: Mohammad Etemadi <mohammad.etemadi@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 9356c1c9024d..169672a6935c 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -743,7 +743,9 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | X86_CR0_CD;
 	write_cr0(cr0);
-	wbinvd();
+
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
 
 	/* Save value of CR4 and clear Page Global Enable (bit 7) */
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
@@ -760,7 +762,9 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 
 	/* Disable MTRRs, and set the default type to uncached */
 	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
-	wbinvd();
+
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
 }
 
 static void post_set(void) __releases(set_atomicity_lock)
-- 
2.17.1

