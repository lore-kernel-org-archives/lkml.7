Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11862C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6D3208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIFxE+K9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437293AbfFLIx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:53:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37044 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407641AbfFLIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:53:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so14395251ljf.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIawAQGWbLfWKTC3QZLXfcvTQA4CewZ25jbyqgy97+M=;
        b=jIFxE+K9E+9sLfOXVhz7UhSXRSFRim36eS6PxLRxoAg84JEx1jh75jRvY3qyffVITd
         lydhSmYqeZuBdXFrUO2/Sgn8Xtg4PTAZ+FTUb017+ByPeoR19sawrC03KCTTpAFi2Yoz
         6L3AijeU2ipvMHlSkoZQpDNjNNy1e73Ao6OfLDP2mitZeLPhkISb2JCO6lmtDVhfqm8Q
         4lJ0ruYaDTrE1CSiwuTn0QeCCc6ZvMJxAmCHrI9RtTmj2w8YuhwVHeZALl3GP9YO3Zxi
         CUVQr73huP0KWf+XXV4eXtrMAML8vpFJJdDsZr5UJFb2i4zWu9LSo/FJtTTifNf7c6yW
         AAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIawAQGWbLfWKTC3QZLXfcvTQA4CewZ25jbyqgy97+M=;
        b=NbMRwWdbD5avvz6OOOq7aYEK7LbJNJsf5eJCiHZbt/JrW2ULcHBz4/7uzVKuHJ9KM0
         camUUK+RQeDKIhpJwfbp/P57zL0jicQxDePbcmC2XooAgeHBwoyhQFsPxRmvgY5GScHe
         Apby31G+pj7N6l2E4DLZqU7rnU+AFfqS9bFEXB2uFYMVfopo4z1aaICqFj6ti1ANB+JS
         8xiidM81+pbBwN95/Pn86tKusFGA8AVRdILJKX7z6ixf+ZIC7avURmtbAEI3WSwzCUQZ
         r3f7aNtPMen9SJHbt4ddo9mIPKujpPKBnGIokb1rITZ/w0gq4/FZ97c6f2YVrjkAtQEg
         BIhw==
X-Gm-Message-State: APjAAAVNkRExWNU6JGY7XfjnE2TnwgLVpB5FYqIpRnM59QSnTwkr/4XY
        lqQex0UUsZ/ycbsp6lxLKVQgI32wbXYj9zOPvgDdlJE+xeE=
X-Google-Smtp-Source: APXvYqxNIIw9LCbyTcI5g6LaBsQRBR0wCq3T/j2cKTZRbhzfeQ43ACd8rs8QCnicFF7qmbfskgJqAyNjSj9WpNbJRTY=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr3993428ljj.113.1560329604687;
 Wed, 12 Jun 2019 01:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-13-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-13-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:53:13 +0200
Message-ID: <CACRpkdamGnFfvmdd_-DMph+AYCjYjF4sF+YOEqKig3L7kn4dkw@mail.gmail.com>
Subject: Re: [PATCH-next 12/20] gpio: gpio-omap: simplify read-modify-write
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> We already have a read-modify-write helper, but there's more that can
> be done with a read-modify-write helper if it returned the new value.
> Modify the existing helper to return the new value, and arrange for
> it to take one less argument by having the caller compute the register
> address.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
