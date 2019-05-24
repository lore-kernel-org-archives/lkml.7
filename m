Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CF7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4C520868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ0bD/CU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391474AbfEXMXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:23:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43677 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391216AbfEXMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:23:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id u27so6987008lfg.10;
        Fri, 24 May 2019 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C+myfdGRYFPLLSybMtkNtVx2Tt/XQimBNXiCQ/VdObg=;
        b=hZ0bD/CUdsrgatmNXy5higdZbx3OSCJT8sw3LgkqkYgqbLtDn/gLs9c3g8mirUEDrG
         l+4o7a9TAxKLDBrPxE1t79fM9XPEqezMkBejfXLFW1INWkfF6OniubiwX8l6JtdYRW5M
         tFXRga1iZyPaMA5IfgLcUNsVq0/n8CPAA7ngiZ2vlfacytZlLloQGm7izI50MYXleqvm
         ISGNwOfcAGX8Xe6oTUH7CHfM9HQ/3MXe5c0F3fumRQ20D6mMK9Uiok4uhyMArRoFFH+q
         u4G3Opyv18dM583Kp0bxWnPFYDg/9AdqBdoV4pWXcATSuvokXHnSxlg9lkFRrlKRVbRQ
         1utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C+myfdGRYFPLLSybMtkNtVx2Tt/XQimBNXiCQ/VdObg=;
        b=ATbpaZOburacXnUixjr3z/A5JcWc7SrFgtcMouhpbA3rHTkYQH6bQ71mwBmSP3dlJn
         1L3rKnIdKqI1UqTPvAT3wpC9UcTX6oZfi5dB13yGAr9Xu2isz17jrjBXmmTdM4aQi5x9
         8w11HwZPYyQUx4Ffg33lF4BQNV2vnek3d9jV6FxouTG5r7u4SmxNxo1GE18tFqhmQHNG
         2vajgS54+rCdwXrioYJKlE8nJMK6zHgBsS6nr70GA99jlVs12SqchXLLsTwKANWOvRSk
         ZIssYtL4UACQ3JtZFV80PBjyfdeLA0YhS6N9RLJzhaXxYFftQIN1ZL34k59DquX9MUvF
         CoJQ==
X-Gm-Message-State: APjAAAXX9xNq4o0if/ZgrxaSSYIdLoK5keA8MVFOo7CtFXb8glj9wxIg
        ooo6ecTMCJcv1A3vl0C0uObaFlAYOrqydMHPrDg=
X-Google-Smtp-Source: APXvYqzNQQPTSEiT9TgbJ91HH92JPe3O9NL20r1waVsd3eYrkSbkO8SrKpooDjZEBXWcbK0tw4yY2uokVzdzBVZa5zc=
X-Received: by 2002:ac2:4428:: with SMTP id w8mr46274166lfl.99.1558700610795;
 Fri, 24 May 2019 05:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557657814.git.agx@sigxcpu.org> <2000bc4564175abd7966207a5e9fbb9bb7d82059.1557657814.git.agx@sigxcpu.org>
In-Reply-To: <2000bc4564175abd7966207a5e9fbb9bb7d82059.1557657814.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 24 May 2019 09:23:30 -0300
Message-ID: <CAOMZO5BaFYJxh1v46n2mdPyc+-jg6LgvoGR1rTE+yHZg_0Z8PA@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] phy: Add driver for mixel mipi dphy found on
 NXP's i.MX8 SoCs
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Sun, May 12, 2019 at 7:49 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> This adds support for the Mixel DPHY as found on i.MX8 CPUs but since
> this is an IP core it will likely be found on others in the future. So
> instead of adding this to the nwl host driver make it a generic PHY
> driver.
>
> The driver supports the i.MX8MQ. Support for i.MX8QM and i.MX8QXP can be
> added once the necessary system controller bits are in via
> mixel_dphy_devdata.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Co-developed-by: Robert Chiras <robert.chiras@nxp.com>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Would you have any comments on this series, please?

Thanks
