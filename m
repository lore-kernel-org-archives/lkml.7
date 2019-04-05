Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD54DC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5EF20700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="najpfBIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfDEQY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:24:27 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38621 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:24:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id w206so2449853ybg.5;
        Fri, 05 Apr 2019 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DSOL+tWZjghaL+H4kv+T9sf5HBi8owquhf/5/RkxJjE=;
        b=najpfBIiD70dmQdF1WJ2DjCryNoY/aUeTFQkTKw/PS6KYKPIzewQQvbvPfv6zRWr9F
         f1ELQ7hlf8ja9ale4v2g8ACgnxBfHq00JWYPou3dx6EAF9a1jevjoML9tWO/yUfMIBPX
         w5vwIPiiXljwflhqwUPuFmRRmHIcXPjFrQt8m/9LEg++1+0ZJCsfca82S3brFfyRCkJd
         j5DMyfYDJa2I9S6Xx/KydtduFfXx5mjSvGBeVOt2GH5F2cQFwRTjnX+SxR8VMPrUeC2H
         viB9odSzMuaMQkIY3pT32X5E2uHZkFfX7GMAoliXQ1qBJX2gRnltL0kBFVUF14O5WQX/
         bsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DSOL+tWZjghaL+H4kv+T9sf5HBi8owquhf/5/RkxJjE=;
        b=K5B1gQ674yuhYREUUgrvVmtF9zxPSHWNBZvmUhKrS6mYiULw9wluCMilfmLNBibNr4
         q/kxtlefLZTrnCRu+g6D20Umc/5nNzK75TpOKY7ZscgjFQbmvnio/zq9O7MgF/PyXUCH
         ykur1W7yDJdVRXH92+/hIJfZfjCksjvXftlOMaLK9d/evwxJlJ2UTHZwGks1MH3lJdQo
         ipy2RT2X+mU7kQngRXXj/PAyIN8s7VecmiJ4z42xYP7Fd3TxmDW3o4qolxB0NJWOAYPu
         n2tYVqlhQerOABdSoBELQprdkZKz4LJ+CohP5QkOh2rnb8W1OPNMJUGvPPiBdT9RPhT7
         GhkQ==
X-Gm-Message-State: APjAAAUk/ObQBGHDNcZA5jiCasPRjjDAXejP0vZsP+b2FqaFiEOhKlMq
        7ZxVhsB5TkOSFzdx4NUSopNShYT97xovJ0bTR3U=
X-Google-Smtp-Source: APXvYqy4QjjWHm3bxQNqp7v7IJA4LcQa8Jk+9FKC4ls3kaWr4KTrPM8VKoXpvMH4bME0c0AZ/vmoAoqBw0Behy6jQzc=
X-Received: by 2002:a25:868e:: with SMTP id z14mr11714901ybk.319.1554481466241;
 Fri, 05 Apr 2019 09:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190404135736.8491-1-peron.clem@gmail.com> <20190404135736.8491-2-peron.clem@gmail.com>
 <20190405090236.e7vnyjzxmzfke3d6@flea> <CAGb2v65wcEAUTwRhC42iRkPaWXLGX1CJeq+TSzHVTOrT+L=8vA@mail.gmail.com>
 <20190405145005.jmmwsvbateqssbyq@flea> <CAGb2v66cv7dVwj7oyRaHT5Q2XCbNqzuS-Uk9hdNJbVv57QOmUg@mail.gmail.com>
 <20190405150810.zjwtu6crzaz6ufhx@flea>
In-Reply-To: <20190405150810.zjwtu6crzaz6ufhx@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 5 Apr 2019 18:24:53 +0200
Message-ID: <CAJiuCccfmwxAqK1mTJ3eLO0RggV8sZTTKRy=fxFFenxn1hATvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: h6: Add watchdog node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Apr 2019 at 17:08, Maxime Ripard <maxime.ripard@bootlin.com> wrot=
e:
>
> On Fri, Apr 05, 2019 at 10:59:35PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Apr 5, 2019 at 10:50 PM Maxime Ripard <maxime.ripard@bootlin.co=
m> wrote:
> > >
> > > On Fri, Apr 05, 2019 at 10:35:08PM +0800, Chen-Yu Tsai wrote:
> > > > On Fri, Apr 5, 2019 at 5:02 PM Maxime Ripard <maxime.ripard@bootlin=
.com> wrote:
> > > > >
> > > > > On Thu, Apr 04, 2019 at 03:57:36PM +0200, Cl=C3=A9ment P=C3=A9ron=
 wrote:
> > > > > > Allwinner H6 has a watchog compatible with A31.
> > > > > >
> > > > > > Declare it in the device tree.
> > > > > >
> > > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > >
> > > > > Applied both, thanks!
> > > > > Maxime
> > > >
> > > > IIRC there are 3 watchdogs on the H6. One is the trusted watchdog,
> > > > which should be reserved for underlying firmware.
> > > >
> > > > The other two are the normal and R-block watchdog. Although they
> > > > look the same, the "normal" one can't reset the system. :(
> > > > That one is actually the one ATF currently uses. So reboot doesn't
> > > > work on the H6.

Some users report that the reboot on the PineH64 actually works.

Clement

> > >
> > > So that patch will not do anything then?
> >
> > I'm still on vacation, so I haven't checked the address of the new devi=
ce.
> > If it's the normal one, then yeah, it won't do anything. I've tried tha=
t.
> > IIRC Samuel (or someone else) on IRC also mentioned this.
>
> It's the one in the timer that we've used since pretty much day 1 on
> older SoCs, so I guess it qualifies as the normal one :)
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
