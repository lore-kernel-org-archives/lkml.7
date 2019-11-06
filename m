Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03546C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19392178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVYt2y6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfKFVvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 16:51:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46257 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFVvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:51:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so14603799ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 13:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXHffMhLqHV3+nf/8dCtN6KvSuj9fMAxyuhOM6lmxAs=;
        b=VVYt2y6mmF5rVyBM0aYxD9AE+a5vRgGSZdO2bi6U8c2WRgi/xa1J4PtJmJT0eOD2LO
         fOEs7VCCtZybdoirayhpjnp+VhEvb8EjdzfpBnEEMqTUttfbGrt8EWWqpyjFOqq9NEbe
         2NwK3aTU5HmFQnjUtXz2CrxS1My5iMESEuWgC7ZQt2olHOcgexC2ABFg6wLLhunB0LuO
         x58adyhHwK/9vfVq+EPDnO/sMQ1P7dxkL+sWQFV5oFe/VVbMyFmNJYcGJQS01htj31hW
         YzjC09YBrNwzoOnmkRwSHMlh18D1KtcSXa7a1x/yVkslgjFKHvED3ATLTbOi48aEhKhD
         RlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXHffMhLqHV3+nf/8dCtN6KvSuj9fMAxyuhOM6lmxAs=;
        b=hUJRBspmn9j7XyBrMpG7shNH+/5bOWfafktqVjdCNHwYkKY94jnrn6gQBfaJfzsYt4
         N03I3oB4Cx1oPVs+zfqpG5QkPAwB3jpfwbh53Dae+wEee4O5gb4EE0xytNQM7c3mjFnq
         ErkFqRKeNkjgks5TDYAygTMLRjt26GfAQAu6Mq8wFT8i7clUQf24FeHJMScfkag5HL19
         JydhYr4Unx+0cXhMv+ucc/BPdK2sp1tiaINBcrd5mHGoWZrhwvCyYJOYKOYY+hPhu/Rx
         brgxX0GisNWiDG+wH3NJyTub/bGnO8gX3fhRleMHpTmM68BtjfGM+6X5jgcxkekzgcD4
         hqHQ==
X-Gm-Message-State: APjAAAXJrdLZI/0aUdvnG/1s6WbPkFjk8hYBsDjJFqjUIgEfLEulc3Dm
        1rcqrFPL0QZfUXop8qYz5U7APZ+nWhTcWg3HiuQ=
X-Google-Smtp-Source: APXvYqy/wCCWRQ2JBV3PNapXKlfu1wU4Z35nh3XscrtsJDbENGiKGiAE5Q0b/ln+I7HSRVkJr0GqvlyeoxZt6njoZZY=
X-Received: by 2002:a2e:6a19:: with SMTP id f25mr3575611ljc.147.1573077069287;
 Wed, 06 Nov 2019 13:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20191012200524.23512-1-alistair@alistair23.me>
 <20191016144946.p3tm67vh5lqigndn@gilmour> <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
 <20191021111709.dpu6g7jltuw6cbbn@gilmour> <CAKmqyKN8Ru19h3y=9O13=5wpys3BC2LQM65S+2QYjPdJQn2O4w@mail.gmail.com>
 <20191106115222.GA8617@gilmour.lan>
In-Reply-To: <20191106115222.GA8617@gilmour.lan>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 6 Nov 2019 13:45:24 -0800
Message-ID: <CAKmqyKOQDD848PCXrqB1YD5OORtGhSF_uz4WzAzYr1iEQANZag@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sun50i: sopine-baseboard: Expose serial1,
 serial2 and serial3
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 3:52 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Tue, Nov 05, 2019 at 11:27:42AM -0800, Alistair Francis wrote:
> > On Mon, Oct 21, 2019 at 4:17 AM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Oct 16, 2019 at 10:54:27PM +0800, Chen-Yu Tsai wrote:
> > > > On Wed, Oct 16, 2019 at 10:49 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > > > On Sat, Oct 12, 2019 at 01:05:24PM -0700, Alistair Francis wrote:
> > > > > > Follow what the sun50i-a64-pine64.dts does and expose all 5 serial
> > > > > > connections.
> > > > > >
> > > > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > > > ---
> > > > > >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 25 +++++++++++++++++++
> > > > > >  1 file changed, 25 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > > > index 124b0b030b28..49c37b21ab36 100644
> > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > > > @@ -56,6 +56,10 @@
> > > > > >       aliases {
> > > > > >               ethernet0 = &emac;
> > > > > >               serial0 = &uart0;
> > > > > > +             serial1 = &uart1;
> > > > > > +             serial2 = &uart2;
> > > > > > +             serial3 = &uart3;
> > > > > > +             serial4 = &uart4;
> > > > > >       };
> > > > > >
> > > > > >       chosen {
> > > > > > @@ -280,6 +284,27 @@
> > > > > >       };
> > > > > >  };
> > > > > >
> > > > > > +/* On Pi-2 connector */
> > > > > > +&uart2 {
> > > > > > +     pinctrl-names = "default";
> > > > > > +     pinctrl-0 = <&uart2_pins>;
> > > > > > +     status = "disabled";
> > > > > > +};
> > > > > > +
> > > > > > +/* On Euler connector */
> > > > > > +&uart3 {
> > > > > > +     pinctrl-names = "default";
> > > > > > +     pinctrl-0 = <&uart3_pins>;
> > > > > > +     status = "disabled";
> > > > > > +};
> > > > > > +
> > > > > > +/* On Euler connector, RTS/CTS optional */
> > > > > > +&uart4 {
> > > > > > +     pinctrl-names = "default";
> > > > > > +     pinctrl-0 = <&uart4_pins>;
> > > > > > +     status = "disabled";
> > > > > > +};
> > > > >
> > > > > Since these are all the default muxing, maybe we should just set that
> > > > > in the DTSI?
> > > >
> > > > Maybe not, since people may want to only use RX/TX, and leave the other
> > > > two pins for GPIO?
> > >
> > > Right, I'll apply that patch.
> >
> > Ping, just want to make sure this has been applied/will be applied.
>
> This has been applied, and was part of the PR for 5.5 sent last week

Thanks :)

Alistair

>
> Maxime
