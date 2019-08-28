Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6F8217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W3rG2buh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfH1Fy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:54:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53277 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfH1Fy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:54:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so1354999wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGmiQt/UsaBijFOEhYrYqRMTRujiOfYHOw+bx00fOk4=;
        b=W3rG2buhdnwgCZZ4bAPhEyB6pmKm9fUHX++eXK+ylmU+IwJlXUvLxqjQ0kaGjuwSBb
         ImveNu1P1EVncE2ZMqg8QX6jZCAonZccjY3GEOLMU7VR4AoCuwwaxQKyO4aAhyNX62C3
         ekVph/xAp7yzGjOz/CJDUjVw2zCHJ5RfSIKDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGmiQt/UsaBijFOEhYrYqRMTRujiOfYHOw+bx00fOk4=;
        b=dgsI250nH0VUMVriERKe2iL62j9b1PEoLlmHRXPGPayo8wgU4E+etAOOAUAUniJoN/
         rt5F2enjql5QmI73h4YfumVsYn+i5S75oOjCcGkmEJKDLM578mVX0/XttsXN6SAtS67C
         qFvKd7/k0ANz5Cki09Gwf7oy+iLEy2h33NUlhz1PexTpNTt/w05xeGF9F//V+DQribCr
         XG8TaE/84egj4Hi9Kb/SsBBIOTWCeMJbhRlyHhpJcfrUgnNwoc7bEkXrvptJ3n5gx2gn
         CH2kM0rhF8VNs3DG/5/AQQpcgDrMY4pl51rYdnIaewkf4cl7DoOwReoY9v8LfEurFnVz
         8iIg==
X-Gm-Message-State: APjAAAWReIx1o1ZjENIUvhOnaTfV02iFYaUJuZJAqlJ7ZUZoBQTWyPlh
        67/cJjbVQTWpG9SPLhfSpDtOgf515BCv7Rk5YVm2mg==
X-Google-Smtp-Source: APXvYqyNKT9gKH1a0DMuIPhUNn6zUB5bjbpRfJzlqFyfMDI+s5q7Sr0JAEBy+kq/myd50wlpjtspJcLH3RE5PPbwtJc=
X-Received: by 2002:a05:600c:2245:: with SMTP id a5mr2467090wmm.121.1566971694777;
 Tue, 27 Aug 2019 22:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
 <1564568395-9980-3-git-send-email-srinath.mannam@broadcom.com> <20190821182119.GA27408@bogus>
In-Reply-To: <20190821182119.GA27408@bogus>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 28 Aug 2019 11:24:43 +0530
Message-ID: <CABe79T6rcm2OatYYf2j6Ht5Ft6YQAZ26es2txVuPyRUNdW8Q3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: Modify Stingray USB PHY #phy-cells
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.
I will modify commit message and send new patch set.
We have a plan to upstream DTS files. We will send DTS changes in
different patch set once this is done.

Regards,
Srinath.

On Wed, Aug 21, 2019 at 11:51 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jul 31, 2019 at 03:49:52PM +0530, Srinath Mannam wrote:
> > Increase #phy-cells from 1 to 2 to have bitmask of PHY enabled ports.
>
> And from 0 to 1...
>
> Are you going to update all the dts files so when we convert this to
> schema we don't get a bunch of warnings? (Feel free to convert this
> to schema too).
>
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> >  .../devicetree/bindings/phy/brcm,stingray-usb-phy.txt      | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > index 4ba2989..aeb0568 100644
> > --- a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > @@ -6,9 +6,11 @@ Required properties:
> >       - "brcm,sr-usb-hs-phy" is a single HS PHY.
> >   - reg: offset and length of the PHY blocks registers
> >   - #phy-cells:
> > -   - Must be 1 for brcm,sr-usb-combo-phy as it expects one argument to indicate
> > -     the PHY number of two PHYs. 0 for HS PHY and 1 for SS PHY.
> > -   - Must be 0 for brcm,sr-usb-hs-phy.
> > +   - Must be 2 for brcm,sr-usb-combo-phy.
> > +     - Cell 1 - PHY Number, 0 for HS PHY and 1 for SS PHY.
> > +     - Cell 2 - Bitmask of enabled ports connected to USB Host controller.
> > +   - Must be 1 for brcm,sr-usb-hs-phy to indicate Bit mask of ports connected
> > +     to USB Host controller.
> >
> >  Refer to phy/phy-bindings.txt for the generic PHY binding properties
> >
> > @@ -16,17 +18,17 @@ Example:
> >       usbphy0: usb-phy@0 {
> >               compatible = "brcm,sr-usb-combo-phy";
> >               reg = <0x00000000 0x100>;
> > -             #phy-cells = <1>;
> > +             #phy-cells = <2>;
> >       };
> >
> >       usbphy1: usb-phy@10000 {
> >               compatible = "brcm,sr-usb-combo-phy";
> >               reg = <0x00010000 0x100>,
> > -             #phy-cells = <1>;
> > +             #phy-cells = <2>;
> >       };
> >
> >       usbphy2: usb-phy@20000 {
> >               compatible = "brcm,sr-usb-hs-phy";
> >               reg = <0x00020000 0x100>,
> > -             #phy-cells = <0>;
> > +             #phy-cells = <1>;
> >       };
> > --
> > 2.7.4
> >
