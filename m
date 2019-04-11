Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CCBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634452133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5tcpxay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDKNuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:50:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34683 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:50:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id j89so5614604ljb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4R2nON0fldrx5nngWEL1/9mxMORAgC13VD1L1J+hqE=;
        b=n5tcpxayQJWVkfmz544eU/QxZK23icq8z6nor0EUpI65AyurqVGjsnpdLWxaCxrcLw
         zjGEz4yTq6YL6JsBMgLRjeQvUISwUYiq3cGX4defR+9JDRL9oUi1fP5f3VkAqv2jJdCt
         b4R3K97mIvt2UZbz/xy++6ZCOTaeA2FwXQYtMEyIBFryDI5TBsWLmgrJkRVJlqdU660k
         ec5F6TdsVxE0ISKhTkUIgrZywqdiEaf1CFzrb0XZoAHmc5aT7uFYmxyIuSlKUw5Q8LQ7
         Gu1z2iCwKcG0jc5W8074pW/NPBS5jthqetXQgvk6peGEPn9PDB9+zbQ4UpYamYdOn1GA
         agsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4R2nON0fldrx5nngWEL1/9mxMORAgC13VD1L1J+hqE=;
        b=THOkFg2zcFI0ezGGuBHaGtMoJSq+/UDyhFr+kG64IuWZI76cvN/8opwU3IbnrK9vHK
         EUuCzWtr9PkqRY1TkDxOzXkKakt4I1CBnWEaYWip6UMUhBI4WTbiAIwLpZrilV/YY9SY
         Srh3z3M4PTuOrk4nieYFHTOxTnZC+BWUu3be3o9z+Z3i/a9y2U3yE4eGCqVw9vxqlzuD
         v3wrXjW+IvZTFVTONc5abqkGVsK81tQwKUB+OXeHy3zEHPcuhCnQC/RyMvE0AFXIeFyD
         9Img9thTJjsH9aqmRxAJrKg4WtuqcplAtmDnijGYRM598X+6QwLLwYzNZLqQE6je70JJ
         2vIQ==
X-Gm-Message-State: APjAAAVYUFN0zixDQnlTGlRd1RQ3GtXDr85bnW5z2FEhEbC8/E8MXtO6
        pZoh9nXUh8GF0uHvq1V1OdJVZWp+pGkJoBd6zSgdzg==
X-Google-Smtp-Source: APXvYqwgecgntexEoE1X1kv52LpK3MtvkI2UElw9fMlfchiLismJczoNQzXXJi3WahoUKyoYK+094DukwKoS4Ym6w/o=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr28032166ljg.103.1554990609376;
 Thu, 11 Apr 2019 06:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190410103926.8781-1-alexandre.belloni@bootlin.com> <20190410103926.8781-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190410103926.8781-2-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:49:58 +0200
Message-ID: <CACRpkdZfdxNwU_9h3PtcJkAE++QZnC_JifoqNfLwJyqj_ofJuA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: gpio: lpc32xx: document interrupt bindings
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

thanks for your patch!

On Wed, Apr 10, 2019 at 12:39 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Some of the LPC32xx gpios are wired directly to one of the interrupt
> controllers while port 0 and port 1 share the same interrupt for their
> interrupt capable gpios.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
(...)

> +- interrupts: Should be the interrupt shared by port 0 and port 1 and the
> +  interrupts for individual pins from port 3.
> +- interrupt-names : Should be the names of irq resources. The shared port
> +  interrupt is named "p01", the other use the pin names.

The recent design pattern with hierarchical interrupts such as this one
is to simply hardcode the relationship between parent interrupt controller
and child interrupt controller in the driver.

However you should add interrupt-controller and possibly
interrupt-parent to the bindings and example.

More comments in patch 2.

Yours,
Linus Walleij
