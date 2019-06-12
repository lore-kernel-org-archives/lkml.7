Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD49C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3E4208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSg2rXqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfFLI5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:57:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45112 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbfFLI5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:57:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so11432481lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AO6tXHL0MIrI5PKsPY9yMrIUQzOMgeWQn+5LBcWu5/A=;
        b=tSg2rXqu8jgkoPwygOaPeLpX9WM453fRghyKYBXvNtYKkfQ8Jw8WlttSk4DKne1vRY
         O/O7yUgA/OvD8gEAY2KX2AJgmTM9oVRbIEXEm97p3YZo7tGu7fodb7lmdiJYIgtbbKNe
         vQQRp6P4l4YYcP+/nHj99yrHgq3CwIvjCJQsbwruNZW/XHngZBj1VWew42VHhZ0ry78Q
         /ClQDeMqcQcTuk8jV/grio9YrxoKDyqwP3RXKEu73uyG4vsMgEeWD/FrvH0wmf1ybvWb
         Fxv7zvGh1taGSevLTKVK4AwTZrDQhQLjTW7yzZrosQBB5vpzcA3XLXVbQU/FUVXfGRzz
         /ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AO6tXHL0MIrI5PKsPY9yMrIUQzOMgeWQn+5LBcWu5/A=;
        b=pRbNcOlK7QKwSYAvdSJFy0pePa3cUTiMdHvmIRwmA9uCb/8iJjMetab5U/y+wm0Qbx
         Ehh8eBZYCcGk1tU18XiL3mupUQw3RJc39rIpBTCjjPB7okABundleWcvzNydMpDoPfuG
         TpxEMqV6Rx7Hsy8uBvm0JKH2dae6WXykjl7BuGh80MpOveeQNZAFc+dRoX2nnifhKS8L
         4xcyg7DqSfIR/GFIRAYmEgQlJNjTLvIhW2TOkRJceJ76CYvTdRpgLRUox+h/mY1UK8Ic
         MpMGsZ58CIz3rBYlnR1GhSd5LbLN2BQreu1K0sp8U950pahX7271g7LZdAOzwlr5CAib
         AqHw==
X-Gm-Message-State: APjAAAWNPRadkVjLmmEWe9eR7CZZ5tz/yMoU6OxpXw0SdLAMz2OizOgt
        43GGGLk7riXVrtc2IOdeJHSyc9f3QMENhii0RMYzaQ==
X-Google-Smtp-Source: APXvYqx7/U5en44gUOzYZ8yPmE23B84RXv7n+VLhsaSN8Ln0pBxF0981D+KVOcBExB2RE4G2fsqTgPKUOqFqSpHqMVs=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr5285457lfc.60.1560329868976;
 Wed, 12 Jun 2019 01:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-18-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-18-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:57:37 +0200
Message-ID: <CACRpkdYObWMhshXcHTMrmjr7hPnmk=j6g52APzgg5=meP_XTMQ@mail.gmail.com>
Subject: Re: [PATCH-next 17/20] gpio: gpio-omap: constify register tables
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

On Mon, Jun 10, 2019 at 7:13 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> We must never alter the register tables; these are read-only as far
> as the driver is concerned.  Constify these tables.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
