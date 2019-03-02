Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B113C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6D020836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCBQYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:24:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:27387 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfCBQYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:24:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2019 08:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,432,1544515200"; 
   d="scan'208";a="138532444"
Received: from spandruv-mobl3.jf.intel.com ([10.252.135.12])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2019 08:24:54 -0800
Message-ID: <426011fc8925a3fd27737f22d39ea6fc04c67404.camel@linux.intel.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date:   Sat, 02 Mar 2019 08:24:54 -0800
In-Reply-To: <20190302103008.GA7086@chenyu-office.sh.intel.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
         <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
         <20190302103008.GA7086@chenyu-office.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-02 at 18:30 +0800, Yu Chen wrote:
> On Fri, Mar 01, 2019 at 09:39:27AM -0800, Srinivas Pandruvada wrote:
> > On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > Hi All,
> > > 
> > > This is how I would fix the issue reported in BZ 200759 (see this
> > > patch series
> > > from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2)
> > > .
> > > 
> > > Patch [1/2] causes intel_pstate to update all policies if it gets
> > > a
> > > _PPC change
> > > notification and sees a global turbo disable/enable change.
> > > 
> > > Patch [2/2] makes it update cpuinfo.max_freq for all policies in
> > > those cases.
> > > 
> > > The patches here have not been tested yet, so testing would be
> > > much
> > > appreciated.
> > > 
> > > Of course, comments are welcome too!
> > 
> > This is the only platform, someone reported such issue.
> > Can we solve this by some udev rules and offline/online cpu 1-3 on
> > power source change?
> > 
> 
> Sound reasonable, we can deal with this BIOS problem in user space
> too. But if cpu0 could not be offline, how could cpu0's policy
> be updated?
I thought CPU0 is not a problem as the _PPC is sent on this and
policies gets updated from the following log.

# Unplug

[   25.775643] CPU 0: _PPC is 6 - frequency  limited
[   25.775660] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 
1700000
[   25.775666] intel_pstate: cpu:0 max_state 17 min_policy_perf:8
max_policy_perf:17
[   25.775670] intel_pstate: cpu:0 global_min:8 global_max:30
[   25.775674] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8

"REDUCED FREQUENCY ABOVE AFTER UNPLUG"


# Re-plug

[   36.979264] CPU 0: _PPC is 6 - frequency  limited
[   36.979276] intel_pstate: policy->max > max non turbo frequency
[   36.979280] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 
3000000
[   36.979283] intel_pstate: cpu:0 max_state 30 min_policy_perf:8
max_policy_perf:30
[   36.979286] intel_pstate: cpu:0 global_min:8 global_max:30
[   36.979289] intel_pstate: cpu:0 max_perf_ratio:30 min_perf_ratio:8

Thanks,
Srinivas

> 
> Thanks,
> Yu
> 
> > There are examples of changing governors on power source change.
> > https://bbs.archlinux.org/viewtopic.php?id=207186
> > 
> > Here instead of changing governor just
> > echo 0 > /sys/devices/system/cpu/cpu1/online
> > echo 1 > /sys/devices/system/cpu/cpu1/online
> > echo 0 >
> > /sys/devices/system/cpu/cpu2/online
> > echo 1 >
> > /sys/devices/system/cpu/cpu2/online
> > echo 0 >
> > /sys/devices/system/cpu/cpu3/online
> > echo 1 >
> > /sys/devices/system/cpu/cpu3/online
> > 
> > Thanks,
> > Srinivas
> > 
> > > 
> > > Thanks,
> > > Rafael
> > > 

