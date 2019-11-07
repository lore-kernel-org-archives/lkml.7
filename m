Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EB6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8667A21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6FTWVC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfKGPBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:01:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47018 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKGPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:01:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so2599235ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgAkr102LqQKPAr3pGJYhPDK4e/SFK30Vkoy1JW8C9s=;
        b=K6FTWVC18/HyP+n8tnIdWBbmpg4P7IxBIGjTfd3smZOdNgDhapmaHf1IhT8kb2LSeg
         Jp07yGotkBOcA6+pRceCmh3VjtNawsLwxSifx2YACvzh9JDUgrSG5pHHU6YW2cq3V8qi
         wbXClCy8b0xtcYKRt6csHAPi5UH1fVW1AlSaTW87EJcyy26oAX/KQxunAyTCdCbMLQao
         hmwkxLx/5OQRsiBShbFCZRZq+qwSxwx5ReOVAbsv2fE+fKibsPIEhdksbqEEnkH6QekX
         NqQzaZNv//tuRz+X9s5Fgxa3pRbvJVbZDYBy4Ju2n+OYbhL2uB9GnNoF66wM6k4KJ3B1
         J1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgAkr102LqQKPAr3pGJYhPDK4e/SFK30Vkoy1JW8C9s=;
        b=jJj7I21X1cv9kqj6i46peH6+lrWi5bGAMUo3znVSX2eyQvphxXQuiHa3FLKS/ZAfqq
         9qw57CYOTnhCc35droZQlQ56BNsnnJ1I/DQQ6IxW3kAHVI2hxdtN5PHHGBUZVSQJmfgV
         3UMwAB6HVr8b7viz8yPBepMo0hJ5QAGQbXZoeWZTk4nT7nuv31YnzGKp7yAZ52U01cyN
         +mpng6/QLdK0gR9EgHh47R4BCDK44KCHT2XS1rEcewTQ7Asn+Tst35bWwirBCaFCwRCT
         hl2dXaI8l/AZQ5U/yhK8B/UDrTKzl3dVGH1lL/0v2NqaJfTP7bMgiXFYFhHm4fihTkPV
         Tb1w==
X-Gm-Message-State: APjAAAXZ6Iv7EG/3kXJyB7JdCFPfKeyRzoMajxAQCGzVQ4qfZqrHMtur
        kla9jpm4NaJCVW/6QIbb+0H7MbFK4VsCknbu0SuHZA==
X-Google-Smtp-Source: APXvYqxEfc/CuHeO/tUPbA/L8KnwpKF2GYeDL5vyFe1U1/wxU4srnu1AJ/8ugakgyWV8GG7sl3Pz4PrhWVkvlJpK/wQ=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr2740565ljj.233.1573138907121;
 Thu, 07 Nov 2019 07:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20191107103540.21088-1-jonathanh@nvidia.com>
In-Reply-To: <20191107103540.21088-1-jonathanh@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 16:01:35 +0100
Message-ID: <CACRpkdZircUVEcQHV2saCk_Mihf-hUWWKUJ=h9jg1it58VeitA@mail.gmail.com>
Subject: Re: [PATCH] gpio: xgs-iproc: Fix crash when driver is built as a module
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 11:35 AM Jon Hunter <jonathanh@nvidia.com> wrote:

> Commit 6a41b6c5fc20 ("gpio: Add xgs-iproc driver") introduced a new
> GPIO driver for the Broadcom GPIO controller. When this driver is built
> as a module the following warning is observed because the
> bcm_iproc_gpio_of_match structure is defined with the __initconst
> attribute ...
>
>  MODPOST vmlinux.o
>  WARNING: vmlinux.o(.data+0x834d0): Section mismatch in reference from
>  the variable bcm_iproc_gpio_driver to the variable
>  .init.rodata:bcm_iproc_gpio_of_match
>  The variable bcm_iproc_gpio_driver references
>  the variable __initconst bcm_iproc_gpio_of_match
>
> This then causes a translation fault on boot which and results in a
> system crash. Fix this by dropping the __initconst attribute from the
> bcm_iproc_gpio_of_match structure.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Incidentally Mark Brown already sent an identical patch.

Thanks anyway!

Yours,
Linus Walleij
