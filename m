Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D30C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92222073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TlO9sELl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgAGJhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:37:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36255 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:37:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so53992464ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjaL6TQQ67z3Hiza8RIJBFEWpIcxuINQkeVUEw4p0bg=;
        b=TlO9sELlXVwO6vHRNSdRj0yMgj7w5fcPcrhI59kz1i5xLmAPlByZzg6ceNKc51aFD+
         z/ouDTFq9LN+RS6pHBrLleeFSV7kRH63Lqxr+sI7XG6VAeejnpmn3nxdPDv4qr5jfNtj
         xNMAZVGIk56yodRwLq+KV1Ug7pVQIAG9DqD7F5AEM8NR+u1tdqp50WhSNyBxxPExIWt3
         lBAGD5mSE5KkTla33goZBBg9B48WcRu95LEtmO6m/HMyHoVrsTXsfDzlKabFaSJ4+BaH
         9dKIj+sF58tbGXkIgJPiMDbZ38NISl2YLtQdl1pn0HasmP0uM0FAEVd28rvFEYbkkysI
         tzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjaL6TQQ67z3Hiza8RIJBFEWpIcxuINQkeVUEw4p0bg=;
        b=ALZ37yxWDrH8HesqX4mLpQzq2z0hBatiwtAEWBvYwLiJV3RMxUGkfGQO5KKG6zT+qe
         ZscEes8gy9LMFQpbjNwYtsHBEuD7zd15FtCfF+1TnYtD2DgojVKpKxd38hQOijjUrFei
         CporlCPirG3h8g7jNfNV5bzOb8U0hfTn2jWh1xY/9q9GYYJwst+hEJsfsAb0moGUV3ER
         LKS+udueI25fT8uCauonXE2jcctwCl9bc8900eC/O6hWVkqkogG4xQ4I0+3QsMf3FMas
         CVNLD/vyE+HDOhHMqZia1wtKMYjBlFr187njk2nRP5c/p1ufUvsR8hgnB/Eyun4A/Jv0
         IcWQ==
X-Gm-Message-State: APjAAAWfkilWhg0FWm76Wnx9AlcQK8DrfApzTHMOuQsKYhwsyiHOlOqb
        3BJK/mtq7kcXbcgz+GJo09Y0EJpw43Sfd9J0fB7Zaw==
X-Google-Smtp-Source: APXvYqzB2j28WO/M2d32CA7lzxO2yvIBzwHpXUuZ9BN186aaxvzkAOxXfE5Y252VvGFkaL9F8nV8CDYVZ4plw7vK3w0=
X-Received: by 2002:a2e:9587:: with SMTP id w7mr60204347ljh.42.1578389833544;
 Tue, 07 Jan 2020 01:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20191218132605.10594-1-baijiaju1990@gmail.com>
In-Reply-To: <20191218132605.10594-1-baijiaju1990@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 10:37:02 +0100
Message-ID: <CACRpkdY4JsvOsjQvB=hb=QPV=bLXkC3ekmPUXFiPMnj1NK-Jtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: gpio-grgpio: fix possible sleep-in-atomic-context
 bugs in grgpio_irq_map/unmap()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andreas Larsson <andreas@gaisler.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 2:26 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> The driver may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
>
> drivers/gpio/gpio-grgpio.c, 261:
>         request_irq in grgpio_irq_map
> drivers/gpio/gpio-grgpio.c, 255:
>         _raw_spin_lock_irqsave in grgpio_irq_map
>
> drivers/gpio/gpio-grgpio.c, 318:
>         free_irq in grgpio_irq_unmap
> drivers/gpio/gpio-grgpio.c, 299:
>         _raw_spin_lock_irqsave in grgpio_irq_unmap
>
> request_irq() and free_irq() can sleep at runtime.
>
> To fix these bugs, request_irq() and free_irq() are called without
> holding the spinlock.
>
> These bugs are found by a static analysis tool STCheck written by myself.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

I suppose this is correct, so patch applied.

However there is a deeper problem, this code was added by Andreas
Larsson in 2013 and at the time this was a hacky way to deal with
an interrupt that is actually hierarchical.

Since 2013 we have gained:
- Hierarchical interrupt controllers
- Hierarchical interrupt chip helpers in gpiolib

So this code really needs to be modernized using a hierarchical
irqchip.

See for example commit:
aa7d618ac65f ("gpio: ixp4xx: Convert to hierarchical GPIOLIB_IRQCHIP")
for an example.

Who is using grgpio these days and could work on fixing this up?

Yours,
Linus Walleij
