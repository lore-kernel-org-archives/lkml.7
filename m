Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFDFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F652206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MGvMuB0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCKJz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:55:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46043 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfCKJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:55:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id t82so3099523oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4mgLO8GjIRGemzyiDWBOZgSDz812zHoHuJiyKDaWj6g=;
        b=MGvMuB0pVVRHiVoUELQKyxcn3kfJr4VS+GCKSpRO9J0lK8A/kwJxH0v9TCw6EAvl3O
         97X6lPm4g34dGOMqdAe3KkHDWw8uP53d1DlI6069xDlAXV6FyEenH/HjPZJTItZH8ovS
         RoGRqcGRsDuYg5TfW4BZlDrY2cC6iUKXzPCg+RHvz5vqsnfTmkR+7H/8gitfSCi42XYt
         i4gtL/iLd+AGXcaWZQGROJAxFWfUzsjvA5d7wcJgvq2KPm6SOwQHiDHxaZAEOIyrYpsd
         NbbfhuO9pbAktp0IicKMfktMVfj0nFABtDfO5VutNdS8nt3KpyCerQFzfmoeWAO0/xGM
         bWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4mgLO8GjIRGemzyiDWBOZgSDz812zHoHuJiyKDaWj6g=;
        b=P/baBq/qeuCoLNp6lwSI50/BHi8EJlIooAw23VLrDdeIVysNrQY7Xd8SylUZcGj+WJ
         5BKu1dkJDOpewcQsqO/CcbtWtffteObGt5ph6Z8DYzWTgwKnqsFxdzhd41x0sde2wRIL
         oJnEKWFzCArBjJB5V93xxcWYnzmZdfTlgvuane74PjH9df7bJnS3y6BEG+ruhusoMQGu
         V45c5ZnTbGrZ/zlU4schuOVQw54qHTJPLpOCc+86XbIGp0DgDCYVEnNrKme9vn/IB7ZA
         zHd+6+u6gB30H+Y2i8QiV6kpbzsxD2PEDxLAlLjyXPomOECx/1R+p7eTgyaFkFPmVoWb
         mJhw==
X-Gm-Message-State: APjAAAXc0hTumZh9v95EMotbDtCR/alKDZ8J75qwjQ8qVMIpynle5p5b
        MFntD0gPTf4Dt0ZnsUJ55aVbykRSahmJqtHD42lSlQ==
X-Google-Smtp-Source: APXvYqxNLGbrA/VllyprphQLk9CKxJSR/HQEOnemVinc8qayxHm2j2IUrcu5svuWrQhJzdRfBTAzCp2XUpE8qFMPtbI=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr16540852oii.170.1552298154134;
 Mon, 11 Mar 2019 02:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190311062737.6652-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190311062737.6652-1-andrew.smirnov@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 11 Mar 2019 10:55:43 +0100
Message-ID: <CAMpxmJXXp9KMNBExV5xQZg-dmS=WeRSD52_CKgXneMw5oA9dSg@mail.gmail.com>
Subject: Re: [PATCH 0/7] VF610 GPIO fixes/improvments
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 11 mar 2019 o 07:28 Andrey Smirnov <andrew.smirnov@gmail.com> napisa=
=C5=82(a):
>
> Everyone:
>
> This series contains a number of fixes/improvements I came up with
> while working VF610 GPIO code. Hopefully each commit is
> self-explanatory.
>
> Feedback is welcome!
>
> Thanks,
> Andrey Smirnov
>
> Andrey Smirnov (7):
>   gpio: vf610: Do not share irq_chip
>   gpio: vf610: Simplify vf610_gpio_set()
>   gpio: vf610: Simplify vf610_gpio_get()
>   gpio: vf610: Use devres to disable clk_port
>   gpio: vf610: Use devres to disable clk_gpio
>   gpio: vf610: Use devres to remove gpiochip
>   gpio: vf610: Don't use explicit &pdev->dev in vf610_gpio_probe()
>
>  drivers/gpio/gpio-vf610.c | 85 +++++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 49 deletions(-)
>
> --
> 2.20.1
>

Nice cleanups! Series applied, thanks!

Bart
