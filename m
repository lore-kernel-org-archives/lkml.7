Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD1DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A298420851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcqiGDCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCHTab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:30:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40417 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfCHTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:30:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so15068764lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmzsITCMPK4um1+ibn4CgaT5J8qoiXor28fB4dXe1gs=;
        b=CcqiGDCs2V6fYi+ttKMH5LEYZbFuj7r3EoK9tX6WDIiONd0BzrJqd1lqxc+Vs+dIzy
         IuPr6dYVpzWamMCHHyPPpKBD3v8ttHSICS1rVilvhYA5wOunnTXxcH9G8rA5IlPd+9fD
         lkiXdvcIBVA6VjOXcrLspYUFc8Jcorq7fjN7WXZO0LwGEiIdBRWGT4UXmD6VhSDmBScY
         +VVR9dl5eHH1aEI3Plczi0w+gkTR4dM3GJO6DH4NPVyESxrDmSU8B5XBk9DPFvAI0d/P
         x94siWE8p26nqT1vxRFq0p8yxZDIhTeF1594fqOA+c5WBS/bWVAsalxgr3XDB6Ldg5Gp
         e1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmzsITCMPK4um1+ibn4CgaT5J8qoiXor28fB4dXe1gs=;
        b=gVbr8Av+9M+dlr+qn7u45LO7NgwhXszY8B7fbZrcn/8N4KiCHsEyaRYbb2j5NOmCI0
         mR++2aMkqedH6MZOBX6rKhFCb3MiXB3JZr5iJ0BT7s6WUWzlItuE4vgjRqPBv/FzamaS
         uff7zaEMwLI7xkFwZ6gJKCPIJDgXk35e9FFOu/KTYO4mDs8p4XwXE2ToI8rWmJXJB9G/
         7Io8CIcRRvlJqx0AWbMjPYZ55Gdo+NUUealyXfkIOlRbubetpKe+ekAqnfJob8lmnNu0
         3M9nvve9eeLtcHVIBCkwhPEa8Z3jd34VzLGL0hbUpVxnCY6e3zJfEwvNEida7R9Aa+2q
         jMEA==
X-Gm-Message-State: APjAAAVjUoHWcLsVDFld61Cf5Ug/nglmdhOXj1xVTnzrNLbHlW9FPYr5
        pxhMZSGuOVsnZzMBIWC9p+2K7EoR9VwYXkYOUaQCiQ==
X-Google-Smtp-Source: APXvYqzbq5wykZ883iQq8qN/95y5bHgJsnoQciG0ROPvx3TSDtlFpZsmloEadrpx1Rfbuwb07B66A6KBKPuaKPUKqQE=
X-Received: by 2002:a19:28c7:: with SMTP id o190mr4615109lfo.43.1552073427360;
 Fri, 08 Mar 2019 11:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com> <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
 <20180730173345.GI1206094@devbig004.ftw2.facebook.com> <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
 <54d2b8e6-332b-117a-b982-77a535152246@redhat.com> <CACK8Z6GzOHJbh-M=0AxNbBoi3TqVehrs5xYsi2cUhW_dxz6vxg@mail.gmail.com>
 <3914af3f82d8aad8c22d814a20af4be654f8ad43.camel@linux.intel.com> <917a32a4-c806-af99-a9a3-246b28a5196a@redhat.com>
In-Reply-To: <917a32a4-c806-af99-a9a3-246b28a5196a@redhat.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 8 Mar 2019 11:29:50 -0800
Message-ID: <CACK8Z6GhBKKs7KVOZ50XrFQ2H3ps76uR8cpoohOHBSRkCOPsqA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, alan.cox@intel.com,
        "IDE/ATA development list" <linux-ide@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:57 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 08-03-19 01:04, Srinivas Pandruvada wrote:
> > On Thu, 2019-03-07 at 15:07 -0800, Rajat Jain wrote:
> >> Hello,
> >>
> >> On Thu, Mar 7, 2019 at 12:37 PM Hans de Goede <hdegoede@redhat.com>
> >> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 07-03-19 21:27, Gwendal Grignou wrote:
> >>>> Srinivas,
> >>>>
> >>>> I am looking at problem on a laptop machine that suspends to
> >>>> S01x, but
> >>>> link_management is set to max_performance, because the machine is
> >>>> connected to a charger.
> >>>
> >>> What is setting it to max_performance when charging?  I assume
> >>> chrome-os is
> >>> running something in userspace to do this (like TLP, but I guess
> >>> you are not
> >>> using TLP) ?
> >>
> >> Yes, we have a udev script that does this.
> >>
> >>>
> >>> Have you run benchmarks with max_performance vs the default?
> >>> I seriously doubt there will be a significant difference, esp.
> >>> with a chrome-os style workload.
> >>>
> >>>> Given DVLSP must be set before the laptop suspends ["""One of the
> >>>> requirement for modern x86 system to enter lowest power
> >>>> mode  (SLP_S0)
> >>>> is SATA IP block to be off."""], the machine never reaches S01x.
> >>>> Does it make sense to change the target_lpm_policy at suspend
> >>>> (ata_port_suspend()) to min_power and bring it back to the
> >>>> original
> >>>> value on resume?
> >>>
> >>> If userspace messes with the setting, then userspace should also
> >>> put it back before suspending...
> >>>
> >>> The upstream kernel's default behavior is to have the target level
> >>> set
> >>> to a fixed level independent of the charging state. Could it be
> >>> this
> >>> fixed level is actually max-performance ? If that is the default
> >>> the
> >>> kernel comes up with, that would indicate a kernel bug.
> >>
> >> Side note: max-performance indeed can be the default forced by the
> >> kernel for some (broken) SATA devices:
> >>
> >>          if (dev->horkage & ATA_HORKAGE_NOLPM) {
> >>                  ata_dev_warn(dev, "LPM support broken, forcing
> >> max_power\n");
> >>                  dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
> >>          }
> >>
> >> So definitely these systems won't be able to go into S0ix today.
> >>
> >> But I think the main idea that we are asking is:
> >>
> >> 1) Yes, we acknowledge that the userspace has set it max-performance.
> >>
> >> 2) However, given that the kernel already knows that:
> >>         - while in suspend, there is no real value in retaining the
> >> max-performance.
> >>         - On the contrary, we know system will fail to go into lower
> >> power mode because of max-suspend.
> >>
> >> 3) Does it not make sense to use this knowledge and switch to
> >> min_power when we are actually going to suspend (even if user
> >> specified max-performance), and restore max-performance on resume?
> >
> > It is all about regressions. Hence we added multiple conditions for
> > setting default to min power.
> > It may cause issues for some SATAs, which may not recover once enters
> > slumber or DEVSLP. There is also case where user having issues with
> > default LPM policy hence he changed policy to max performance. We can't
> > detect that.
> > So it will be much safer if user space change policy to default before
> > calling suspend.

Now I understand, and agree.

>
> Right, or simply do not mess with the setting in the first place!
>
> I noticed you did not answer this part of my original reply:
>
> "Have you run benchmarks with max_performance vs the default?
> I seriously doubt there will be a significant difference, esp.
> with a chrome-os style workload."
>
> I seriously doubt the max-performance setting has a user
> noticeable impact on performance. So I repeat has someone
> actually measured this with real-world chrome-os workloads ?

The reason we're setting it to max-performance is not really
performance - but as a work around to a broken SATA device (Transcend
SSD) that can't handle DEVSLP in active state (similar to what
Srinivas said). Putting it to min_power while suspended was OK because
it'd be in reset anyway at that time. Thanks for your explanations and
help.

Rajat


>
> Regards,
>
> Hans
>
