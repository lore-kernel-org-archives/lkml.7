Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A93C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CDF20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IjQr5S8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfCFVAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:00:52 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39641 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfCFVAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:00:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id b4so11066393oif.6;
        Wed, 06 Mar 2019 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkZ4HEOJZFJ5tvEsQ4ywiwfaW/8mEqhWWpAAzk9aizg=;
        b=IjQr5S8gwfPe+w9yvuXdiT+V+jsiia4rARi/vB88Q5xKvTp8AIaK/D6CG3920dUhG2
         NSk3tujLvxjCe4D4ndxu6c+tg17hSyu5qwV3IXH53hEZm8Cfqa2/e8tp1aKkZir2bi4l
         kZT5jssK5fudG5pIakE4tXpKG0bU5Blw15M6yKCvIe092BBakxRgDgkcQ5vCxfenoHJ9
         BjCuTSBX1/Xjg4oQKdjekVqUV3pNnDm+d8Y3cRI2nulsOpW3lHVNYZgYlHRqrHJkszZP
         uv38j4CkNgqIOILJut9FV97s0yaVETJXSuNdp5W3k0GtHVPrJyit1XQqlcDbRrUpJKaL
         utbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkZ4HEOJZFJ5tvEsQ4ywiwfaW/8mEqhWWpAAzk9aizg=;
        b=kxz5bIvPe+W0EEzWgl/gYnueYGHG6xTpmT6Q+tPGjzbCQuFvSxHmhIY+4MfxKnAYlg
         fbFRUPgj6HjqDeRysbU31uJSfT3twi3xxFkf9dzRE+nNgFhhSxy2bj5mrYOhVU9zLV/D
         yRWKpgVBSPpS0eeZlsniexjMR6URCHi9TCyOYMQC0I9Xq7d76/r4CrybzCVBnjoQj5mt
         qxroBgMvCFkWRrApwrPizm9dKRaKeYb0un3iXtwgOBdrvxQMH9TjK94OlGXYt/Fk6JF8
         4OBY6Q16NcQ2S27HHWA2Nq27z8EYNL89Z8f73enffeYIVQUZy43e/46AUAdzri93GTk4
         uqXw==
X-Gm-Message-State: APjAAAU6K37BAAkR74yoesDmNRlDaxqmDjlDEWwVYGKcVr4LcFWdVrRZ
        pE3jo2uQLwAt5byuBaw1S+RgnF8XFRHEJhaYYUc=
X-Google-Smtp-Source: APXvYqzjgug8DoTlX4m1L/JICwfzoFheIp+0TFPFevCk+4vLgK+k7KoG9TZ6GSBWv2cc2lBWJcDy70x3XEVKsDwnyj0=
X-Received: by 2002:aca:aacb:: with SMTP id t194mr2996977oie.129.1551906050696;
 Wed, 06 Mar 2019 13:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20190304103846.2060-1-narmstrong@baylibre.com> <20190304103846.2060-6-narmstrong@baylibre.com>
In-Reply-To: <20190304103846.2060-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 6 Mar 2019 22:00:39 +0100
Message-ID: <CAFBinCAacdsjwtg_RK=e=Lnep7oLF+eTBmkb1FB4nFR129z1jA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: amlogic: add Amlogic G12A USB2 PHY Driver
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
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
there's a "regmap" include right above. this driver doesn't use syscon
so this include can be dropped

[...]
> +static int phy_meson_g12a_usb2_exit(struct phy *phy)
> +{
> +       struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +       return reset_control_reset(priv->reset);
do you know whether we should reset_control_assert here instead of
reset_control_reset?
the probe function below already uses reset_control_deassert, so the
current implementation is inconsistent. in v1 you replied with "Maybe
it would be better, indeed." - if there's a reason why
reset_control_assert doesn't work here then I would like to have a
comment stating why

Apart from these two this is looking good!
Human readable BIT/GENMASK #defines for the register bits would be
nice, but I'm not sure if you have the details to add these.


Regards
Martin
