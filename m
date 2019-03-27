Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C242087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553689499;
	bh=xI0jbD7zwUHxQH0RJnlUR/ARVoWMzkD8RwnU4+DpmtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DLVizKkaVui2iFzBv5KsfwF9HflGQaCh/SldNbLFcdKbktG1x1WzsgFE3wk0RvgKq
	 TZPbmuPTN3W7fI0Y5gtwyGms8IKZR3W/fVwIE9wzFq4aUsq8MtTSEe/uyvvEwin4ok
	 y8VI4R5irlDO8rKefo06Rz+CQrx7aGokL0I0LTwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfC0MY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:24:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46564 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbfC0MY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:24:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id s24so5167642otk.13;
        Wed, 27 Mar 2019 05:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfFshy6yUmw3fn1e2kIixH6gRskdXAUXKGmi7EYRuEI=;
        b=hiMI5Gxftp2SXD1ZSOB/m9FBuk/Vt7Tx8H915RdmKyiZHxl9aDWqhFn+lp91HXIHhv
         rc+Nf0+R4h7XrFMrqnB1tghsQeX3azmRKvPp6AfveIiTw9xyF5/gnI5/rO5/w8r8jQ5Q
         GNuinvDfkyojDmLbgt+hhDmptyeWeZ1rmMf4REE6vvKbhcPbp0TL+jVNxb7VYgVasDQh
         wZDyVDxvgHFcdz476jfh71J+Cy0UhaWk2p8I8T/xbti+6R/yL61amLXupw50n94EnA7c
         QBbsoKozCLRlnTUg96rySxftpHvpLEGioOqs03X1PzzQzDzuzaUokIXGGMx77PbYDy1C
         XEhQ==
X-Gm-Message-State: APjAAAWSAWUAuqplBaBxMvDgoeIbFfMGyQ+vnE79fkBEXc4j7cf7hscI
        TaVZEVGe8BpIn8UPYFNGr8u8vxjkL87TH+I/WqE=
X-Google-Smtp-Source: APXvYqyoIoNq63WVvpibqVtzkWrXRXQgMOXJLlozmqg6phHPjDhn+7stdJYkXn2AuWa1j0OOOcGHhZnigV9Ne/1DwT8=
X-Received: by 2002:a05:6830:13cd:: with SMTP id e13mr27294998otq.139.1553689497441;
 Wed, 27 Mar 2019 05:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222844.134765-1-furquan@google.com> <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
 <CAEGmHFEqhh_xYaTXsVHqSgNW-1Ao6-mtk0BPhgu3-8ua6cCZ-Q@mail.gmail.com>
In-Reply-To: <CAEGmHFEqhh_xYaTXsVHqSgNW-1Ao6-mtk0BPhgu3-8ua6cCZ-Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Mar 2019 13:24:46 +0100
Message-ID: <CAJZ5v0hxNA_KHjcqSL4XPpQpB1M4UuWJcYOknex=NOGavoooHA@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Clear status of an event before enabling it
To:     Furquan Shaikh <furquan@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Evan Green <evgreen@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 3:16 AM Furquan Shaikh <furquan@google.com> wrote:
>
> On Wed, Mar 20, 2019 at 5:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan@google.com> wrote:
> > >
> > > Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > > clearing ACPI IRQs during suspend/resume") was added to stop clearing
> > > of event status bits unconditionally on suspend and resume paths. This
> > > was done because of an issue
> > > reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
> > > lid status stays closed even on resume (which happens because event
> > > status bits are cleared unconditionally on resume). Though this change
> > > fixed the issue on suspend path, it introduced regressions on several
> > > resume paths.
> > >
> > > First regression was reported and fixed on S5 path by the following
> > > change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> > > entering S5"). Next regression was reported and fixed on all legacy
> > > sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> > > events when entering sleep states"). However, regression still exists
> > > on S0ix sleep path since it does not follow the legacy sleep path.
> >
> > What exactly is failing?
>
> Here is the failure scenario:
>
> 1. Consider the case of trackpad which acts as a wake source.
> 2. Since the pad is configured for SCI, GPE_STS gets set for that pad
> during normal interrupts as well (i.e. during probe at boot or when
> using the trackpad)

I don't quite understand this.

Is the same GPE used for signaling trackpad events in the system
working state and for wakeup?

> 3. Now, when the platform decides to enter S0ix, it enables the wake
> on trackpad by enabling appropriate GPE_EN bit.
> 4. So, at this point, we are in a situation where GPE_EN as well as
> GPE_STS are set.
> 5. Now, if the platform enters S0ix, having GPE_STS set will result in
> unwanted wakes because of stale events.
>
> This is similar to what was fixed on the legacy sleep path:
> https://lkml.org/lkml/2018/8/12/42. However, as S0ix does not follow
> the legacy sleep path, clearing of GPE status does not happen. Thus,
> it is causing failures to go into S0ix on our platforms because of the
> stale wake events as described above.
>
> >
> > > In case of S0ix, events are enabled as part of device suspend path. If
> > > status bits for the events are set when they are enabled, it could
> > > result in premature wake from S0ix. This change ensures that status is
> > > cleared for any event that is being enabled so that any stale events
> > > are cleared out.
> > >
> > > Signed-off-by: Furquan Shaikh <furquan@google.com>
> > > ---
> > >  drivers/acpi/acpica/evgpe.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
> > > index 62d3aa74277b4..61455ab42fc87 100644
> > > --- a/drivers/acpi/acpica/evgpe.c
> > > +++ b/drivers/acpi/acpica/evgpe.c
> > > @@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
> > >
> > >         ACPI_FUNCTION_TRACE(ev_enable_gpe);
> > >
> > > -       /* Enable the requested GPE */
> > > +       /* Clear the GPE (of stale events) */
> > > +       status = acpi_hw_clear_gpe(gpe_event_info);
> > > +       if (ACPI_FAILURE(status))
> > > +               return_ACPI_STATUS(status);
> >
> > Well, this may cause events to be missed.
>
> Won't those be stale events?

They need not be stale, the device may have already detected some
activity before the GPE is enabled.

> i.e. any event that has occurred before GPE is enabled should be ignored.

But this is a good point.

>
> >
> > >
> > > +       /* Enable the requested GPE */
> > >         status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
> > >         return_ACPI_STATUS(status);
> > >  }
> > > --
