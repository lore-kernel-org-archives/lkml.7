Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0529D2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7zg9NIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfGYNdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:33:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35901 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfGYNdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:33:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id q4so8491272oij.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1z3qSqeis7KRp59LvW3GrIz3rWu/CFv+sXSsB3MIv0=;
        b=S7zg9NIJWKApcIDLjPg7XBK9rjPeDYoBWNVm005ZjT5gIbIyVfUK1xk1sLRQw2MM6x
         0Mdkbzf6ixFn9ev3RGLQI0Euk3fBpj38V9Um9YNXmB8Nig9Gqm7yu3MXe9SGvtsSF/wm
         cBMTtWscvwBj58mpSYQZHP82mWWmXezEv903XajiM4H7GkdESKIQ2TWthd1ygp1tVdlf
         auy3V0rc8NfdYnkaaXDknQrzs7TI038ABRxdFGjrDH+niO5voLKTNLeZJ3SjiHVtixc8
         lxDg71dtEjf+ShJe5QILrIeZjUXh+f9GR/ZH/Tfe/MfFQcGDLs78lnMBTM2MtL7glJNB
         5yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1z3qSqeis7KRp59LvW3GrIz3rWu/CFv+sXSsB3MIv0=;
        b=B9qsvphBpm6bB3G42Kyl8DM1mX/clX794WIfqNz3zzr28sQi9jWO06kF/rywLH3iSa
         Jnpqb7yArAAoivoO9gy9qk82x0lzNAz/ruDbY/blAnjZXJscY4oG6OBJkNARdSDjipnX
         PVgg7WoPpyQnwlV5oEWTganqOcR2Mkt3yyQULQrEaBSus0UH5UwCEW1iYVAMah2EQyUU
         XJIzr5qIqsgsL+ggEP03GaMU19kp6aQ2igVfbI4z+k039NfRGSRdg/U95Ofxp922cqEp
         YuHD3WfF1N1ZSa4JfS80PaoK7G7TDlw6W4h40jSTANuMgpRQdK3PQG+9d6ITbICVubRm
         S5wA==
X-Gm-Message-State: APjAAAW74d7RbrrL8ji/3TQvZVhg2NcumO3wOVQrA/oVeYhDKPgwWlm9
        2Gt4FUBBDjvCLgu3Uvrbv7MN7WWbPJ7zjPfQ69lEwKgBa7s=
X-Google-Smtp-Source: APXvYqzWSaFSn1p/xkKu/nTk8JDTShS1XkRJNDVHcXJf+E/HgRUTiWRJNBpO14sGxRyKRreBRD1/QWYHKp73a7558FA=
X-Received: by 2002:a1f:f282:: with SMTP id q124mr34325145vkh.4.1564059690186;
 Thu, 25 Jul 2019 06:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
 <20190722215404.GA28292@bogus> <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Jul 2019 15:00:53 +0200
Message-ID: <CAPDyKFostBKYipTkCsDbggsrux7w8BPqARx7fwRsL1XqEEX2NQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     Rob Herring <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "christoph.muellner@theobroma-systems.com" 
        <christoph.muellner@theobroma-systems.com>,
        "philipp.tomsich@theobroma-systems.com" 
        <philipp.tomsich@theobroma-systems.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "ayaka@soulik.info" <ayaka@soulik.info>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 at 10:23, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Rob,
>
> Thanks a lot for the review!
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, July 23, 2019 3:24 AM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: ulf.hansson@linaro.org; mark.rutland@arm.com; heiko@sntech.de; Michal
> > Simek <michals@xilinx.com>; adrian.hunter@intel.com;
> > christoph.muellner@theobroma-systems.com; philipp.tomsich@theobroma-
> > systems.com; viresh.kumar@linaro.org; scott.branden@broadcom.com;
> > ayaka@soulik.info; kernel@esmil.dk; tony.xie@rock-chips.com; Rajan Vaja
> > <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Nava kishore Manne
> > <navam@xilinx.com>; mdf@kernel.org; olof@lixom.net; linux-
> > mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > rockchip@lists.infradead.org
> > Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update
> > documentation for SD Card Clock
> >
> > On Mon, Jul 01, 2019 at 10:59:41AM +0530, Manish Narani wrote:
> > > The clock handling is to be updated in the Arasan SDHCI. As the
> > > 'devm_clk_register' is deprecated in the clock framework, this needs to
> > > specify one more clock named 'clk_sdcard' to get the clock in the driver
> > > via 'devm_clk_get()'. This clock represents the clock from controller to
> > > the card.
> >
> > Please explain why in terms of the binding, not some driver calls.
> Okay.
>
> >
> >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 ++++++++++-
> > ----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > index 1edbb04..15c6397 100644
> > > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > @@ -23,6 +23,10 @@ Required Properties:
> > >    - reg: From mmc bindings: Register location and length.
> > >    - clocks: From clock bindings: Handles to clock inputs.
> > >    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> > > +            Apart from these two there is one more optional clock which
> > > +            is "clk_sdcard". This clock represents output clock from
> > > +            controller and card. This must be specified when #clock-cells
> > > +            is specified.
> > >    - interrupts: Interrupt specifier
> > >
> > >  Required Properties for "arasan,sdhci-5.1":
> > > @@ -36,9 +40,10 @@ Optional Properties:
> > >    - clock-output-names: If specified, this will be the name of the card clock
> > >      which will be exposed by this device.  Required if #clock-cells is
> > >      specified.
> > > -  - #clock-cells: If specified this should be the value <0>.  With this property
> > > -    in place we will export a clock representing the Card Clock.  This clock
> > > -    is expected to be consumed by our PHY.  You must also specify
> > > +  - #clock-cells: If specified this should be the value <0>. With this
> > > +    property in place we will export one clock representing the Card
> > > +    Clock. This clock is expected to be consumed by our PHY. You must also
> > > +    specify
> >
> > specify what?
> I think this line was already there, I missed to correct it, Will update in v3.
>
> >
> > The 3rd clock input I assume? This statement means any existing users
> > with 2 clock inputs and #clock-cells are in error now. Is that correct?
> Yes, this is correct. So far there was only one vendor using '#clock-cells'  which is Rockchip. I have sent DT patch (02/11) for that also.
> Here this is needed as earlier implementation isn't correct as suggested by Uffe. (https://lkml.org/lkml/2019/6/20/486) .

I am not sure how big of a problem the backwards compatible thingy
with DT is, in general we must not break it. What do you say Manish?

As a workaround, would it be possible to use
of_clk_get_from_provider() somehow to address the compatibility issue?
Or maybe there is another clock API that can help.

Kind regards
Uffe
