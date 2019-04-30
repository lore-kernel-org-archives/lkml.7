Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A4C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C6F21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556632319;
	bh=FK7HvOl0jhVPsMklvQn4u+qk2YgkQYXDQ9T+ToRvAXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y8KZ/rVIpN4Eiadl0hUAhrIwgc/V3x6rFtIFr66ZqKtDyP73rDvGnHAJhcgSeBroa
	 BSxulKMITun2TqtbFvnVY1ZcemOxPgUx/Pm5zpqM1WKg/ZjSPYN1NvfUYU6aPfIllR
	 SvLMAERR/hCqv7Y93iK2WGn/fQbJbfW4VAr/e8zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfD3Nv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfD3Nv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:51:58 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699B4217D4;
        Tue, 30 Apr 2019 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556632316;
        bh=FK7HvOl0jhVPsMklvQn4u+qk2YgkQYXDQ9T+ToRvAXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R3Eq5UQpEL1ulohhuEsrUMBN4yHKbGSE7eO2Aq5wIH53jMAkaDaUoTMiGUdGhJCfo
         WFhwmfPa6Mrtcx1/G4u31gKPjxJ6BYpGPQdVcYXQ1Q/02mGIz/C3dfMquL9S1tZz6S
         qK033DJlKnFFTeKQbT8FT5KXlVEifZYTDv2KtKUw=
Received: by mail-qt1-f171.google.com with SMTP id g7so16210459qtc.0;
        Tue, 30 Apr 2019 06:51:56 -0700 (PDT)
X-Gm-Message-State: APjAAAXV1whIOfQDJx8iOBBUMFWmuoyk7+9/IaTu489PX4E9kKDp8sxQ
        cDS+4ZpQyyQe+qo56ZnPQdKpjBXzePwSd+FiVw==
X-Google-Smtp-Source: APXvYqysWBnERRiggEZsMb3Mmr6NNKePq261OyqR1iKPSacnJ82Idt1QSfZ2Dzyk1tH321Fn4H2E6up6IIy0+QNvHz4=
X-Received: by 2002:aed:3f6b:: with SMTP id q40mr14911616qtf.26.1556632315591;
 Tue, 30 Apr 2019 06:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190416215351.242246-1-dianders@chromium.org>
 <20190416215351.242246-2-dianders@chromium.org> <20190430005357.GA13695@bogus>
 <CAD=FV=V3_NcBHdg5A8LvGMoVd_eLN0q=pXo_3f2GCdi5u2GP-Q@mail.gmail.com>
In-Reply-To: <CAD=FV=V3_NcBHdg5A8LvGMoVd_eLN0q=pXo_3f2GCdi5u2GP-Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 30 Apr 2019 08:51:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGMBhqRw0D9ehsV=A7cQ4cPah=Ot335npraBdGm1Yhag@mail.gmail.com>
Message-ID: <CAL_JsqJGMBhqRw0D9ehsV=A7cQ4cPah=Ot335npraBdGm1Yhag@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: dwc2: Document quirk to reset
 PHY upon wakeup
To:     Doug Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Randy Li <ayaka@soulik.info>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:29 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Apr 29, 2019 at 5:54 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Apr 16, 2019 at 02:53:48PM -0700, Douglas Anderson wrote:
> > > On Rockchip rk3288 there's a hardware quirk where we need to assert
> > > the reset signal to the PHY when we get a remote wakeup on one of the
> > > two ports.  Document this quirk in the bindings.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >
> > > Changes in v2: None
> > >
> > >  Documentation/devicetree/bindings/usb/dwc2.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> > > index 6dc3c4a34483..f70f3aee4bfc 100644
> > > --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> > > +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> > > @@ -37,6 +37,8 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
> > >  - g-rx-fifo-size: size of rx fifo size in gadget mode.
> > >  - g-np-tx-fifo-size: size of non-periodic tx fifo size in gadget mode.
> > >  - g-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
> > > +- snps,reset-phy-on-wake: If present indicates that we need to reset the PHY when
> > > +                          we detect a wakeup.  This is due to a hardware errata.
> >
> > Synopsys or Rockchip errata?
> >
> > Ideally, this should be implied by the controller or phy compatible.
>
> I have no idea.  The errata was described to me by Rockchip but I
> don't know if it's common to more than one board.
>
> You're right that we could do it on the controller compatible, but we
> have to be careful.  The two ports on rk3288 currently have the same
> compatible string but the errata only applies to one of them.  ...so
> I'd have to cue on not just the compatible string but also detect
> whether we're on the "OTG" port of the "host only" port.  That's not
> too hard, though since it is probe-able.
>
> I'm happy to spin this but I'll wait to hear from Felipe.  This is
> already in his testing tree, so presumably I should do a follow-up
> patch.  ...but if he wants me to re-post I can do that too.

Okay, I guess it is fine as-is.

Rob
