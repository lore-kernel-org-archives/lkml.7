Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE32FC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9600F2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF0Snx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:43:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:56448 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0Snx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:43:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 11:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="313893963"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga004.jf.intel.com with ESMTP; 27 Jun 2019 11:43:51 -0700
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/2] Speed MTRR programming up when we can
Date:   Thu, 27 Jun 2019 11:43:15 -0700
Message-Id: <1561660997-21562-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
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

By measuring the execution time of mtrr_aps_init() (from which MTRRs
in all CPUs are programmed in lock-step at boot), I find savings in the
time required to program MTRRs as follows:

Platform                      time-with-wbinvd(ms) time-no-wbinvd(ms)
104-core (208 LP) Skylake            1437                 28
2-core (4 LP) Haswell                 114                  2

However, there exist CPU models with errata that affect their self-
snooping capability. Such errata may cause unpredictable behavior, machine
check errors, or hangs. For instance:

     "Where two different logical processors have the same code page
      mapped with two different memory types Specifically if one code
      page is mapped by one logical processor as write back and by
      another as uncacheable and certain instruction timing conditions
      occur the system may experience unpredictable behaviour." [1].

Similar errata are reported in other processors as well [2], [3], [4],
[5], and [6].

Thus, in order to confidently leverage self-snooping for the MTRR
programming algorithm, we must first clear such feature in models with
known errata.


Thanks and BR,
Ricardo

LP = Logical Processor

[1]. Erratum BF52, 
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-3600-specification-update.pdf
[2]. Erratum BK47, 
https://www.mouser.com/pdfdocs/2ndgencorefamilymobilespecificationupdate.pdf
[3]. Erratum AAO54, 
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-c5500-c3500-spec-update.pdf
[4]. Errata AZ39, AZ42, 
https://www.intel.com/content/dam/support/us/en/documents/processors/mobile/celeron/sb/320121.pdf
[5]. Errata AQ51, AQ102, AQ104, 
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-dual-core-desktop-e2000-specification-update.pdf
[6]. Errata AN107, AN109, 
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-dual-core-specification-update.pdf

Ricardo Neri (2):
  x86/cpu/intel: Clear cache self-snoop capability in CPUs with known
    errata
  x86, mtrr: generic: Skip cache flushes on CPUs with cache
    self-snooping

 arch/x86/kernel/cpu/intel.c        | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mtrr/generic.c |  8 ++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.17.1

