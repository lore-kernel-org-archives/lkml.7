Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4CF20684
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfCDXEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:04:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:54252 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCDXEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:04:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 15:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,441,1544515200"; 
   d="scan'208";a="131232787"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2019 15:04:07 -0800
Message-ID: <edab7c9f77e682c701c58a02e7b6af70a57abf25.camel@linux.intel.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date:   Mon, 04 Mar 2019 15:04:07 -0800
In-Reply-To: <CAJZ5v0jzRyz4gZFwJ36feppeEMEzOPJ5Y8weV3pz=+S5ijnEVw@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
         <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
         <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
         <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
         <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com>
         <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
         <CAJZ5v0iCVhj-HmToGnSBuYE99LMn0BZpB-Ax48Aqh9hVc1+qwQ@mail.gmail.com>
         <9099672e17ea9fc7711b34e92ce5a016afb43a0c.camel@linux.intel.com>
         <CAJZ5v0jzRyz4gZFwJ36feppeEMEzOPJ5Y8weV3pz=+S5ijnEVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 22:57 +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 4, 2019 at 7:06 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > [...]
> > > > There are other methods like PL1 budget limit for such cases.
> > > > FW
> > > > can
> > > > just change the config TDP level.
> > > 
> > > OK, but that would be done without notification I suppose?
> > 
> > There is a notification via processor PCI device (B0D4). This is
> > passed
> > to user space to change the power limits. The new element is called
> > PPCC and it is exposed via sysfs.
> 
> What do you mean by "new element" and how exactly is it exposed?
This is part of DPTF processor ACPI object (INT3401 or B0D4). They are
exposed in sysfs 
E.g, /sys/bus/platform/devices/INT3401:00/power_limits/
There is a thermal uevent sent when they change. Both dptf daemon and
thermald listen and use to set rapl power-constraints including step
sizes for control. Someone can write a udev rule to do the same.

> 
> > Disabling turbo is not very interesting as there can be more turbo
> > than
> > non turbo. So you loose lots of performance. So instead you can
> > control
> > power in turbo region to give you more control. _PPC is even less
> > interesting as you can't control uncore power.
> 
> I guess that designers should know about that.  The kernel is on the
> receiving end here. :-)
I think they know. Hence you don't see this issue of enable/disable of
turbo by firmware quite often. This laptop here I guess released in
beginning of 2014 with Haswell.

> 
> > > 
[...]

> 
> I guess that you are talking about intel_pstate_update_max_freq()
> which acquires policy->rwsem.  If so, what exactly is the problem
> with
> it?
I was suggesting to use an API/define in cpufreq.h which does operation
on policy->rwsem for better abstraction. This is the first time it was
used outside core cpufreq.c. As more places it will be used in future,
common function will help debug, if in some path there is a bug in
aquire/release of semaphore. But you can ignore this.

Thanks,
Srinivas


