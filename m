Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BB4ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78C1218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571139633;
	bh=oGPUs6ScsKBWjiqXvGtsLhcAYD8CQlphpe25WiR9FGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GRJ70s2/y0HJLh83LaMi5aWaMjeaf30KjRHJPSJCztUTycdRpOeyHZN8mKgoS384Q
	 RrEuWZs1iABi90BzITCmvF7lZGHnhDnpMfE3BpJekLOWeh39kQabuR78bnBcNer0Sr
	 B3mAPQsb9Vfpf9H6e6bfCqyrEd23wj7RxWLweq38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfJOLkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfJOLkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:40:31 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A4821A49;
        Tue, 15 Oct 2019 11:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571139631;
        bh=oGPUs6ScsKBWjiqXvGtsLhcAYD8CQlphpe25WiR9FGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IuhXmlHj2PRLsBZj2269HsoFFYUJrFjAzqKrBXSsQ2lsXfxkAooLORx/ALjRhk/av
         ERpKqQNIxKws3tEloX9E5mfprd62BzVlhogQ3aOrpQrb9cxxE3XPXOK00XeBGl973Y
         lVbRtilHoNYYolWIarpI02u6whi0mzrqQRS4oax4=
Received: by mail-qt1-f177.google.com with SMTP id m15so30074401qtq.2;
        Tue, 15 Oct 2019 04:40:31 -0700 (PDT)
X-Gm-Message-State: APjAAAWhL/rI0qhYBfHM8DEWfMzO3/NGgv2BBnIN9oadhCsnWZsUElaV
        kUZYni865pnk1Tn40DT44LkSodXNUr2N3MsQyg==
X-Google-Smtp-Source: APXvYqwOmCf+8YOVZvLtKg632W0xW7C6kdgWWv1JJ/jsejb6F+m2ruoP20gZce1ZKtzSOkNUWHdYVGoH9vEkkWJApFc=
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr39160131qto.300.1571139630214;
 Tue, 15 Oct 2019 04:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191007175553.66940-1-john.stultz@linaro.org>
 <20191007175553.66940-5-john.stultz@linaro.org> <CAL_JsqJLY2n7hfneNptAGswVZtGm3vJbSR6W2wUG+ZTzMN8wZA@mail.gmail.com>
 <CALAqxLWB7Vd-H70LLLSW0Fv=_4-saQ9CE2k3-L_43E+F8mLj2w@mail.gmail.com>
 <CAL_JsqJ9uUtqTDEkLi86-BCvW+wM6Pgz_K+JuTsuOqHfFOHStA@mail.gmail.com>
 <CALAqxLVpPvHf2RpwjHh5v9cnQm9CLtj0HHaqVH=EFQJk-GhaPQ@mail.gmail.com>
 <20191011155123.GA14272@bogus> <CALAqxLUbh7_PkOwh9NrS_+sgLDZMHndbp44jVQkB=WqOhKUotA@mail.gmail.com>
In-Reply-To: <CALAqxLUbh7_PkOwh9NrS_+sgLDZMHndbp44jVQkB=WqOhKUotA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Oct 2019 06:40:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLB_Pruk0n0jS0B-uB74R=pE7aOhoo5FU191Hg3wsd7XA@mail.gmail.com>
Message-ID: <CAL_JsqLB_Pruk0n0jS0B-uB74R=pE7aOhoo5FU191Hg3wsd7XA@mail.gmail.com>
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
        <devicetree@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:57 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Fri, Oct 11, 2019 at 8:51 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Oct 07, 2019 at 04:00:24PM -0700, John Stultz wrote:
> > > On Mon, Oct 7, 2019 at 2:11 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 7, 2019 at 2:07 PM John Stultz <john.stultz@linaro.org> wrote:
> > > > >
> > > > > On Mon, Oct 7, 2019 at 11:38 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Oct 7, 2019 at 12:56 PM John Stultz <john.stultz@linaro.org> wrote:
> > > > > > >
> > > > > > > Add necessary compatible flag for HiSi's DWC3 so
> > > > > > > dwc3-of-simple will probe.
> > > > > > >
> > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > Cc: Felipe Balbi <balbi@kernel.org>
> > > > > > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > > > Cc: Yu Chen <chenyu56@huawei.com>
> > > > > > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > > > > > Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > > > Cc: linux-usb@vger.kernel.org
> > > > > > > Cc: devicetree@vger.kernel.org
> > > > > > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > > > > > ---
> > > > > > > v2: Tweaked clock names as clk_usb3phy_ref didn't seem right.
> > > > > > > ---
> > > > > > >  .../devicetree/bindings/usb/hisi,dwc3.txt     | 52 +++++++++++++++++++
> > > > > > >  1 file changed, 52 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > > > > >
> > > > > > Can you make this a schema.
> > > > >
> > > > > Sorry, I'm not sure exactly what you're asking. I'm guessing from
> > > > > grepping around you want the bindings in yaml instead (I see a few
> > > > > examples)?
> > > >
> > > > Yes.
> > > >
> > > > > Is there some pointer to documentation? The
> > > > > Documentation/devicetree/bindings/writing-bindings.txt file doesn't
> > > > > seem to say much on it.
> > > >
> > > > You mean Documentation/devicetree/writing-schemas.rst? There's that
> > > > and Documentation/devicetree/bindings/example-schema.yaml which has a
> > > > bunch of annotations on what each part means.
> > >
> > > Ah! Sorry for missing that. Thanks for the pointer, though I may get
> > > away with dropping this one.
> > >
> > > > > > If it's only clocks and resets for the wrapper node, just make this
> > > > > > all one node.
> > > > >
> > > > > Just to make sure I'm following, you're suggesting I put all the
> > > > > clocks/resets in the dwc3 node (renamed to usb for the node name) and
> > > > > not add the wrapper?
> > > >
> > > > Yes.
> > > >
> > > > > I'll have to see if that's possible. The generic dwc3 binding wants 3
> > > > > clocks, but I only have two in the code I've worked with (similarly it
> > > > > seems to only want two resets, not 4) so I'll have to see if I can
> > > > > figure out how to adapt that.
> > > >
> > > > Possible since commit fe8abf332b8f ("usb: dwc3: support clocks and
> > > > resets for DWC3 core").
> > >
> > > Ok. It *seems* like I can get it working with the existing binding
> > > then. There's a little funkiness with the core expecting three clocks
> > > while I only have two (currently I'm duplicating the "bus_early" clk
> > > for "suspend". Is there a preferred way to do this sort of hack?), and
> > > I'm a little worried that only the first reset is being used (instead
> > > of the 4 specified), but it seems to work so far.
> >
> > I would assume that you simply don't know how the 'suspend' clock is
> > connected rather than you don't have one. But that's maybe not a
> > problem you can fix.
> >
> > I would make dwc3 use devm_clk_bulk_get_all and allow for less than 3
> > clocks. And do a similar change for resets.
>
> So got a chance to start implementing this and it seems like it will
> work. That said, it feels like I'm duplicating logic already in the
> dwc-of-simple.c implementation (which already handles arbitrary clks
> and resets), particularly if I try to implement the device specific
> need_reset quirk used by HiKey960 (and rk3399).
>
> Do you feel having that logic copied is worth avoiding the extra
> bindings? Or is it too duplicative?

We already have reset and clock setup in 2 places, so it's already
kind of duplicated.

Why not refactor into a helper that both can use?

Rob
