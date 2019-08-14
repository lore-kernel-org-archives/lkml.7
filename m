Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BC1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A8A208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vv74Giis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfHNH7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:59:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42703 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfHNH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:59:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so1268733ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vktWgJym3yCRgx3u45+g969459no7O3RZoGUxegUaEA=;
        b=vv74GiiskJwY6lBYmg6l4Zu9bHeALT4JI0bsJH4KFIuDlc1IIX6AEDJZ50lghMVEX9
         WKFFLzL6FyE3/Rs/Tf1xpXrnZanOyGWbjge1UfMjdE3r9+SVchOzBvMZFj18Zvih5p2z
         nncsdqMtWCBV2cMJxXNWcJzLzD5rgb3Y8SujIq/WjWvCRb0VaSFSiqYGIDUhgva3k6Li
         tC8RsunDocuTF/tvfbMzW6gazz1TVpdAWr4aCsEYOOwSmqwb9ukuI3vLqpnJvDEwCxpK
         Q61KnvPx9eCK8RsiX4fD7sKaYovdCd/FEf7RZ5l+HOwc3mlUsK/wRWSb1So/EgnyAI9L
         xSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vktWgJym3yCRgx3u45+g969459no7O3RZoGUxegUaEA=;
        b=dkAbI19brXjjfW9/H1ff6lxbzevKUZI6P2GDVlCxE3gk3yRsI/w3fKmvp61wWzT6zP
         FdVbce5EZreGpWS8MvniYRk/vqXOU3G9rC/Ohk65QRKYcQB5zarobnAsuAZADgmAnXuH
         10yviyH9FSENRJebmOizpJXtWWxdRCqWjSKH3Fz5qzqBRkWutdr3jf+m1H4nuo8fe6M5
         2zjFSuncvpneH+WZqdEDjANWDqnslrOJ2VjoG2NHCUK8tP+2PnsW5/goGdPcCkgJaqHH
         P6MfujQ3tHTfs/kwckmJIKVDBogJcdWp3oIOavmLgmv/0gI6fHlddFm8wDShgn9XQCnq
         9cwA==
X-Gm-Message-State: APjAAAWeYEKq2qzv3BuSfzEjL1HviHUZK8U+SUzlqVe3etxyIL3QKJ7B
        p9osvgTyJcQWpoeypmTegvYRWz0wJHnxD4p6mtdjKQPIwG4=
X-Google-Smtp-Source: APXvYqyu0HbKHviVbPJdDWFqmy4PxLilmJoLtCGqXaaggcm5lCdH90/gDgxNiL8hStl1RMJZCYuS/NRIVXNAMlY2Kq0=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr18693136ljo.69.1565769574230;
 Wed, 14 Aug 2019 00:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <1564603297-1391-1-git-send-email-hongweiz@ami.com> <1564603297-1391-2-git-send-email-hongweiz@ami.com>
In-Reply-To: <1564603297-1391-2-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 09:59:22 +0200
Message-ID: <CACRpkdaGe4G17Pv0+X=zcgfwikv8sr+m55NZNZu5JMtLOYjaAQ@mail.gmail.com>
Subject: Re: [v7 1/2] dt-bindings: gpio: aspeed: Add SGPIO support
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 10:01 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add bindings to support SGPIO on AST2400 or AST2500.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> Reviewed-by:   Andrew Jeffery <andrew@aj.id.au>

OK timeout for further DT binding review. I adjusted a bunch
of things like whitespace and referencing other files when
applying.

Yours,
Linus Walleij
