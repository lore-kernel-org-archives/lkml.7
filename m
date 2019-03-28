Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC107C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0EE20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vgU63AKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfC1UAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:00:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38158 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfC1UAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:00:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so19567629ote.5;
        Thu, 28 Mar 2019 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OM/8gXw0ruyBhM5nsJAfeWqS5Sp56wlwsUqgsT5UCMg=;
        b=vgU63AKK5dDDYV4xlfEvUBM1yeSxlihzL+adhZo10iOkTQGS3Ju4lGEBcPbFmD3xFt
         QqKX+DuDBrGkGB3uWY+JJnFfFWTQdgmfwGzE6ubMOIDO/l8F/oNcoVZTpJdskXBDW/Sv
         svsVls78ajxswO7VQEwHxRtuNGEZXSJsCvHgzkvWwtAimUvgqxgGuPhZUHiA9tX+II5n
         rS5vqfFQMRjAFuDvqxL/zgMHMbLvqfogiuEKMZEkOW2wDEYBMML0/3uxUU5+2pUzbCG0
         Twr1OTQM/8GDoMrEmQ68nsUzuOZGAD/276KnaOKe1QTXBFsxY4xS44PhNWR/uWEpyNWd
         uwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OM/8gXw0ruyBhM5nsJAfeWqS5Sp56wlwsUqgsT5UCMg=;
        b=jLzjGyqRRjn8LkkmPWiSKANbkQo5y2Kbz22eDxkC3MNaeN+umRIsZDtWtPdReOcioU
         Pa8BiPVsZTN26v0DX/Pp3tUW8JAqyqoFFoCZUJ9vpGKqZhbpD0HquAHGDMMfsVzV4gqK
         DfQ7W6hmLbsPAGFSVdEw75wn8bWZA59Ya9Es9qxJ+E5NtAD9+wCazTKPqW7PWrSscEiu
         ZFlgvKfpZy2fx14jOdJV8umEqxWXAryNJ9Q+sRbde191/KGwo+dkznh3xHgRVy6Hvn27
         Oi61E+Gdw1jFpGMDW+7ndc8i4Vx5JbXBtOKlVOGSR15BcwjAd/cRZvhgI30Imy7CZ3I0
         8Y/A==
X-Gm-Message-State: APjAAAWg8KbdO/uMBP70AIyWkJKDR8BgH9R2z7pAsyUPs2FxRBoZLitv
        xVgWNhXIKDT1b5UmrmiGBCeTBU90wLtwYqXqr/k=
X-Google-Smtp-Source: APXvYqwx7ABBvUDeDLLzu5sdiZdlGpI1MG0EPoXBF6ReVBJsGsLul+QpIgPRue2ncgpx6Qi0WEfr5lwbMdo3ekeofvU=
X-Received: by 2002:a9d:e8f:: with SMTP id 15mr32821348otj.148.1553803234751;
 Thu, 28 Mar 2019 13:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190306212431.5779-1-martin.blumenstingl@googlemail.com> <20190327234217.GA8346@bogus>
In-Reply-To: <20190327234217.GA8346@bogus>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 28 Mar 2019 21:00:23 +0100
Message-ID: <CAFBinCDzYDH8NTwedUMaaN-gxtP29FEmvPtrmnQ+d2_N_PZ+=A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc2: document the vbus-supply property
To:     Rob Herring <robh@kernel.org>
Cc:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amelie.delaunay@st.com, felipe.balbi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Mar 28, 2019 at 12:42 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 06, 2019 at 10:24:31PM +0100, Martin Blumenstingl wrote:
> > Various boards have an external VBUS supply regulator. This regulator
> > depends on the current mode of the controller which is defined as:
> > - dr_mode set to either "host" or "peripheral" (fixed value)
> > - dr_mode set to "otg", based on the OTG status the dwc2 controller
> >   internally switches between "host" and "peripheral" mode (selection
> >   happens at runtime)
> >
> > Based on the current mode the regulator has to be enabled or disabled:
> > - host: provide power to the connected USB device, thus the regulator
> >   has to be enabled
> > - peripheral: the host device to which the controller is connected
> >   provides power, thus the regulator has to be disabled
> >
> > Add the dt-bindings documentation for this property so .dts authors know
> > that this property exists and how it behaves.
> >
> > Fixes: 531ef5ebea9639 ("usb: dwc2: add support for host mode external vbus supply")
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  Documentation/devicetree/bindings/usb/dwc2.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> > index 6dc3c4a34483..1e8a775a0e72 100644
> > --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> > +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> > @@ -31,6 +31,10 @@ Refer to clk/clock-bindings.txt for generic clock consumer properties
> >  Optional properties:
> >  - phys: phy provider specifier
> >  - phy-names: shall be "usb2-phy"
> > +- vbus-supply: reference to the VBUS regulator. Depending on the current mode
> > +  this is enabled (in "host" mode") or disabled (in "peripheral" mode). The
> > +  regulator is updated if the controller is configured in "otg" mode and the
> > +  status changes between "host" and "peripheral".
>
> This is actually wrong IMO unless Vbus is powering the controller
> itself. If it is just a regulator routed to the USB connector, then the
> DT should use the usb-connector binding and put vbus-supply there. If
> the driver needs it, then it can walk the tree/graph and get it. For
> some reason folks seem to think everything the driver needs has to be in
> the node associated with the driver.
I didn't know about the usb-connector binding yet - thank you for
pointing it out (rather than saying that this is bad without giving a
reason)!

do you want me to re-spin this with a notice (stating that this should
be implemented in another way)?
I'm asking because I suggested that Neil adds a "vbus-supply" property
to "dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings" [0].
He already added it and you reviewed it (it's easy to miss though, the
patches are not merged yet though).

> </rant>
>
> I guess given this is already in use:
I know of at least two consumers:
- arch/arm/boot/dts/meson8b-ec100.dts (I'm guilty of adding that
because I thought that the only problem with this binding was the
missing documentation)
- (downstream) OpenWrt has switched the lantiq target to use this property: [1]


Regards
Martin


[0] https://patchwork.kernel.org/patch/10868515/
[1] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=d8b475212bbf9e5f80c1c923a9701dca5ceb23e2
