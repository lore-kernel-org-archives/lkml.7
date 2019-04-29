Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511A7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146FD2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqTTfZ8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfD2ReE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:34:04 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34813 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2ReE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:34:04 -0400
Received: by mail-vs1-f66.google.com with SMTP id n17so6410254vsr.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oRI/yWgrQc4mohswqM3B8q6VlrbjFTkbV3C0nqXm/N8=;
        b=SqTTfZ8xJPeqYmNsfZX4+7c7BOKZ+w14+xT/g9LA4jEOJ/AvzuukBOxc/w4W9/ar0o
         u8eRsIF7UgmNV6PzwCkEO/jDyOCF7AdfB53c0wLmmIMl3EBzBwHOvZCTQZZzvDgy3SjA
         fS3NhoZs4IM+X4Jzf5r4xVFETZvFgAFmXfZfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oRI/yWgrQc4mohswqM3B8q6VlrbjFTkbV3C0nqXm/N8=;
        b=tClXUb9TKrJfSSAgDwspUimYVWDHwTBLFM5wiTCDZMxaorCdcMswtQ4hRJGy+oOHgz
         VpLk4/P8IkuNWV2rTYTYGgpwcv27hDlqof3Hkd3sFRkyUxH9yhyzPn9ue0xV9wncY/QF
         otcjYeANyp0XRt601dvd6j42oDfgfokuRHyjNboxsvxXfebEERxMnLe/TOD7drEzpbyp
         bkgDYXpSqO6CgzUf8ixT228tVDP6SbCkMlbVOkE9jv/1boDzICe1eiruQSjmQjnVu5N8
         TZUQR6QFW+f7cdviYiS6z34p1nEgWzVsHNjnhyc6OQ1JpAExK/4rQmhuxQb2hZJN/3p7
         5SBg==
X-Gm-Message-State: APjAAAVyIXFRYTI6ZeuP78cb1SiRD/r7tnCyraEoIReaZkVcXr0g+wIj
        U7+AjB93WxdufMDeEz8z814MhvheUcw=
X-Google-Smtp-Source: APXvYqyhpZ3Rw/n1CShhoiHz5VDps20GNJRjC9Ofq9x2h/fTi2Exit+qhOtBePW4L3IgavevUByX/A==
X-Received: by 2002:a67:78c5:: with SMTP id t188mr33183190vsc.107.1556559242049;
        Mon, 29 Apr 2019 10:34:02 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id s16sm4106577vks.39.2019.04.29.10.34.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 10:34:00 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id o10so6353272vsp.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:34:00 -0700 (PDT)
X-Received: by 2002:a67:bc01:: with SMTP id t1mr33891102vsn.149.1556559239606;
 Mon, 29 Apr 2019 10:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org> <SN1PR12MB243108D1EF3239EC4F730ACDA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB243108D1EF3239EC4F730ACDA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Apr 2019 10:33:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UOmfNeuZPrDcZRdwAkF4yRifCpBGUuZTsmmz0UVEZ+yA@mail.gmail.com>
Message-ID: <CAD=FV=UOmfNeuZPrDcZRdwAkF4yRifCpBGUuZTsmmz0UVEZ+yA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with DWC2_POWER_DOWN_PARAM_NONE
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        "amstan@chromium.org" <amstan@chromium.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>,
        "zyw@rock-chips.com" <zyw@rock-chips.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "ryandcase@chromium.org" <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "jwerner@chromium.org" <jwerner@chromium.org>,
        "dinguyen@opensource.altera.com" <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 29, 2019 at 1:43 AM Artur Petrosyan
<Arthur.Petrosyan@synopsys.com> wrote:
>
> Hi,
>
> On 4/18/2019 04:15, Douglas Anderson wrote:
> > This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add bus
> > suspend/resume for dwc2") on ToT.  That commit was reverted in commit
> > b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2"")
> > because apparently it broke the Altera SOCFPGA.
> >
> > With all the changes that have happened to dwc2 in the meantime, it's
> > possible that the Altera SOCFPGA will just magically work with this
> > change now.  ...and it would be good to get bus suspend/resume
> > implemented.
> >
> > This change is a forward port of one that's been living in the Chrome
> > OS 3.14 kernel tree.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This patch was last posted at:
> >
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.org_=
r_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=
=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqr=
C_D7niMJI&m=3DMMfe-4lZePyty6F5zfQ54kiYGuJWNulyRat944LkOsc&s=3DnExFpAPP_0plZ=
fO5LMG1B-mqt1vyCvE35elVcyVgs8Y&e=3D
> >
> > ...and appears to have died the death of silence.  Maybe it could get
> > some bake time in linuxnext if we can't find any proactive testing?
> >
> > I will also freely admit that I don't know tons about the theory
> > behind this patch.  I'm mostly just re-hashing the original commit
> > from Kever that was reverted since:
> > * Turning on partial power down on rk3288 doesn't "just work".  I
> >    don't get hotplug events.  This is despite dwc2 auto-detecting that
> >    we are power optimized.
> What do you mean by doesn't "just work" ? It seem to me that even after
> adding this patch you don't get issues fixed.
> You mention that you don't get the hotplug events. Please provide dwc2
> debug logs and register dumps on this issue.

I mean that partial power down in the currently upstream driver
doesn't work.  AKA: if I turn on partial power down in the upstream
driver then hotplug events break.  I can try to provide some logs.  On
what exact version of the code do you want logs?  Just your series?
Just my series?  Mainline?  Some attempt at combining both series?  As
I said things seem to sorta work with the combined series.  I can try
to clarify if that's the series you want me to test with.  ...or I can
wait for your next version?


> > @@ -4506,21 +4507,35 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hc=
d)
> >        */
> >       if (!hsotg->bus_suspended) {
> >               hprt0 =3D dwc2_read_hprt0(hsotg);
> > -             hprt0 |=3D HPRT0_SUSP;
> > -             hprt0 &=3D ~HPRT0_PWR;
> > -             dwc2_writel(hsotg, hprt0, HPRT0);
> > -             spin_unlock_irqrestore(&hsotg->lock, flags);
> > -             dwc2_vbus_supply_exit(hsotg);
> > -             spin_lock_irqsave(&hsotg->lock, flags);
> > +             if (hprt0 & HPRT0_CONNSTS) { > +                        h=
prt0 |=3D HPRT0_SUSP;
> Here you set "HPRT0_SUSP" bit but what if core doesn't support both
> hibernation and Partial Power down assuming that
> hsotg->params.power_down" value us equal to "DWC2_POWER_DOWN_PARAM_NONE"
> which is 0.

I am by no means an expert on dwc2, but an assumption made in my patch
is that even cores that can't support partial power down can still
save some amount of power when hcd_suspend is called.

Some evidence that this should be possible: looking at mainline Linux
and at dwc2_port_suspend(), I see:

* It is currently called even when we have DWC2_POWER_DOWN_PARAM_NONE

* It currently sets HPRT0_SUSP

* It currently sets PCGCTL_STOPPCLK specifically in the case where
power down is DWC2_POWER_DOWN_PARAM_NONE.

...I believe that the net effect of my patch ends up doing both those
same two things in hcd_suspend.  That is: when power_down is
DWC2_POWER_DOWN_PARAM_NONE I believe my patch is really just doing the
same thing that dwc2_port_suspend() would do in the same case.  Is
that not OK?



> > +                     if (hsotg->params.power_down =3D=3D DWC2_POWER_DO=
WN_PARAM_PARTIAL)
> You make one checking of hsotg->params.power_down mode here.
> > +                             hprt0 &=3D ~HPRT0_PWR;
> > +                     dwc2_writel(hsotg, hprt0, HPRT0);
> > +             }
> > +             if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM=
_PARTIAL) {
> another checking of power_down mode here.

Yeah, we can debate about how to best share/split code.  I'm not in
love with the current structure either.  When I rebased your patches
atop mine I changed this to more fully split them and I agree that was
better.


> > @@ -4592,10 +4612,12 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd=
)
> >               spin_unlock_irqrestore(&hsotg->lock, flags);
> >               dwc2_port_resume(hsotg);
> >       } else {
> > -             dwc2_vbus_supply_init(hsotg);
> > +             if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM=
_PARTIAL) {
> > +                     dwc2_vbus_supply_init(hsotg);
> >
> > -             /* Wait for controller to correctly update D+/D- level */
> > -             usleep_range(3000, 5000);
> > +                     /* Wait for controller to correctly update D+/D- =
level */
> > +                     usleep_range(3000, 5000);
> > +             }
> >
> >               /*
> >                * Clear Port Enable and Port Status changes.
> >
>
> I have tested the patch on HAPS-DX. With this patch or without it when I
> have a device connected core  enters to partial power down and doesn't
> exit from it. So I cannot use the device.

Can you explain what HAPS-DX is?


-Doug
