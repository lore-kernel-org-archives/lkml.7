Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83FEC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995922075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRmEmm4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfD3Fdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:33:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37525 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3Fdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:33:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so7300320vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAZB9m78vyMqVnCUT5sxg+zHI1l8qWvxtWApzbGtN1A=;
        b=iRmEmm4IrU6e+wZHgKHwQwIr0tcTTb9ixCcFFUV+Q+c6fi2SKUyMCAt/qUlgKI5Zjz
         JohZhhouXMXuxCAlnL7+6YHVlqjsv5zhMjn+o41T14oN8A6DN+HAOIRuUdSHnW9rAwE2
         LY5Jyu7Yvsvk8uDEVZrh9r7avMXSXUJJPl1cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAZB9m78vyMqVnCUT5sxg+zHI1l8qWvxtWApzbGtN1A=;
        b=kH/MqMIr3bcv8w5WZjNQFIPZ+e+vfYiOzE84j981WCxPk81w90u+12VGwJi7g65zC7
         ZTqjNG0DihKI469olbUUMdey/M/Rfw/ohMDvYjhU886yNHIQoiP0zPDC6RYsP9gFPobS
         xjqHjYPvUAcvsfMjgamhlV1K6EqLrfkOPNxSAw1uiyM5/SfWDvHtuPBVVznEi3rQopRm
         faljgMFh+uEfabn5dID7FSJIaCOhTjdpIhxtq2lnbC8ycccvhyFY4Cjx5Y1lE/iUmleF
         +rtR6o3qsvJEJ0f+Q7dCG1ZVuEbPxDRNfw3z51l3VRY7K4V82fCvMydGX14AYSVnSpRA
         V+zg==
X-Gm-Message-State: APjAAAVq7kF9g2m3B8JrwpundK4JkTL42Ov0pz6SlluQ16wTpuH9b9LZ
        zKZxCE/HKkWfwkzvaMBtO5i54Y7Pl64=
X-Google-Smtp-Source: APXvYqzRfpcanSCUQGcJNbNo2b+4plYLTvORQOpegGPP2hhLOtTUMhI+2209o/GGzj2mYop2k+CxRA==
X-Received: by 2002:a67:b343:: with SMTP id b3mr32213280vsm.237.1556602424570;
        Mon, 29 Apr 2019 22:33:44 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id z192sm23173003vkd.45.2019.04.29.22.33.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 22:33:44 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id s11so7326507vsn.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:33:44 -0700 (PDT)
X-Received: by 2002:a67:e88c:: with SMTP id x12mr9502003vsn.87.1556601955497;
 Mon, 29 Apr 2019 22:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-4-dianders@chromium.org> <20190430012328.GA25660@bogus>
In-Reply-To: <20190430012328.GA25660@bogus>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Apr 2019 22:25:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UdtgAZBxuwjrrXtKT1sMfaELF8V193BF=UHg9fvM+yRw@mail.gmail.com>
Message-ID: <CAD=FV=UdtgAZBxuwjrrXtKT1sMfaELF8V193BF=UHg9fvM+yRw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Documentation: dt-bindings: Add
 snps,need-phy-for-wake for dwc2 USB
To:     Rob Herring <robh@kernel.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Julius Werner <jwerner@chromium.org>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 29, 2019 at 6:23 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Apr 17, 2019 at 05:13:54PM -0700, Douglas Anderson wrote:
> > Some SoCs with a dwc2 USB controller may need to keep the PHY on to
> > support remote wakeup.  Allow specifying this as a device tree
> > property.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > For relevant prior discussion on this patch, see:
> >
> > https://lkml.kernel.org/r/1435017144-2971-3-git-send-email-dianders@chromium.org
> >
> > I didn't make any changes from the prior version since I never found
> > out what Rob thought of my previous arguments.  If folks want a
> > change, perhaps they could choose from these options:
> >
> > 1. Assume that all dwc2 hosts would like to keep their PHY on for
> >    suspend if there's a USB wakeup enabled, thus we totally drop this
> >    binding.  This doesn't seem super great to me since I'd bet that
> >    many devices that use dwc2 weren't designed for USB wakeup (they
> >    may not keep enough clocks or rails on) so we might be wasting
> >    power for nothing.
>
> 1b. Use SoC specific compatible strings to enable/disable remote
> wake-up. We can debate what the default is I guess.

Unfortunately it's more than just SoC.  While you need the SoC to be
able to support this type of wakeup, you also need the board design,
firmware design, regulator design, etc.  ...so I don't think we can
just use the SoC specific compatible string.

In fact, while testing this I found that USB wakeup was totally broken
unless I enabled "deep suspend" mode on my system.  Something about
the clocks / wakeup sources in the shallow suspend totally blocked it
and I couldn't figure out what.

...so I believe it really needs to be something where someone has
said: I tested it out on this board and everything is setup properly
to support USB wakeup.


> > 2. Rename this property to "snps,wakeup-from-suspend-with-phy" to make
> >    it more obvious that this property is intended both to document
> >    that wakeup from suspend is possible and that we need the PHY for
> >    said wakeup.
> > 3. Rename this property to "snps,can-wakeup-from-suspend" and assume
> >    it's implicit that if we can wakeup from suspend that we need to
> >    keep the PHY on.  If/when someone shows that a device exists using
> >    dwc2 where we can wakeup from suspend without the PHY they can add
> >    a new property.
> >
> > Changes in v2: None
> >
> >  Documentation/devicetree/bindings/usb/dwc2.txt | 3 +++
> >  1 file changed, 3 insertions(+)
