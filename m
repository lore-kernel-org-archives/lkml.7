Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB38C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F17218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5vcZXWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfCUCQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:16:21 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55753 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:16:20 -0400
Received: by mail-it1-f194.google.com with SMTP id z126so2114352itd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 19:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GEtIscopF9TJ/61Pptrydo8k5Yuaic+jv+1XcIshqg=;
        b=J5vcZXWmGrzS4udQxzOdLyPMxyRjOjH7t8HnBYmnYCvDvDNwQTenP5Dre4Ti+vUajN
         W/tG9Iesn4TE4Of9yS8cfskAjqUEuC+wr1R27RgZyrmPO8bjYJWP4pkeRkwhHQc9Xqor
         zjb1lU9I9gwtT1PovemHN1YYu9NQRQsH7P+2U/IiEjfgqAqrmKtqSYyHAPtvWhP2Mj+4
         Lu3DO4vMHIIVaZnYivNPpCV9dE9ESz8U4dpiiadinKXM2iOJ+n2xpleYprjEWoCjPuzy
         WDiefNO7m6FPul7iZzuzpyiqhMDKteY7N496ii0MyvU3cKzcjmiRfsClD8obyuM48Dlm
         Vefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GEtIscopF9TJ/61Pptrydo8k5Yuaic+jv+1XcIshqg=;
        b=g0NahezSz/iFuNCCftO5YL1wka8uNqs0c96x82/n3bRmxJX0LxemkrIFYD4HccsdRA
         LpFX7fgzyo8INhBrgL9aCzIGg9wD5fMJA24UYNygtzBniwsk4amSXecU91OGsfdPtHx2
         d81jJpT4EIAHPIuva5gGvx5hbMnXosjIHE8pIHmpZEJfBdV9jkzpnQa42eHincIc7hEj
         8qSb0emaeBJwrbStf3epJYHMdvZO2lefuSdtV96+fUiTn1L3pJxpDQhx472JzVmowMUt
         VVtFWI6klohVy4WE8it47Qds0KQmcqP1wOMDGomAkvlcPrOypfMBlJ6Wil7DhSZoBs66
         J7Bg==
X-Gm-Message-State: APjAAAV8vuOmqr6TC+uN0V2vJIt36tvjxg+WjsifkqmpKmdBxGb8iLtI
        xWg4N3W1Dm7FXfHDqcgEqonK2UTVn4VjBdjbMIUN4g==
X-Google-Smtp-Source: APXvYqwPw6CoRmrvVLgt57ePisGLXLFvZu0oZI4yJIoRnN8+ErLYE/UyUG4MaX3acADLAb7D6zsFwiMdYZCJcK6kDXg=
X-Received: by 2002:a05:660c:3cf:: with SMTP id c15mr995985itl.52.1553134579324;
 Wed, 20 Mar 2019 19:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222844.134765-1-furquan@google.com> <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
In-Reply-To: <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 20 Mar 2019 20:16:08 -0600
Message-ID: <CAEGmHFEqhh_xYaTXsVHqSgNW-1Ao6-mtk0BPhgu3-8ua6cCZ-Q@mail.gmail.com>
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

On Wed, Mar 20, 2019 at 5:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan@google.com> wrote:
> >
> > Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > clearing ACPI IRQs during suspend/resume") was added to stop clearing
> > of event status bits unconditionally on suspend and resume paths. This
> > was done because of an issue
> > reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
> > lid status stays closed even on resume (which happens because event
> > status bits are cleared unconditionally on resume). Though this change
> > fixed the issue on suspend path, it introduced regressions on several
> > resume paths.
> >
> > First regression was reported and fixed on S5 path by the following
> > change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> > entering S5"). Next regression was reported and fixed on all legacy
> > sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> > events when entering sleep states"). However, regression still exists
> > on S0ix sleep path since it does not follow the legacy sleep path.
>
> What exactly is failing?

Here is the failure scenario:

1. Consider the case of trackpad which acts as a wake source.
2. Since the pad is configured for SCI, GPE_STS gets set for that pad
during normal interrupts as well (i.e. during probe at boot or when
using the trackpad)
3. Now, when the platform decides to enter S0ix, it enables the wake
on trackpad by enabling appropriate GPE_EN bit.
4. So, at this point, we are in a situation where GPE_EN as well as
GPE_STS are set.
5. Now, if the platform enters S0ix, having GPE_STS set will result in
unwanted wakes because of stale events.

This is similar to what was fixed on the legacy sleep path:
https://lkml.org/lkml/2018/8/12/42. However, as S0ix does not follow
the legacy sleep path, clearing of GPE status does not happen. Thus,
it is causing failures to go into S0ix on our platforms because of the
stale wake events as described above.

>
> > In case of S0ix, events are enabled as part of device suspend path. If
> > status bits for the events are set when they are enabled, it could
> > result in premature wake from S0ix. This change ensures that status is
> > cleared for any event that is being enabled so that any stale events
> > are cleared out.
> >
> > Signed-off-by: Furquan Shaikh <furquan@google.com>
> > ---
> >  drivers/acpi/acpica/evgpe.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
> > index 62d3aa74277b4..61455ab42fc87 100644
> > --- a/drivers/acpi/acpica/evgpe.c
> > +++ b/drivers/acpi/acpica/evgpe.c
> > @@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
> >
> >         ACPI_FUNCTION_TRACE(ev_enable_gpe);
> >
> > -       /* Enable the requested GPE */
> > +       /* Clear the GPE (of stale events) */
> > +       status = acpi_hw_clear_gpe(gpe_event_info);
> > +       if (ACPI_FAILURE(status))
> > +               return_ACPI_STATUS(status);
>
> Well, this may cause events to be missed.

Won't those be stale events? i.e. any event that has occurred before
GPE is enabled should be ignored.

>
> >
> > +       /* Enable the requested GPE */
> >         status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
> >         return_ACPI_STATUS(status);
> >  }
> > --
> > 2.21.0.225.g810b269d1ac-goog
> >
