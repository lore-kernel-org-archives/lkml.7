Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D4CC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7834D2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JATFfirz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0LRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:17:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42365 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0LRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:17:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so1897186lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 04:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+M32KORGemVLrEhCU+mugrqZ6KHhAjcB7ktP25bgUw=;
        b=JATFfirzIRvl4Bn0MzZWqLXi3Ey2itUpvEWgha059qAjA3IR4c2e1wMYo0c8Z9yL/L
         WyGOxZrDK3Wnpu+UNfnPJmkwU9xOdh+bOAd5U+upstomSDHtE62P4UarRnshyBxTZwJC
         GXuAX0YXnoWrBeA4RM3Qn1INmR+BJS6DN+IzO5VbLtp3T6R99ZjdyYG6rtknT6+hXXwJ
         DPoPboHY7TP74z5yaajm17KS0cWKWMGHFArJHx42qzxQyRY1KKg7LMdAMfkwaPbuyatE
         kXX7rKx4ZmsGCoeVQpyujljI9AIVkuBs6ld7AtEB4hCOp/+cjbUg8oBHYZu0nmkh8mI7
         CsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+M32KORGemVLrEhCU+mugrqZ6KHhAjcB7ktP25bgUw=;
        b=HKGwG5OMfmpayJyrKb6L/BeP0iN2wUJXTL/ymR3tYiPqXaEtO1A+YvizZvfjCkBptZ
         k+2NDqtb4Ppr38376uWZxveTFLJkgCyZmhc3mcS/PyeDD+eukfdCAT0/HkqI8o4ZTHZo
         hJZw3X7sN91HjezkrWXHKspTYoVW0SesT9f3JEDM9gZmcwsKYumrkXDpY6tnfXusfIhy
         0UfcEHRCfwQIyjpxXZsgT1bKPyjlYNgINgs6anfWR7PYPYSmtJ/b14JEFn7an4431Kdl
         oBR/+9IhNrzCDHl2WTIUDgwrsUhPEdNfJwGczFG5ZmGAH0zPJaL4zeKH2W8RaLlMnZw2
         BjGQ==
X-Gm-Message-State: APjAAAUQxewGCEXoZJJJVbF6vGoFFOqUqVmNobvKkpuX3xm/kBk7MqUw
        wNz4FnxCmeyXhuIdKj5x76WzsjMCmxftxkrT5nZ6Vg==
X-Google-Smtp-Source: APXvYqwhIrf7JDRO2BMtKtOJvp54agYbc9d0DQAtQ0T63qMEcpkYpkkimqLDdz3gA69lWL5g0fktxZUtlvgv/RN7KDI=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr2370304ljj.108.1561634226615;
 Thu, 27 Jun 2019 04:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190625163434.13620-1-brgl@bgdev.pl> <20190625163434.13620-7-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-7-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Jun 2019 12:16:55 +0100
Message-ID: <CACRpkdZdKigQ08bf5P9sYf-EhWFn5LmMRPQoMS2O5ouB9h6=MQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] ARM: davinci: da850-evm: model the backlight GPIO
 as an actual device
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 5:34 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Instead of enabling the panel backlight in a callback defined in board
> file using deprecated legacy GPIO API calls, model the line as a GPIO
> backlight device.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
