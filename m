Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F525206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfCDSGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:06:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:32514 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfCDSGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:06:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 10:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="325318178"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga005.fm.intel.com with ESMTP; 04 Mar 2019 10:06:39 -0800
Message-ID: <9099672e17ea9fc7711b34e92ce5a016afb43a0c.camel@linux.intel.com>
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
Date:   Mon, 04 Mar 2019 10:06:39 -0800
In-Reply-To: <CAJZ5v0iCVhj-HmToGnSBuYE99LMn0BZpB-Ax48Aqh9hVc1+qwQ@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
         <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
         <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
         <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
         <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com>
         <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
         <CAJZ5v0iCVhj-HmToGnSBuYE99LMn0BZpB-Ax48Aqh9hVc1+qwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> > There are other methods like PL1 budget limit for such cases. FW
> > can
> > just change the config TDP level.
> 
> OK, but that would be done without notification I suppose?
There is a notification via processor PCI device (B0D4). This is passed
to user space to change the power limits. The new element is called
PPCC and it is exposed via sysfs.
Disabling turbo is not very interesting as there can be more turbo than
non turbo. So you loose lots of performance. So instead you can control
power in turbo region to give you more control. _PPC is even less
interesting as you can't control uncore power.

> 
> > > That's fair enough, but the point is that the driver doesn'dev_t
> > > do
> > > the right thing even if the platform does send a _PPC
> > > notification.
> > 
> > _PPC notification is to indicate levels in _PSS not to
> > disable/enable
> > turbo via IA32_MISC_*.
> 
> I was not talking about notifications, but about what the driver does
> when MSR_IA32_MISC_ENABLE_TURBO_DISABLE is set or unset by FW on the
> fly: this only really works if the change is from unset to set,
> because the range of frequencies to use is restricted then, even
> though user-visible policy limits are not updated.  However, if the
> change is from set to unset, the update of policy limits is actually
> necessary for the change to really take effect (otherwise the user
> policy max prevents turbo frequencies from being requested).  HWP
> seems to be affected too, for that matter, because the upper limit in
> the MSR is not updated too then AFAICS.
> 
> > The platform could have just set _PPC to 1 or to TAR-1. Here _PPC
> > is sent for somthing more than just changing _PSS max
> > level. Do we have bug in if _PPC just changes performance level?
> 
> I think that we just need to live with the fact that _PPC may be
> triggered for something more than changing _PSS max.
I understand the reason why you are doing the change. I investigated
this bugzilla before. I was thinking can udev rules should be enough to
address this issue. But it was not a requirement.

The change itself is fine. Except may be hide the policy->rwsem in some
header file instead of directly exposing to clients to use.

Thanks,
Srinivas

