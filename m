Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B328FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821EC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjJ+LF+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfEOPJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:09:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38484 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfEOPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:09:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id u199so19153oie.5;
        Wed, 15 May 2019 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzdAY9eNLFH6q18HeEB4S9VM37pJLDSHQjylPsT3TbY=;
        b=MjJ+LF+8pBMZJmrf/PUQGYzx6jkAIvZXVOaDkwDUy9j8LjnckyRKVimNt3qRpZ7QXs
         odt09gcUESirFG4LKGWD8wrs44NwvpmYA2lxf+ihQ7feGSSECN829NXz97xTZk1YqWok
         35/lGba1azoqDEabJk9bWsU7/bkhsjO9nkRYDhC0oT9sbfj+MNtAHSqEKLAJhOF3S6Rs
         R+rUWZGYA0dVjK3uQ9i1dVZfPXcCRFzlBj3LZ2YdHmMedSaa4kOtX9v0QZ8SKRLyhu7Z
         yvA1skM2zKLs6y+yPy3x/+CSXqODR2VRcyLDYU2/3JhylYVvTFrpq49h0oyAJEL7ENkN
         jPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzdAY9eNLFH6q18HeEB4S9VM37pJLDSHQjylPsT3TbY=;
        b=rSQxCXZ7QavzWRWgkflSEk87bo14SgVlvLzbfqgB0pNmbsdXtnlvhhbQgYBNTv/Sx0
         F3DP0/7XyPKgyLZ9jxa4H0TcQMuJERs7jSaiSZbCCOSkHBQAE235B2kqm3BhN8hcjdWb
         /U3QQZTKCMJ3y5G9vLUZZipX2uBSm/rrZdtFDFBk/UHhu0PBamd8FJHBJ7KYCSPoFzzv
         GTBo0lI9fnFkMt90Z9S6W/JtKkKTMyYHqy8e9ovsn8lpFOyqzrBOZp6Rnrn1ezgxMCnc
         raqC01dqPPqVhr/jMSln0jl/1wx6hYe3vVg+OIsoJbWdKJ/447hz8OvLBzEnrHu7GGoE
         WZJA==
X-Gm-Message-State: APjAAAUhgiW2+wuUBRqtwYfSgvynFpNBA/dUtRIQI3n9ZbMaPH29aoDB
        6EIgkk6YovpedHN99KIZpDrtsi5S14Ahqr4qKZ0=
X-Google-Smtp-Source: APXvYqx2op3tX9A4P1hZwzw0eFhbk5CfYg0Tbl3ieHQEQJwA11MZzaowFPPO1ZfSsj+7d5NaD8TUBJpiL4dsKvwOW9o=
X-Received: by 2002:aca:240d:: with SMTP id n13mr6735433oic.145.1557932964018;
 Wed, 15 May 2019 08:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190514155911.6C0AC68B05@newverein.lst.de> <20190514160241.9EAC768C7B@newverein.lst.de>
 <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com> <20190515093141.41016b11@blackhole.lan>
In-Reply-To: <20190515093141.41016b11@blackhole.lan>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 15 May 2019 08:08:57 -0700
Message-ID: <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge on Teres-I
To:     Torsten Duwe <duwe@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 12:32 AM Torsten Duwe <duwe@lst.de> wrote:
>
> On Tue, 14 May 2019 10:48:40 -0700
> Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> > > +       anx6345: anx6345@38 {
> > > +               compatible = "analogix,anx6345";
> > > +               reg = <0x38>;
> > > +               reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24
> > > */
> > > +               dvdd25-supply = <&reg_dldo2>;
> > > +               dvdd12-supply = <&reg_dldo3>;
> > > +
> > > +               port {
> > > +                       anx6345_in: endpoint {
> > > +                               remote-endpoint =
> > > <&tcon0_out_anx6345>;
> > > +                       };
> > > +               };
> >
> > It doesn't comply with bindings document. You need to add out endpoint
>
> It does comply with the bindings. The ports are all optional.
> As far as DT is concerned, the signal path ends here. This is also the
> final component _required_ to get the Linux kernel DRI up and running.

Ugh, then bindings should be fixed. It's not optional. It may work if
bootloader enables power for you, but it won't if you disable display
driver in u-boot.

> > as well, and to do so you need to add bindings for eDP connector first
> > and then implement panel driver.
> > See Rob's suggestions here: http://patchwork.ozlabs.org/patch/1042593/
>
> Well, one *could* extend the hardware description down to the actual
> panel if necessary, but on the Teres-I it is not. I assume the panel
> they ship provides proper EDID to the anx6345, because the display
> works fine here with this DT.

I guess you're testing it with older version of anx6345. Newer version
that supports power management [1] needs startup delay for panel.
Another issue that you're seeing is that backlight is not disabled on
DPMS events. All in all, you need to describe panel in dts.

[1] https://github.com/anarsoul/linux-2.6/commit/2fbf9c242419c8bda698e8331a02d4312143ae2c


> Do I understand this correctly that the (3 different?) pinebook panels
> are not that easy to handle? I try to include the pinebook wherever
> possible, just because it's so similar, but here I'm a bit lost, so I
> had to omit these parts.
>
> Should I also have added a Tested-by: ? ;-)

I don't have Teres, so I haven't tested these.

>
>         Torsten
