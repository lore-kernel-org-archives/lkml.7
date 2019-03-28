Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFEBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B439B206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDx7PjXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfC1Aqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:46:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41261 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfC1Aqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:46:35 -0400
Received: by mail-io1-f66.google.com with SMTP id v10so5102149iom.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 17:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7apfFfokeZYVdIdRB9jlOBKYHSNg5753GpwFHi1Hb0=;
        b=lDx7PjXPgsFZipAu/NjljzVNVAXZM6mmq6XjVhWG0Blxbou6khob3BrkNFREjIKiL0
         wCh1nqkGeapPn3mGbJdoLlofRojJFiJXtOhO3jooY2MytWWNGPYJIgwKMNwBBjdK8TNq
         RI64d/MsJCJC4AcNlFII0oXh7OL4WyDQbfRhZJZdMjDbDgYYO0L/rz+rGorOAXZozzxW
         JWuvX1aS+Yt8px29INNdMC90DpVmyqyG8/9hvVCshU9sMKBkUj++voUiQ48xgyovPYwg
         xABCRWQykTySOVFE6IhToWW0oOpDjsExdrEaofmyH2pXZ0Jx1UfpjlJmeK/eoCZPgTr+
         GBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7apfFfokeZYVdIdRB9jlOBKYHSNg5753GpwFHi1Hb0=;
        b=JlTTbpstf8nj1TzASmxDS8n8v8UXItAbDuRoBobRDP7UKBZawllwz9jZWI+94bBEiH
         1whmRScRHjbw1e6UCkCuYQ1ld17IMbtiJEutqQx4pKka9i3hjEPcTRake4SfIR+SePjF
         VYjPn3xjEmM8VKNBPO6Xb0KWlsw9t/Qo+ZrxsXhlMB3VeFYzU87f+S6r1WwXwShy6fjT
         Vfn3YoJvnH7b1OT3QZUu+nT4Jw32uiEXy4sDPu3+VqSzCx2ap9Mcs1cf76xOGbaiiq1d
         M7fL8F1gXty6Z0BidrU/EpN9wrHmon0RF6tce0WZilZ7FaAGq4t0/QboOCFbvhFc68JS
         igxA==
X-Gm-Message-State: APjAAAU255wI/VuBnKnjRvGWJRkUXw6mnLpxD/GRCJNapDuZ4TpYWEyZ
        4aS/8hj2y8qG3faMv3T5D7oXKrlbk25suVESGUSX7A==
X-Google-Smtp-Source: APXvYqwFzmNrtM6m+BnUYb/6SRU2fGA/vPeAuFrUC1/ork2HmjOWKBYNC/HiY3ytIaG1siZlbjY0s3zR9R9Hrc3yr9U=
X-Received: by 2002:a6b:d119:: with SMTP id l25mr108512iob.278.1553733993895;
 Wed, 27 Mar 2019 17:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222844.134765-1-furquan@google.com> <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
 <CAEGmHFEqhh_xYaTXsVHqSgNW-1Ao6-mtk0BPhgu3-8ua6cCZ-Q@mail.gmail.com> <CAJZ5v0hxNA_KHjcqSL4XPpQpB1M4UuWJcYOknex=NOGavoooHA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hxNA_KHjcqSL4XPpQpB1M4UuWJcYOknex=NOGavoooHA@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 27 Mar 2019 17:46:21 -0700
Message-ID: <CAEGmHFHaFk6v=vcciU3QNaQfLriWSJtQ5QUjciY+O8dLh3DhJA@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Clear status of an event before enabling it
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
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

On Wed, Mar 27, 2019 at 5:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 21, 2019 at 3:16 AM Furquan Shaikh <furquan@google.com> wrote:
> >
> > On Wed, Mar 20, 2019 at 5:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan@google.com> wrote:
> > > >
> > > > Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > > > clearing ACPI IRQs during suspend/resume") was added to stop clearing
> > > > of event status bits unconditionally on suspend and resume paths. This
> > > > was done because of an issue
> > > > reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
> > > > lid status stays closed even on resume (which happens because event
> > > > status bits are cleared unconditionally on resume). Though this change
> > > > fixed the issue on suspend path, it introduced regressions on several
> > > > resume paths.
> > > >
> > > > First regression was reported and fixed on S5 path by the following
> > > > change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> > > > entering S5"). Next regression was reported and fixed on all legacy
> > > > sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> > > > events when entering sleep states"). However, regression still exists
> > > > on S0ix sleep path since it does not follow the legacy sleep path.
> > >
> > > What exactly is failing?
> >
> > Here is the failure scenario:
> >
> > 1. Consider the case of trackpad which acts as a wake source.
> > 2. Since the pad is configured for SCI, GPE_STS gets set for that pad
> > during normal interrupts as well (i.e. during probe at boot or when
> > using the trackpad)
>
> I don't quite understand this.
>
> Is the same GPE used for signaling trackpad events in the system
> working state and for wakeup?

Yes. The same pad is being configured for interrupts (i.e. routed to
APIC) during S0 as well as configured for GPE (i.e. routed for SCI) to
cause wakes when in S0ix/S3. This pad is externally connected to
trackpad interrupt line.

>
> > 3. Now, when the platform decides to enter S0ix, it enables the wake
> > on trackpad by enabling appropriate GPE_EN bit.
> > 4. So, at this point, we are in a situation where GPE_EN as well as
> > GPE_STS are set.
> > 5. Now, if the platform enters S0ix, having GPE_STS set will result in
> > unwanted wakes because of stale events.
> >
> > This is similar to what was fixed on the legacy sleep path:
> > https://lkml.org/lkml/2018/8/12/42. However, as S0ix does not follow
> > the legacy sleep path, clearing of GPE status does not happen. Thus,
> > it is causing failures to go into S0ix on our platforms because of the
> > stale wake events as described above.
> >
> > >
> > > > In case of S0ix, events are enabled as part of device suspend path. If
> > > > status bits for the events are set when they are enabled, it could
> > > > result in premature wake from S0ix. This change ensures that status is
> > > > cleared for any event that is being enabled so that any stale events
> > > > are cleared out.
> > > >
> > > > Signed-off-by: Furquan Shaikh <furquan@google.com>
> > > > ---
> > > >  drivers/acpi/acpica/evgpe.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
> > > > index 62d3aa74277b4..61455ab42fc87 100644
> > > > --- a/drivers/acpi/acpica/evgpe.c
> > > > +++ b/drivers/acpi/acpica/evgpe.c
> > > > @@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
> > > >
> > > >         ACPI_FUNCTION_TRACE(ev_enable_gpe);
> > > >
> > > > -       /* Enable the requested GPE */
> > > > +       /* Clear the GPE (of stale events) */
> > > > +       status = acpi_hw_clear_gpe(gpe_event_info);
> > > > +       if (ACPI_FAILURE(status))
> > > > +               return_ACPI_STATUS(status);
> > >
> > > Well, this may cause events to be missed.
> >
> > Won't those be stale events?
>
> They need not be stale, the device may have already detected some
> activity before the GPE is enabled.
>
> > i.e. any event that has occurred before GPE is enabled should be ignored.
>
> But this is a good point.
>
> >
> > >
> > > >
> > > > +       /* Enable the requested GPE */
> > > >         status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
> > > >         return_ACPI_STATUS(status);
> > > >  }
> > > > --
