Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996C4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B62621734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDCUHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:07:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:44594 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbfDCUHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:07:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 13:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,306,1549958400"; 
   d="gz'50?scan'50,208,50";a="157976969"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2019 13:06:57 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hBm9x-000I2A-EP; Thu, 04 Apr 2019 04:06:57 +0800
Date:   Thu, 4 Apr 2019 04:06:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [tip:perf/urgent 4/5] arch/x86/events/amd/core.c:538:10: error:
 'NMI_DONE' undeclared; did you mean 'EM_NONE'?
Message-ID: <201904040409.xMIK0wuk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
head:   60f52ab61c7dc0a991125903ae06a35d1812698c
commit: 6d3edaae16c6c7d238360f2841212c2b26774d5e [4/5] x86/perf/amd: Resolve NMI latency issues for active PMCs
config: i386-allnoconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 6d3edaae16c6c7d238360f2841212c2b26774d5e
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/events/amd/core.c: In function 'amd_pmu_handle_irq':
>> arch/x86/events/amd/core.c:538:10: error: 'NMI_DONE' undeclared (first use in this function); did you mean 'EM_NONE'?
      return NMI_DONE;
             ^~~~~~~~
             EM_NONE
   arch/x86/events/amd/core.c:538:10: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/events/amd/core.c:542:9: error: 'NMI_HANDLED' undeclared (first use in this function); did you mean 'IRQ_HANDLED'?
     return NMI_HANDLED;
            ^~~~~~~~~~~
            IRQ_HANDLED
   arch/x86/events/amd/core.c:543:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +538 arch/x86/events/amd/core.c

   493	
   494	/*
   495	 * Because of NMI latency, if multiple PMC counters are active or other sources
   496	 * of NMIs are received, the perf NMI handler can handle one or more overflowed
   497	 * PMC counters outside of the NMI associated with the PMC overflow. If the NMI
   498	 * doesn't arrive at the LAPIC in time to become a pending NMI, then the kernel
   499	 * back-to-back NMI support won't be active. This PMC handler needs to take into
   500	 * account that this can occur, otherwise this could result in unknown NMI
   501	 * messages being issued. Examples of this is PMC overflow while in the NMI
   502	 * handler when multiple PMCs are active or PMC overflow while handling some
   503	 * other source of an NMI.
   504	 *
   505	 * Attempt to mitigate this by using the number of active PMCs to determine
   506	 * whether to return NMI_HANDLED if the perf NMI handler did not handle/reset
   507	 * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of the
   508	 * number of active PMCs or 2. The value of 2 is used in case an NMI does not
   509	 * arrive at the LAPIC in time to be collapsed into an already pending NMI.
   510	 */
   511	static int amd_pmu_handle_irq(struct pt_regs *regs)
   512	{
   513		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
   514		int active, handled;
   515	
   516		/*
   517		 * Obtain the active count before calling x86_pmu_handle_irq() since
   518		 * it is possible that x86_pmu_handle_irq() may make a counter
   519		 * inactive (through x86_pmu_stop).
   520		 */
   521		active = __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
   522	
   523		/* Process any counter overflows */
   524		handled = x86_pmu_handle_irq(regs);
   525	
   526		/*
   527		 * If a counter was handled, record the number of possible remaining
   528		 * NMIs that can occur.
   529		 */
   530		if (handled) {
   531			this_cpu_write(perf_nmi_counter,
   532				       min_t(unsigned int, 2, active));
   533	
   534			return handled;
   535		}
   536	
   537		if (!this_cpu_read(perf_nmi_counter))
 > 538			return NMI_DONE;
   539	
   540		this_cpu_dec(perf_nmi_counter);
   541	
   542		return NMI_HANDLED;
   543	}
   544	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--AqsLC8rIMeq19msA--
