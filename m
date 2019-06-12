Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE94EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C497B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiL/H776"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfFLI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:57:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33388 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfFLI5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:57:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so11461060lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EziaPVHwI3OsN4q5Q0m4XpCeZBocIr9dDoB/RcVNjs=;
        b=RiL/H776u6ayTVWLP4Rrw0ebZQ3DKh3efnfcUVnvwGSkIgTbR+eWHbcPCZedkbXbsH
         Mwcxf4g6FpWRQ90+/runRr9kZnXPcNNW0i/pWfCxnBnQpGfBQojgZX33jbwmIr8LkEBn
         va8mu634mqOa4r7r/odvuSu6dIl3GVmN8rdKvF/jRcG1UnVI8033D1vgZfZfzniwH3na
         ZqiH2elFYwFqaXbuDeshhpgt0Hs5zc4cb//Gt/fQ32rpmh6mqLBPJtloIdP/6BCc6NSf
         VU/WZsqFNER2FzpFptEnFMA+1lFnpokcdcG1Fp5Yqs7FUG3RQJ4Gr8Lb4cDLr0my9zo0
         h8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EziaPVHwI3OsN4q5Q0m4XpCeZBocIr9dDoB/RcVNjs=;
        b=thUeWRUrLlao2JejXFTrkHcLB6bLFNo/fUnREQQInVvklDNRZF3O+0NIfRxA09AT6h
         mHmDTcu2vXw1mIzShWFMptCxmDqedsKvMXm1C1a57Fj4UlAU6S3BJRdAuGsd6BuURXNk
         fcV7KE2hlY5yhzpKyphCTz3UcMMPEemV0X9zKB8Le6vKQY+un6VTeofjkdbND224eWps
         NVovwJnehSnMsnhDsDIIcYOEAFHxYhBlelwKxlnZAClIGbszMIDoZM45Q6UWhLNKiE5i
         kSuj+VmE1mZjTPelQ8iMt1lPuL4vsDYOOPTXzSzw7eZUWTMCqcDjTerTspy8mb+BU7+T
         v9/g==
X-Gm-Message-State: APjAAAWXhfjpMf/YP3J3WuV6Iw4522J7o1B2GL5R/ym/nwKlaSGV8WvT
        hSyKCSGMWhSyr9X9fHNIEINyna2IEObR0O9u6eAgHA==
X-Google-Smtp-Source: APXvYqzdXC0nDBe338kDBZkoplEJnp9z+g++x8HvyKX6p6DHugHZB+t5hf2uxbdvplO64qLWE8dpOegyo1Bkz+japzE=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr39749313lfh.92.1560329827260;
 Wed, 12 Jun 2019 01:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-17-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-17-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:56:55 +0200
Message-ID: <CACRpkda7d9SV-muuvEpO5VhCHrJozRtOMVGi+1siyWzabTMmww@mail.gmail.com>
Subject: Re: [PATCH-next 16/20] gpio: gpio-omap: clean up omap_gpio_restore_context()
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
> Use local variables to store the base iomem address and regs table
> pointer like omap_gpio_init_context() does. Not only does this make
> the function neater, it also avoids unnecessary reloads of the same
> data multiple times.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
