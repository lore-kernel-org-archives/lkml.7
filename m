Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00BCC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFF92173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfH3BEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:04:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:39798 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfH3BEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:04:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 18:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="183649891"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2019 18:04:32 -0700
Date:   Fri, 30 Aug 2019 09:08:56 +0800
From:   Philip Li <philip.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild test robot <lkp@intel.com>,
        linux-tip-commits@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, kbuild-all@01.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [kbuild-all] [tip: timers/core] posix-cpu-timers: Use common
 permission check in posix_cpu_clock_get()
Message-ID: <20190830010856.GE857@intel.com>
References: <156698737946.5688.8980349129135194974.tip-bot2@tip-bot2>
 <201908291858.PW3xOkIL%lkp@intel.com>
 <alpine.DEB.2.21.1908291320010.1938@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908291320010.1938@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:21:59PM +0200, Thomas Gleixner wrote:
> On Thu, 29 Aug 2019, kbuild test robot wrote:
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on linus/master]
> > [cannot apply to v5.3-rc6 next-20190828]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> I have no idea what you are testing there.
oops, looks we have missed some info in report. We actually test patches
from mailing list we monitor.
> 
> >    kernel/time/posix-cpu-timers.c: In function 'posix_cpu_clock_get':
> > >> kernel/time/posix-cpu-timers.c:275:8: error: implicit declaration of function 'get_task_for_clock'; did you mean 'get_task_struct'? [-Werror=implicit-function-declaration]
> >      tsk = get_task_for_clock(clock);
> >            ^~~~~~~~~~~~~~~~~~
> >            get_task_struct
> > >> kernel/time/posix-cpu-timers.c:275:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> >      tsk = get_task_for_clock(clock);
> >          ^
> >    cc1: some warnings being treated as errors
> 
> That commit comes _after_ the commit which introduced the function and
> get_task_for_clock() is defined above posix_cpu_clock_get(), so I assume
> you missed to apply the commit on which this depends on.
thanks for info, currently the bot can't figure out the dependency if two
patches are not in one series, or we didn't find the right base repo to
apply, which we will improve continuously.

> 
> Thanks,
> 
> 	tglx
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
