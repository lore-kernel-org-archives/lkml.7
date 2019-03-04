Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5082070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCDLpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:45:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:16060 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfCDLpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:45:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 03:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="scan'208";a="151851798"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2019 03:45:19 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] log2: make is_power_of_2() integer constant expression when possible
In-Reply-To: <201903041956.eLAFVhUK%fengguang.wu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190301125207.30973-1-jani.nikula@intel.com> <201903041956.eLAFVhUK%fengguang.wu@intel.com>
Date:   Mon, 04 Mar 2019 13:47:17 +0200
Message-ID: <87o96qn9oa.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Mar 2019, kbuild test robot <lkp@intel.com> wrote:
> Hi Jani,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.0 next-20190301]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Jani-Nikula/log2-make-is_power_of_2-integer-constant-expression-when-possible/20190304-153529
> config: microblaze-mmu_defconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=microblaze 
>
> All warnings (new ones prefixed by >>):
>
>>> arch/microblaze/mm/pgtable.c:185: warning: "is_power_of_2" redefined
>     #define is_power_of_2(x) ((x) != 0 && (((x) & ((x) - 1)) == 0))

Oh wow, a copy of is_power_of_2() introduced 10 years ago, apparently
unused since its introduction.


BR,
Jani.


>     
>    In file included from include/linux/kernel.h:12,
>                     from arch/microblaze/mm/pgtable.c:30:
>    include/linux/log2.h:56: note: this is the location of the previous definition
>     #define is_power_of_2(n) \
>     
>
> vim +/is_power_of_2 +185 arch/microblaze/mm/pgtable.c
>
> 15902bf6 Michal Simek 2009-05-26  183  
> 15902bf6 Michal Simek 2009-05-26  184  /* is x a power of 2? */
> 15902bf6 Michal Simek 2009-05-26 @185  #define is_power_of_2(x)	((x) != 0 && (((x) & ((x) - 1)) == 0))
> 15902bf6 Michal Simek 2009-05-26  186  
>
> :::::: The code at line 185 was first introduced by commit
> :::::: 15902bf63c8332946e5a1f48a72e3ae22874b11b microblaze_mmu_v2: Page table - ioremap - pgtable.c/h, section update
>
> :::::: TO: Michal Simek <monstr@monstr.eu>
> :::::: CC: Michal Simek <monstr@monstr.eu>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
Jani Nikula, Intel Open Source Graphics Center
