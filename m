Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7329ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B676A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570482678;
	bh=2++8T5z+QfZLxrx0+JY4Ig6nJlGMQTg7pMrbsTi8s/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m7K4fMn1urRPIngVEhizuXAp32QYSMxbLWqFColGW+8fvqa37u9oTfJhQfhKYijEt
	 46/nSkS5ebgVxusEG0K0PPQTfXJP36rpdMcWxcAusOp/VlBm2Hjjh8qM0PVyknCXfj
	 uw4DbkwWx9c5XNVHZ/0iNaoGekwM8n5tn9JbnElo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfJGVLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfJGVLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:11:17 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A95321871;
        Mon,  7 Oct 2019 21:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570482675;
        bh=2++8T5z+QfZLxrx0+JY4Ig6nJlGMQTg7pMrbsTi8s/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MqnJMCvIdq80J7Il5BK3z4Hl/Rjz0FvDiuBTyPxi1L/hJdXCjTadbkoZzujx+rP5i
         lboI8E810fgzQpg7RhEyqt7H/YOS+BHlBnKfYDSLNZdwRL5Tmr7JjhO1Lf2A7Y9Dy6
         8qi++nUKNtWLv6HGtIhG6oqo+fgIj3YKezVgUrB0=
Received: by mail-qt1-f172.google.com with SMTP id o12so21414190qtf.3;
        Mon, 07 Oct 2019 14:11:15 -0700 (PDT)
X-Gm-Message-State: APjAAAW/6LPeMArZ4m7LwDFARoaovbjtDFJEx0j2kDu4pdeMkZa8SNZn
        gXMSLVCX3+qRvbjB3/uZ+9nrDUrY134UDsZ1RQ==
X-Google-Smtp-Source: APXvYqxgC4Y+IoQKs1SvKtAXtb35EwkBoHIwCUxxsWKBsFy/kXYqrEVfDUkyri9NnRTPi/5JhBKP08QwsTyWEYngVpk=
X-Received: by 2002:a05:6214:1590:: with SMTP id m16mr29194689qvw.20.1570482674220;
 Mon, 07 Oct 2019 14:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191007175553.66940-1-john.stultz@linaro.org>
 <20191007175553.66940-5-john.stultz@linaro.org> <CAL_JsqJLY2n7hfneNptAGswVZtGm3vJbSR6W2wUG+ZTzMN8wZA@mail.gmail.com>
 <CALAqxLWB7Vd-H70LLLSW0Fv=_4-saQ9CE2k3-L_43E+F8mLj2w@mail.gmail.com>
In-Reply-To: <CALAqxLWB7Vd-H70LLLSW0Fv=_4-saQ9CE2k3-L_43E+F8mLj2w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Oct 2019 16:11:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ9uUtqTDEkLi86-BCvW+wM6Pgz_K+JuTsuOqHfFOHStA@mail.gmail.com>
Message-ID: <CAL_JsqJ9uUtqTDEkLi86-BCvW+wM6Pgz_K+JuTsuOqHfFOHStA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 4/5] dt-bindings: usb: dwc3: of-simple: add
 compatible for HiSi
To:     John Stultz <john.stultz@linaro.org>
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

On Mon, Oct 7, 2019 at 2:07 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Mon, Oct 7, 2019 at 11:38 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Oct 7, 2019 at 12:56 PM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > Add necessary compatible flag for HiSi's DWC3 so
> > > dwc3-of-simple will probe.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Felipe Balbi <balbi@kernel.org>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Yu Chen <chenyu56@huawei.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > Cc: linux-usb@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > > v2: Tweaked clock names as clk_usb3phy_ref didn't seem right.
> > > ---
> > >  .../devicetree/bindings/usb/hisi,dwc3.txt     | 52 +++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> >
> > Can you make this a schema.
>
> Sorry, I'm not sure exactly what you're asking. I'm guessing from
> grepping around you want the bindings in yaml instead (I see a few
> examples)?

Yes.

> Is there some pointer to documentation? The
> Documentation/devicetree/bindings/writing-bindings.txt file doesn't
> seem to say much on it.

You mean Documentation/devicetree/writing-schemas.rst? There's that
and Documentation/devicetree/bindings/example-schema.yaml which has a
bunch of annotations on what each part means.

> > > diff --git a/Documentation/devicetree/bindings/usb/hisi,dwc3.txt b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > > new file mode 100644
> > > index 000000000000..3a3e5c320f2a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > > @@ -0,0 +1,52 @@
> > > +HiSi SuperSpeed DWC3 USB SoC controller
> > > +
> > > +Required properties:
> > > +- compatible:          should contain "hisilicon,hi3660-dwc3" for HiSi SoC
> > > +- clocks:              A list of phandle + clock-specifier pairs for the
> > > +                       clocks listed in clock-names
> > > +- clock-names:         Should contain the following:
> > > +  "clk_abb_usb"                USB reference clk

Probably 'ref' from dwc3.txt.

> > > +  "aclk_usb3otg"       USB3 OTG aclk

'bus_early'? IIRC, 'aclk' is the clock name for AXI bus clock.

> > > +
> > > +- assigned-clocks:     Should be:
> > > +                               HI3660_ACLK_GATE_USB3OTG
> > > +- assigned-clock-rates: Should be:
> > > +                               229Mhz (229000000) for HI3660_ACLK_GATE_USB3OTG
> > > +
> > > +Optional properties:
> > > +- resets:              Phandle to reset control that resets core and wrapper.
> >
> > Looks like 4 resets though.
>
> Good point. I'll fix that up.
>
> > > +
> > > +Required child node:
> > > +A child node must exist to represent the core DWC3 IP block. The name of
> > > +the node is not important. The content of the node is defined in dwc3.txt.
> > > +
> > > +Example device nodes:
> > > +
> > > +       usb3: hisi_dwc3 {
> > > +               compatible = "hisilicon,hi3660-dwc3";
> > > +               #address-cells = <2>;
> > > +               #size-cells = <2>;
> > > +               ranges;
> > > +
> > > +               clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> > > +                        <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> > > +               clock-names = "clk_abb_usb", "aclk_usb3otg";
> > > +
> > > +               assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> > > +               assigned-clock-rates = <229 000 000>;
> > > +               resets = <&crg_rst 0x90 8>,
> > > +                        <&crg_rst 0x90 7>,
> > > +                        <&crg_rst 0x90 6>,
> > > +                        <&crg_rst 0x90 5>;
> > > +
> > > +               dwc3: dwc3@ff100000 {
> >
> > If it's only clocks and resets for the wrapper node, just make this
> > all one node.
>
> Just to make sure I'm following, you're suggesting I put all the
> clocks/resets in the dwc3 node (renamed to usb for the node name) and
> not add the wrapper?

Yes.

> I'll have to see if that's possible. The generic dwc3 binding wants 3
> clocks, but I only have two in the code I've worked with (similarly it
> seems to only want two resets, not 4) so I'll have to see if I can
> figure out how to adapt that.

Possible since commit fe8abf332b8f ("usb: dwc3: support clocks and
resets for DWC3 core").

>
> If that approach is preferred, do I also no longer need a separate
> binding document/schema?

Correct. And then no need to convert to schema yet (though feel free
to convert dwc3.txt :)).

Rob
