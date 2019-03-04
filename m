Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F56206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551736676;
	bh=B1c82RDiRBA6yADmZPdzWHuCSVCYyT20r9ETpT0x/aQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c6qgdJqHtAhbIQRxm4qctRB4uXGr9CHTCWfU29oJ+LbBtj8kwaxmrUbwEwONuR96N
	 /TCudd49tPtZ/0GqvK+pR3s16wSgCfaMq1cAppWm6V+DjNPIXWIajz3VRl61o/T2wh
	 6TbnVICvrxWmX2TMhytmPiIq7Meker4lY3D03qrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfCDV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:57:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38219 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:57:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id m1so5608639otf.5;
        Mon, 04 Mar 2019 13:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNWd3hmUwWVU8rIqywJ4Dcs/vHh+1ZAUu7L3X3c+8m0=;
        b=r6hKjq0ujnH41OloOb5WAgoHAFgVISV/jcVJ6LpeQKvEmn1gokmzzuIZdsVY7OSqkf
         iRblpU0+Kc09DtCRUJi38lIvVKaZxTHbZap/EbHGxj/aLYYC+Ojcph1oK14vMOWZ4fBI
         2U1/T43pMl0BPvE2NrYo6V3U6PnR1IgvLbtW5teSyRwmeP+t2LSUVD/rctW8Tau3QG77
         y0D/1Y3UpjH9frNOLf9mCfVqPtMoT00gjyPe+L2vOqws+ofKSQZPbzBrIgB1oCRT6N5e
         oeIzomwG/cEWKZwQz7X/r9lbM2Rk/VK21ckgBrGHEJu8xMY19WGzHBdsvlB9a66kSrWz
         6cZw==
X-Gm-Message-State: APjAAAWHOyV1/qgSb8JShhlIslSvd82DwX+Pv0VEG+3xhO5Tbohp8J6L
        HAeeZmyEx4YQiN+/olyLr/60z/8qDxnT0I1sXbU=
X-Google-Smtp-Source: APXvYqzBU7uL6SOzu38vVYEMKWZTTIT8wUSXORA7q8C2BEsEFXLKtDIxu63+tR0isB/C+ZapqoskhLcoWx1WWR/RhTU=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr14196098otl.343.1551736672663;
 Mon, 04 Mar 2019 13:57:52 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
 <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
 <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
 <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com>
 <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
 <CAJZ5v0iCVhj-HmToGnSBuYE99LMn0BZpB-Ax48Aqh9hVc1+qwQ@mail.gmail.com> <9099672e17ea9fc7711b34e92ce5a016afb43a0c.camel@linux.intel.com>
In-Reply-To: <9099672e17ea9fc7711b34e92ce5a016afb43a0c.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Mar 2019 22:57:40 +0100
Message-ID: <CAJZ5v0jzRyz4gZFwJ36feppeEMEzOPJ5Y8weV3pz=+S5ijnEVw@mail.gmail.com>
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

On Mon, Mar 4, 2019 at 7:06 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> [...]
> > > There are other methods like PL1 budget limit for such cases. FW
> > > can
> > > just change the config TDP level.
> >
> > OK, but that would be done without notification I suppose?
>
> There is a notification via processor PCI device (B0D4). This is passed
> to user space to change the power limits. The new element is called
> PPCC and it is exposed via sysfs.

What do you mean by "new element" and how exactly is it exposed?

> Disabling turbo is not very interesting as there can be more turbo than
> non turbo. So you loose lots of performance. So instead you can control
> power in turbo region to give you more control. _PPC is even less
> interesting as you can't control uncore power.

I guess that designers should know about that.  The kernel is on the
receiving end here. :-)

> >
> > > > That's fair enough, but the point is that the driver doesn'dev_t
> > > > do
> > > > the right thing even if the platform does send a _PPC
> > > > notification.
> > >
> > > _PPC notification is to indicate levels in _PSS not to
> > > disable/enable
> > > turbo via IA32_MISC_*.
> >
> > I was not talking about notifications, but about what the driver does
> > when MSR_IA32_MISC_ENABLE_TURBO_DISABLE is set or unset by FW on the
> > fly: this only really works if the change is from unset to set,
> > because the range of frequencies to use is restricted then, even
> > though user-visible policy limits are not updated.  However, if the
> > change is from set to unset, the update of policy limits is actually
> > necessary for the change to really take effect (otherwise the user
> > policy max prevents turbo frequencies from being requested).  HWP
> > seems to be affected too, for that matter, because the upper limit in
> > the MSR is not updated too then AFAICS.
> >
> > > The platform could have just set _PPC to 1 or to TAR-1. Here _PPC
> > > is sent for somthing more than just changing _PSS max
> > > level. Do we have bug in if _PPC just changes performance level?
> >
> > I think that we just need to live with the fact that _PPC may be
> > triggered for something more than changing _PSS max.
>
> I understand the reason why you are doing the change. I investigated
> this bugzilla before. I was thinking can udev rules should be enough to
> address this issue. But it was not a requirement.
>
> The change itself is fine. Except may be hide the policy->rwsem in some
> header file instead of directly exposing to clients to use.

I'm not sure what you mean.

I guess that you are talking about intel_pstate_update_max_freq()
which acquires policy->rwsem.  If so, what exactly is the problem with
it?
