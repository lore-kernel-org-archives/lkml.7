Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB7C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344BE205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557247217;
	bh=bvy3TxkD6QYNRWZoUtKKAkzQfSrcSJIcIGTYRGnLKug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pKcHOlfTAGyZ+s29/DoLEQ0ep5548xNuzJg8qtoYhUIPHVPH6P5MVpjm8+i9LpnRu
	 k4ubK0qJfbEl/vu3CHkx+06+OIrneV/CPVwc7a99c84LD+ap691BfYOJwm/JJVBf30
	 VgL6wDIa05Ik35qy8D5Ntf1a3MOQLfvykGZqcsZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfEGQkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEGQkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:40:16 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9BE205C9;
        Tue,  7 May 2019 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557247215;
        bh=bvy3TxkD6QYNRWZoUtKKAkzQfSrcSJIcIGTYRGnLKug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JTCJWQqMALzVnz8pn0XWSps1BGXqUlUzq+/+NT/Ch42t/H9o2FEbSvt7oC++u0ThX
         0LqL/ynMHT3x9ny1Txnf+8YJ2NzB7zdliZvC6DP6MdKAQSEWt6XwZOqSXvm/uK3iJX
         N9Cmj98zvy+F+ywMFFWm43oZlpxOWVcThstqdmVA=
Received: by mail-qt1-f175.google.com with SMTP id d13so2859030qth.5;
        Tue, 07 May 2019 09:40:15 -0700 (PDT)
X-Gm-Message-State: APjAAAWPVzl6ytuD08wNxp0MHLe5jhDQrwk9fbKWI8LZ3ehzzXB/DIRy
        tqhwXrnE36ZaPL1rnhfI6z5AUqgaUbfMhsz1JQ==
X-Google-Smtp-Source: APXvYqwp5oN/U/L3GW2JMFZpyrG4LHPEVHaqtylnCTc4SbNGRF2GMOSnOZpjLlwUzTir6yXm3AenT0Q78p+6iSnukXE=
X-Received: by 2002:ac8:641:: with SMTP id e1mr27627572qth.76.1557247214367;
 Tue, 07 May 2019 09:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190426055558.44544-1-ran.wang_1@nxp.com> <20190501235410.GA25492@bogus>
 <AM5PR0402MB286539A070BDEEDFC3304F0EF1310@AM5PR0402MB2865.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0402MB286539A070BDEEDFC3304F0EF1310@AM5PR0402MB2865.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 May 2019 11:40:02 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+tmUCjZw7ybhKTGg0NNfc+JsOQ30vArfHzdw14XoWm5A@mail.gmail.com>
Message-ID: <CAL_Jsq+tmUCjZw7ybhKTGg0NNfc+JsOQ30vArfHzdw14XoWm5A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Add USB dt nodes
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 3:48 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Rob,
>
> On Thursday, May 02, 2019 07:54 Rob Herring wrote:
> >
> > On Fri, Apr 26, 2019 at 05:54:26AM +0000, Ran Wang wrote:
> > > This patch adds USB dt nodes for LS1028A.
> > >
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > > Changes in v2:
> > >   - Rename node from usb3@... to usb@... to meet DTSpec
> > >
> > >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   20
> > ++++++++++++++++++++
> > >  1 files changed, 20 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > index 8dd3501..188cfb8 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > @@ -144,6 +144,26 @@
> > >                     clocks = <&sysclk>;
> > >             };
> > >
> > > +           usb0:usb@3100000 {
> >                      ^ space needed
>
> Yes, will update this in next version.
>
> > > +                   compatible= "snps,dwc3";
> >
> > Needs an SoC specific compatible.
>
> Do you mean change compatible to "snps,dwc3", "fsl,ls1028a-dwc3" ?

Well, that's the wrong order, but yes.

> As I know, so far there is no SoC specific programming for this IP, so do
> you think it's still necessary to add it?

Yes. All the bugs and quirks are discovered already?

Rob
