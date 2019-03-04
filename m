Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9257C20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551692497;
	bh=4P8RoLiYD0ZUyjPuCiGHblcYRulJJlpt54LavqE0KZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xbJTegYd3j++WwU6fewJeq33I0wcDPyWY6LgtyTKiIyFWs0OcvXMDGpvM9VGITZCd
	 x+g8Xuna9eHtSeQrAuRw7lC9hwgHSa2i8FDan3IXK+YSR0qnEoE7WN66wQVezI33nc
	 Blk8OhkpSX92uU9IirBHSi4AUFo3GN60/bxiAg/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCDJlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:41:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44989 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCDJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:41:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id a81so3327146oii.11;
        Mon, 04 Mar 2019 01:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxZOjL8rfcQsaR3p+fMtLJ2bMc9ap3yM1eKP4htytYk=;
        b=mApk3H3FDmOhLSxqCY2GAnkxHO5FG9GbaD2TygagxL/ESzCkPC/YyAPlTJypjij5d3
         AUbnr/FnhDKxFWh11nbWdoBCng4bnK3qA/GOwFWvzF2eBby4e8BauGoL7mkxVMy9XTU4
         zp/PgZKUlyB52M+l7V8FDW069koMuThNpp26K5hIP+37/A/tw3tJtntZdRryije98C1Z
         jLHfBCEzcJzx8XU+Yh08MQK1pl0rTHuUl2QW1p/ESj9Q2OJGK4K63pl6dxRw9NXDfKMq
         biukHM335AuMCoe+OrmK0Xj8HsZ5bDFGaigwknifUhEAF9ZuXsJ1fc/Q4yl35m5Q1lve
         Qi4Q==
X-Gm-Message-State: AHQUAuYQCJ2KuCLxzkNYMZvTrvoPvwEr1J/JHBAuUD2GjjfQtSKhzMDd
        Gexv8uP2P5KxHmYUc9sIsFj6ViX2U/TBuuMK7yY=
X-Google-Smtp-Source: AHgI3IaifYeuDFK/1uNtGzeSZfaNBZU5RElHsOZPEtvGZc3d3u/ZJv9RvsUt76N0wq65PVOW4v6B7EF62a5PaqRf6H0=
X-Received: by 2002:aca:355:: with SMTP id 82mr11997841oid.30.1551692494720;
 Mon, 04 Mar 2019 01:41:34 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
 <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
 <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
 <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com> <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
In-Reply-To: <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Mar 2019 10:41:22 +0100
Message-ID: <CAJZ5v0iCVhj-HmToGnSBuYE99LMn0BZpB-Ax48Aqh9hVc1+qwQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 5:06 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sun, 2019-03-03 at 22:51 +0100, Rafael J. Wysocki wrote:
> > On Sun, Mar 3, 2019 at 10:20 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Sun, 2019-03-03 at 18:03 +0100, Rafael J. Wysocki wrote:
> > > > On Fri, Mar 1, 2019 at 6:39 PM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > > > > Hi All,
> > > > > >
> > > > > > This is how I would fix the issue reported in BZ 200759 (see
> > > > > > thisdev
> > > > > > patch series
> > > > > > from Yu too:
> > > > > > https://marc.info/?l=linux-pm&m=155137672924029&w=2)
> > > > > > .
> > > > > >
> > > > > > Patch [1/2] causes intel_pstate to update all policies if it
> > > > > > gets
> > > > > > a
> > > > > > _PPC change
> > > > > > notification and sees a global turbo disable/enable change.
> > > > > >
> > > > > > Patch [2/2] makes it update cpuinfo.max_freq for all policies
> > > > > > in
> > > > > > those cases.
> > > > > >
> > > > > > The patches here have not been tested yet, so testing would
> > > > > > be
> > > > > > much
> > > > > > appreciated.
> > > > > >
> > > > > > Of course, comments are welcome too!
> > > > >
> > > > > This is the only platform, someone reported such issue.
> > > >
> > > > I don't think this matters.
> > > >
> > > > First, it doesn't mean that no other problems have this problem.
> > > >
> > > > Second, the current handling of
> > > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> > > > changes in intel_pstate is not sufficient if the changes is from
> > > > set
> > > > to unset anyway.
> > >
> > > Any platform with HWP, you can't even notify of this change. So any
> > > platform beyond SKL is not useful.
> >
> > Do you mean that HWP platforms don't supply _PPS (as a rule) and so
> > they don't send _PPC notifications?  Is there anything they do
> > instead
> > of it?
>
> There are other methods like PL1 budget limit for such cases. FW can
> just change the config TDP level.

OK, but that would be done without notification I suppose?

> > That's fair enough, but the point is that the driver doesn'dev_t do
> > the right thing even if the platform does send a _PPC notification.
>
> _PPC notification is to indicate levels in _PSS not to disable/enable
> turbo via IA32_MISC_*.

I was not talking about notifications, but about what the driver does
when MSR_IA32_MISC_ENABLE_TURBO_DISABLE is set or unset by FW on the
fly: this only really works if the change is from unset to set,
because the range of frequencies to use is restricted then, even
though user-visible policy limits are not updated.  However, if the
change is from set to unset, the update of policy limits is actually
necessary for the change to really take effect (otherwise the user
policy max prevents turbo frequencies from being requested).  HWP
seems to be affected too, for that matter, because the upper limit in
the MSR is not updated too then AFAICS.

> The platform could have just set _PPC to 1 or to TAR-1. Here _PPC is sent for somthing more than just changing _PSS max
> level. Do we have bug in if _PPC just changes performance level?

I think that we just need to live with the fact that _PPC may be
triggered for something more than changing _PSS max.

Note that the driver could trigger policy updates on
MSR_IA32_MISC_ENABLE_TURBO_DISABLE changes even without _PPC
notifications, but that would require more intrusive changes, because
work items cannot be queued up from scheduler context.  It would need
to use irq_work for that and with some extra synchronization etc, and
for the time being it looks like we can piggy back on the _PPC change
notification mechanism.
