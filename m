Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5090BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A832183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WhXE1oQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfDRMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:30:39 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53192 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbfDRMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:30:39 -0400
Received: by mail-it1-f193.google.com with SMTP id x132so3003037itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+fIGS9wz6NOXPBAIJc986U9/USK2WuNFF0ivuzohWc=;
        b=WhXE1oQlGKA+r/jf7iL9CyTGsYpjvwAKMl8GTcScMs/zf2py/uxbNFvH34IFUwPDVl
         lyedz+bTe8wIfqUnT1eO9fgAh81aiE9DeC/AnbMb8LFgazmTmxo7C6R5iiTZu+BLk7R5
         tAN6pCv9wfd4QYTxGWM7aPpcyfmEI+lPcuHcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+fIGS9wz6NOXPBAIJc986U9/USK2WuNFF0ivuzohWc=;
        b=FY2nnyDacXYM6aO0ouYOQbokQ79WIkeLaFS6k2d/EhzHQ9GbGZApqiNYJQkVHo3+8Z
         wYadBWKb+aJZoWBNCTXwD2ArpJILwH2eRFqKvptgmWWuSb7k+IUrsqr8rTDWiNw7g5ZI
         ymRC1ulgPsbJ47+WyXpok0fnYL3UiTv0JtCRO3vZn3LZZRqUueuPmH+zaO6AdhtaaA3s
         v2RKvnnyZdaSg2K7YlAUR5jRCSMQ4+03qCpWKJD+gNhiyL9oR16BvusfDC6WelxjGuxl
         4eR+UDZ1on/2hm1fe8SBuUz7d4GW5xJN0x+YaXkQejqhiF1kwIR8LmGChnpt/+NqBwHt
         PTsQ==
X-Gm-Message-State: APjAAAXWt/bNndg9INqAn5hJN4m0NFkovr353Ex4g1hjzGupAXKJBH3c
        42ydkZ/gW39Q/tMjwcgRFfLbY3up+cPVrJ1b5LWlaw==
X-Google-Smtp-Source: APXvYqy5hEk1YcnrjJYBsszJ+JpNfbke8/Mekx9YcsVJP8KsmWkSxAGuWIqNs6BKU+nfWWtfAnvuTfDg2LHXY+a/VOU=
X-Received: by 2002:a02:a399:: with SMTP id y25mr8322640jak.58.1555590638603;
 Thu, 18 Apr 2019 05:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190418083543.11695-1-jagan@amarulasolutions.com> <20190418112357.qic227rdwordmzyh@flea>
In-Reply-To: <20190418112357.qic227rdwordmzyh@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 18 Apr 2019 18:00:27 +0530
Message-ID: <CAMty3ZDwhB+63i_Cy90n0Y_Ra6XdTXbsX+z5q6swnj=FLH976g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: allwinner: a64-amarula-relic: Add
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

On Thu, Apr 18, 2019 at 4:54 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Apr 18, 2019 at 02:05:42PM +0530, Jagan Teki wrote:
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
> > Changes for v2:
> > - drop i2c1, bias-pull-up
> >
> >  .../allwinner/sun50i-a64-amarula-relic.dts    | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > index 3575db216016..3819ce396073 100644
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
> That's the default already

Yes, and i2c1 node in sun50i-a64.dtsi is not attaching pinctrl. So I
attached here.
