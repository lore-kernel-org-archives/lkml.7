Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D54EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FD320882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDCOsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:48:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:57619 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfDCOsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:48:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 07:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="gz'50?scan'50,208,50";a="158394682"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2019 07:48:37 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hBhBs-000HsS-JK; Wed, 03 Apr 2019 22:48:36 +0800
Date:   Wed, 3 Apr 2019 22:47:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [tip:perf/urgent 4/5] arch/x86//events/amd/core.c:542:9: error:
 'NMI_HANDLED' undeclared; did you mean 'IRQ_HANDLED'?
Message-ID: <201904032235.CIh9J97I%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
head:   60f52ab61c7dc0a991125903ae06a35d1812698c
commit: 6d3edaae16c6c7d238360f2841212c2b26774d5e [4/5] x86/perf/amd: Resolve NMI latency issues for active PMCs
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 6d3edaae16c6c7d238360f2841212c2b26774d5e
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   arch/x86//events/amd/core.c: In function 'amd_pmu_handle_irq':
   arch/x86//events/amd/core.c:538:10: error: 'NMI_DONE' undeclared (first use in this function); did you mean 'EM_NONE'?
      return NMI_DONE;
             ^~~~~~~~
             EM_NONE
   arch/x86//events/amd/core.c:538:10: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86//events/amd/core.c:542:9: error: 'NMI_HANDLED' undeclared (first use in this function); did you mean 'IRQ_HANDLED'?
     return NMI_HANDLED;
            ^~~~~~~~~~~
            IRQ_HANDLED
>> arch/x86//events/amd/core.c:543:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +542 arch/x86//events/amd/core.c

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
 > 542		return NMI_HANDLED;
 > 543	}
   544	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--WIyZ46R2i8wDzkSu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--WIyZ46R2i8wDzkSu--
