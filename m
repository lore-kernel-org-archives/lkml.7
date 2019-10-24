Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED3ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997612166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439167AbfJXLp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:45:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:49925 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfJXLp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:45:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 04:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="gz'50?scan'50,208,50";a="210139732"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 04:45:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iNbYv-0009g8-5b; Thu, 24 Oct 2019 19:45:53 +0800
Date:   Thu, 24 Oct 2019 19:45:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: Fix a huge pud insertion race during faulting
Message-ID: <201910241921.oi4h7o4m%lkp@intel.com>
References: <20191022123003.37089-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="enzjts7iy36i7xe4"
Content-Disposition: inline
In-Reply-To: <20191022123003.37089-1-thomas_os@shipmail.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--enzjts7iy36i7xe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Thomas,

I love your patch! Yet something to improve:

[auto build test ERROR on mmotm/master]

url:    https://github.com/0day-ci/linux/commits/Thomas-Hellstr-m-VMware/mm-Fix-a-huge-pud-insertion-race-during-faulting/20191024-175905
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/um/include/asm/pgtable.h:363:0,
                    from include/linux/mm.h:99,
                    from include/linux/memcontrol.h:20,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from init/do_mounts.c:7:
   include/asm-generic/pgtable.h: In function 'pud_none_or_trans_huge_or_dev_or_clear_bad':
>> include/asm-generic/pgtable.h:920:52: error: implicit declaration of function 'pud_devmap'; did you mean 'put_device'? [-Werror=implicit-function-declaration]
     if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
                                                       ^~~~~~~~~~
                                                       put_device
   In file included from include/linux/memcontrol.h:20:0,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from init/do_mounts.c:7:
   include/linux/mm.h: At top level:
   include/linux/mm.h:572:19: error: static declaration of 'pud_devmap' follows non-static declaration
    static inline int pud_devmap(pud_t pud)
                      ^~~~~~~~~~
   In file included from arch/um/include/asm/pgtable.h:363:0,
                    from include/linux/mm.h:99,
                    from include/linux/memcontrol.h:20,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from init/do_mounts.c:7:
   include/asm-generic/pgtable.h:920:52: note: previous implicit declaration of 'pud_devmap' was here
     if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
                                                       ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +920 include/asm-generic/pgtable.h

   914	
   915	/* See pmd_none_or_trans_huge_or_clear_bad for discussion. */
   916	static inline int pud_none_or_trans_huge_or_dev_or_clear_bad(pud_t *pud)
   917	{
   918		pud_t pudval = READ_ONCE(*pud);
   919	
 > 920		if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
   921			return 1;
   922		if (unlikely(pud_bad(pudval))) {
   923			pud_clear_bad(pud);
   924			return 1;
   925		}
   926		return 0;
   927	}
   928	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--enzjts7iy36i7xe4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nZO0pRtdTO0n/wE8VjPOK4AAAA==

--enzjts7iy36i7xe4--
