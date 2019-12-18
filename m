Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7BFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EB62064B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUVPJd9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLRR7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:59:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:59:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id p27so1298415pli.10;
        Wed, 18 Dec 2019 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqZeMQZTEcUUCzzL1OhPW2qHvSBKC8GWokh+0MirbcQ=;
        b=HUVPJd9Q/xHyIh4YH3n0sQIBzAwgTRy1Kq8PES0Z1JoVfeGnyOMeEPRQpcq3jpfMqT
         LZR6AQVW5RRLZImHjNBm0JJOSfyrIsfyCbG+sq6q3WmFZHvF2D+BZcpZJwiO3N2WbX43
         kZ1YcGGsOvsDwwUUw244Duaz8z65aHWhMrnWMe2iu245bfIoYUqHhmtL1YF8to96Zcyl
         3h7Fg5Hj4AfVrNaz1oDwyd1q+B2KG4EGzT7eMNXtjJNUjghqvHvOJ27iQgDsVekITPmz
         LIXFy9XF+6CQCsfwmQHHwfsI2NbbhYcmNBPMfv+qhIF62x+07/sMqk4ODdox50EVQDvB
         Vw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqZeMQZTEcUUCzzL1OhPW2qHvSBKC8GWokh+0MirbcQ=;
        b=Ax/E2bI3qLIQdY4HT87O9ilL2afEw28x5YhrTG8I8P9lv934cS0+iU/Z5RnMl87Kws
         AMLOX1Ro5NLt+BhgtP9118gV3N4QDjE6ND+LIjrZNMCVWMCwVs5WAV8lv6W9xlAend3b
         DSUONzKXbU0ABeO+5GiMBEvD91kErf9g8ympKoer86opZeQlTJPa6FKKLnDmv/Aa4Hfm
         c+1tkOvCLi4lK5bnz1x/EcEkOcLZM9jTfCLbvV7PFjHFIQr1QJ+pDJFm1phbTbSy/883
         R5MY7edwqwM/TokcVReZQYDbJR12EGgjrkurOpzmeEVh0+2ZuxpXsI4bQqWZCKvKrdk7
         DROg==
X-Gm-Message-State: APjAAAXr8z/Wiw/j/+HEkc1yJwpYPsHCGX1uHCZxcbRYnz/Bhk5FHS0F
        fdsm5a809ZN38jzXf/CP4ouKS8EX9wObnoqbplg=
X-Google-Smtp-Source: APXvYqwS3MKiBp0OHcgTppeczhbj0nDd+RGE4RAfER1ebVTGKhuVrzyOpOFPkEpSjYliru0d70jxYBQA7jJJrpSGndQ=
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr4311950plk.18.1576691993059;
 Wed, 18 Dec 2019 09:59:53 -0800 (PST)
MIME-Version: 1.0
References: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
 <1576682676-31957-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1576682676-31957-1-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Dec 2019 19:59:43 +0200
Message-ID: <CAHp75VfYwxviATZnmYcgzkKKGw47ki=BZQYw4xRmUrfNqsiBww@mail.gmail.com>
Subject: Re: [PATCH v3] platform/mellanox: fix the mlx-bootctl sysfs
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 5:25 PM Liming Sun <lsun@mellanox.com> wrote:
>
> This is a follow-up commit for the sysfs attributes to change
> from DRIVER_ATTR to DEVICE_ATTR according to some initial comments.
> In such case, it's better to point the sysfs path to the device
> itself instead of the driver. The ABI document is also updated.
>
> Fixes: 79e29cb8fbc5 ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")
> Signed-off-by: Liming Sun <lsun@mellanox.com>

...

> -ATTRIBUTE_GROUPS(mlxbf_bootctl);

What's wrong with above macro?

> +static const struct attribute_group mlxbf_bootctl_group = {
> +       .attrs  = mlxbf_bootctl_attrs,
> +};

...

> +static const struct attribute_group *mlxbf_bootctl_dev_groups[] = {
> +       &mlxbf_bootctl_group,
> +       NULL
> +};

-- 
With Best Regards,
Andy Shevchenko
