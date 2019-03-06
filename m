Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F4AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC41E2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfCFLnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:43:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:55254 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfCFLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:43:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 03:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,447,1544515200"; 
   d="gz'50?scan'50,208,50";a="324710146"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Mar 2019 03:43:27 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h1UxK-0004Hv-Nn; Wed, 06 Mar 2019 19:43:26 +0800
Date:   Wed, 6 Mar 2019 19:42:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:x86/asm 2/4] arch/x86/include/asm/special_insns.h:31:9: error:
 'X86_CR0_WP' undeclared
Message-ID: <201903061919.b2BJj7iX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
head:   a0bf7fc24303a538396aa8d32450d05c1929b9f0
commit: d309ba034fac1a149d00cac79318973e9ba81848 [2/4] x86/asm: Pin sensitive CR0 bits
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-8 (Debian 8.3.0-2) 8.3.0
reproduce:
        git checkout d309ba034fac1a149d00cac79318973e9ba81848
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/cacheflush.h:7,
                    from include/linux/highmem.h:12,
                    from net//core/sock.c:117:
   arch/x86/include/asm/special_insns.h: In function 'native_write_cr0':
>> arch/x86/include/asm/special_insns.h:31:9: error: 'X86_CR0_WP' undeclared (first use in this function)
     val |= X86_CR0_WP;
            ^~~~~~~~~~
   arch/x86/include/asm/special_insns.h:31:9: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from arch/x86/include/asm/cacheflush.h:7,
                    from include/linux/highmem.h:12,
                    from net//ipv4/ip_output.c:52:
   arch/x86/include/asm/special_insns.h: In function 'native_write_cr0':
>> arch/x86/include/asm/special_insns.h:31:9: error: 'X86_CR0_WP' undeclared (first use in this function); did you mean 'X86_BUG_11AP'?
     val |= X86_CR0_WP;
            ^~~~~~~~~~
            X86_BUG_11AP
   arch/x86/include/asm/special_insns.h:31:9: note: each undeclared identifier is reported only once for each function it appears in

vim +/X86_CR0_WP +31 arch/x86/include/asm/special_insns.h

    25	
    26	static inline void native_write_cr0(unsigned long val)
    27	{
    28		bool warn = false;
    29	
    30	again:
  > 31		val |= X86_CR0_WP;
    32		/*
    33		 * In order to have the compiler not optimize away the check
    34		 * after the cr4 write, mark "val" as being also an output ("+r")
    35		 * by this asm() block so it will perform an explicit check, as
    36		 * if it were "volatile".
    37		 */
    38		asm volatile("mov %0,%%cr0" : "+r" (val) : "m" (__force_order) : );
    39		/*
    40		 * If the MOV above was used directly as a ROP gadget we can
    41		 * notice the lack of pinned bits in "val" and start the function
    42		 * from the beginning to gain the WP bit for sure. And do it
    43		 * without first taking the exception for a WARN().
    44		 */
    45		if ((val & X86_CR0_WP) != X86_CR0_WP) {
    46			warn = true;
    47			goto again;
    48		}
    49		WARN_ONCE(warn, "Attempt to unpin X86_CR0_WP, cr0 bypass attack?!\n");
    50	}
    51	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--r5Pyd7+fXNt84Ff3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
BrlwhZ1LoeL75sKr/wHCkpDTCXQAAA==

--r5Pyd7+fXNt84Ff3--
