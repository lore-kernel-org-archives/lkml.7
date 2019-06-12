Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE04320874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUCceScK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfFLIrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:47:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45228 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFLIrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:47:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so11408885lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDFAFECTi9IJ8RIKoDmEwceaP3UeuNfuR779SQGAHFc=;
        b=XUCceScKU1nCUOlPsPT2oRmMzU1+T1rULa2vUKcAxy7KocMHhmZA5QZGx6Mpyns0zv
         vl2G0gxAyBN4OBk+CCDGlqek81ioUX/hZhzNsFDxz9s2invH6ywoTbtB/V6bUMDZjLjl
         fSm4cYsUXlFYeVQXo5MLfFQckGO8MNdfYK0HPFZaU8dY2xlyXALeqakhuNncXZueZPsR
         w3FuBnTO3ajCjnn70szMy1tJm/i52NiqhKBrChxlFbWs7fFjKPtWKnV6d1PdBe8UPuYi
         pjsNWPPqjLksxwBL1Pn0F+/G65nhOLuGWfRAvJ90rEaqn3bcati6XawLtZwbCAlq+Dle
         3kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDFAFECTi9IJ8RIKoDmEwceaP3UeuNfuR779SQGAHFc=;
        b=FAMSU/8bqeCL0SB6rxqb+7ihsLVJ5911yk6EkjSNLfjNKUeMdKOokQtNoa+qTBoPYD
         JzxR4ghwFJymJQuaDUjV72rM7mtU970Mcs77Uv8UiFUeq1xbBRXZcd9xo2WSyZeGJSxD
         oOJyMAQdhYGOGhDbcXur8kMje++LeNxvoNTNTa10/dKHRlnnR11ptQlCIiaa6hf3HBdW
         fBwF7BXg0hhxDLSkF3ttcq24UN/l4uZdMdUkzms0bseB2arzLsSoRbbwS1az+4e9ZcLj
         123+cepKcIqGosbILz/5rOTIPh7ApxTVJEDpf727UiNUQLpjZkx2ThatzerQDiv6zs9Z
         CcoA==
X-Gm-Message-State: APjAAAXcPSBiLPR2bURBHIsI3bPgl27VXmBUPx6w8GUz8aCBHg7Ee+zk
        d8v+uq/KVph3zVmRj12k5lTt6Gis2zTOYAtL9mc2lg==
X-Google-Smtp-Source: APXvYqwfDjFlkCMYZFw/Bn7coNKAbnOhLBHhiftO+YMQniDmlCWBpk8GUtbDNqAT2f1P7cU3hOBHz5vqmnZqTrYtxjM=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr5258785lfc.60.1560329255343;
 Wed, 12 Jun 2019 01:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-8-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-8-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:47:23 +0200
Message-ID: <CACRpkdYaropisZADA61LF_0aUmWzi44c7pQbEUV92r06Qu3m_w@mail.gmail.com>
Subject: Re: [PATCH-next 07/20] gpio: gpio-omap: simplify omap_gpio_get_direction()
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
> Architectures are single-copy atomic, which means that simply reading
> a register is an inherently atomic operation.  There is no need to
> take a spinlock here.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

This makes me wonder how many more instances we have
of this kind of mistake in the kernel :/ I guess it is mostly
harmless but it sure makes for massive code complexity.

I would sure like e.g. drivers/gpio/gpio-mmio.c to avoid
taking locks on architectures where this is not a problem
given it is used on a plethora of architectures.

Yours,
Linus Walleij
