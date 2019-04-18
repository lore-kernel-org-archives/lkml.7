Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E500CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C3220821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gMka/SCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389291AbfDROJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:09:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36495 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfDROJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:09:40 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so3514920itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vQxUTPpV+QAp7VOe/pO5Z/vllrtqd6aopV/0UIfOpI=;
        b=gMka/SCNNhO0vI6WZZPtw3c+pS8Q7LI+v9OOgbxqfKqo/d4Fm7kF3hYdwUide+9gA9
         qau5Ayopc7lp4BLvVaDVav0NaKJn+rACFg8oak1yUK77Vx43c9rfCZuRX3sIuLuDKeKZ
         TEI5vdZaS+5tUHavFhyQ5KM1Hw9duqEhD6geE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vQxUTPpV+QAp7VOe/pO5Z/vllrtqd6aopV/0UIfOpI=;
        b=lAXRbIVMkVYhlKXsMt87hWFufBbD/fG9P4mtG9OTk8ByRKpsuHEiVqOFUA8uv6O3Vw
         iC3/lCZJwCjGNnK9WwYfIDyEKV+nCT9TdI+k95sQC+nl/EMdcirjVVlo73yaKWjMdZhk
         AwFiHFHo64WibLWDQH9pvgQmF4hs2c3kMphs7Ty0nOFTdTl8DDl7KUFnXsCGJKZ7zKG9
         FhwkH2esLP7hthpv7MjPcXGZZe+zGhn9iUX6B5gb8FKqLhEB+6JKr9bBYtsHfewPGueD
         msDyMCueHeF0Bd6ousOQaMvRvHSWBl0N7KDN2lkg3FJTC0T3g110vyFJrKpNcIe86Bro
         eWrw==
X-Gm-Message-State: APjAAAV0SECvkk5RMdEDqivFgOhML+PmTNO8k97atUpvKcwCtoSCpP5U
        8RVVfUAiWHVc1xPhp9BScVAGrAlae+FnCwVM6ke4Dw==
X-Google-Smtp-Source: APXvYqwVBc0daa3q02n1pDv9nt2WeRCrhhmyTba0J46IZtNDw+1BN3cAq8Z3eSoiKkVZcRRvdjxxKXm5SHXOAHE5a2U=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr3581824itb.107.1555596579055;
 Thu, 18 Apr 2019 07:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190418134838.8806-1-jagan@amarulasolutions.com> <20190418140423.ch43fz2xuk5teqyl@flea>
In-Reply-To: <20190418140423.ch43fz2xuk5teqyl@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 18 Apr 2019 19:39:28 +0530
Message-ID: <CAMty3ZAGWOtkGRXLLZ14XgNYDX7-XtEbt+y53eqCJJKgfxwNuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: allwinner: a64-amarula-relic: Add
 GT5663 CTP node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 7:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Apr 18, 2019 at 07:18:37PM +0530, Jagan Teki wrote:
> > Add Goodix GT5663 capacitive touch controller node on
> > Amarula A64-Relic board.
> >
> > The CTP connected to board with,
> > - SDA, SCK from i2c1
> > - GPIO-LD0 as AVDD28 supply
> > - PH4 gpio as interrupt pin
> > - PH8 gpio as reset pin
> > - X axis is inverted
> > - Y axis is inverted
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - Use 2.8v for reg_ldo_io0
> > Changes for v2:
> > - drop i2c1, bias-pull-up
> >
> >  .../allwinner/sun50i-a64-amarula-relic.dts    | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > index 3575db216016..bd31a4385bc1 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > @@ -49,6 +49,24 @@
> >       bias-pull-up;
> >  };
> >
> > +&i2c1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&i2c1_pins>;
>
> You haven't fixed this, and you didn't either in the second patch.

Sorry, I interpreted previous comment to keep this pinctrl.

Since i2c1 node in sun50i-a64.dtsi doesn't have pinctrl attached to
it, added here like i2c0 is it something wrong?
