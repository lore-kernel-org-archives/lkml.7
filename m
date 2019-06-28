Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A10C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28F72133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MPhEKGGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfF1F0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:26:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1F0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:26:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5S5PpvU616477
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 22:25:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5S5PpvU616477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561699552;
        bh=ihiGMznRlJDv+YxFw8hvsSg0MaU7hm7pTLX7pqsUP0g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MPhEKGGupQsexuJziiFGwSZ/N/kRCHZG7O3QUzR2JiestoHPBCs5hqPHl3tGYxwVN
         4ECyU3YX8CP0E4dGoS0FJ2+wXS9dTjnsjmK042dpnV4Z1mWdW5jmNgFEapJMDd657n
         ZSHQw4XE0h+fPyS0rXN17nniYNiKrcoFb8kJLI2UhFztNuLBK6fjqaZzjTl0kqZ/zT
         grhL4pn3zFjzOvNikBtnrW1yAjoncA+Prd2v/ER+N6CNQXnZ5DzB5vnA9GtQXYGJ1x
         tFiL15Id8rQU173pEXJkUzsWXVRGHPsV6rsHKjYZMm0rppXy1r99Jl7dm4th2gBP1e
         52NTPTI8uDDoQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5S5Po19616474;
        Thu, 27 Jun 2019 22:25:50 -0700
Date:   Thu, 27 Jun 2019 22:25:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ricardo Neri <tipbot@zytor.com>
Message-ID: <tip-fd329f276ecaad7a371d6f91b9bbea031d0c3440@git.kernel.org>
Cc:     ravi.v.shankar@intel.com, mail@jordan-borgner.de,
        alan.cox@intel.com, linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mingo@kernel.org,
        gregkh@linuxfoundation.org, andi.kleen@intel.com,
        hdegoede@redhat.com, pfeiner@google.com, hpa@zytor.com,
        ak@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        andriy.shevchenko@intel.com, ricardo.neri@intel.com,
        tony.luck@intel.com, mohammad.etemadi@intel.com,
        rafael.j.wysocki@intel.com
Reply-To: ravi.v.shankar@intel.com, mail@jordan-borgner.de,
          alan.cox@intel.com, mingo@kernel.org,
          andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
          ricardo.neri-calderon@linux.intel.com, hdegoede@redhat.com,
          andi.kleen@intel.com, gregkh@linuxfoundation.org,
          tglx@linutronix.de, hpa@zytor.com, ak@linux.intel.com,
          pfeiner@google.com, bp@suse.de, ricardo.neri@intel.com,
          andriy.shevchenko@intel.com, mohammad.etemadi@intel.com,
          rafael.j.wysocki@intel.com, tony.luck@intel.com
In-Reply-To: <1561689337-19390-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1561689337-19390-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/mtrr: Skip cache flushes on CPUs with cache
 self-snooping
Git-Commit-ID: fd329f276ecaad7a371d6f91b9bbea031d0c3440
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

Commit-ID:  fd329f276ecaad7a371d6f91b9bbea031d0c3440
Gitweb:     https://git.kernel.org/tip/fd329f276ecaad7a371d6f91b9bbea031d0c3440
Author:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate: Thu, 27 Jun 2019 19:35:37 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 07:21:00 +0200

x86/mtrr: Skip cache flushes on CPUs with cache self-snooping

Programming MTRR registers in multi-processor systems is a rather lengthy
process. Furthermore, all processors must program these registers in lock
step and with interrupts disabled; the process also involves flushing
caches and TLBs twice. As a result, the process may take a considerable
amount of time.

On some platforms, this can lead to a large skew of the refined-jiffies
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

As per measurements, around 98% of the time needed by the procedure to
program MTRRs in multi-processor systems is spent flushing caches with
wbinvd(). As per the Section 11.11.8 of the Intel 64 and IA 32
Architectures Software Developer's Manual, it is not necessary to flush
caches if the CPU supports cache self-snooping. Thus, skipping the cache
flushes can reduce by several tens of milliseconds the time needed to
complete the programming of the MTRR registers:

Platform                      	Before	   After
104-core (208 Threads) Skylake  1437ms      28ms
  2-core (  4 Threads) Haswell   114ms       2ms

Reported-by: Mohammad Etemadi <mohammad.etemadi@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Alan Cox <alan.cox@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/1561689337-19390-3-git-send-email-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 9356c1c9024d..aa5c064a6a22 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -743,7 +743,15 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | X86_CR0_CD;
 	write_cr0(cr0);
-	wbinvd();
+
+	/*
+	 * Cache flushing is the most time-consuming step when programming
+	 * the MTRRs. Fortunately, as per the Intel Software Development
+	 * Manual, we can skip it if the processor supports cache self-
+	 * snooping.
+	 */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
 
 	/* Save value of CR4 and clear Page Global Enable (bit 7) */
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
@@ -760,7 +768,10 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 
 	/* Disable MTRRs, and set the default type to uncached */
 	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
-	wbinvd();
+
+	/* Again, only flush caches if we have to. */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
 }
 
 static void post_set(void) __releases(set_atomicity_lock)
