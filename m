Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D175C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CEF20848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSSG7wPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfDMOLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:11:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40146 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDMOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 10:11:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id a28so9661384lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDhyszRqYnE59eo76sqXHTlepefi7Fg6L1WR10CmH3Y=;
        b=YSSG7wPzBPdRONipc2kC9eoz+ffU3+xIUWbZsmA5Z/hGRzRjDuv0H5bmNlYJ8P6xi+
         Q6ZoLjVtCkK0A7PY9RQO87xvhIGA71VgG3MlvXXApRserCMTGO+ru+3cTz+IwcUAa0BW
         n7qCgHRJRrw3VYpOSYfkJIjFinZPgEr/hQ4ztC/Jmq5pbdXR/C87A/a25HTsTIUZFhXl
         f13jjqP0aVQx2AYJZp6fTjHJtyUMZlHu+wri526nnRn/4wYT+SsRZqVcMHBI4va9HM2K
         iOa2gHG0cAZ6xj/zkoFy3ncZevWtEbGMljthSrkd4aH+Su1vH53ZJZL8vkaU6ueje6oT
         jVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDhyszRqYnE59eo76sqXHTlepefi7Fg6L1WR10CmH3Y=;
        b=ljdAAr3/gHF+rh2mGEf0wZPYnjypzXeh4D0kjZJ4MLSGF+O0gPzYAwCYQPoNdbOmE8
         UI5yQAs/6eUvKfaIqpWSkiFfgD91Xq6S9P4WwrBgbkI36gLx2ZZTc8ogOFyZkRKHUg5u
         ja/ANdgfnbRApqQ+FuEUeg99p36S45jkba1Y+ClWIb1UdjEWwiRzLlOKqDSy2XAGDZTs
         PCocda/SFNDPgSEYTeIS9m23MB6wWkMp7E07/b+sE5pIiw7ihTl9XFEgcLE18EBR28FY
         nmPk8bv6LJskqAQeZOg66+grw3nSN/jkraJiQyPJ7uy/nkKcOhgOMWuceZBThRsRDC4w
         3TkQ==
X-Gm-Message-State: APjAAAUUgXvxWNrImSygNQTgv3bxsZ7S0p5vO9M9Sjh/Tney8KaMgk0T
        +SufWxdY3ThTyiC3kT7wxUFudiEypQX6ZNBBP8E=
X-Google-Smtp-Source: APXvYqzB7shYrIFb0Pi4xTKAsE6TKnAmXH2d/Hps8fCtqTkTwvj0AcxBVYokW8nv72t6AyAkk1HZgtd9CwUPNEQETCE=
X-Received: by 2002:a19:c51a:: with SMTP id w26mr32546620lfe.59.1555164665732;
 Sat, 13 Apr 2019 07:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <1555140213-1081-1-git-send-email-hofrat@osadl.org> <1555140213-1081-5-git-send-email-hofrat@osadl.org>
In-Reply-To: <1555140213-1081-5-git-send-email-hofrat@osadl.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 13 Apr 2019 11:11:05 -0300
Message-ID: <CAOMZO5DV=fyefeazCE0EEnBQC5_zvBW5JyHdFoZA5ROCxQVTdQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: imx legacy: add an SPDX license identifier
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 4:30 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> The header clearly identifies this code as GPL V2 or later - so pop
> in the SPDX license identifier.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>  arch/arm/mach-imx/mach-mx27ads.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
> index c83fdd3..3f68972 100644
> --- a/arch/arm/mach-imx/mach-mx27ads.c
> +++ b/arch/arm/mach-imx/mach-mx27ads.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+

As you are adding the SPDX line you could also remove the legal text below.
