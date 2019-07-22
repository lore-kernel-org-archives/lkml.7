Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B965C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170BE21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/SPgKgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfGVSrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:47:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43532 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfGVSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:47:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id j11so17066038otp.10;
        Mon, 22 Jul 2019 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aC1MLxLbjDg5tOzPiyVil8Be4/KhIGolhfOdnXDjtBE=;
        b=a/SPgKgtMHEdYvP1ujLe27UWsqf7cBVVME1tq3pKmJc6b83inBBubiAdSQckX+VKbG
         NMiOeacyFUgN0Qt19RTEwwPT60/w8OyT7FsZutliKE1iXT7iAB5PXEBx7BYKXiNZfH8q
         MF7lGbAelaec9OuYlnC4Mp9B7PfHQpJ7fUA99cfrk5ijZizuyFAhxRAvDekrMOOz3Gen
         7qV5snjmYlHafHWT2AQK/LeRCwUiqhg0Vlar9IN/RRt8Ktr5nA+9wRIxopDqu+I+xDwV
         Jc3FCInW4B1XPn3GIvYd+4BICjqmE09mOcrVpVYrSXl+ID0WjJJqVUA2r0N2FDhpOdQS
         2oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aC1MLxLbjDg5tOzPiyVil8Be4/KhIGolhfOdnXDjtBE=;
        b=emjPx4TfJc/f8pK7KxpFMzoCkuzPJKDJwAgJuf1rX2wuq44WdHqSH5NDgR/sWTEgk0
         yVEppwWY7cvsyunb4VQ2l26Hpjq2NBr/xAzb9l18oAYg4tfyw/SDpURPm8c+00BtqNU1
         26pjtyLTHpMxKpAD+C4CMADedcjj2b/6IKrdjfccn0poh4dVrd0PIqgZSW4ANtI0cxMR
         RnQ4VFoz2rWfpTkuoNPT8ksJZxCfxLARBD8otNQJvy9EMBE/8TDcTNeV2XGi7fTXyViW
         6OZDPiaPPnQK3R0scFi/Tpk91feYvcDQD8yhA1Mys6XP3/4Rk0U5Wk1hd9qPEaa3gznn
         MD4Q==
X-Gm-Message-State: APjAAAVK3Kznw9mG4OI7ULmSAL+xoN2BWJFrQbdSBFMFRzuzeLzGxpfp
        r2PyMnXulMi+kkau2Iwf23h9tCDP2q3GrzJPwo8=
X-Google-Smtp-Source: APXvYqz7FTaxBbgoBulSD/5MeRxUZjfIzP2icEYwqRHNrphiJ8v0/gXcEbEuwHUZ6peLJ89JG8ockAPkEj2/P6ileAw=
X-Received: by 2002:a9d:4109:: with SMTP id o9mr29072586ote.353.1563821262309;
 Mon, 22 Jul 2019 11:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190722150414.9F97668B20@verein.lst.de>
In-Reply-To: <20190722150414.9F97668B20@verein.lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 22 Jul 2019 11:47:33 -0700
Message-ID: <CA+E=qVdoqkpLvRULOQLLY6heOCNYEizfqBCV4iTrCMEj6HfDZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add anx6345 DP/eDP bridge for Olimex Teres-I
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, <"Bcc:duwe"@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 8:04 AM Torsten Duwe <duwe@lst.de> wrote:
>
> ANX6345 LVTTL->eDP video bridge, driver with device tree bindings.
>
> Changes from v2:
>
> * use SPDX-IDs throughout
>
> * removed the panel output again, as it was not what Maxime had in mind.
>   At least the Teres-I does very well without. No connector spec, no "quirks"[1],
>   just plain EDID at work.

You still need a panel to put backlight in there. Otherwise backlight
will stay on when display is turned off.

>
> * binding clarifications and cosmetic changes as suggested by Andrzej
>
> Changes from v1:
>
> * fixed up copyright information. Most code changes are only moves and thus
>   retain copyright and module ownership. Even the new analogix-anx6345.c originates
>   from the old 1495-line analogix-anx78xx.c, with 306 insertions and 987 deletions
>   (ignoring the trivial anx78xx -> anx6345 replacements) 306 new vs. 508 old...
>
> * fixed all minor formatting issues brought up
>
> * merged previously separate new analogix_dp_i2c module into existing analogix_dp
>
> * split additional defines into a preparatory patch
>
> * renamed the factored-out common functions anx_aux_* -> anx_dp_aux_*, because
>   anx_...aux_transfer was exported globally. Besides, it is now GPL-only exported.
>
> * moved chip ID read into a separate function.
>
> * keep the chip powered after a successful probe.
>   (There's a good chance that this is the only display during boot!)
>
> * updated the binding document: LVTTL input is now required, only the output side
>   description is optional.
>
>  Laurent: I have also looked into the drm_panel_bridge infrastructure,
>  but it's not that trivial to convert these drivers to it.
>
> Changes from the respective previous versions:
>
> * the reset polarity is corrected in DT and the driver;
>   things should be clearer now.
>
> * as requested, add a panel (the known innolux,n116bge) and connect
>   the ports.
>
> * renamed dvdd?? to *-supply to match the established scheme
>
> * trivial update to the #include list, to make it compile in 5.2
>
> --------------
> [1] I hesitate to associate information about a connected panel with that term.
>     But should it be neccessary for maximum power saving (e.g. pinebooks),
>     it would be good to have something here, regardless of nomenclature.
>
>         Torsten
