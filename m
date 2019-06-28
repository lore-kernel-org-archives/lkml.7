Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2CCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551132083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Hz0aXYf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfF1R7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:59:52 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:43445 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfF1R7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:59:50 -0400
Received: by mail-pf1-f171.google.com with SMTP id i189so3354127pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Of1JaN7sHuZfD0NstaLTd2MzqkoQNU+dB9/U+AM5Bdc=;
        b=Hz0aXYf9FNAepuCVFV167R3gAlxBZ41oQ5OOcua47PXfGIdizOWCfV7tUZJE3QgyE/
         rQLoSx180BgnxwlNgVTpQ4Ig+1Xn1VJoIeTgLsNDp2QQxn6WDq1x+YB4YdmWR1WRSEYI
         fWBIw7gApvr5ABgJvq1W+dx/05+xPrT5pRWc28UcKWjgAkPgDOoeyClRAvTuoAUW72Cf
         3dQPhidbgh7UAQ/wW9+OU+yw0I4jRXfps1zfC6+2QY+vRwyd5O8DiX8senYHiYvw9jue
         5l1RCL0un8DiyEfOgErem33EsWOke5gka4sQlT7+fIWwWP3Q/BbUKGSoQb7/N7qJTbea
         brMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Of1JaN7sHuZfD0NstaLTd2MzqkoQNU+dB9/U+AM5Bdc=;
        b=LnvNI6GRq0cz4d/3HjP/9OYT2oB9qhitxfV/kx9X3O0oLQ0ul2TOu/k86DDAVrvsZn
         C2+2o6dj2Nr+Pief0ELYruVfRSA1Jrk52MAF4a4Y/USIA792HkDyoVkPCxRq9FWj0vIy
         0GzrXvNPved8wYO7TgsFuIxkSLKjtCtCeBDfOkNKh/uvBSqheqXdBcYObfaD4O4gmFfO
         DZiFxrYu2yld/Op2gquZhVcciMyZnS8qwn8r3AZiXMVBlU8jtkCIIfojIqY71D5rlMGI
         y6bOQbBUQ/2SRZZlpTBikOUj+4VQshhlDV6Rp4mbiCL20PZVuONjF9R68qmIjMLzlgzv
         +rqw==
X-Gm-Message-State: APjAAAWnp8E97HIZwTXFzM+roejCor8RVLnv1Qo6yLOJlHIzKyXDuUL4
        WJRzan5c9BCj1ghkDB97Pi6yKQ==
X-Google-Smtp-Source: APXvYqzVm3ctFoObBMm0Kx/+AEZc0kKotlZRvKqXLokKmAqQl+Yz8kBBvBT8Pkq4aB9NKrit17xIEw==
X-Received: by 2002:a63:3d8d:: with SMTP id k135mr10798175pga.23.1561744789355;
        Fri, 28 Jun 2019 10:59:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id s66sm2933246pgs.39.2019.06.28.10.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 10:59:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFC/RFT v2 01/14] pinctrl: meson-g12a: add pwm_a on GPIOE_2 pinmux
In-Reply-To: <20190626090632.7540-2-narmstrong@baylibre.com>
References: <20190626090632.7540-1-narmstrong@baylibre.com> <20190626090632.7540-2-narmstrong@baylibre.com>
Date:   Fri, 28 Jun 2019 10:59:48 -0700
Message-ID: <7hmui1r3or.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add the missing pinmux for the pwm_a function on the GPIOE_2 pin.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
