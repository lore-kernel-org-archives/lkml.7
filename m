Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7775EC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A96921882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmI4XRPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGCIJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:09:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45414 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:09:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so1342211lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ivvl5CCQ3XOn/x5HlCBu4EVnhOHWx5rpHDy0gA4JAE=;
        b=xmI4XRPd+lQlj68cPzA6JlwRpOXyFjP1HS3BlSaoF2x2081Fvrv4UaFUgervHHaYhU
         POqzjtzqyn0VdMh42JXX9BmtgL69KfjHSg+r4unjasP98lt9q5aki76/a6Dx/U9yeXDO
         vqAgRYFYxHAl49vbYOsclcx3i4UxVokDR3O2PljbW1Eb/8vnL48LELy0/dzojKKDA+Ws
         Qv3fWNIgVopf5/9Qak5nwiWtP+QLRa3V5H0HDyGRCUOJTFFsioR7KBdtM4Rj5NVzm0/i
         KO26bEgsfqxcHwW06GAuqxTEDPbuoA1xi/IOTqvfYN6x+GPK6cfWXTzCu4u1oS0RaGwW
         7RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ivvl5CCQ3XOn/x5HlCBu4EVnhOHWx5rpHDy0gA4JAE=;
        b=Hz3L+U7/T3rxetDgn5s0FvcPoZMMWmj4FmYAGGeRfR3wKBuBPeEUMrRm5E0MM4WhZX
         Ef1zseuZ5IciNjCo9q0p70G7B6mo/H5UlT+lQasZfPAPZID5/TZTUzA4jm0PIoeq4vtg
         rbn8YN5aGJMSWajqVZlBV4GSGenf+/Rj/giTm229GpQL4PUr/Z6eZX7GUo7c548kkMZ7
         xYCOUUf2Bqp//4PFcR4ASd1oBRs0E/ZET9C59RHFGLy/oESawnDwVbErAamLqnza8bjz
         vSWPw8gSjPDqjRWhHmOye/Ju7scGtNuDKdaMw8bP4SB5wCtNDVnKs9N6lHwIdRXPQ9d/
         TaxQ==
X-Gm-Message-State: APjAAAW/ppWlkpTbiS1E8Ku4lCjOQSqum5dbyHNNbmt7nv8ABWdOZ7l5
        1d25xzwcUZXP8vOLX3Y7GSJQa+EDHZ2gbtCYHj7/4w==
X-Google-Smtp-Source: APXvYqzfT3CXQZE6J3uTELd2zBtuCY22dowAzbU0MVWOjXSOT6h8EXceXwH+MwKG/ftQAKgcCqWQE0vohmtXNlTjjv8=
X-Received: by 2002:a2e:650a:: with SMTP id z10mr20267672ljb.28.1562141395764;
 Wed, 03 Jul 2019 01:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190628150049.1108048-1-arnd@arndb.de>
In-Reply-To: <20190628150049.1108048-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jul 2019 10:09:44 +0200
Message-ID: <CACRpkdbcgaNmWkHJpj9bt4bFu+RtWSAtUjwkNDpJj6VsJGyTrw@mail.gmail.com>
Subject: Re: [PATCH] devres: allow const resource arguments
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 5:00 PM Arnd Bergmann <arnd@arndb.de> wrote:

> devm_ioremap_resource() does not currently take 'const' arguments,
> which results in a warning from the first driver trying to do it
> anyway:
>
> drivers/gpio/gpio-amd-fch.c: In function 'amd_fch_gpio_probe':
> drivers/gpio/gpio-amd-fch.c:171:49: error: passing argument 2 of 'devm_ioremap_resource' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>   priv->base = devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
>                                                  ^~~~~~~~~~~~~~~~~~~
>
> Change the prototype to allow it, as there is no real reason not to.
>
> Fixes: 9bb2e0452508 ("gpio: amd: Make resource struct const")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Greg's and Enrico's ACKs.

Yours,
Linus Walleij
