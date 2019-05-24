Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77645C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E442175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlQveNqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbfEXQbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:31:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36879 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390392AbfEXQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:31:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id p15so4381827pll.4;
        Fri, 24 May 2019 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SbEPxSc3I9t4ZXFty6TOIoP4vL3V/mhx3yZoaGSreo=;
        b=GlQveNqrq65wwhA4ieUT9aYptmfo7DDk7kZsOPsenXJoyymP8EW2oqHg4Ml8/3MChv
         Rk26pdLUgacRyUSwRU5Vli1itjAwjxUP8dpy/hF0LYe91eSyh93RklAZOtrePW07t4Wj
         AO4EQ4Wi0bF+Z5609+Ivos/VCDTS8RF6fs0wSDNQZfexOWJ7Gds++zNzKA9xQxVub2/G
         AgTV+WWZPwYVLlOVKev8Z0NuqgxC2ke/Z9LOlT2sMcWjHMmZJthTibU6z3JrVp5qaYJv
         2uxmKXCSnWi3iJei8Qsp3Vx6Do6adEetf1+MvMbEPDmzmubBQDiC3Rkjb2Y4U/QvR6F2
         4URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SbEPxSc3I9t4ZXFty6TOIoP4vL3V/mhx3yZoaGSreo=;
        b=EToL5/H2jXOnzxF49v2o3V6qO8f19401xobMgyj834JKtIq0h3G1G08CfazGcPqAJs
         9eCKzSP/dfE1r20pyj35kDmlqhFtiDhhRIojlyhRO9ixT0c6jmqphCxJYv+Wkf8GS/8M
         Bb7mq31SdOkFM3ZI+aDW85vHuAT3y9lYgHUb3fHJ8mRmOIblQztmATIqIUQ8bkSgiL5i
         58Gk/tQK/+Sjk7gpgsSX7/IO5EGs37WHjHrs/h4K7lYtf17M8Ztu3UDBX5EDk6K0agLE
         M0QK8mdHDaacxbLtNrEA1v9Ko1SCxOcSr5amBzU0uj6aEIx6PZ8qdzBwG7sseCEV5i/p
         RZmQ==
X-Gm-Message-State: APjAAAUxSCIUsjoOdbdhV59ajbf7dA906IMZQo6yJnRZOgqPC1jPHW/m
        ycCz9vgawVl9CpJM7adGXBpgE7AgPHwecVaXIKzCdkkipcA=
X-Google-Smtp-Source: APXvYqyfIsWqcIjwlEhAaUOL1D7Git4IbxuJL/FO7WdnNTDUNfF9A6xrslrJUF9+OPD2qFwXrrjhqkm7DEAzbJU3nnM=
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10mr109769533plb.18.1558715481196;
 Fri, 24 May 2019 09:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190520224124.153005-1-mathewk@chromium.org> <CAK+PMK47_OE-BgOYD_TD0kwxD4RG+nS9Wstg4ydUy7yV9nVmHQ@mail.gmail.com>
 <a7a23cbea93d46b48f7c9bd4e4cd4314@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <a7a23cbea93d46b48f7c9bd4e4cd4314@AUSX13MPC105.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 May 2019 19:31:10 +0300
Message-ID: <CAHp75VdQs-e0F-MHk3bX3Csp6cGCf5mYJLdVVTBc3i3S8ExgmA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel-vbtn: Report switch events when
 event wakes device
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     jettrink@chromium.org, mathewk@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 4:43 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Jett Rink <jettrink@chromium.org>
> > Sent: Tuesday, May 21, 2019 8:37 AM
> > To: Mathew King
> > Cc: linux-kernel; AceLan Kao; Andy Shevchenko; Darren Hart; platform-driver-
> > x86@vger.kernel.org; Limonciello, Mario
> > Subject: Re: [PATCH v2] platform/x86: intel-vbtn: Report switch events when event
> > wakes device
> >
> >

Pushed to my review and testing queue, thanks!

> > [EXTERNAL EMAIL]
> >
> > On Mon, May 20, 2019 at 4:41 PM Mathew King <mathewk@chromium.org>
> > wrote:
> > >
> > > When a switch event, such as tablet mode/laptop mode or docked/undocked,
> > > wakes a device make sure that the value of the swich is reported.
> > > Without when a device is put in tablet mode from laptop mode when it is
> > > suspended or vice versa the device will wake up but mode will be
> > > incorrect.
> > >
> > > Tested by suspending a device in laptop mode and putting it in tablet
> > > mode, the device resumes and is in tablet mode. When suspending the
> > > device in tablet mode and putting it in laptop mode the device resumes
> > > and is in laptop mode.
> > >
> > > Signed-off-by: Mathew King <mathewk@chromium.org>
> > >
> > > ---
> > > Changes in v2:
> > >   - Added comment explaining why switch events are reported
> > >   - Format so that checkpatch is happy
> > > ---
> > >  drivers/platform/x86/intel-vbtn.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> > > index 06cd7e818ed5..a0d0cecff55f 100644
> > > --- a/drivers/platform/x86/intel-vbtn.c
> > > +++ b/drivers/platform/x86/intel-vbtn.c
> > > @@ -76,12 +76,24 @@ static void notify_handler(acpi_handle handle, u32
> > event, void *context)
> > >         struct platform_device *device = context;
> > >         struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
> > >         unsigned int val = !(event & 1); /* Even=press, Odd=release */
> > > -       const struct key_entry *ke_rel;
> > > +       const struct key_entry *ke, *ke_rel;
> > >         bool autorelease;
> > >
> > >         if (priv->wakeup_mode) {
> > > -               if (sparse_keymap_entry_from_scancode(priv->input_dev, event)) {
> > > +               ke = sparse_keymap_entry_from_scancode(priv->input_dev, event);
> > > +               if (ke) {
> > >                         pm_wakeup_hard_event(&device->dev);
> > > +
> > > +                       /*
> > > +                        * Switch events like tablet mode will wake the device
> > > +                        * and report the new switch position to the input
> > > +                        * subsystem.
> > > +                        */
> > Thanks for adding the comment; This looks good to me.
> >
> > > +                       if (ke->type == KE_SW)
> > > +                               sparse_keymap_report_event(priv->input_dev,
> > > +                                                          event,
> > > +                                                          val,
> > > +                                                          0);
> > >                         return;
> > >                 }
> > >                 goto out_unknown;
> > > --
> > > 2.21.0.1020.gf2820cf01a-goog
> > >
> >
> > Reviewed-by: Jett Rink <jettrink@chromium.org>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>



-- 
With Best Regards,
Andy Shevchenko
