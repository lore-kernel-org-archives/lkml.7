Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E4C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B88A2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfLFBpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:45:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:43238 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfLFBpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:45:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 17:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="413183225"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2019 17:45:12 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1id2gC-0006Wa-EP; Fri, 06 Dec 2019 09:45:12 +0800
Date:   Fri, 6 Dec 2019 09:45:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: Optimise x86 IP checksum code
Message-ID: <201912060941.f3Qi9xtV%lkp@intel.com>
References: <c92db041c78e4d81a70aaf4249393901@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92db041c78e4d81a70aaf4249393901@AcuMS.aculab.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/auto-latest]
[also build test WARNING on tip/x86/core linus/master v5.4 next-20191202]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/David-Laight/x86-Optimise-x86-IP-checksum-code/20191203-211313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e445033e58108a9891abfbc0dea90b066a75e4a9
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-91-g817270f-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/x86/lib/csum-partial_64.c:141:23: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __wsum @@    got icted __wsum @@
>> arch/x86/lib/csum-partial_64.c:141:23: sparse:    expected restricted __wsum
>> arch/x86/lib/csum-partial_64.c:141:23: sparse:    got unsigned int

vim +141 arch/x86/lib/csum-partial_64.c

   126	
   127	/*
   128	 * computes the checksum of a memory block at buff, length len,
   129	 * and adds in "sum" (32-bit)
   130	 *
   131	 * returns a 32-bit number suitable for feeding into itself
   132	 * or csum_tcpudp_magic
   133	 *
   134	 * this function must be called with even lengths, except
   135	 * for the last fragment, which may be odd
   136	 *
   137	 * it's best to have buff aligned on a 64-bit boundary
   138	 */
   139	__wsum csum_partial(const void *buff, int len, __wsum sum)
   140	{
 > 141		return do_csum(buff, len, (__force u32)sum);
   142	}
   143	EXPORT_SYMBOL(csum_partial);
   144	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
