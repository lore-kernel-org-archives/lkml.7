Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B701C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DE1206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKrVndDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfLLK12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:27:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45235 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfLLK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:27:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id d20so1638085ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1IjxJJxDMWAlUZ4WjR8vfjxD9i7QeZnQLbWau+hr2w=;
        b=zKrVndDfMw5glaHDvVVAERCr6kNERWEAEMaXnAn6XjQp1Dz/ANs2Bs7QXF0mQR/Cz2
         nJq0uiTRUI3KdAfk94Snpeb5sFuFc/+MjT+xGMz7lVSrbWVIMg1wk0Bo7Vdx6zRT0Nwp
         jLhzeS9MJVDq/XIfd9aBvnCKoN9Py6x7OHzWKLGzROylVGLJIa1F9LbGhaOyzkSWLlNg
         PMmv5RSR22LOqjofX27f+enAaGR/ruNw47HlU9/dwmk4sPOTsPo1DNXe0IZH3BS1hDMp
         v5HpUjV3QdTya4PFNm84l69+yY6Rl07fkHSbD4ILn9bLvr3w5FD75QFUCNLLK0adbwu1
         bUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1IjxJJxDMWAlUZ4WjR8vfjxD9i7QeZnQLbWau+hr2w=;
        b=LVOIb8kGmF/reoho95gT9ThXpF/OIGgWDVPsuGM3A6TUkWOZcXXhT/RRFjckNTmfub
         MMUpCj6M/bheVsvOIOVdwoDAPxMAJhVDNgC4OXMKe/+0qHqtLJVtTSweKtt2MfRO5H/f
         UJlAApBLvEBP6QR18ipwxchbdcpn59OGnJJsc+F0PNm2aDKlC/hbCd0t1o7O3eSgR2SL
         1IePj70CjR1vW13MPgyd/UXwjrdWF/GdNJmf0uCG1cRGrpwTu6vTGGpMxT39rip9f4gG
         2yqzN0NyHvVGPELLLrupcuJaRo9DpMohwypzTGwWWVaukawYPU7/KPw4TDbmsgZZB4i4
         Butg==
X-Gm-Message-State: APjAAAX1rc1eaKCDSka0hGMUJCXpzO+EuG3DRhjmnIJmmWv9MgOwQcnU
        S1j0kx+4whR7on0zI39Pqq/ryOtu66ouCKrQ+fzdRw==
X-Google-Smtp-Source: APXvYqwyACjvGWNGgkwPrufrCiow0rWiDwCg8ObQ7/eGrZqpX1fin/kDROJF3DYdo4KqAwmTuqVW6FWtIZ4Mh9qKk0M=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr5340967ljh.183.1576146445650;
 Thu, 12 Dec 2019 02:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20191211010308.1525-1-dan@dlrobertson.com> <20191211010308.1525-3-dan@dlrobertson.com>
In-Reply-To: <20191211010308.1525-3-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 11:27:13 +0100
Message-ID: <CACRpkdaTfA1+Wj--cqCGWDOQGMWnupSYRhQeGL2i7917mN8pEw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

thanks for your patch!

Inspired by my recent work to revive the BMA180/BMA250 driver
for BMA254 I have some comments:

On Wed, Dec 11, 2019 at 2:20 AM Dan Robertson <dan@dlrobertson.com> wrote:

> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
(...)
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>

#include <linux/regulator/consumer.h>

> +int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)

Even if the component is always powered on in your design
please add regulator handling already from start so that we
don't have to go in and add it later. I've added regulator support
to sooo many IIO drivers by now.

You can pretty much just copy/paste my code for BMA180/BMA250:
https://lore.kernel.org/linux-iio/20191211213819.14024-2-linus.walleij@linaro.org/T/#u

Yours,
Linus Walleij
