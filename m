Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B768C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C181222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kiaj0N5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfKMPPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:15:51 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46841 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKMPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:15:50 -0500
Received: by mail-vk1-f196.google.com with SMTP id o2so631428vkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tdx64IKqxKujdLSoPw+cjx2+bVR8WBgZkb8xil7EtMM=;
        b=Kiaj0N5S0qYuVlCpJBh03NNDuyWtcNFnOuJsukl9zdoiOeFcx8h4ED9IUaW/x4fITZ
         tYZ0Le24vH3+ac2xQ/6lGGC+9jq9R+JXkAVb5c8k/UtUgtPpEpiU3ULFRARyfY4dFdqg
         tZQdf67Tiwl23gMVa1lI8+BqS//VN6Y3kNX+XkjvoQN1V6JXq6UoiUXJjuRTOqHPXEdM
         jzzP+kAZDU9zY+J/O0raG0KPLhX41af5R0cHcBJUk+o7penJeGbFwOkqh+BP1+OyA5fe
         yr0GyhqxCK9Lej974x047/O+3wkrx097s9AYydjrreC5U2UMB99SKacR5BccrvtPV/iS
         XFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tdx64IKqxKujdLSoPw+cjx2+bVR8WBgZkb8xil7EtMM=;
        b=KOwIhpROVu2oANj8F9j4DXsLC0ncIJ9deC61PSwHEcfCbJQ96Vps2uwZI3Qq6Dixjp
         S6G1BiV92n0vJGTycYj5WifQIJlA6ZlBZZi9LpHvTJcyfx/Db5IYT5iW1P336PYljwNc
         XSd18kpvfeS3PiGxBZ1sUDU8iaHFmE7tWXLTEhG3fIWYk9BOR8hy6iGxo3xj6S/RybGY
         vsevAvF6T94xjNVmpAKIlBOIW+L8eupY2Dyf6kQ8y+ktYtkL4WViNYva0Ltjt2NvcDwB
         X8q9KUCs1Sbj5SGByTj/cyseUTJ39b2LOU0FSy0oJwZtKPjJVaaDrC6D2U/oXkJx2gGq
         MHeA==
X-Gm-Message-State: APjAAAXMjttdDCZyNs0j4VIYFSpQazT+97CRjQGmjx4+gv6M387upT/5
        R2HwTpVxvpnRg4kp64DBvlBuU0epJGrTzVKSLEk=
X-Google-Smtp-Source: APXvYqwwACa+02CrVM7lnQq8G9xOFlxb696P1JSOC3QIO3M+yBf6hT1VsVmH1ipJUkNQQy14paArRCJowFOcazun1gI=
X-Received: by 2002:a1f:a1ce:: with SMTP id k197mr1986349vke.28.1573658149379;
 Wed, 13 Nov 2019 07:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20191106163031.808061-1-adrian.ratiu@collabora.com> <20191106163031.808061-3-adrian.ratiu@collabora.com>
In-Reply-To: <20191106163031.808061-3-adrian.ratiu@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 13 Nov 2019 15:15:22 +0000
Message-ID: <CACvgo51TpL1GMwf-QFidsbAQ-GiE6ry+QHwmi9x0Nen9Gg4B1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm: bridge: dw_mipi_dsi: abstract register access
 using reg_fields
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, 6 Nov 2019 at 16:31, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> Register existence, address/offsets, field layouts, reserved bits and
> so on differ between MIPI-DSI versions and between SoC vendor boards.
> Despite these differences the hw IP and protocols are mostly the same
> so the generic driver can be made to compensate these differences.
>
> The current Rockchip and STM drivers hardcoded a lot of their common
> definitions in the bridge code because they're based on DSI v1.30 and
> 1.31 which are relatively close, but in order to support older/future
> versions with more diverging layouts like the v1.01 present on imx6,
> we abstract some of the register accesses via the regmap field APIs.
>
> The bridge detects the DSI core version and initializes the required
> regmap register layout, so platform drivers will continue to use the
> regmap as before. Other DSI versions / register layouts can easily be
> added in the future by only changing the bridge code.
>
> An additional benefit of using the reg_field API is that much of the
> bit-shifting and masking boilerplate is removed because it's now
> handled automatically by the regmap subsystem.
>
> Not all register accesses have been converted: only the minimum diff
> between the three host controller versions supported by the current
> vendor platform drivers (rockchip, stm and now imx), more can be added
> in the future as needed.
>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

With the extra const mentioned below the patch is:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

> +
> +static struct dw_mipi_dsi_variant dw_mipi_dsi_v130_v131_layout = {
It's a non-const here, while we consider it a const below. I'd add the explicit
const declaration here.

> +#define INIT_FIELD(f) INIT_FIELD_CFG(field_##f, cfg_##f)
> +#define INIT_FIELD_CFG(f, conf)                                                \
> +       do {                                                            \
> +               dsi->f = devm_regmap_field_alloc(dsi->dev, dsi->regs,   \
> +                                                variant->conf);        \
> +               if (IS_ERR(dsi->f))                                     \
> +                       dev_warn(dsi->dev, "Ignoring regmap field " #f "\n"); \
> +       } while (0)
> +
> +static int dw_mipi_dsi_regmap_fields_init(struct dw_mipi_dsi *dsi)
> +{
> +       const struct dw_mipi_dsi_variant *variant = &dw_mipi_dsi_v130_v131_layout;
> +

Having a closer look at the const-ness thing:
devm_regmap_field_alloc() uses a read/write copy of the reg_field struct (5
unsigned ints), even though it only uses them as read-only. A sensible way to
improve is is to pass a "const struct reg_field *" instead.

But that for another day ... might be worth adding a newbie regmap task for, if
you can see where to file that.


-Emil
