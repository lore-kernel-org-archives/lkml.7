Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A9B2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtoXSgQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKRKrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:47:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34674 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfKRKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:47:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id z188so9474454pgb.1;
        Mon, 18 Nov 2019 02:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dge8oGHILOMVpeHYXPYEEqzdaTbTgZkgcFraEKUk5Iw=;
        b=HtoXSgQeDMMxc5Almr2lsw2p6Uk0TomEHQWZp/YE3klijiuXaP/HtEkaD07T387JVp
         SJfq2dljQY2IWXxTqWA9EOwisHAhCFM/G4lCLqy2DUIrCH7Ha/KDcoO1jiL2kMvuQ5N5
         a2lUYxRmI+sxqTkWBQN496KiQ8S804wP0NX9LdAvFnR1Ksuo4exwAm0oKUmlBIXzWR4c
         0zNzE5AtxrQt71Huc8eHjyfKBw1f25nl2Owqaa2EIlS/JKr/CIb1I0+nUK8BcCav1/HC
         EA2EIsy5zMpkh1WzDW4wHlMIeBm5WZufOmgGvzpdTMlPSLe7qG3xFWx7jwAHUbhlWzys
         i4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dge8oGHILOMVpeHYXPYEEqzdaTbTgZkgcFraEKUk5Iw=;
        b=a4/lXH1U1cFGM7rtjAFAtjcfg6Lb9Vq19ecCe1EOlgOvgy+dn4T3Bc/lQjMjt4EGjv
         eu4Y7y3GcA9J7IShwvOGBjMu3DqWubTZr8tZwIbo+41apGtM5I+nty1CCzdDbQSIdbBw
         vJN+eijoXrdUUzAi5SDvwQfG75MQw0No4KaTLONmMysrwqAmpH5aHuIGrN9aVPdyiNvQ
         li6GFF3RWzOPJPPS0wCWky8s5koSI45klM2UE3ucnoJZD+qicA06QRX7lC34J9/DKrSe
         vgDxB27LvTDXQpQaN2LLFObPjIv7u82aV8uAMbi0cGPi9EMv9hRRDoyyOdS8GZ4Ut4pw
         0Rjg==
X-Gm-Message-State: APjAAAXV8+JDDXXiuvt2W/RBkbhX99T5hP7bZqGjtY/SkJRTWn6dIojF
        ZfuhyRkq5edtUYXpiubHfPVCe0ioFZOZsdNmf6g=
X-Google-Smtp-Source: APXvYqx6vi0UhJpubvhU/knhFdFxdxzoVMkqr6flgKEmwAWcrWS+2xYp0m7NdJDseyWgwuuzE1KAyGSaRhcMMxfdj5Q=
X-Received: by 2002:a65:5542:: with SMTP id t2mr14392758pgr.74.1574074042336;
 Mon, 18 Nov 2019 02:47:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573460910.git.sramani@mellanox.com>
In-Reply-To: <cover.1573460910.git.sramani@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Nov 2019 12:47:11 +0200
Message-ID: <CAHp75VdWM8Y7TAbVYNoo9vV2N+ZYDZWWGHtgvt8WjD5KiFfZRA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Liming Sun <lsun@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 4:35 PM Shravan Kumar Ramani
<sramani@mellanox.com> wrote:
>
> This patch adds support for Mellanox BlueField TRIO PCIe host controller.
> The driver supports multiple TRIO instances and provides a sysfs interface
> to allow the user to read/set the L3 cache profile for transactions going
> through the TRIO. It also provides an interrupt handler for the TRIO blocks.

Besides on-going review, this doesn't apply. So, please check that you
rebase it on top of our for-next branch, thanks!

P.S. I'll wait for v2 with Vadim's comments being addressed.

>
> Shravan Kumar Ramani (1):
>   platform/mellanox: Add Mellanox TRIO driver
>
>  MAINTAINERS                            |   5 +
>  drivers/platform/mellanox/Kconfig      |   8 +
>  drivers/platform/mellanox/Makefile     |   1 +
>  drivers/platform/mellanox/mlxbf-trio.c | 624 +++++++++++++++++++++++++++++++++
>  4 files changed, 638 insertions(+)
>  create mode 100644 drivers/platform/mellanox/mlxbf-trio.c
>
> --
> 2.1.2
>


-- 
With Best Regards,
Andy Shevchenko
