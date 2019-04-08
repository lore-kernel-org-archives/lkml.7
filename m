Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE8DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6116820863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esz8Tz1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDHLME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:12:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46654 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHLMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:12:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so10801703ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaIdqWQzx9urc2F1WD2+r3aCXFVQM5Q7vC0HFU94hLw=;
        b=esz8Tz1JB5qsbQRiRwi0M6XwYZ97KNA3O/o0mK8nwur2Pj3pRVsyp9BtQACRu52pJT
         6L+bhuyiCbNhUtzmh2SoNjwg4uULgrJ/yYSvrAnItUiLtbda8XK4oNpFuohkEvrqVtK7
         n8OyB7TkT8ci2FWnPdAT0trUtdH9bbzp6Hzo32gDAxYJlWwirADOlX9n8hKUMykyjuqo
         cYr80yMrWQVuByuiIS4zWvJXIFcRUJcfK2wlxjSri7rhZTDyymHsCJ+p2Gzjg18Lt6bM
         DAQ7PVzG/mjE4xgNt1fse99H3zHkx0S3gq+8CF8uQRQea014klae1nosrY7XycKseuvA
         S/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaIdqWQzx9urc2F1WD2+r3aCXFVQM5Q7vC0HFU94hLw=;
        b=JRdqHzq83BZ63V2h98scfknfm5S524zMk2UjMETnO2FRs7liXLv6kwTW/pv0/Jt9Jn
         1WjgKRm4WC4IZE1j7NrTdmc6wVlIxgvUSaeYAhcVaJDFmCFGloOXKNBRbDwWVoboKk0f
         dzf6h1F33ZtUHeBqhTRshEp7YPTJuuN0I71H/eqo3ZtUQ7PcSDKP/jpXEaETwbHwzguD
         mEeox9qpuZuUQi6bBRDVesKWuYqcymOG+1usvtnqFyoMvRUtULocMN3/rrX1YaKoUuPd
         UmKahyIBCHxgDsTfpJUd1k/bAtPIewr9nxOE7g3GmzAZg/J0vanTypBYLCzRrMgk76R9
         tDMQ==
X-Gm-Message-State: APjAAAWIhcBnSg6uFb9htoymSy4QZyvGO+0TEvtDi9nD+2YG3zccbWSH
        MuT20O64vFurj5zj/xfdADs+360yne8YLIuPfXGvvQ==
X-Google-Smtp-Source: APXvYqwo1Zxxe7U3k1N+IfclL6rK9cujHTi2LhnkK+oeaZLNvP96vp2kYZcHGxeFJoXslhE0A+dDXJCrSBWL22jYAlA=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr15354736lje.138.1554721921765;
 Mon, 08 Apr 2019 04:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190403144602.8098-1-geert+renesas@glider.be>
In-Reply-To: <20190403144602.8098-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 13:11:50 +0200
Message-ID: <CACRpkdb1AKiuQEsysmOse+qzv4GhJZ1nHQraJozNntORYE0XnA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-gpio: Remove spi->controller_data comment
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 4:46 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The conversion from GPIO numbers to GPIO descriptors removed the use of
> spi->controller_data, but forgot to update a comment referring to it.
>
> Fixes: 9b00bc7b901ff672 ("spi: spi-gpio: Rewrite to use GPIO descriptors")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
