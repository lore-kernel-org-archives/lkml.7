Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21032C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C0921955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1UeEi17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfGVVTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:19:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50960 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfGVVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:19:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so36556118wml.0;
        Mon, 22 Jul 2019 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcHpQo876d02CYFiHQVItlAaSl/jfjKPiU6RN4TFprw=;
        b=I1UeEi17GMEIe6au5rGLh3RvbccB2FY6dbNa1E9vsdRutTAF/j5zsxlFYgg12ObK85
         u81bgOZDMP5ZBKa4ky4ep7OZgij8yIoNiw9ZNh4oH/XoqwCwDRnq/J6nxwpvlv6GRMrI
         Ljsn6kcmeb5e/RdA+MlQ4AIUgSZMvzHQH6N0RRHnRcBrAy5c65FKe+6IL3CUSJa1R7Mv
         qn1BkFvwOSGXF74VZsKGyEyaSwuA81rwkQTSIzlqFBI+w+tLgLCL3MgoZOOwo01o7ozR
         OB0yw7PZRW75RY0lVv0FzfXdTrlkOVlTNcpE++qbI2eTPr2sIQE+njdtr8mljRzka2Nk
         Nq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcHpQo876d02CYFiHQVItlAaSl/jfjKPiU6RN4TFprw=;
        b=RBRy/WqKR/PKQfVZJxYFEUkxfm2Qlmo/oFsDKJjrIKraJ83pWvtwA6N6V+6CNALgEU
         9PSa8spHn0quXUF7999i/kw1RQayYQ4moUmw/S6gyKT6/tuxnUJga84cPFbc097BpMn6
         zQMI/Tus7OPio3KQp2+l8H+P7KPfTHSC4zbFedbomyj7QMhptJFfMGMAL4aaJLxa7GxK
         dMlGtHoDgdQOj2vZf8iOFHJ7kr3rjrlAbnl0pfL2CZWADX85fkgzuvbmt0TvXea3GAUi
         U+YOpenRuIl5LmIGmStTFed18cnFrgorEX5Jd6wbWg/7AcZt9iQS7+xGqpAQqiBBa0Op
         TzCA==
X-Gm-Message-State: APjAAAXEkDrpMEfdGyc/8AIbKWy7l0NKat8CMSs67W+AQARZtz+cJt0G
        W2y/xRwRsg3onBjU1zQ8PK/+JZXE+YZuXg/oIK0=
X-Google-Smtp-Source: APXvYqz7N07i6ohLv6+0gi1iEmrCQkPrVsOixoIwNWebkS9RIprupSjMey4srEFKt2qONF8zx4PlqSB9BaObesJr6Ck=
X-Received: by 2002:a1c:c188:: with SMTP id r130mr61772280wmf.73.1563830358070;
 Mon, 22 Jul 2019 14:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190625123407.15888-1-andradanciu1997@gmail.com>
 <20190718035523.GD11324@X250> <CAJNLGszB239AHpD+kRCPRWZaToTYHiq5YUHRjfRwTqknwHMdMA@mail.gmail.com>
 <20190722020345.GR3738@dragon> <042F8805D2046347BB8420BEAE397A40749E9BDA@WILL-MAIL002.REu.RohmEu.com>
In-Reply-To: <042F8805D2046347BB8420BEAE397A40749E9BDA@WILL-MAIL002.REu.RohmEu.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 23 Jul 2019 00:19:06 +0300
Message-ID: <CAEnQRZDDjvMA5imQK5cEfycMUm3DiJ6i=0uuoHma2PfY3cqS-Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: fsl: pico-pi: Add a device tree for the PICO-PI-IMX8M
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Andra Danciu <andradanciu1997@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "vabhav.sharma@nxp.com" <vabhav.sharma@nxp.com>,
        "pankaj.bansal@nxp.com" <pankaj.bansal@nxp.com>,
        "bhaskar.upadhaya@nxp.com" <bhaskar.upadhaya@nxp.com>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Richard Hu <richard.hu@technexion.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 9:30 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
> Sorry for top posting. I'm replying using mobile phone and outlook web app...
>
> gpio_intr is not needed. Irq must be given using the standard irq property. gpio_intr has been used in an old draft driver - I assume the dts originates from NXP bsp which used the old driver.

Thanks Matti for your observation! We already fixed this as we are now
on v6 of the patches for review :).

yes the dts originates form TechNexion bsp tree which is based on NXP tree :).

Daniel.
