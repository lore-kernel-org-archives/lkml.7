Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613AACA9EC7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 02:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F52084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 02:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKCC2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 22:28:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:16802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfKCC2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 22:28:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2019 19:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,261,1569308400"; 
   d="scan'208";a="401249804"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2019 19:28:26 -0700
Date:   Sun, 3 Nov 2019 10:28:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>, Qian Cai <cai@lca.pw>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, "lkp@01.org" <lkp@01.org>
Subject: Re: [LKP] [mm] 87eaceb3fa: stress-ng.madvise.ops_per_sec -19.6%
 regression
Message-ID: <20191103022826.GA54034@shbuild999.sh.intel.com>
References: <20190930084604.GC17687@shao2-debian>
 <20191101094154.GA68419@shbuild999.sh.intel.com>
 <23762632-2b5a-80fa-815f-1a8c58c5bb74@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23762632-2b5a-80fa-815f-1a8c58c5bb74@linux.alibaba.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 01:04:36AM +0800, Yang Shi wrote:
> 
> 
> On 11/1/19 2:41 AM, Feng Tang wrote:
> > Hi Yang,
> >
> > On Mon, Sep 30, 2019 at 04:46:05PM +0800, kernel test robot wrote:
> >> Greeting,
> >>
> >> FYI, we noticed a -19.6% regression of stress-ng.madvise.ops_per_sec due to commit:
> >>
> >>
> >> commit: 87eaceb3faa59b9b4d940ec9554ce251325d83fe ("mm: thp: make deferred split shrinker memcg aware")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>
> >> in testcase: stress-ng
> >> on test machine: 72 threads Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz with 192G memory
> >> with following parameters:
> >>
> >> 	nr_threads: 100%
> >> 	disk: 1HDD
> >> 	testtime: 1s
> >> 	class: vm
> >> 	ucode: 0x200005e
> >> 	cpufreq_governor: performance
> >>
> >>
> >>
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >>
> >>
> >> Details are as below:
> >> -------------------------------------------------------------------------------------------------->
> >>
> >>
> >> To reproduce:
> >>
> >>          git clone https://github.com/intel/lkp-tests.git
> >>          cd lkp-tests
> >>          bin/lkp install job.yaml  # job file is attached in this email
> >>          bin/lkp run     job.yaml
> >>
> >> =========================================================================================
> >> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
> >>    vm/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2019-05-14.cgz/lkp-skl-2sp8/stress-ng/1s/0x200005e
> >>
> >> commit:
> >>    0a432dcbeb ("mm: shrinker: make shrinker not depend on memcg kmem")
> >>    87eaceb3fa ("mm: thp: make deferred split shrinker memcg aware")
> >>
> >> 0a432dcbeb32edcd 87eaceb3faa59b9b4d940ec9554
> >> ---------------- ---------------------------
> >>           %stddev     %change         %stddev
> >>               \          |                \
> >>        6457           -19.5%       5198        stress-ng.madvise.ops
> >>        6409           -19.6%       5154        stress-ng.madvise.ops_per_sec
> > Do you have any clue on this?
> 
> I replied the email once I got this report, please see 
> https://lore.kernel.org/lkml/d30b1358-fb6b-2658-e675-ceff3bc465ab@linux.alibaba.com/
> 
> And, the potential fix had been posted to the mailing list, please see 
> https://lore.kernel.org/linux-mm/1569968203-64647-1-git-send-email-yang.shi@linux.alibaba.com/
> 
> But, the review looks stalled, I will try to move it forward.

Great! Thanks for the update.

- Feng

> 
> >
> > Thanks,
> > Feng
> >
