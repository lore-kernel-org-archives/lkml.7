Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F0420657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9HrIa/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfEPQHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:07:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44256 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfEPQHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:07:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id z65so2896986oia.11;
        Thu, 16 May 2019 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=If7DIMq1Gfx6XG6/ApM/VqLufFm2C3KncjrdjTPi5fw=;
        b=W9HrIa/zrt9i9wWQLsWOgqvOcJ/ZEinVeMjhGTg/M6LgXGdcbPB38gp7CKW1Akzuix
         FZeEC2qxcJaDiDUQWE144oDzyC6CIY14bFcVik75qRdaFo6gpHvLaXMHScwpez/TBXDE
         LEJud/rc55JbTq4FLPH0uKppHUcREMpYUO0cWhrffQid3TzgZG0dj9tA79ffwhu7DX1L
         ARsIgzfa6OlYV0/AUIwNy4TqKQ6NF/L3JtlzigKT31jbr3qBLHxPDUBJIR439EiMSiLt
         zv6T7X7Lj9kuFbhIBO14quCYdRswsASy27tioqzSIKYGeVZBprXPfyb9dHAXh381oL9i
         Ed7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=If7DIMq1Gfx6XG6/ApM/VqLufFm2C3KncjrdjTPi5fw=;
        b=KJSdjYedsUL7N/IsSUCKn+nbO7QWyCAlb60awKoGDU+Er0lKkYfKeqOnna+AIS5x85
         uWFODuHhFIc3zgGBYlBipfo/5oQijLpjpkxez/kPTyR/jdYpxIAGUDzMQvWVlkAHIO9X
         1fKDewXzW8FgP4GQ6g7De509kQT4/XwopmnmwEQ93NK1E5jlqhhuE2DeIknDAJlOgFqQ
         cB6AOIjjmszJB6TJAqa1gP1yLpHRoq836O/esJo3L6ok56L6lTuT9dOWE3JdxlT2IZTG
         JiBkJ47+UqKHuMWAC3BulJhK9q+uwj4/gE+2lXdeLPIMQUXqFEpWTo4jEZpyACkWE/lo
         Ozkg==
X-Gm-Message-State: APjAAAX/AiM1DRiz6aYX9lEOmulMI2FiLGVrwi//IhGjtbIOdLtIwvBi
        S7Ten5gP07WVqy4R01G1AOSaBdV5kjKokSmdgUE=
X-Google-Smtp-Source: APXvYqxeWnmWZhffcM9dTuiS/N02EO1l6OnHcvpZADX+xNRI7YfuXCN7riZ/UAUEu9b/pdmZpShaSStxlQVSsRJkIpk=
X-Received: by 2002:aca:38d4:: with SMTP id f203mr1339419oia.88.1558022828175;
 Thu, 16 May 2019 09:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190514155911.6C0AC68B05@newverein.lst.de> <20190514160241.9EAC768C7B@newverein.lst.de>
 <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com>
 <20190515093141.41016b11@blackhole.lan> <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com>
 <20190516154820.GA10431@lst.de>
In-Reply-To: <20190516154820.GA10431@lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 16 May 2019 09:06:41 -0700
Message-ID: <CA+E=qVe5NkAvHXPvVc7iTbZn5sKeoRm0166zPW_s83c2gk7B+g@mail.gmail.com>
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

On Thu, May 16, 2019 at 8:48 AM Torsten Duwe <duwe@lst.de> wrote:
>
> On Wed, May 15, 2019 at 08:08:57AM -0700, Vasily Khoruzhick wrote:
> > On Wed, May 15, 2019 at 12:32 AM Torsten Duwe <duwe@lst.de> wrote:
> > >
> > > It does comply with the bindings. The ports are all optional.
> > > As far as DT is concerned, the signal path ends here. This is also the
> > > final component _required_ to get the Linux kernel DRI up and running.
> >
> > Ugh, then bindings should be fixed. It's not optional. It may work if
> > bootloader enables power for you, but it won't if you disable display
> > driver in u-boot.
>
> I double-checked. On the Teres-I, mentioning the panel _is_ optional.

It's not. See power on sequence in
https://www.olimex.com/Products/DIY-Laptop/SPARE-PARTS/TERES-015-LCD11-6/resources/N116BGE-EA2.pdf

Driver can talk to the panel over AUX channel only after t1+t3, t1 is
up to 10ms, t3 is up to 200ms. It works with older version of driver
that keeps panel always on because it takes a while between driver
probe and pipeline start.

It'll likely break with newer version of driver that turns on panel
only when bridge is active. You'll see AUX timeouts - it won't be able
to probe EDID in some cases. Problem can be intermittent and device
dependent.

All in all - you don't need panel timings since there's EDID but you
still need panel delays. Anyway, it's up to you and maintainers.

> PD23 powers down panel and backlight as much as possible, see
> 24bd5d2cb93bc arm64: dts: allwinner: a64: teres-i: enable backlight
> (currently only in Maxime's repo) and the Teres-I schematics...
>
> And the driver in your repo neatly guards all accesses with
> "if (anx6345->panel)" -- good!
> But I found the Vdds are required, so I added them as such.
>
> > I guess you're testing it with older version of anx6345. Newer version
> > that supports power management [1] needs startup delay for panel.
> > Another issue that you're seeing is that backlight is not disabled on
> > DPMS events. All in all, you need to describe panel in dts.
> >
> > [1] https://github.com/anarsoul/linux-2.6/commit/2fbf9c242419c8bda698e8331a02d4312143ae2c
>
> > > Should I also have added a Tested-by: ? ;-)
> >
> > I don't have Teres, so I haven't tested these.
>
> *I* have one, and this works. I'll retest with your newer driver,
> just in case. Nonetheless, the changes in this series should be fine.
> Sending out v2 in a moment...
>
>         Torsten
>
