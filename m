Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF3F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Cnmw59xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCFVEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:04:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43998 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfCFVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:04:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id i8so11085593oib.10;
        Wed, 06 Mar 2019 13:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgbYN7sbTtC5qybBooAIr5XzExXz/wGYviaUCOPutr0=;
        b=Cnmw59xTES08avSK1MsPmNO4e8KJ0RJx69irjQs+gmTL/Iqm0TGcuK8RmulXSmQoeb
         Z0b8WM3uemB4HjUV2yutud/+pru4iPJqbI6Al8buJWiwGuLH59en0gbqT60P2dV0ti1N
         DL6BqdZGA6GYcc/hY/Re79bJbxxWs0EUpbIbChPg6Biunwy64o0W5wjIQO56rCdK1Rcz
         cBs6JoCE8Gmxk7Oqq/+XkRStaAoZc/TLwt6ffYWmHJCnksLqxXtxzQd2il9G89zFnarU
         YLjpvDE9aUsqOsUWraei16c1hMJMvdkW5/ZZ8G4zR80my9JGag2s5g6ZcQNVGEGMIbBM
         USeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgbYN7sbTtC5qybBooAIr5XzExXz/wGYviaUCOPutr0=;
        b=TyUGbjpBMZwNspwf4C3kuFFtOJ/crNyAGWHYoZspaBPaBQudw+mpLJfhJhRE8clqsc
         8yocUSHutgbPUyq4DIc3q6Yzhz1UIvvN6amGdd6jJZZNUdUGjj/fmoggo1KlQrwcUwrh
         +GkfUFsWjf7QgGrnU34KryO2+G2q2mxtCQX0xhYSk97Lu2O9GHu9k/SlCV9gIDGTMZaR
         C7TEf0KmhJ7w5LGpMTHGQlJDkwe5ANZxiYe+w16cMPkMwnFcnyGdffP/cIZouIyaD8AB
         7jt896y6UXvL/na+awRe2onxruR2JmwOukkV7rK5U+L+oHFLbxG7CAbdnmpYIkG6SPrs
         vTsA==
X-Gm-Message-State: APjAAAWRu7oDTIQ1MqvFUv+6ZqHZOM7VtbP1752XHdos3+2dGq0T+YSD
        pFJMSp56PRSwQKgJnFZZgslWU0o1gejjPOc3Q+0=
X-Google-Smtp-Source: APXvYqyVtjeWk0g8Ubz1AWZ+XM9e9958QjEqCl7+EO3jTyzf+hO4qoxHWStx0+OfNIQe6+W2ndySRo5jhuIrWEIE/5w=
X-Received: by 2002:aca:aacb:: with SMTP id t194mr3009114oie.129.1551906284488;
 Wed, 06 Mar 2019 13:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20190304103846.2060-1-narmstrong@baylibre.com> <20190304103846.2060-7-narmstrong@baylibre.com>
In-Reply-To: <20190304103846.2060-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 6 Mar 2019 22:04:33 +0100
Message-ID: <CAFBinCBnDPcHpOQ1vW1gL6FxgLSxMv-f-qMm_TTCvXfDaFr3zA@mail.gmail.com>
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

On Mon, Mar 4, 2019 at 11:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +static int phy_g12a_usb3_init(struct phy *phy)
> +{
> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +       int data, ret;
> +
> +       /* Switch PHY to USB3 */
> +       regmap_update_bits(priv->regmap, PHY_R0,
> +                          PHY_R0_PCIE_USB3_SWITCH,
> +                          PHY_R0_PCIE_USB3_SWITCH);
does this automatically clear PHY_R0_PCIE_POWER_STATE (in case the
bootloader incorrectly set that)?

[...]
> +static int phy_g12a_usb3_pcie_init(struct phy *phy)
> +{
> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +       int ret;
> +
> +       ret = reset_control_reset(priv->reset);
> +       if (ret)
> +               return ret;
> +
> +       if (priv->mode == PHY_TYPE_USB3)
> +               return phy_g12a_usb3_init(phy);
> +
> +       /* Power UP PCIE */
> +       regmap_update_bits(priv->regmap, PHY_R0,
> +                          PHY_R0_PCIE_POWER_STATE,
> +                          FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
similar to my question above: does this automatically clear
PHY_R0_PCIE_USB3_SWITCH (in case the bootloader incorrectly set that)?

Apart from these two questions this looks good to me!


Regards
Martin
