Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D455C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF56021E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q15/PIty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfHGMUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:20:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44678 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfHGMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:20:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id v16so10007855lfg.11;
        Wed, 07 Aug 2019 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9dlSPXIzwmRwec9cdZClPzD9O+p1LKOhOyELuFhZek=;
        b=Q15/PItyWyETquN34CMbjwJ8N3JdQ2jojagedl/ZtLn7KxDOUSGFWXkjsG6cCjxO4L
         nSGM53vO0c3VzFWfcjYy9hno+WW4LNKoNsNKm1eIy+SWmNvwjdyT2PKAGrCw6nO0s7kW
         KhTijdOkOa1SXD3k7ISB0EtJJkODTQ3PZIbASmC9RgvpJhGl/GytLAEzmIhZLrNR+jyn
         QV3Ji0fhpD3kOdNy/pdjgv7SPwqkosYByEJO8hbNlt+vmWNwyZPoo0Bq4YOd5WVJGCrn
         7EssIh9fLaaowQYS6bIHLiP+0kCzdXk4jgmX7OpEVT+JJi8JNWhTq5zOf5Xy85dDXtid
         B1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9dlSPXIzwmRwec9cdZClPzD9O+p1LKOhOyELuFhZek=;
        b=h26UjuhTuulYJltI1/N6yFmCXohcTbGeElMgFwWIZhkwnNm5o7UROXjtcFqqCR2Hxc
         De41wRvCx9QGGxIkjkajiLhojeHhCxoPS534qXr3ESWO6m+2wYShQFlg8ehWIcYbxL3y
         1r9OzgzbfdyO700CTp7v5RKYB0taJHrQitd+3OSv8Q9zd48EsKbfB3IQ0ljJbbdIf01x
         dtfehoxqFedqEgFnixUr0DDG4QKFIoVAy79qeztNwXsbr4W1H8eZfckEKxAJWuCfwNwi
         ZRHE7Hw8lNJgjAloXT9ibo9i13LbF81OZB13HhRo26FNG6JqwBr6ZncLI6YGlApvSlnU
         xLSw==
X-Gm-Message-State: APjAAAVKug9UHmV5n5+2k1YTek0uPHH0CXTid+va4P/5EmaKoltZKEb7
        ma5baeldRqDeDMdC/xVWOTPinybXx4+jXOCxwmSipPWzlwI=
X-Google-Smtp-Source: APXvYqw1qIGbc2GrmabnZLHIOdC+D/kaa3/fhCJM3SMOqJETxIq8dEY4U/gHsb2IcbqLAOZ8K7LNcQHKTokxl/W0raY=
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr5518934lfp.80.1565180398794;
 Wed, 07 Aug 2019 05:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190807114332.13312-1-frieder.schrempf@kontron.de> <20190807114332.13312-2-frieder.schrempf@kontron.de>
In-Reply-To: <20190807114332.13312-2-frieder.schrempf@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Aug 2019 09:20:19 -0300
Message-ID: <CAOMZO5C61NjX5=7FJj7WpQW=cSvBRi4ADKonUp3CRXtUkSqwCQ@mail.gmail.com>
Subject: Re: [PATCH] net: fec: Allow the driver to be built for ARM64 SoCs
 such as i.MX8
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

On Wed, Aug 7, 2019 at 9:04 AM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The FEC ethernet controller is used in some ARM64 SoCs such as i.MX8.
> To make use of it, append ARM64 to the list of dependencies.

ARCH_MXC is also used by i.MX8, so there is no need for such change.

By the way: arch/arm64/configs/defconfig has CONFIG_FEC=y by default.
