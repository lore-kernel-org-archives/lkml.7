Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8F4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D0A2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfEUIBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:01:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:5563 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfEUIBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:01:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 01:00:58 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2019 01:00:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hSzhg-0004xJ-9C; Tue, 21 May 2019 16:00:56 +0800
Date:   Tue, 21 May 2019 16:00:10 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/failslab: By default, do not fail allocations with
 direct reclaim only
Message-ID: <201905211524.RpQYbGWw%lkp@intel.com>
References: <20190520044951.248096-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520044951.248096-1-drinkcat@chromium.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.2-rc1 next-20190520]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Boichat/mm-failslab-By-default-do-not-fail-allocations-with-direct-reclaim-only/20190521-045221
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> mm/failslab.c:27:26: sparse: sparse: restricted gfp_t degrades to integer

vim +27 mm/failslab.c

    16	
    17	bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
    18	{
    19		/* No fault-injection for bootstrap cache */
    20		if (unlikely(s == kmem_cache))
    21			return false;
    22	
    23		if (gfpflags & __GFP_NOFAIL)
    24			return false;
    25	
    26		if (failslab.ignore_gfp_reclaim &&
  > 27				(gfpflags & ___GFP_DIRECT_RECLAIM))
    28			return false;
    29	
    30		if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
    31			return false;
    32	
    33		return should_fail(&failslab.attr, s->object_size);
    34	}
    35	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
