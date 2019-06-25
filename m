Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21355C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7621215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAWNyHEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfFYIlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:41:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43906 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfFYIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:41:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so11999478lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+Ki1qmJ5eAYa7yLUWjWU9Nv/mbLfvJhA0V0d9PA+8E=;
        b=rAWNyHEHEaCNvRsh5wPaYUtzUB3cAGDkLwRIzl40TysW8RkU/swQ8kySGKpi4sOKQs
         fIeen3XxnFkLEPa9x5VOmp8OwFyw83x+UbkI8uu3851gKMJ1VO7vqI3QsJWqQGycq/fV
         nEpHLD++m1/6YY/q9kM/lHDlrC1JPUN8y6O5ZApXnQR/nxJ43G03XHOIWCQuPs/qQoy3
         /xEWHx4f8xym92jqMChrXqmRXm4eYeCWUwhgAX/ou/HFqAUzfU89mErWSzTCvgZVW0tE
         Ri/gd8Al0RGUTtJvMCVx9TeC8T/9Dq6vEI82wVBarh95pdf0g/VRS9yUBmUr6VhKn2ZF
         OUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+Ki1qmJ5eAYa7yLUWjWU9Nv/mbLfvJhA0V0d9PA+8E=;
        b=p80gxpk/OUDhqmB/DIJOpYi5c5oIxxLjDFiQNx6E1IEEDKz48n4P3waryJio5dK4BY
         jL5HUoNxEeiad9p5KgjUgN0OwIWQfi+2PGAfBYlvNM6/Z42BUAm2QcTCIjgUlpi7/vNR
         xwfF1oTss2VOpbKVepd0SLMF6ll9Z2aQw0eWPbsI2o/XbjWoNzy3cWtj5ePSG89E1e/M
         EJP2ocWBz7GoYrLbCH3tsFWpUfwKqe+jXEGMvHNECBJYoIUhC1INB9zFKlVJ2r/xqJqo
         1rupc68BGsJooMakYYGWEddh93HL2yu+6F8slEXqbIPDm+Em8GuzcT4S2db2o1YcWhLl
         YgjQ==
X-Gm-Message-State: APjAAAUp66O9Qch4czVPEKAPuHIsVDlXwRXnTdUjMq8BO7pQoZbeaD+W
        AK3Q/6fVq/vc90P+RLxjJvgkN+H4bsYN3IfvIbGEUA==
X-Google-Smtp-Source: APXvYqz77Z3Mlo0zQC0urLqRnamltUCd0egBwhvs7M18tlhawrJdORa2pZ6fQz9y4Utqsjds40jeglQU0O0j2VJGOwo=
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr51472630lfg.152.1561452060873;
 Tue, 25 Jun 2019 01:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190611122535.23583-1-Anson.Huang@nxp.com> <20190611122535.23583-2-Anson.Huang@nxp.com>
In-Reply-To: <20190611122535.23583-2-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 10:40:49 +0200
Message-ID: <CACRpkdZhaAxP1rYdXx88zd=13Z_OZU8Ze_+zQegywkTp7N+QtA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] pinctrl: freescale: Add i.MX8MN pinctrl driver support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 2:24 PM <Anson.Huang@nxp.com> wrote:

> From: Anson Huang <Anson.Huang@nxp.com>
>
> Add the pinctrl driver support for i.MX8MN.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> Changes since V1:
>         - Fix some nitpicks like sorting the change in alphabet order
>           and improve the headfile included.

Patch applied.

Yours,
Linus Walleij
