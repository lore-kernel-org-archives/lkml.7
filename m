Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F2A20863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfCDEG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:06:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:2859 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfCDEG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:06:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 20:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,438,1544515200"; 
   d="scan'208";a="279482274"
Received: from spandruv-mobl3.jf.intel.com ([10.252.135.12])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2019 20:06:57 -0800
Message-ID: <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
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
Date:   Sun, 03 Mar 2019 20:06:57 -0800
In-Reply-To: <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
         <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
         <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
         <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
         <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-03 at 22:51 +0100, Rafael J. Wysocki wrote:
> On Sun, Mar 3, 2019 at 10:20 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Sun, 2019-03-03 at 18:03 +0100, Rafael J. Wysocki wrote:
> > > On Fri, Mar 1, 2019 at 6:39 PM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > 
> > > > On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > > > Hi All,
> > > > > 
> > > > > This is how I would fix the issue reported in BZ 200759 (see
> > > > > thisdev
> > > > > patch series
> > > > > from Yu too: 
> > > > > https://marc.info/?l=linux-pm&m=155137672924029&w=2)
> > > > > .
> > > > > 
> > > > > Patch [1/2] causes intel_pstate to update all policies if it
> > > > > gets
> > > > > a
> > > > > _PPC change
> > > > > notification and sees a global turbo disable/enable change.
> > > > > 
> > > > > Patch [2/2] makes it update cpuinfo.max_freq for all policies
> > > > > in
> > > > > those cases.
> > > > > 
> > > > > The patches here have not been tested yet, so testing would
> > > > > be
> > > > > much
> > > > > appreciated.
> > > > > 
> > > > > Of course, comments are welcome too!
> > > > 
> > > > This is the only platform, someone reported such issue.
> > > 
> > > I don't think this matters.
> > > 
> > > First, it doesn't mean that no other problems have this problem.
> > > 
> > > Second, the current handling of
> > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> > > changes in intel_pstate is not sufficient if the changes is from
> > > set
> > > to unset anyway.
> > 
> > Any platform with HWP, you can't even notify of this change. So any
> > platform beyond SKL is not useful.
> 
> Do you mean that HWP platforms don't supply _PPS (as a rule) and so
> they don't send _PPC notifications?  Is there anything they do
> instead
> of it?
There are other methods like PL1 budget limit for such cases. FW can
just change the config TDP level.

> 
> That's fair enough, but the point is that the driver doesn'dev_t do
> the
> right thing even if the platform does send a _PPC notification.
_PPC notification is to indicate levels in _PSS not to disable/enable
turbo via IA32_MISC_*. The platform could have just set _PPC to 1 or to
TAR-1. Here _PPC is sent for somthing more than just changing _PSS max
level. Do we have bug in if _PPC just changes performance level?

> 
> > Fixing is always good :-)
> 
> Well, I can only agree with that ...

