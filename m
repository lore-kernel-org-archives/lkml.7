Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8167206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiYHgGfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfDOIJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:09:23 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42846 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:09:23 -0400
Received: by mail-yw1-f68.google.com with SMTP id e76so5692811ywa.9;
        Mon, 15 Apr 2019 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5FF98CIqtyE2Fy2k0bmkw2sa4GHJCZnGCxNLUt2DcAI=;
        b=KiYHgGfFv/KEzp1wWWwS0FbtdSCM5TpXwUpMmPbbQALgB9guG85e7+4W8Nittb+uRy
         PQ5cED9u5g8ZPMB1g/3QQgqFJukJKpj773r0XdES9gbnZ65s9k5S8KRd02CTL2XVRl7A
         IrjSDmQE3cRcOXS/CIN9VhiGRmVAk5YzJh6p9kzWS9f48QoVxqwmfmNaNu99QOh5uBbG
         laGIADRcGjcjAYA8inTtONueJUA4bSJ7JKMaRle3bqXkUBbBhpf8ORkqRVQAQP7L7gXe
         +CO4QVTorn/LgEDqt0oD4LXLRsISm2pzF9EUy/OiqtUlOtrVuOOoAl1RZkWfatmTpgAR
         0BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5FF98CIqtyE2Fy2k0bmkw2sa4GHJCZnGCxNLUt2DcAI=;
        b=Agf41Pyt5yyC0wBjvHKdPhTwOhxhFmPjjy1Ha+CjdQXe4cnCVUxqN/1OWwmbWyqTF3
         p12W0jvkI9F6yihMuaT7mvRPGV+VhOPFATMr43ZqhkwUnlLeGrQFUIsFiT7ReIARa3N+
         zxaS8OHQdSrS7k2MC8Fk+/PfkqNbBPTOBuKf49pc7LSLNyssnWESXCBPyme8crvOnoms
         /15as3dwZp4MrSV9oWqSxiZk6DYzWopp7AiGKd8482GDvDCXJSZCG/JFM+JlgaTXRGS+
         LgW89ebq3gyAdGPTDKR8lznytDwVMdvRKliW9vyY2MAisc8Unoq/Lp4nbJ24r4/OTjNH
         n0/A==
X-Gm-Message-State: APjAAAWFu3rkjnsXrCUMGmm98NgbuEfgTNymkEfRA3npoy9PTihYvEEY
        8U9zevmrt5ZeWWUK55Uq4SZ7D77fR0ubNLKMNsQ=
X-Google-Smtp-Source: APXvYqzhRrgNvHwN+eFuyBuzU6nIw9T1nkKQCMzCejwF4UoN95UKAGf9TwhVoAtboaG40hO56RWJkFwQvdhv3pTW5NY=
X-Received: by 2002:a0d:d645:: with SMTP id y66mr58420161ywd.459.1555315762517;
 Mon, 15 Apr 2019 01:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190411214422.2267-1-peron.clem@gmail.com> <20190411214422.2267-2-peron.clem@gmail.com>
 <20190415080443.frubh4ln4agrdsfe@flea>
In-Reply-To: <20190415080443.frubh4ln4agrdsfe@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 15 Apr 2019 10:09:11 +0200
Message-ID: <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Apr 2019 at 10:04, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> Hi,
>
> On Thu, Apr 11, 2019 at 11:44:19PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Allwinner H6 has a SPDIF controller with an increase of the fifo
> > size and the possibility to output the master clock.
> > However it's still compatible with the already existing driver for
> > Allwiner H3.
> >
> > Add this compatible in the device-tree bindings documentation.
>
> How was this tested?

Using Alsa utils on a Beelink GS1 and I check correct output sound on
my home cinema.
>
> After looking at the datasheet, it looks like it's still significantly
> different. In particular:
>
>   - The MCLK divider isn't at the same offset
We don't use the MCLK
>   - The bits to flush the FIFO aren't at the same offset
>   - The FIFO trigger levels aren't at the same offset
>   - The FIFO status register layout is almost entirely different
We use DMA not FIFO

Clement
>
> So it doesn't really look compatible to me
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
