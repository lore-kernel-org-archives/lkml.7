Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D1E2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OiFh82tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfCKVOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:14:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41597 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCKVOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:14:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id e7so304026oia.8;
        Mon, 11 Mar 2019 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LJx1bgWhwnOV4g1ZsjM8oUCFlzqPuh14sDBiNuc0LY=;
        b=OiFh82tSJQO6TUDjtZPGtofwnpkR+QgQ+ogne/DPoigWMpsw6jLxgm+DO68u/Ag+Mr
         IYYU49B7qQja0gAsj7LLb3JaQ93yrocjAoGM7dHGhU3y4pPfe4z3lO/1zBdWg+X+bDSU
         ygbQyMXa1RGAdjww4QjTjY4m64HdWDs9xIyokzqAnea7yZKprOxn4jH33LqB4tOpXrC8
         Q0bTDsIL92qXLppjD6l7HQzyrH/t4VRV45i9Hh2vAbyJ/z+J29h5x1eo8pbSrb/rb8LZ
         3G53t0LMYavwv16okJc71nw7a8sTBFb3I+ck5vzv7olreYHwJj5h9OsyHApKmnxCf8lR
         UY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LJx1bgWhwnOV4g1ZsjM8oUCFlzqPuh14sDBiNuc0LY=;
        b=H5VccBWYyC0d4HDRQmyKQ3IHL8HZu1KwSnxUtJ0KAOEQI0NTZZFUEJ5RUxrsTNqQEA
         VR3V57ppJ17tfWFQPvutgoJdHpJznqzw0ogzRZTYEQ+AFZHmwLSw3T3KBKhsUeY2NZsk
         lkkSiGM7mTqo6bXmX3fknHbW6KXYRkm6qOFNZOqlW5if+EPhVo6T1ITRY9gPl2O/+hmS
         psS/QQ46Wi5LHM+fpCklIoj0Vee4xktHho8HS2pJgftdS2q8czWr6l1lGIl+Uw4T6O3N
         F1Gx/RlsYzkVRbNmmrAgmn/EthmpdVStBJyH3U78XQoXoNnGNn2qo1EUQ5C3bonUmO4G
         4akA==
X-Gm-Message-State: APjAAAXC14pcQ/bfQQPNEx0152JjLjH/NV3c2rdafHQ22pvZs/Y3J2Il
        YCKD/oq+3j+cUpOsNK1Twj54JplH95pLwWyGuUo=
X-Google-Smtp-Source: APXvYqwDLrnWKQj+zP1QIGzKJcs55swgmqdCBxD51MwA5D7MjVGxmNy2NoSVkkQzAqGnmi/ijoLBzp5+BJvAX13/LZE=
X-Received: by 2002:aca:4205:: with SMTP id p5mr171502oia.15.1552338878194;
 Mon, 11 Mar 2019 14:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190304103846.2060-1-narmstrong@baylibre.com>
 <20190304103846.2060-7-narmstrong@baylibre.com> <CAFBinCBnDPcHpOQ1vW1gL6FxgLSxMv-f-qMm_TTCvXfDaFr3zA@mail.gmail.com>
 <6e8b1935-ba91-d06e-be63-cb2632a19654@baylibre.com>
In-Reply-To: <6e8b1935-ba91-d06e-be63-cb2632a19654@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 11 Mar 2019 22:14:27 +0100
Message-ID: <CAFBinCCHZULDQjVeifiag-rzaPopVY7ir42RCGm9Wn6i9-=Qaw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo
 PHY Driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Mar 7, 2019 at 9:44 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 06/03/2019 22:04, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Mon, Mar 4, 2019 at 11:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > [...]
> >> +static int phy_g12a_usb3_init(struct phy *phy)
> >> +{
> >> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> >> +       int data, ret;
> >> +
> >> +       /* Switch PHY to USB3 */
> >> +       regmap_update_bits(priv->regmap, PHY_R0,
> >> +                          PHY_R0_PCIE_USB3_SWITCH,
> >> +                          PHY_R0_PCIE_USB3_SWITCH);
> > does this automatically clear PHY_R0_PCIE_POWER_STATE (in case the
> > bootloader incorrectly set that)?
>
> Don't forget it's a static configuration, on the board, only USB3 XOR PCIE
> will be available, if the bootloader sets this and the kernel uses USB3,
> or the reverse, one of them is wrong.
I'm specifically asking is because we've seen various GXL/GXM boards
with a bootloader which is configured for the wrong PHY interface
(RGMII != RMII)

> >
> > [...]
> >> +static int phy_g12a_usb3_pcie_init(struct phy *phy)
> >> +{
> >> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> >> +       int ret;
> >> +
> >> +       ret = reset_control_reset(priv->reset);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (priv->mode == PHY_TYPE_USB3)
> >> +               return phy_g12a_usb3_init(phy);
> >> +
> >> +       /* Power UP PCIE */
> >> +       regmap_update_bits(priv->regmap, PHY_R0,
> >> +                          PHY_R0_PCIE_POWER_STATE,
> >> +                          FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
> > similar to my question above: does this automatically clear
> > PHY_R0_PCIE_USB3_SWITCH (in case the bootloader incorrectly set that)?
>
> Same answer, but I'll investigate to have more details on this register.
>
> It's more an implementation issue, we can change it when PCIe is enabled
> on this platform.
I'm fine with postponing this until we bring up PCIe support on this
platform if you add a comment (preferably marked with "TODO") in the
driver. that makes it obvious to everyone who comes across this in the
PHY driver

with a TODO-comment you can add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
