Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DEEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36891206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wW6rr+1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfJGTHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:07:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33467 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:07:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so16637683wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95juAPRibRsg5re+laxQpzz0D8Am/jXsPVvZ79cjhUQ=;
        b=wW6rr+1hS+VmsRnIZrSE0LcWIGuTNm/CGXrzeSUP+yMjFX8ONLJUEFVbaavrpyiD0O
         xmV6DbtmOrjCDLaongOaRi86y1lq1sgKTl8lmSNE9AvH3YoJEFegf2KVyjj54PuSMRyO
         cK1uRRL4Ku7+uZkBiAGrilSsrGpN3EyXGxKm9Kt3GlXxPHT6bWYXAFyH8E4iEW03+SNm
         iLesfPQ2lVCQOvVvx/r5qDetWCgZPzD7BWVwzztUl3WWaDk2YSY1K4TP56uzyURnKzZC
         UW0QIjYwNVHs6lZW7XmyzGj7YN/Rj8sDaOR6LKGRE6cl85HsjchFtIfrRdMddy8Ucy+a
         JE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95juAPRibRsg5re+laxQpzz0D8Am/jXsPVvZ79cjhUQ=;
        b=CEdIiQhEy8BIQJuQFnUAcNl+7zykmHCEvA14iRtpMLbrcS35+3jMEQV49CRmaN7ExM
         UJOO/hqBuKgbZsok/6gOaImsOayTuvpgAnZHCDtiYzT27PJfNdqGedrsVUkcb2F8g3F3
         ypXk0zhyd5rVPqB2eduhnz8B+dy/osATvV/0L8XLTeJ0TnkA5iAvMogTKm9RYmQ/QhaW
         sLWJ/Z8YfwBgimVHiyWjenXfidT0+0gWOc5jBRidfnXcRbFf/2zD1RfREBxYD6Aj/vFn
         0E9xYLUfDTHKhyU2ZOeyOV6UV5eYC+UzlismUTNhqDLjTXjljn2MwtVNj1sn+woWTReR
         6uoA==
X-Gm-Message-State: APjAAAUlJl85Y7YpKIoD8aWQEzx+FOc+IIXAG2sWy1Wyi4c/ThZvol8j
        n5w6GG3ADDSLOmkCyXFnPNNWeXXOOTCNQD6K289bXA==
X-Google-Smtp-Source: APXvYqwtOgoWDzXe4XvcuBAiER1TlL5FYyZ+X3/oRcI/zh6Y8qgusWcdXgu+/X3MKRMM9vnwEhq0Gw2bS6tqef/R2ZM=
X-Received: by 2002:adf:fc07:: with SMTP id i7mr8880378wrr.50.1570475224332;
 Mon, 07 Oct 2019 12:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191007175553.66940-1-john.stultz@linaro.org>
 <20191007175553.66940-5-john.stultz@linaro.org> <CAL_JsqJLY2n7hfneNptAGswVZtGm3vJbSR6W2wUG+ZTzMN8wZA@mail.gmail.com>
In-Reply-To: <CAL_JsqJLY2n7hfneNptAGswVZtGm3vJbSR6W2wUG+ZTzMN8wZA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 7 Oct 2019 12:06:53 -0700
Message-ID: <CALAqxLWB7Vd-H70LLLSW0Fv=_4-saQ9CE2k3-L_43E+F8mLj2w@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 4/5] dt-bindings: usb: dwc3: of-simple: add
 compatible for HiSi
To:     Rob Herring <robh+dt@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu Chen <chenyu56@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 11:38 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Oct 7, 2019 at 12:56 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > Add necessary compatible flag for HiSi's DWC3 so
> > dwc3-of-simple will probe.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Yu Chen <chenyu56@huawei.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Cc: linux-usb@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2: Tweaked clock names as clk_usb3phy_ref didn't seem right.
> > ---
> >  .../devicetree/bindings/usb/hisi,dwc3.txt     | 52 +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/hisi,dwc3.txt
>
> Can you make this a schema.

Sorry, I'm not sure exactly what you're asking. I'm guessing from
grepping around you want the bindings in yaml instead (I see a few
examples)? Is there some pointer to documentation? The
Documentation/devicetree/bindings/writing-bindings.txt file doesn't
seem to say much on it.

> > diff --git a/Documentation/devicetree/bindings/usb/hisi,dwc3.txt b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > new file mode 100644
> > index 000000000000..3a3e5c320f2a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > @@ -0,0 +1,52 @@
> > +HiSi SuperSpeed DWC3 USB SoC controller
> > +
> > +Required properties:
> > +- compatible:          should contain "hisilicon,hi3660-dwc3" for HiSi SoC
> > +- clocks:              A list of phandle + clock-specifier pairs for the
> > +                       clocks listed in clock-names
> > +- clock-names:         Should contain the following:
> > +  "clk_abb_usb"                USB reference clk
> > +  "aclk_usb3otg"       USB3 OTG aclk
> > +
> > +- assigned-clocks:     Should be:
> > +                               HI3660_ACLK_GATE_USB3OTG
> > +- assigned-clock-rates: Should be:
> > +                               229Mhz (229000000) for HI3660_ACLK_GATE_USB3OTG
> > +
> > +Optional properties:
> > +- resets:              Phandle to reset control that resets core and wrapper.
>
> Looks like 4 resets though.

Good point. I'll fix that up.

> > +
> > +Required child node:
> > +A child node must exist to represent the core DWC3 IP block. The name of
> > +the node is not important. The content of the node is defined in dwc3.txt.
> > +
> > +Example device nodes:
> > +
> > +       usb3: hisi_dwc3 {
> > +               compatible = "hisilicon,hi3660-dwc3";
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> > +                        <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> > +               clock-names = "clk_abb_usb", "aclk_usb3otg";
> > +
> > +               assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> > +               assigned-clock-rates = <229 000 000>;
> > +               resets = <&crg_rst 0x90 8>,
> > +                        <&crg_rst 0x90 7>,
> > +                        <&crg_rst 0x90 6>,
> > +                        <&crg_rst 0x90 5>;
> > +
> > +               dwc3: dwc3@ff100000 {
>
> If it's only clocks and resets for the wrapper node, just make this
> all one node.

Just to make sure I'm following, you're suggesting I put all the
clocks/resets in the dwc3 node (renamed to usb for the node name) and
not add the wrapper?

I'll have to see if that's possible. The generic dwc3 binding wants 3
clocks, but I only have two in the code I've worked with (similarly it
seems to only want two resets, not 4) so I'll have to see if I can
figure out how to adapt that.

If that approach is preferred, do I also no longer need a separate
binding document/schema?

thanks
-john
