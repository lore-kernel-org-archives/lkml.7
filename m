Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04490C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA30420838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCBKVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:21:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:44994 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfCBKVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 05:21:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2019 02:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,431,1544515200"; 
   d="scan'208";a="147944535"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2019 02:21:16 -0800
Date:   Sat, 2 Mar 2019 18:30:08 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Message-ID: <20190302103008.GA7086@chenyu-office.sh.intel.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 09:39:27AM -0800, Srinivas Pandruvada wrote:
> On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > This is how I would fix the issue reported in BZ 200759 (see this
> > patch series
> > from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).
> > 
> > Patch [1/2] causes intel_pstate to update all policies if it gets a
> > _PPC change
> > notification and sees a global turbo disable/enable change.
> > 
> > Patch [2/2] makes it update cpuinfo.max_freq for all policies in
> > those cases.
> > 
> > The patches here have not been tested yet, so testing would be much
> > appreciated.
> > 
> > Of course, comments are welcome too!
> 
> This is the only platform, someone reported such issue.
> Can we solve this by some udev rules and offline/online cpu 1-3 on
> power source change?
>
Sound reasonable, we can deal with this BIOS problem in user space
too. But if cpu0 could not be offline, how could cpu0's policy
be updated?

Thanks,
Yu

> There are examples of changing governors on power source change.
> https://bbs.archlinux.org/viewtopic.php?id=207186
> 
> Here instead of changing governor just
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo 1 > /sys/devices/system/cpu/cpu1/online
> echo 0 >
> /sys/devices/system/cpu/cpu2/online
> echo 1 >
> /sys/devices/system/cpu/cpu2/online
> echo 0 >
> /sys/devices/system/cpu/cpu3/online
> echo 1 >
> /sys/devices/system/cpu/cpu3/online
> 
> Thanks,
> Srinivas
> 
> > 
> > Thanks,
> > Rafael
> > 
> 
