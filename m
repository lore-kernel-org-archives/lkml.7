Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02474C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90C020718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfL3Eue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 23:50:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:58627 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfL3Eue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 23:50:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Dec 2019 20:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,373,1571727600"; 
   d="gz'50?scan'50,208,50";a="220599545"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2019 20:50:28 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iln0d-000GKi-Qb; Mon, 30 Dec 2019 12:50:27 +0800
Date:   Mon, 30 Dec 2019 12:49:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kbuild-all@lists.01.org, Jonas Bonn <jonas@southpole.se>,
        kernel-janitors@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] openrisc: use mmgrab
Message-ID: <201912301238.xfn6pKut%lkp@intel.com>
References: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6xo3g43cz2rw5wsd"
Content-Disposition: inline
In-Reply-To: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6xo3g43cz2rw5wsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Julia,

I love your patch! Yet something to improve:

[auto build test ERROR on vfio/next]
[also build test ERROR on char-misc/char-misc-testing v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Julia-Lawall/use-mmgrab/20191230-011611
base:   https://github.com/awilliam/linux-vfio.git next
config: openrisc-simple_smp_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/openrisc/kernel/smp.c: In function 'secondary_start_kernel':
>> arch/openrisc/kernel/smp.c:116:2: error: implicit declaration of function 'mmgrab'; did you mean 'igrab'? [-Werror=implicit-function-declaration]
     116 |  mmgrab(mm);
         |  ^~~~~~
         |  igrab
   cc1: some warnings being treated as errors

vim +116 arch/openrisc/kernel/smp.c

   107	
   108	asmlinkage __init void secondary_start_kernel(void)
   109	{
   110		struct mm_struct *mm = &init_mm;
   111		unsigned int cpu = smp_processor_id();
   112		/*
   113		 * All kernel threads share the same mm context; grab a
   114		 * reference and switch to it.
   115		 */
 > 116		mmgrab(mm);
   117		current->active_mm = mm;
   118		cpumask_set_cpu(cpu, mm_cpumask(mm));
   119	
   120		pr_info("CPU%u: Booted secondary processor\n", cpu);
   121	
   122		setup_cpuinfo();
   123		openrisc_clockevent_init();
   124	
   125		notify_cpu_starting(cpu);
   126	
   127		/*
   128		 * OK, now it's safe to let the boot CPU continue
   129		 */
   130		complete(&cpu_running);
   131	
   132		synchronise_count_slave(cpu);
   133		set_cpu_online(cpu, true);
   134	
   135		local_irq_enable();
   136	
   137		preempt_disable();
   138		/*
   139		 * OK, it's off to the idle thread for us
   140		 */
   141		cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
   142	}
   143	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--6xo3g43cz2rw5wsd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
FmcMd4tTlWShtF1i3VImOgPUyRqnAYmH7/BmgpDnyYwAKjUVJgNBw/Xu6e/lrvIet8v7amdL
GM5MxqXvu5rL3e94jLRNVkO/SXYC0+MadLowyPnU4RIbBjbNHRC5ZtAlOM0wABwSODTcIWo2
AqibtsymAgXZ7mNCHsIzmJ3TJg9lZ7yG52m2y3/Ze/fmgnSeZuxm67ILuH3U9aIRpa6UkcLe
yQJlvWOIsJOsDXU4phylSkDVEb2uGLAHKBnJ4wVOmgj/z06DDsbBdnTaOgkb+F2HaKffCRi8
TgOMwPIpBGS9Bz8gaUXsPXpbkWquc2SD25xOE+bJl+fn7e5gn0WnvU6C6FI5+9TaLS2SZKHX
gc4LkXksZAHapMXmruoAmRPc4M71cxXEzUHIHGZtmpHUEQzRS3TNjMGdTry9tepWWkMpP13R
+QdUh3td6/qk6p/lvnkleTIvifvvoOb33mG33Ow1n/e43lTePWzg+ln/055S8bIffbeFRP/9
uGZg8niodksvzCLifWttzv327422O97TVld3eG931f+9rHcVTHBJ/2hrHPnmUD16CWznv7xd
9WgqKE/b1GPR6lprd0uTFBzWsHkqsm7rCZqJTIOPwQmdJhlv94fecCciXe7uMRGc/Nvn4wuK
PMDq7KTQWypk8oflsY6yW3K31XBn9sm6TXQs0JPtqFIjNoC5usXa8FY5gKhT4LZ5xTpYcO1k
kFtzyHkXzzUJ1xNQEmngCtiMiuPq/aUwlaVuuKuYQ7MTQnWY44pFXaTp3EXRDsnh1SJH0AYy
SIddAdnhX1K4Eg4FLgS0l1Ozv6ZW1NF7yhQeOKRxItKBOhggeNL6++4VDdZgIdZfX/QllH+v
D6vvHrGemSz20xvjL3Y5JujVmOUd16SXCGgpEDngF0L1G0S3GJboGJ6USmLYwe6dkDs7222T
4HKlihOcmFO8vchF3gm065Yy9W9v0adkq3Ndeyo6jtW/xmNZnyb6xuHxhVxA/Jb0vc9wQgpo
sa7QwmhTbtc62CQYmKedVUYs4Sk/nhSuxz3CcGB219QOnzTctJRpBiiapASm0Ri5v/DhSJEQ
UYwvbFyQGeMoid9e3sznOClVLEYpCQFA1C0PS6ZJgFZA2d04zVmn10Te3t5clAlarNXrKbpF
1n2qhONAqSlRbhpTuUhFgm9b2qkpg7OeR+y/O5Pbq08j69VNjQWuQxlLJURIAiVqi69rY21h
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

--6xo3g43cz2rw5wsd--
