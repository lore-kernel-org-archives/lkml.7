Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C949C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540FC218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553875980;
	bh=os+F3qD9dnbJBb0Vup0xUy0RmpAR3x/0FLfaUR77dM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fkVggJHzLUI62rtifubhSMaupVYZeAi/xbG+MTvokvFKRhxq4SX6l30D0mQc7iErX
	 B17tXgUB3iNscsCCENVV9/KBomuNjR6OsEG2XL47onLhkX5LC9DdChwqytClfVMtfb
	 kyr1i4QkhoGkZFK+NeUMd3XfLNn/urdpiMqycDMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfC2QM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbfC2QM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:12:58 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588DC218A6;
        Fri, 29 Mar 2019 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553875977;
        bh=os+F3qD9dnbJBb0Vup0xUy0RmpAR3x/0FLfaUR77dM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H5aU7bBuRVKjRwWkzBBVxl6jrb5DHO12+SRNEhBUzWE/rpAmeSNUotdKZwLE1rx1o
         8tghWVR5maCGZtHqH5OXDd8PQXXC61QwFUcHIbvTXVc4QgYUZ0WDttdzkLmESRltQ8
         iJUzkuRhHCTuj4SG0xWrWdumUMM2XZSaEI0Vi2po=
Received: by mail-qk1-f182.google.com with SMTP id o129so1673040qke.8;
        Fri, 29 Mar 2019 09:12:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWzkvUrgr04z1CGQnyOnM1w6GBqfShSsnB99Do0qGpgSQaXxMEE
        bZmOLiqhANaxglKKh+PbmagVcBu2CXQShAkBMQ==
X-Google-Smtp-Source: APXvYqzzdzlgBpPrJFK5DiG6IvF+K1Xye5MTJcn6W+ZJ0wVgxtPqiDOFO+uAZpnU0fLaLNVeWRytoGD8scs0RvCtqxQ=
X-Received: by 2002:a37:d285:: with SMTP id f127mr39655924qkj.147.1553875976561;
 Fri, 29 Mar 2019 09:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190328171710.31949-1-dianders@chromium.org> <20190328171710.31949-2-dianders@chromium.org>
 <f2f82f439f2b7586cb4c83f15122d8d19952d596.camel@collabora.com> <CAD=FV=WOKSHWCHPv9kQT7np6v_ZYBmAsnTpAHJv7zRS_3b46JQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WOKSHWCHPv9kQT7np6v_ZYBmAsnTpAHJv7zRS_3b46JQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 29 Mar 2019 11:12:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJNPMnVLyPGeK5Jd=QVSO1zWvPEiPcgas03yP_P66M-uw@mail.gmail.com>
Message-ID: <CAL_JsqJNPMnVLyPGeK5Jd=QVSO1zWvPEiPcgas03yP_P66M-uw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: Add panel-timing subnode to simple-panel
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 6:50 PM Doug Anderson <dianders@chromium.org> wrote=
:
>
> Hi,
>
>
> On Thu, Mar 28, 2019 at 1:27 PM Ezequiel Garcia <ezequiel@collabora.com> =
wrote:
> >
> > On Thu, 2019-03-28 at 10:17 -0700, Douglas Anderson wrote:
> > > From: Sean Paul <seanpaul@chromium.org>
> > >
> > > This patch adds a new subnode to simple-panel allowing us to override
> > > the typical timing expressed in the panel's display_timing.
> > >
> > > Changes in v2:
> > >  - Split out the binding into a new patch (Rob)
> > >  - display-timings is a new section (Rob)
> > >  - Use the full display-timings subnode instead of picking the timing
> > >    out (Rob/Thierry)
> > > Changes in v3:
> > >  - Go back to using the timing subnode directly, but rename to
> > >    panel-timing (Rob)
> > > Changes in v4:
> > >  - Simplify desc. for when override should be used (Thierry/Laurent)
> > >  - Removed Rob H review since it's been a year and wording changed
> > >
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Cc: Eric Anholt <eric@anholt.net>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-rockchip@lists.infradead.org
> > > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  .../bindings/display/panel/simple-panel.txt   | 24 +++++++++++++++++=
++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/simple-p=
anel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > > index b2b872c710f2..6157f86ddce4 100644
> > > --- a/Documentation/devicetree/bindings/display/panel/simple-panel.tx=
t
> > > +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.tx=
t
> > > @@ -15,6 +15,18 @@ Optional properties:
> > >    (hot plug detect) signal, but the signal isn't hooked up so we sho=
uld
> > >    hardcode the max delay from the panel spec when powering up the pa=
nel.
> > >
> > > +panel-timing subnode
> > > +--------------------
> > > +
> > > +This optional subnode is for devices which require a mode differing
> > > +from the panel's "typical" display timing.  The panel timings provid=
ed
> > > +here will be ignored if they are found to be outside of allowable
> > > +ranges for the given panel.
> > > +
> >
> > Is it OK to put this comment about how the implementation
> > will behave when values are out of range, given this is just a binding
> > spec?
> >
> > Perhaps -if needed- this sentence can be rephrased to state that,
> > e.g. the OS may not be able to apply these values, if the controller
> > or device is unable to?
>
> I will defer to Rob H. on this one, but I'm happy to simply remove the
> last sentence.  I was trying to add a more OS-agnostic version of the
> bullet points from V3 but agree that we could just remove this from
> the bindings completely.

Following my opinion that it's not the kernel's job to validate
bindings, I would say it's fine for the OS to blindly apply them if it
chooses.

Plus with schema, you can provide the ranges of values and validate
DTs up front (unless you want to validate some result of math
operations).

Rob
