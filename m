Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252BAC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBE027888
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISwdVjqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFBIj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:39:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39568 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfFBIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:39:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so10164157ljf.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yE2J5a6MB0Gc48eIqCKYzxTEPvXkEUZm6g5N6vUrQy0=;
        b=ISwdVjqGJ/u5HKAq5gTbqhDyiyczVmMmlYTgwPHKcPUmp0SwhHzU7n9NBcQLBkvePA
         AWZD4Y/Gd3Yl5vikkmWg5f0Ggh2Bx5BvM4zyG0wVU7KLmxO33iIVHM7rgYXNl1Ccs1Xy
         GEnHP6yig7grGK7di8iJCX6nFOvvZ1avP631pXQHKH+bw1LgP2uBOkr+ExzwXGbxTYgr
         xBp9nEvrC7335Ckbb2gq8dp5yWLCsj1QgPWMcODMuUhBThSETgSzzM7wrbzsLl7yxDBl
         10ZyzxfsW7kA1z0zpt5fsaNVuQ+47nBrhlHLOro5mWUJ+Fcv0rdwL1eFPX/OFm+ns+pE
         H4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yE2J5a6MB0Gc48eIqCKYzxTEPvXkEUZm6g5N6vUrQy0=;
        b=c8j/b1uNfcKHJOxMVbmpTgt6GmFwpG9dowps9XUnN6hmCFYmxGXykvi7kQfFv3R8U8
         vWq6ogmpj5ffQZ1mOg6KqKb9ddymtOyaNkRxsO3G3QwMrcX6xOTVZQRHUkHL3yj7i13d
         Y/cgjTeIZCOjFQ1G7XcI6/zqv0w1XzH73QlBTurDqP0J16AjRCrNJYVQOeV/ku2EPklu
         DC0KuheS34ibRGM/bVkHW8NdUZQr9Y7QEFbSV/tmmP4UjyIrRNVzLd2/eJlwwiuwUrAe
         C63wLmUYgtF5LpRnJR0PiE6EJwIRytC5plNXvejIIItCKa4AEEwdJGbCtGaeMun4dkRK
         fVOA==
X-Gm-Message-State: APjAAAX+On8mjgTOnWqgbDtVAsyc3Q/u5YVb1Z4WGWCloRepA+wr0Myo
        0pcDwyGNTP7LKrz8sTxDGhvzqtVd8G/7B7fxDFim2A==
X-Google-Smtp-Source: APXvYqyh6hWIl5W5nMmF/9/ej0DWHVcr46h1HQVRnLm8WUwbiyWxXnadUkdktX1kP9ytr2yZqkgU50r5CZ++QGbwClo=
X-Received: by 2002:a2e:8902:: with SMTP id d2mr10897010lji.94.1559464764019;
 Sun, 02 Jun 2019 01:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190528091304.9932-1-yuehaibing@huawei.com>
In-Reply-To: <20190528091304.9932-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jun 2019 10:39:12 +0200
Message-ID: <CACRpkdb0dti=x2UxaOoP=VRrzxQTuAaeQ2==UM4U6KNyHC2QwQ@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: bcm2835: Fix build error without CONFIG_OF
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Greg KH <gregkh@linuxfoundation.org>,
        Doug Berger <opendmb@gmail.com>, Eric Anholt <eric@anholt.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matheus Castello <matheus@castello.eng.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:18 AM YueHaibing <yuehaibing@huawei.com> wrote:

> drivers/pinctrl/bcm/pinctrl-bcm2835.c: In function bcm2835_pctl_dt_node_to_map:
> drivers/pinctrl/bcm/pinctrl-bcm2835.c:720:8: error: implicit declaration of function pinconf_generic_dt_node_to_map_all;
> drivers/pinctrl/bcm/pinctrl-bcm2835.c: In function bcm2835_pinctrl_probe:
> drivers/pinctrl/bcm/pinctrl-bcm2835.c:1022:15: error: struct gpio_chip has no member named of_node
>   pc->gpio_chip.of_node = np;
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 0de704955ee4 ("pinctrl: bcm2835: Add support for generic pinctrl binding")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
