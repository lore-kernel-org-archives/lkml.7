Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096CFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0F5214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHqBBSOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfDWKkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:40:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38879 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfDWKkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:40:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so13025669ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeAEIuKbM0NLEfaTImPXK8o39hYLwsffvF/4CrO3LuQ=;
        b=qHqBBSOoiBBdSXm0B+lNJ2knW8/lDSivj5qmSZ3g2PCNnWzorpjxUErms8WiNlDeg4
         l5MAa2zikDmDpUaemh/E7M8Ed0LDgLQDUDevKdOQnfK6Qr5qzC5tOd2zTNtaGdOye7Y5
         2t+lol1rm4KfPH4G/sQA8k90IMgR7aLhP3DKSAfQv79ofBUpRpHAcyFr2PfUKEm9OWTa
         HjxkUE32Y7rdieLmstpAOGRr0ITv9su3bGccIDakUx/468s72AdNhWSQa9xMyTm+8N01
         eCyQ9eC5fceV2fQwrdbsXiL4BnMky+CgAElE1+fy1rTFBDT8c7JmPAcfl4nZz9aVAb5g
         GoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeAEIuKbM0NLEfaTImPXK8o39hYLwsffvF/4CrO3LuQ=;
        b=eRGdn6lwtOnM8hbkqQn6lRRG3N1IGwgWOntKyh7v6KZ23gnKp18oqiqljnbyioRT1r
         SSvTE+Q0z5jpktQDKJ1jEV8uKu+K3g05zHi/STlJM+aMxrog6ZP9JjYEDndovegPDzto
         ML0VwOzTtPxxjGdcrPHdgvPc5M3LzbpBs/PAR4r5Evmq3/M7rjSD7lp9V9S4Th+v4aul
         vuAiAuTcK6+J6froi5lpBJscSmsWPufGg543QnfkKVoedDR/D6YpONR4iQqmWOBaVIlw
         QQSpdi1WuYxhY6ivKjvLMe4bBsZ/ZKqANyqk3aTaBnYwjEiOICwx3ja2p1IZZPMKSmV7
         lh+A==
X-Gm-Message-State: APjAAAUqj320yfhn1j2kGsO8fCPMGMR4W6fk5GV0WyGq0gywMimQtlAp
        ky0C9fF3YuUQnsGnT99CURhDqTPSz+pm6yenrwBa+g==
X-Google-Smtp-Source: APXvYqy54pMAGRFiuA+p2NCoVWWRU2gIRrXspkVrDJNkLorduJKvLwEEBSGaBEl5GnsOfa80nc26vCHbhuLRSRt3T+M=
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr1638023ljj.159.1556015998892;
 Tue, 23 Apr 2019 03:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190415192734.935387-1-arnd@arndb.de>
In-Reply-To: <20190415192734.935387-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:39:47 +0200
Message-ID: <CACRpkdZ7F0fZv1nkRda_u1Fo2_hD93MHNURzwoWA_FbWjrzqBQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: ep93xx: move network platform data to separate header
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Ahern <dsahern@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 9:27 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The header file is the only thing preventing us from building the
> driver in a cross-platform configuration, so move the structure
> we are interested in to the global platform_data location
> and enable compile testing.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

My EP93xx board is not working right now but looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
