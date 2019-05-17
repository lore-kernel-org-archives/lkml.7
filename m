Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73936C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42561217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnGDVA/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfEQP0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:26:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37760 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfEQP0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:26:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id f4so5455498oib.4;
        Fri, 17 May 2019 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xu5A8L7ffk/VuZGGKLFuV6FJUYoNh1BlyhIBaFYJKc8=;
        b=fnGDVA/CPKgszzyvVNGPqdLlo3j4aBFjTJaRyaTzUsUqqtk3Ma/fdvvR6u0jV1QpnS
         ODbWVtFHuGlSkV64ydsIhDYXqWgNvxd9hUKbNVi5azAzpVFWM1JIDuYaGNdd8Pf7kLvX
         gOWTKjEWmmd5+7p/9sWiB9SWvYBGUPrXCEKwk5+wh97ypDgkeA/yPNjXzolAz6em//4Y
         QpgLVf7kpkbMl5b/Ilzqoh78hJdNKJDZRf2yAEaDS8wriC7brnX2Mbko/37I/M5hGoS6
         H4iTDp7tO94GqQ+BaRhwoGNj18Nk/9lxuceTbcsD1wfLtP0skneXJODVFpDmJzqZhHFJ
         vlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xu5A8L7ffk/VuZGGKLFuV6FJUYoNh1BlyhIBaFYJKc8=;
        b=L2vOs/Mci6avbkPZqtCdNGOWtw0dp/SMpg8KYbnR/mnbrczCUe8LZKDZ3mzFFGSiIv
         Z/uyz1d7PrAzurzBGsHVUsEqlre/evS6bEZSqmuvFZSZwPcc47LPWMdzadK75P3RrTa6
         R4je9/fjk7jeQCu/qJwnE+am6BH2vm6amJ3ETTEwfsNMOXK6q4QhSlfe5F9VbKExClMU
         FlO7rlcbCWbTZaFQCCxNrGGBqQ2S3zLUpnpBfOwPW+4kILJm0C7mwouzkMUCPdUU65Be
         Y3nawfFA0AK9VN8+HYpd4FJBEpNT6jeVEd3P1ZCDTiGwhjPVmoX35DQLySqQtkSElWow
         3Srw==
X-Gm-Message-State: APjAAAUdBjeRpAaahpzeO0aRzinFFalmv5LXEMx7Rqb3pD2gVWnaeXWE
        13thMmbkpfJ1aWlbzd49oKg1GgZV64aGYXCvF9Y=
X-Google-Smtp-Source: APXvYqwYlZSL66GeSU4TZbz+0EZuctc8xlZi5TZE8nl8m8iVOM29zqacKrtT9w5oMHvLig9tG04NA6RK4P6OxABQH90=
X-Received: by 2002:aca:38d4:: with SMTP id f203mr5209080oia.88.1558106779678;
 Fri, 17 May 2019 08:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190514160241.9EAC768C7B@newverein.lst.de> <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com>
 <20190515093141.41016b11@blackhole.lan> <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com>
 <20190516154820.GA10431@lst.de> <CA+E=qVe5NkAvHXPvVc7iTbZn5sKeoRm0166zPW_s83c2gk7B+g@mail.gmail.com>
 <20190516164859.GB10431@lst.de> <20190517072738.deohh5fly4jxms7k@flea>
 <20190517101353.3e86d696@blackhole.lan> <20190517090845.oujs33nplbaxcyun@flea>
 <20190517094708.GA16858@lst.de>
In-Reply-To: <20190517094708.GA16858@lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 17 May 2019 08:25:53 -0700
Message-ID: <CA+E=qVcpMeFfC0EEZRpp3Hc_yBGFMv6cGKGSQENpUTw_ZH7UwQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge on Teres-I
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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

On Fri, May 17, 2019 at 2:47 AM Torsten Duwe <duwe@lst.de> wrote:
>
> On Fri, May 17, 2019 at 11:08:45AM +0200, Maxime Ripard wrote:
> > >
> > > So for all current practical purposes, we can assume the Teres-I panel
> > > to be powered properly and providing valid EDID; nothing to worry about
> > > in software.
> >
> > You're creating a generic binding for all the users of that bridge,
> > while considering only the specific case of the Teres-I.
>
> All I'm saying is that _this_ usage is also valid. Nothing keeps other
> users from defining the output panel; on the contrary: the driver at hand
> already considers an _optional_ panel and handles it, conditionally. So
> driver and binding spec are 100% in sync here.

Well, endpoint is not necessarily a panel. It can be another bridge or
connector - that's why panel can be optional in driver. But it don't
think that you can just omit an endpoint.

> This is much more straightforward than requiring an output and making up
> some dummy code and params because it cannot reasonably be handled.
> (Remember, if there is an output, the driver will make calls to the
> "attached device" driver.)

They aren't dummy. Moreover you have to attach backlight somewhere (to
panel) so it can be disabled when output is disabled.

Try 'xrandr --output eDP-1 --off' on teres with your current code and
see that backlight stays on.

>
>         Torsten
>
