Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE75C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6B020678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbgAIStn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:49:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:20532 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732156AbgAIStm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:49:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 10:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="gz'50?scan'50,208,50";a="217870027"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jan 2020 10:49:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ipcs2-0005na-5K; Fri, 10 Jan 2020 02:49:26 +0800
Date:   Fri, 10 Jan 2020 02:49:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     carlosteniswarrior@gmail.com
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
Subject: Re: [PATCH] Init: fixed an error caused by using __initdata instead
 of __initconst
Message-ID: <202001100151.DfTxGsAR%lkp@intel.com>
References: <20200106020217.13234-1-carlosteniswarrior@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hsovtfl4plkaxyxw"
Content-Disposition: inline
In-Reply-To: <20200106020217.13234-1-carlosteniswarrior@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hsovtfl4plkaxyxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.5-rc5 next-20200108]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/carlosteniswarrior-gmail-com/Init-fixed-an-error-caused-by-using-__initdata-instead-of-__initconst/20200109-034253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1522d9da40bdfe502c91163e6d769332897201fa
config: mips-jmr3927_defconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:15,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from init/main.c:17:
>> include/linux/init.h:254:20: error: __setup_str_initcall_blacklist causes a section type conflict with initcall_level_names
     static const char __setup_str_##unique_id[] __initconst  \
                       ^
   include/linux/init.h:262:2: note: in expansion of macro '__setup_param'
     __setup_param(str, fn, fn, 0)
     ^~~~~~~~~~~~~
   init/main.c:874:1: note: in expansion of macro '__setup'
    __setup("initcall_blacklist=", initcall_blacklist);
    ^~~~~~~
   init/main.c:983:20: note: 'initcall_level_names' was declared here
    static const char *initcall_level_names[] __initconst = {
                       ^~~~~~~~~~~~~~~~~~~~

vim +254 include/linux/init.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  246  
^1da177e4c3f41 Linus Torvalds 2005-04-16  247  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  248   * Only for really core code.  See moduleparam.h for the normal way.
^1da177e4c3f41 Linus Torvalds 2005-04-16  249   *
^1da177e4c3f41 Linus Torvalds 2005-04-16  250   * Force the alignment so the compiler doesn't space elements of the
^1da177e4c3f41 Linus Torvalds 2005-04-16  251   * obs_kernel_param "array" too far apart in .init.setup.
^1da177e4c3f41 Linus Torvalds 2005-04-16  252   */
^1da177e4c3f41 Linus Torvalds 2005-04-16  253  #define __setup_param(str, unique_id, fn, early)			\
fd6c3a8dc44329 Jan Beulich    2009-03-12 @254  	static const char __setup_str_##unique_id[] __initconst		\
fd6c3a8dc44329 Jan Beulich    2009-03-12  255  		__aligned(1) = str; 					\
^1da177e4c3f41 Linus Torvalds 2005-04-16  256  	static struct obs_kernel_param __setup_##unique_id		\
3ff6eecca4e5c4 Adrian Bunk    2008-01-24  257  		__used __section(.init.setup)				\
^1da177e4c3f41 Linus Torvalds 2005-04-16  258  		__attribute__((aligned((sizeof(long)))))		\
^1da177e4c3f41 Linus Torvalds 2005-04-16  259  		= { __setup_str_##unique_id, fn, early }
^1da177e4c3f41 Linus Torvalds 2005-04-16  260  

:::::: The code at line 254 was first introduced by commit
:::::: fd6c3a8dc44329d3aff9a578b5120982f63711ee initconst adjustments

:::::: TO: Jan Beulich <jbeulich@novell.com>
:::::: CC: Sam Ravnborg <sam@ravnborg.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--hsovtfl4plkaxyxw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Iwnd/wFmcmQqDrcAAA==

--hsovtfl4plkaxyxw--
