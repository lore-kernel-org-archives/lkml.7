Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD690C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE6820857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfCCMtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:49:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:54908 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfCCMtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:49:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 04:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,436,1544515200"; 
   d="gz'50?scan'50,208,50";a="153669376"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2019 04:49:07 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h0QYF-000BMx-CJ; Sun, 03 Mar 2019 20:49:07 +0800
Date:   Sun, 3 Mar 2019 20:48:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@01.org, Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 2/6] uaccess: Use user_access_ok() in
 user_access_begin()
Message-ID: <201903032015.d0foJyBR%fengguang.wu@intel.com>
References: <155135706227.438.3395927496953086242.stgit@devbox>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <155135706227.438.3395927496953086242.stgit@devbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masami,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v5.0-rc8 next-20190301]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-probes-uaccess-Add-support-user-space-access/20190303-150015
config: riscv-defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.2.0 make.cross ARCH=riscv 

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/bug.h:75,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from lib/strncpy_from_user.c:5:
   lib/strncpy_from_user.c: In function 'strncpy_from_user':
>> arch/riscv/include/asm/uaccess.h:42:19: error: 'TASK_SIZE' undeclared (first use in this function); did you mean 'TASK_SIZE_OF'?
    #define USER_DS  (TASK_SIZE)
                      ^~~~~~~~~
   include/asm-generic/bug.h:148:27: note: in definition of macro 'WARN_ON_ONCE'
     int __ret_warn_once = !!(condition);   \
                              ^~~~~~~~~
   include/linux/uaccess.h:26:16: note: in expansion of macro 'segment_eq'
     WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));   \
                   ^~~~~~~~~~
   include/linux/uaccess.h:26:37: note: in expansion of macro 'USER_DS'
     WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));   \
                                        ^~~~~~~
   include/linux/uaccess.h:285:37: note: in expansion of macro 'user_access_ok'
    #define user_access_begin(ptr, len) user_access_ok(ptr, len)
                                        ^~~~~~~~~~~~~~
   lib/strncpy_from_user.c:117:7: note: in expansion of macro 'user_access_begin'
      if (user_access_begin(src, max)) {
          ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:42:19: note: each undeclared identifier is reported only once for each function it appears in
    #define USER_DS  (TASK_SIZE)
                      ^~~~~~~~~
   include/asm-generic/bug.h:148:27: note: in definition of macro 'WARN_ON_ONCE'
     int __ret_warn_once = !!(condition);   \
                              ^~~~~~~~~
   include/linux/uaccess.h:26:16: note: in expansion of macro 'segment_eq'
     WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));   \
                   ^~~~~~~~~~
   include/linux/uaccess.h:26:37: note: in expansion of macro 'USER_DS'
     WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));   \
                                        ^~~~~~~
   include/linux/uaccess.h:285:37: note: in expansion of macro 'user_access_ok'
    #define user_access_begin(ptr, len) user_access_ok(ptr, len)
                                        ^~~~~~~~~~~~~~
   lib/strncpy_from_user.c:117:7: note: in expansion of macro 'user_access_begin'
      if (user_access_begin(src, max)) {
          ^~~~~~~~~~~~~~~~~
--
   In file included from arch/riscv/include/asm/bug.h:75,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:21,
                    from include/linux/sched.h:12,
                    from include/linux/uaccess.h:5,
                    from lib/strnlen_user.c:4:
   lib/strnlen_user.c: In function 'strnlen_user':
>> arch/riscv/include/asm/uaccess.h:42:19: error: 'TASK_SIZE' undeclared (first use in this function); did you mean 'TASK_SIZE_OF'?
    #define USER_DS  (TASK_SIZE)
                      ^~~~~~~~~
   include/asm-generic/bug.h:148:27: note: in definition of macro 'WARN_ON_ONCE'
     int __ret_warn_once = !!(condition);   \
                              ^~~~~~~~~
   include/linux/uaccess.h:26:16: note: in expansion of macro 'segment_eq'
     WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));   \
                   ^~~~~~~~~~
   include/linux/uaccess.h:26:37: note: in expansion of macro 'USER_DS'
     WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));   \
                                        ^~~~~~~
   include/linux/uaccess.h:285:37: note: in expansion of macro 'user_access_ok'
    #define user_access_begin(ptr, len) user_access_ok(ptr, len)
                                        ^~~~~~~~~~~~~~
   lib/strnlen_user.c:117:7: note: in expansion of macro 'user_access_begin'
      if (user_access_begin(str, max)) {
          ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:42:19: note: each undeclared identifier is reported only once for each function it appears in
    #define USER_DS  (TASK_SIZE)
                      ^~~~~~~~~
   include/asm-generic/bug.h:148:27: note: in definition of macro 'WARN_ON_ONCE'
     int __ret_warn_once = !!(condition);   \
                              ^~~~~~~~~
   include/linux/uaccess.h:26:16: note: in expansion of macro 'segment_eq'
     WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));   \
                   ^~~~~~~~~~
   include/linux/uaccess.h:26:37: note: in expansion of macro 'USER_DS'
     WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));   \
                                        ^~~~~~~
   include/linux/uaccess.h:285:37: note: in expansion of macro 'user_access_ok'
    #define user_access_begin(ptr, len) user_access_ok(ptr, len)
                                        ^~~~~~~~~~~~~~
   lib/strnlen_user.c:117:7: note: in expansion of macro 'user_access_begin'
      if (user_access_begin(str, max)) {
          ^~~~~~~~~~~~~~~~~

vim +42 arch/riscv/include/asm/uaccess.h

5d8544e2 Palmer Dabbelt 2017-07-10  27  
5d8544e2 Palmer Dabbelt 2017-07-10  28  #define __enable_user_access()							\
5d8544e2 Palmer Dabbelt 2017-07-10  29  	__asm__ __volatile__ ("csrs sstatus, %0" : : "r" (SR_SUM) : "memory")
5d8544e2 Palmer Dabbelt 2017-07-10  30  #define __disable_user_access()							\
5d8544e2 Palmer Dabbelt 2017-07-10  31  	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
5d8544e2 Palmer Dabbelt 2017-07-10  32  
5d8544e2 Palmer Dabbelt 2017-07-10  33  /*
5d8544e2 Palmer Dabbelt 2017-07-10  34   * The fs value determines whether argument validity checking should be
5d8544e2 Palmer Dabbelt 2017-07-10  35   * performed or not.  If get_fs() == USER_DS, checking is performed, with
5d8544e2 Palmer Dabbelt 2017-07-10  36   * get_fs() == KERNEL_DS, checking is bypassed.
5d8544e2 Palmer Dabbelt 2017-07-10  37   *
5d8544e2 Palmer Dabbelt 2017-07-10  38   * For historical reasons, these macros are grossly misnamed.
5d8544e2 Palmer Dabbelt 2017-07-10  39   */
5d8544e2 Palmer Dabbelt 2017-07-10  40  
5d8544e2 Palmer Dabbelt 2017-07-10  41  #define KERNEL_DS	(~0UL)
5d8544e2 Palmer Dabbelt 2017-07-10 @42  #define USER_DS		(TASK_SIZE)
5d8544e2 Palmer Dabbelt 2017-07-10  43  

:::::: The code at line 42 was first introduced by commit
:::::: 5d8544e2d0075a5f3c9a2cf27152354d54360da1 RISC-V: Generic library routines and assembly

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--YZ5djTAD1cGYuMQK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+f+DgVy1LBQBAA==

--YZ5djTAD1cGYuMQK--
