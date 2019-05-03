Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD536C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF62070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mx0fWWvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfECPDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:03:47 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34820 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfECPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:03:47 -0400
Received: by mail-vs1-f65.google.com with SMTP id r23so1624950vsq.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/2zB92Wp7OJKMoHTQAGZBoeHpTeZv+wAfkk5Wp8/82I=;
        b=Mx0fWWvVhpczsqJaUFU1eRmw+T3uPX1WqlKj2E7W8b/n99kkVbfP9JspiOpaZLUVky
         in5uLVHMBmxQRyX50+F0j6bFQTxfVZ/jJoVP2mwPVT0u36RZoq28wxcG52d6z1fhpbD4
         Ow0i4UBsPq0npH8UFycS+tjrjwkRFr5GtuViw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/2zB92Wp7OJKMoHTQAGZBoeHpTeZv+wAfkk5Wp8/82I=;
        b=gqyDQmQr0ZOP5Gq1iNCbuSduBOTbxLhrLYhldNs/pesemgFs9xthb+DM4GAF4z5sDN
         /LQVTscYYduXBZUH24PnySn8Kwtub7mWymrLfReKf2RhLZ94uxki9ELsLGp3wLHKKTGZ
         AqR+oy+9fG9+38KX9qmedH5PJg2taors3zSn9u1ypCzNa+/t87338mJ0xidfa+T1/FW8
         y2ESSXOMuSUGx2TOTHfrQUzAj55kLF08/wj9kXrGJdJxpDR4qjrxsqntmOOC9sPlHvrg
         CxSU3BySCBbQZAcnTqGTouSMXFdjUAaBEIjyMFLSApKq+j7zCXamUs23cr8labSXkluy
         4egw==
X-Gm-Message-State: APjAAAUCCPF70Us/cJ9ny8pj5e7m/K6Wk9vaA0LapAc24G8MwK128ubQ
        6eQTniQtLYqBliczyQtWM2LZqU1G30g=
X-Google-Smtp-Source: APXvYqwOjb2Xu292XQ69owbM2tf26N39M+roXIYVjHaIGZXe2rokVQIoOg38ih96CbBl9lOAIGMOhg==
X-Received: by 2002:a67:7f85:: with SMTP id a127mr5727777vsd.141.1556895823498;
        Fri, 03 May 2019 08:03:43 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id c192sm1735121vka.10.2019.05.03.08.03.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 08:03:39 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id g187so3777484vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 08:03:37 -0700 (PDT)
X-Received: by 2002:a67:d29e:: with SMTP id z30mr5820475vsi.111.1556895816252;
 Fri, 03 May 2019 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org> <SN1PR12MB243108D1EF3239EC4F730ACDA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=UOmfNeuZPrDcZRdwAkF4yRifCpBGUuZTsmmz0UVEZ+yA@mail.gmail.com>
 <SN1PR12MB24317F315C5A4DFE70F9CB0DA73A0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=UWGOWiCpy5qUY8oFHPyxdYJe7OsdWBDuCNcXBu5BJoGA@mail.gmail.com> <SN1PR12MB243156982D5BD74F11680597A7350@SN1PR12MB2431.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB243156982D5BD74F11680597A7350@SN1PR12MB2431.namprd12.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 May 2019 08:03:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzsKe5n_ThcrByW79UznpkmHf0YNRNKH8G3eFtUSsYZQ@mail.gmail.com>
Message-ID: <CAD=FV=XzsKe5n_ThcrByW79UznpkmHf0YNRNKH8G3eFtUSsYZQ@mail.gmail.com>
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

On Fri, May 3, 2019 at 1:20 AM Artur Petrosyan
<Arthur.Petrosyan@synopsys.com> wrote:
>
> On 5/1/2019 05:57, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Apr 29, 2019 at 11:06 PM Artur Petrosyan
> > <Arthur.Petrosyan@synopsys.com> wrote:
> >>
> >> Hi,
> >>
> >> On 4/29/2019 21:34, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Mon, Apr 29, 2019 at 1:43 AM Artur Petrosyan
> >>> <Arthur.Petrosyan@synopsys.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 4/18/2019 04:15, Douglas Anderson wrote:
> >>>>> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add b=
us
> >>>>> suspend/resume for dwc2") on ToT.  That commit was reverted in comm=
it
> >>>>> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2""=
)
> >>>>> because apparently it broke the Altera SOCFPGA.
> >>>>>
> >>>>> With all the changes that have happened to dwc2 in the meantime, it=
's
> >>>>> possible that the Altera SOCFPGA will just magically work with this
> >>>>> change now.  ...and it would be good to get bus suspend/resume
> >>>>> implemented.
> >>>>>
> >>>>> This change is a forward port of one that's been living in the Chro=
me
> >>>>> OS 3.14 kernel tree.
> >>>>>
> >>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>>> ---
> >>>>> This patch was last posted at:
> >>>>>
> >>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.=
org_r_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org=
&d=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzY=
qrC_D7niMJI&m=3DMMfe-4lZePyty6F5zfQ54kiYGuJWNulyRat944LkOsc&s=3DnExFpAPP_0p=
lZfO5LMG1B-mqt1vyCvE35elVcyVgs8Y&e=3D
> >>>>>
> >>>>> ...and appears to have died the death of silence.  Maybe it could g=
et
> >>>>> some bake time in linuxnext if we can't find any proactive testing?
> >>>>>
> >>>>> I will also freely admit that I don't know tons about the theory
> >>>>> behind this patch.  I'm mostly just re-hashing the original commit
> >>>>> from Kever that was reverted since:
> >>>>> * Turning on partial power down on rk3288 doesn't "just work".  I
> >>>>>      don't get hotplug events.  This is despite dwc2 auto-detecting=
 that
> >>>>>      we are power optimized.
> >>>> What do you mean by doesn't "just work" ? It seem to me that even af=
ter
> >>>> adding this patch you don't get issues fixed.
> >>>> You mention that you don't get the hotplug events. Please provide dw=
c2
> >>>> debug logs and register dumps on this issue.
> >>>
> >>> I mean that partial power down in the currently upstream driver
> >>> doesn't work.  AKA: if I turn on partial power down in the upstream
> >>> driver then hotplug events break.  I can try to provide some logs.  O=
n
> >>> what exact version of the code do you want logs?  Just your series?
> >>> Just my series?  Mainline?  Some attempt at combining both series?  A=
s
> >>> I said things seem to sorta work with the combined series.  I can try
> >>> to clarify if that's the series you want me to test with.  ...or I ca=
n
> >>> wait for your next version?
> >> As I said this patch doesn't fix the issue with hotplug. With this pat=
ch
> >> or without the hotplug behaves as it was. I have tested it on our setu=
p.
> >>
> >> Have you debugged your patch? Does it make any difference on your setu=
p
> >> ? Does it fix the issue with hotplug?
> >
> > I think we're still not taking on the same page.
> >
> > My patch makes no attempt to make partial power down mode work.  My
> > patch attempts to make things work a little better when using
> > DWC2_POWER_DOWN_PARAM_NONE.  There is no use testing my patch with
> > partial power down as it shouldn't have any impact there.
> >
> >
> >>> I am by no means an expert on dwc2, but an assumption made in my patc=
h
> >>> is that even cores that can't support partial power down can still
> >>> save some amount of power when hcd_suspend is called.
> >> Have you tried to debug dwc2 with power_down =3D=3D DWC2_POWER_DOWN_PA=
RAM_NONE ?
> >>>
> >>> Some evidence that this should be possible: looking at mainline Linux
> >>> and at dwc2_port_suspend(), I see:
> >>>
> >>> * It is currently called even when we have DWC2_POWER_DOWN_PARAM_NONE
> >> Currently (without your and my patches) (looking at mainline Linux) th=
e
> >> function dwc2_port_suspend() is called anyway because its call is issu=
ed
> >> by the system. But it performs entering to suspend only in case of
> >> DWC2_POWER_DOWN_PARAM_PARTIAL.
> >>
> >> This is not an assumption. What I am pointing out is based on debuggin=
g
> >> and before making assumptions without debugging for me seems not ok.
> >>
> >> Currently without your patch and without my patches. In the
> >> dwc2_port_suspend() it will enter to suspend only in case that
> >> power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL. Because if you look a=
t the
> >> code more carefully you will see
> >>
> >>          if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTI=
AL)
> >>                  goto skip_power_saving;
> >>
> >> This says if power_down is not DWC2_POWER_DOWN_PARAM_PARTIAL then skip
> >> power saving.
> >>
> >> So but after your patch. If power_down is DWC2_POWER_DOWN_PARAM_NONE i=
t
> >> tries to suspend.
> >
> > We must be looking at different code.  I'm looking at Linux's tree, AKA=
:
> >
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_usb_dwc2_hcd.c-23n3=
488&d=3DDwIFaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_Hl=
VzYqrC_D7niMJI&m=3DIWkDOOGTr0q-H1piDv2KOZe_Hnrz18g6rXFx-DsTuv4&s=3DAHu2iOKk=
ybliRGtIfN7cF5p070UdvUKTYJsyAKYojis&e=3D
> Here you are looking at the old code. After that there are several of
> changes related to suspend/resume functions.

In my email, see that I said I actually checked out mainline kernel
(and I gave you the exact version: "v5.1-rc7-5-g83a50840e72a") and
added printouts in dwc2_port_suspend() next to where it set HPRT0_SUSP
and PCGCTL_STOPPCLK in dwc2_port_suspend().

[  454.906364] dwc2 ff540000.usb: I'm setting HPRT0_SUSP
[  454.906367] dwc2 ff540000.usb: I'm setting PCGCTL_STOPPCLK

The version "v5.1-rc7-5-g83a50840e72a" is not old code.


> This is the link to the code with changes. Latest version of those
> functions.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/usb/dwc2/hcd.c#n4489
>
> Your changes are sitting on that latest version of code. Not the old
> version of it.

You are pointing me at _dwc2_hcd_suspend() whereas I pointed at
dwc2_port_suspend().  Why?

I am saying that dwc2_port_suspend() _does_ set "HPRT0_SUSP" and
"PCGCTL_STOPPCLK" even with DWC2_POWER_DOWN_PARAM_NONE.  Do you
disagree?

I completely agree that on mainline _dwc2_hcd_suspend() _does not_ set
these bits with DWC2_POWER_DOWN_PARAM_NONE.  That is what my patch
fixes.


-Doug
