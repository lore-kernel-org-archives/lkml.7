Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4A5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EED2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfH2LYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:24:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:31081 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfH2LX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:23:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 04:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="gz'50?scan'50,208,50";a="185939857"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2019 04:23:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i3IWy-0000GY-B9; Thu, 29 Aug 2019 19:23:56 +0800
Date:   Thu, 29 Aug 2019 19:23:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Cc:     kbuild-all@01.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: timers/core] posix-cpu-timers: Use common permission check
 in posix_cpu_clock_get()
Message-ID: <201908291909.BdlMivWO%lkp@intel.com>
References: <156698737946.5688.8980349129135194974.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gap6xrjteqzl2fje"
Content-Disposition: inline
In-Reply-To: <156698737946.5688.8980349129135194974.tip-bot2@tip-bot2>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gap6xrjteqzl2fje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi tip-bot2,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc6 next-20190827]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/tip-bot2-for-Thomas-Gleixner/posix-cpu-timers-Use-common-permission-check-in-posix_cpu_clock_get/20190829-181227
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/time/posix-cpu-timers.c: In function 'posix_cpu_clock_get':
   kernel/time/posix-cpu-timers.c:275:8: error: implicit declaration of function 'get_task_for_clock'; did you mean 'get_task_struct'? [-Werror=implicit-function-declaration]
     tsk = get_task_for_clock(clock);
           ^~~~~~~~~~~~~~~~~~
           get_task_struct
>> kernel/time/posix-cpu-timers.c:275:6: warning: assignment to 'struct task_struct *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     tsk = get_task_for_clock(clock);
         ^
   cc1: some warnings being treated as errors

vim +275 kernel/time/posix-cpu-timers.c

   268	
   269	static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
   270	{
   271		const clockid_t clkid = CPUCLOCK_WHICH(clock);
   272		struct task_struct *tsk;
   273		u64 t;
   274	
 > 275		tsk = get_task_for_clock(clock);
   276		if (!tsk)
   277			return -EINVAL;
   278	
   279		if (CPUCLOCK_PERTHREAD(clock))
   280			cpu_clock_sample(clkid, tsk, &t);
   281		else
   282			cpu_clock_sample_group(clkid, tsk, &t);
   283		put_task_struct(tsk);
   284	
   285		*tp = ns_to_timespec64(t);
   286		return 0;
   287	}
   288	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gap6xrjteqzl2fje
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gap6xrjteqzl2fje--
