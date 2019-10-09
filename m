Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB319C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195F206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="al6Ibeoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfJIIHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:07:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44729 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:07:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so1474648ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0LNDSpFSctbTJTf0zAvXYKetHW153zqZU28HUuc6aw=;
        b=al6Ibeoh+WLVyhfBLsOSWTkDu5aVd8ZnfivuhHFSq+6OfHR5fCwI9BJRWh+2ywdwB2
         7RaFw6L3+jC4LIu0k784taSAmRoksY9qso+BLF3wsBDjqjeHutXwg+yonzAACVOBlxTa
         1fNvJCQtMiqEtPNT3EZM0P8KkEskNiBFXuJFwkx/ILoWNWs2Ba0ay4Aend4cvBbhRNu2
         cL4ZPccP2qxcFEQ28q97/D+wFYD5utOrvGIJyEBDEiAPnBVoodPnydqRBv8hxZ+R+KEx
         KBazv/AW6mcNv02KdyGRKqRnCw0wBmVQOr0XgE5VO5y6U82uY/UYmxLRHh4nSQybiiaF
         BEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0LNDSpFSctbTJTf0zAvXYKetHW153zqZU28HUuc6aw=;
        b=k/NDN3MI7NApGsEMi45NEM1OdM+nY+4pVy4bKxgOgXXy0VFNQ2P2Uz8kgpkwtV353j
         0lSoxJiKF1qDSPEwpc0u+QrR4JbHETViUcaD7FnmDfyxY90tIes9frGGMV63gelADVtl
         zUXpUiNkaFPwVXhWqhAG5a7DLv3mueVKrIGEdZrqTJOZ046YbxymzHcPHvCWaBo6OKNQ
         3zlfBY/gpkzVGlnvhfsA3zHLNQr8uzFZ4tVM1LGhCagoMTs4fQVgAGC9/9Kn3LuuTnBr
         r2ZgnUhseSUDlJW+B2+AERdT3brrQPZNo7GXgtZ2OzXdwMrbX0I/o576fIXqEaXDMw7L
         jlaw==
X-Gm-Message-State: APjAAAXP2ButeCHS3FaWVQVZgM2eUFHM/TcLMhg/RJ0k25p3kKedr+Xd
        eH9JODTZu6EHgqEF2NH5JN3EtVSQ+nX5FQRz1iLRB1o6huU=
X-Google-Smtp-Source: APXvYqw8WgwcmY17xXOAsdHSJSmkcYeQFlwgx89ruHbyb51KBUE6h+72k3lbA4aB1aUnh5XUgrNWfwyOfGRut6XOGxI=
X-Received: by 2002:a2e:9e0a:: with SMTP id e10mr1513190ljk.35.1570608451497;
 Wed, 09 Oct 2019 01:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <6c5d22c8-6e27-3314-9c46-701d932b11a6@infradead.org>
In-Reply-To: <6c5d22c8-6e27-3314-9c46-701d932b11a6@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Oct 2019 10:07:20 +0200
Message-ID: <CACRpkdbtRan_7nwPZNGLWE3xWiB54aF0fv6poFvbJpeGOz_TJg@mail.gmail.com>
Subject: Re: [PATCH] gpio: fix kernel-doc for of_gpio_need_valid_mask()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 10:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix kernel-doc for of_gpio_need_valid_mask().
> Fixes this warning and uses correct Return: format.
>
> ../drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
>
> Fixes: f626d6dfb709 ("gpio: of: Break out OF-only code")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org

Patch applied.

Yours,
Linus Walleij
