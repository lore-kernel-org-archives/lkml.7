Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AB8C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F7F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555539074;
	bh=q1XR7/+I/uhh7vydXyIxyZjUhp3iukwS4YtTMXBwIl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oTrXQ8kxjmyrSfhBHG3ebu5NZTANc3DVV0UHUZwq0m9Hyl9WGMP5j7mPPqMfPvl0k
	 wHEwVX9BTqOdCZd5oCZtxNnMdij3KtUQ/9/lJTz1uyjsRE0OStmd19P1PWOq5p2Zsa
	 4Ic7oibxYCamB/NGWaeCTz9WDWzdzSHjuwbMQ/wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbfDQWLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:11:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43015 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQWLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:11:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id u15so2076otq.10;
        Wed, 17 Apr 2019 15:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/SMcLR60pTb8GHWCFJb8vDfzN0yXO1auw51WJ143aM=;
        b=MzLs64D21/i6dz4Wcp9rEEjaDTWXhDGx3GD3okENLrwdQzsmjRNz1BXr2K2j/mx1IE
         OqjZF/xjclhhALOp5XPeTZbuyO3zAy22O/dQgadXr1Ydg9Xtdc5lDGt/qiGvEgcX1E5Y
         INO1XLOWrskDaCyV3lncejoOlb3SBEgimITk6NUTZ4Jn7YmCht3k9bdBPNGjSDg4u3Nm
         kdOLKw1I3KY+T9UsWEadK0n8E82qbluq8IWz/bs9V5dCGrDiWPr8byRFO/QgAznK29FP
         RWV59BiO50rLO9SEJYFSGjDypmcRSixeX8729ZI8vJ4StELudID5m/MTCLBmjTpys01b
         kK3A==
X-Gm-Message-State: APjAAAXSSzxTUg9aiHDpvGu6tPIMlR/uUyGblFFVq/RiC67Eq0gStkZz
        DpL6kyy/Ed/98G6uxgG6aGpvG+JOC7L/X5s/uYs=
X-Google-Smtp-Source: APXvYqwpEt+M3lTny3H4KeeWmAXm8F5FWDSQQCr2VkvfpK+L+/tEWCct/7FaPolUgo95oM6Jr1OrfNQBaeewW+GrK48=
X-Received: by 2002:a05:6830:20cd:: with SMTP id z13mr57759947otq.168.1555539071987;
 Wed, 17 Apr 2019 15:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
 <d44f4893-0b67-4993-2942-6e03d29dffa1@amd.com> <CAJZ5v0jh0Yn1fy5bO3wett5AsjBA55_Z-8L_M8eRyy5cePqwaw@mail.gmail.com>
 <SN6PR12MB26396618BAC0F6600D786E08F8250@SN6PR12MB2639.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB26396618BAC0F6600D786E08F8250@SN6PR12MB2639.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Apr 2019 00:10:59 +0200
Message-ID: <CAJZ5v0hJpYROLJup0mvCp2G8ekeDyBrp+hdhHdsd+vhBq5RxVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] CPPC optional registers AMD support
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 7:28 PM Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Tuesday, April 16, 2019 4:34 AM
> > To: Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>
> > Cc: Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > pm@vger.kernel.org; devel@acpica.org; Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Viresh Kumar
> > <viresh.kumar@linaro.org>; Robert Moore <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>; Ghannam, Yazen
> > <Yazen.Ghannam@amd.com>
> > Subject: Re: [PATCH v2 0/7] CPPC optional registers AMD support
> >
> > On Tue, Apr 16, 2019 at 12:35 AM Janakarajan Natarajan <jnataraj@amd.com> wrote:
> > >
> > > On 4/4/19 4:25 PM, Natarajan, Janakarajan wrote:
> > > > CPPC (Collaborative Processor Performance Control) offers optional
> > > > registers which can be used to tune the system based on energy and/or
> > > > performance requirements.
> > > >
> > > > Newer AMD processors add support for a subset of these optional CPPC
> > > > registers, based on ACPI v6.1.
> > > >
> > > > The following are the supported CPPC registers for which sysfs entries
> > > > are created:
> > > > * enable                (NEW)
> > > > * max_perf              (NEW)
> > > > * min_perf              (NEW)
> > > > * energy_perf
> > > > * lowest_perf
> > > > * nominal_perf
> > > > * desired_perf          (NEW)
> > > > * feedback_ctrs
> > > > * auto_sel_enable       (NEW)
> > > > * lowest_nonlinear_perf
> > > >
> > > > The CPPC driver is updated to enable the OSPM and the userspace to
> > > > access
> > > > the newly supported registers.
> > > >
> > > > The purpose of exposing the registers via the sysfs entries is to allow
> > > > the userspace to:
> > > > * Tweak the values to fit its workload.
> > > > * Apply a profile from AMD's optimization guides.
> > > >
> > > > Profiles will be documented in the performance/optimization guides.
> > > >
> > > > Note:
> > > > * AMD systems will not have a policy applied in the kernel at this time.
> > > > * By default, acpi_cpufreq will still be used.
> > > >
> > > > TODO:
> > > > * Create a linux userspace tool that will help users generate a CPPC
> > > > * profile
> > > >    for their target workload.
> > > > * Create or update a driver to apply a general CPPC policy in the
> > > > * kernel.
> > > >
> > > > v1->v2:
> > > > * Add macro to ensure BUFFER only registers have BUFFER type.
> > > > * Add support macro to make the right check based on register type.
> > > > * Remove support checks for registers which are mandatory.
> > >
> > >
> > > Are there any concerns regarding this patchset?
> >
> > Yes, there are.
> >
> > Unfortunately, it is generally problematic.
> >
> > First off, the behavior of existing sysfs files cannot be changed at
> > will, as there may be users of them out there already depending on the
> > current behavior.
> >
>
> The intent is to add new sysfs files without changing the existing files. Is that okay?
>
> Or is the addition of new files also not acceptable?
>
> > Second, at least some CPPC control registers are used by cpufreq
> > drivers (cppc_cpufreq and intel_pstate), so modifying them behind the
> > drivers' backs is not a good idea in general.  For this reason, adding
> > new sysfs attributes to allow user space to do that is quite
> > questionable.
> >
>
> Yes, good point.
>
> What if a check is added so that writes only succeed if the CPUFREQ governor is set to userspace?

That wouldn't be particularly straightforward IMO.

What about handling this like the others do, through a proper cpufreq driver?
