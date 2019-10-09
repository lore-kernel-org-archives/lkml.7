Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E3EECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6FD20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjvQivs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfJIHqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:46:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43941 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:46:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so1418189ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZEfc+r3FkjJNXGg5OrQndZ7EVhjrXvy0Arp8Ba6y3Y=;
        b=wjvQivs+C+mNfu/kBT+oqZ7KD4q6+IZ5Kth6hhfGFbltlKdqAJ38C7ajvyZ31te4gJ
         C5EqhO//ZRTNxmVHsnWpL4FPvGmq6RGPaLctgOfRFcn64vZmRPcZzkMMWQJ5TtpYGxOS
         ++ZFPLLjrWzBCECqMtnDgmicGmA0oWmKIWQeYM/ZOxDhwuAVKbdEN/zSfWvAA3hLQZZq
         ubaT/P3ZZ59MYBEbi3oE/Ge+OFG+iQYKsWIiR5Ef3yKK7kivB5XTNZls9k74vNap0dO9
         ytr/crl5hSQEYBvLZjmMXVpBhkzUNMwtOdUVNlFdxRC9uu49L9C1IMRlaxaQ+WnE44XU
         dFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZEfc+r3FkjJNXGg5OrQndZ7EVhjrXvy0Arp8Ba6y3Y=;
        b=uWNkTEfz1e4TaCJ/cAhpTLoz4ks5O0lLOdhdjX0WsgXkZyL1+dLV46vunKDnKpIeoz
         upXSt1DRSBmP66O6/DIY3NFSVvlznKGEZSLcAKmtlQsYvsUQmwJWWaMaGbNIWRAV8vfV
         4eRsrMrtR2b85tWD8PvpgEySQ/gIpn8o1aGCb90inpDhHnWugAhRQswaRla2ogeuZfdN
         y+kntuO6ftsLEXfdyv6Nfqav2HT6PGx5Y8zgy+Co4XMjeslipB135PEaIf31u5B/Jhx1
         VQoZ6AKsSS7VpcSot6WuOprXZFECABunyjFrhkbru3OXweDpwniwtio+pMRU+q7DCZY2
         0eQA==
X-Gm-Message-State: APjAAAWyZ3hhDstIvlWVM487Ge+GBZ3rZU1/w1sux5pYDtTnlHjX/gpN
        ca4Iqtzptighj4QLYi1gdIo8TRSYYO4xMa11IyCtUg==
X-Google-Smtp-Source: APXvYqzKb6yyez5/a7eDQjEjte0+mGMXwCtZbVyeffNWrWYP4x2euviqJJy4ezdD4TVfujVbQ0UR4GcHrwjyGqp8gXQ=
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr1435527ljg.118.1570607198839;
 Wed, 09 Oct 2019 00:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191006102953.57536-1-yuehaibing@huawei.com> <20191006102953.57536-7-yuehaibing@huawei.com>
In-Reply-To: <20191006102953.57536-7-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Oct 2019 09:46:27 +0200
Message-ID: <CACRpkdY5x3wG4h6Wm_L5OXWXB7SPqHimUFOQa2jOeqDETWciYg@mail.gmail.com>
Subject: Re: [PATCH -next 06/34] rtc: coh901331: use devm_platform_ioremap_resource()
 to simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        huang eddie <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 12:32 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
