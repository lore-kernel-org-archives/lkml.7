Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD330C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 02:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FC421D56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 02:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgACCbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 21:31:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:13185 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgACCbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 21:31:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 18:31:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,389,1571727600"; 
   d="scan'208";a="302123811"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga001.jf.intel.com with ESMTP; 02 Jan 2020 18:31:17 -0800
Date:   Fri, 3 Jan 2020 10:31:17 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     kernel test robot <rong.a.chen@intel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [cpuidle] 259231a045: will-it-scale.per_process_ops -12.6%
 regression
Message-ID: <20200103023117.GA1313@shbuild999.sh.intel.com>
References: <20190918021334.GL15734@shao2-debian>
 <20191231055923.GA70013@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191231055923.GA70013@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 01:59:23PM +0800, Feng Tang wrote:
> Hi Marcelo,
> 
> On Wed, Sep 18, 2019 at 10:13:34AM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -12.6% regression of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: 259231a045616c4101d023a8f4dcc8379af265a6 ("cpuidle: add poll_limit_ns to cpuidle_device structure")
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> Any comments on this? We re-run the test for 5.5-rc1, and the regression remains.

Anyway, I found commit 259231a04 lost one "break" when moving
the original code, thus the semantics is changed to the last
enabled state's target_residency instead of the first enabled
one's.

I don't know if it's intentional, and I guess no, so here 
is a fix patch, please review, thanks

But even with this patch, the regression is still not recovered.

- Feng

From cddd6b409e18ce97a8d7b851db4400396f71d857 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Thu, 2 Jan 2020 16:58:31 +0800
Subject: [PATCH] cpuidle: Add back the lost break in cpuidle_poll_time

Commit c4cbb8b649b5 move the poll time calculation into a
new function cpuidle_poll_time(), during which one "break"
get lost, and the semantic is changed from the last enabled
state's target_residency instead of the first enabled one's.

So add it back.

Fixes: c4cbb8b649b5 "cpuidle: add poll_limit_ns to cpuidle_device structure"
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
---
 drivers/cpuidle/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0895b98..29d2d7a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -384,6 +384,7 @@ u64 cpuidle_poll_time(struct cpuidle_driver *drv,
 			continue;
 
 		limit_ns = (u64)drv->states[i].target_residency * NSEC_PER_USEC;
+		break;
 	}
 
 	dev->poll_limit_ns = limit_ns;
-- 
2.7.4

> 
> Thanks,
> Feng
> 
> > 
> > in testcase: will-it-scale
> > on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> > with following parameters:
> > 
> > 	nr_task: 100%
> > 	mode: process
> > 	test: mmap1
> > 	cpufreq_governor: performance
> > 
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> >   gcc-7/performance/x86_64-rhel-7.6/process/100%/debian-x86_64-2019-05-14.cgz/lkp-knm01/mmap1/will-it-scale
> > 
> > commit: 
> >   fa86ee90eb ("add cpuidle-haltpoll driver")
> >   259231a045 ("cpuidle: add poll_limit_ns to cpuidle_device structure")
> > 
> > fa86ee90eb111126 259231a045616c4101d023a8f4d 
> > ---------------- --------------------------- 
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |    
> >            :4           25%           1:4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
> >          %stddev     %change         %stddev
> >              \          |                \  
> >       1611           -12.6%       1408        will-it-scale.per_process_ops
> >     464144           -12.6%     405580        will-it-scale.workload
> >       1581 ±  2%      +3.3%       1633        vmstat.system.cs
