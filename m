Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357ADC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B4F20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vplj40Sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDCW5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:57:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41125 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCW5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:57:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so317902lja.8;
        Wed, 03 Apr 2019 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kzdcy6zDAVBi4lPlN6UsVKWH/Jkbli+MQJiHkKwRPvM=;
        b=Vplj40SrTOR9QSf1dsHAv3KjBehJVyY5dIJnb2V/ahqan/nJNWmCHpL7gP6Jd0zmlx
         rh+lO0bfM6OmCVP1nMUpjhGtXEvIl9xN8Az6Eiw1Xl87j0GuaF6tFYMuZXeeCM6ik4lq
         jGu5+9tlQfUv6tIlLX90+R7fzZXNRcFUXGEWWrfvvUIfcnEuuT8HfojyVgIUatH2H28q
         mY3eUaQxln4054UXVGIj2Ki5xEFvjclQSalsf2w5JNW331LdmWQbK8p2PfEzKr/pnTNg
         PmkZ0NbN0BRAcHamVnbyvClLcsI13IHh2CujvAxGSOVAc10iMi1rQog3cf6Pv98gpobU
         3v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kzdcy6zDAVBi4lPlN6UsVKWH/Jkbli+MQJiHkKwRPvM=;
        b=Z9VjGUS6g9uLJN7bkyQYd4nq6fCn5vVN78KjyGPypSMVUHF/+QkZlLtSXYTm96EGOM
         4U6igHi82mCoQN2/ZMn3Z7xPGIWxvtZuF+mMte3Ei2/RSVOXCe2GFtyvahMUINQ/j7wB
         SqolhAn4Krn5zlDWkpuPHDQ6Bd0b+K7oMj1JbhXjbkohg6w5AcoX0PnN/M75oMjesC7r
         syNFcGbg5PKui0RqpGco2hXzOtVg9CruwoUuLpec5TFEmarnxG4YqUlNpMYrTEMqEcHr
         uj1yOw/Dj6OpB66nCEErNWlxU0SsJpyAqQyVguQhjxERk+EUHCbh4Q2cD24kv7QAWmDC
         YOuQ==
X-Gm-Message-State: APjAAAWe0+fsy40W0hEEePoBif3xNPPQBfSpPRyQuWZdIW8Yo8dfkz3Y
        agjp0WSU6Qff9M5wNqRbFi43yUJJ9yIMaowECc4=
X-Google-Smtp-Source: APXvYqx6MieX7VAgdPO4kGkCz/Jy3PG8BDiXKqowb+OfCkQz+jDhj6oC9GlR+FURApAVaquTD3Bz/8lkgZIvrFOLP8I=
X-Received: by 2002:a2e:309:: with SMTP id 9mr1281709ljd.114.1554332222843;
 Wed, 03 Apr 2019 15:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190327064150.31549-1-andrew.smirnov@gmail.com> <20190327064150.31549-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190327064150.31549-2-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 3 Apr 2019 19:56:53 -0300
Message-ID: <CAOMZO5BZCGzJddFdbXKFYu8YPf-sWrpidf-B8JKi-KXPFR4Kmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: Add support for ZII i.MX7 RPU2 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

This looks good. Only some minor comments:

On Wed, Mar 27, 2019 at 3:41 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
> @@ -0,0 +1,936 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
Shawn mentioned on a prior submission of mine that this empty line is
not needed.

> +       cs2000_ref: cs2000-ref {

generic node name, please.

> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <24576000>;
> +       };
> +
> +       cs2000_in_dummy: cs2000-in-dummy {

generic node name, please.

> +&ecspi1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       status = "okay";
> +
> +       cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;

status property usually is the last one. So please move cs-gpios prior
to status.

> +
> +       flash@0 {
> +               compatible = "jedec,spi-nor";
> +               spi-max-frequency = <20000000>;
> +               reg = <0>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +       };
> +};
> +

> +&i2c1 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       pmic: pfuze3000@8 {

pmic@8

Reviewed-by: Fabio Estevam <festevam@gmail.com>
