Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F4FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F6B2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDSeyOj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393274AbfJPQQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:16:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34132 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390076AbfJPQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:16:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so18010971lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ylL1eydi6OUMBpWNcbTT5Kqt/V1VFfcpzawFZbwf6M=;
        b=kDSeyOj2cXVo7ubdqGLKFFuJ5cwxCUGu2SnwcczXReu8aRgDcead9Wx74qE6k3g3pE
         /07VqXUD5t1xAzaAb2w/P2S+kDu9v7iCNXin8iwCbXhpcKi8EG1A2GmMevstjIgJsKAV
         9T4qEBQcU5aRhoXOw+QwOeSdEIjAMq1EE0I4c9TmZKtTP7eCND+NEHSTRHfMMM9JN4lZ
         p/ITNKm/aLkWLrIn27E60n4e65CNws8LVq/AMlALEwJ5P8dJbhOA8n0PXVL/+h5p+6L9
         UqVqldxfOwPgSaioISiX3JNEN7mxF8WoKmEyn4UvRK3STHuPAdDOgxkeBJhX6pkJRBiX
         a14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ylL1eydi6OUMBpWNcbTT5Kqt/V1VFfcpzawFZbwf6M=;
        b=EeUDDbJKFOpQMVuG/t2F4kHGT4qEO0ngXNFdUmgiUfnFyoJCRxZxqLqWocZBl/kQeW
         j7MCfE2CoIYHJgWd2Z2jROYPn/kLvdBOox3VbBGLBqhVarPgHdDTkEa8KvJTjye4GW3I
         PiNMKO+snE3Z6hbWRNKL1Bt/Z/mt3uNwnmCE9vds5w3BKhpisQPLLFPUEhoiO1nNjm+c
         PLJO3T151A2X0V88fKI37pTqfwKqGx7UYs3Fniibo586gSbGv0EoZyb+Uq6kqGbBuRkf
         3H9hS3T6tG5204SOa8/2FDRZ+6RjszZ8E4mUGegFPovtS9FMX1LYf35yQKYDWOF/Cp1y
         KXaQ==
X-Gm-Message-State: APjAAAWLsnvMBNwb7flxs4a9bBo3lVhZhCBFQZUxBiexvnHm9pOrbYlP
        3pu6NHvkyCMTg8WxRChsG2gHgXpcldSLMf92hCs=
X-Google-Smtp-Source: APXvYqxro5i35Ft6ZD3j7iIxrRJ7VRGx4dCwTbmqD/NDL7ZHsmxJkNf1lH2oVljT+08Fxt5pyVK8s657Msykgea09JE=
X-Received: by 2002:ac2:5610:: with SMTP id v16mr25010105lfd.93.1571242563292;
 Wed, 16 Oct 2019 09:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191012200524.23512-1-alistair@alistair23.me>
 <20191016144946.p3tm67vh5lqigndn@gilmour> <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
In-Reply-To: <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 16 Oct 2019 09:10:54 -0700
Message-ID: <CAKmqyKO1QugY=JHORoGnPjTqZQV-jMfey8T3144vaqTwNoCwqA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sun50i: sopine-baseboard: Expose serial1,
 serial2 and serial3
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 7:54 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Oct 16, 2019 at 10:49 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Sat, Oct 12, 2019 at 01:05:24PM -0700, Alistair Francis wrote:
> > > Follow what the sun50i-a64-pine64.dts does and expose all 5 serial
> > > connections.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > ---
> > >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 25 +++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > index 124b0b030b28..49c37b21ab36 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > @@ -56,6 +56,10 @@
> > >       aliases {
> > >               ethernet0 = &emac;
> > >               serial0 = &uart0;
> > > +             serial1 = &uart1;
> > > +             serial2 = &uart2;
> > > +             serial3 = &uart3;
> > > +             serial4 = &uart4;
> > >       };
> > >
> > >       chosen {
> > > @@ -280,6 +284,27 @@
> > >       };
> > >  };
> > >
> > > +/* On Pi-2 connector */
> > > +&uart2 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&uart2_pins>;
> > > +     status = "disabled";
> > > +};
> > > +
> > > +/* On Euler connector */
> > > +&uart3 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&uart3_pins>;
> > > +     status = "disabled";
> > > +};
> > > +
> > > +/* On Euler connector, RTS/CTS optional */
> > > +&uart4 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&uart4_pins>;
> > > +     status = "disabled";
> > > +};
> >
> > Since these are all the default muxing, maybe we should just set that
> > in the DTSI?
>
> Maybe not, since people may want to only use RX/TX, and leave the other
> two pins for GPIO?

I think this makes the most sense for the default.

Alistair

>
> ChenYu
