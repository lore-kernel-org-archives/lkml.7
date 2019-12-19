Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E512C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B092467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXcQVrIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLSVlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:41:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40746 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfLSVlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:41:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id u1so7827033ljk.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 13:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASudMKT9RvM8+uOEJ+om2HEpPLO01yunBeLwD2PFAJc=;
        b=UXcQVrIGeuZxPW+wBt70BmOeFM34wTHIaDD0QSufDB+hpWy60xAnbwPJzGMxZPXXTh
         Bvo8xVwa12ZkQ98lNPHyUhNhqkyPhh0MIfsaBBppOcWPWZTk2unZdTF49txMzJY3pHCD
         YxHDMEoyLpEkPOpdFmf/K3MonB5D7tmCbAN8kHT74gEBRwDcUB8IFxHMaMXJw7WUtcz3
         +XHy8aT9jY6xESdx5KtiAOTv1zlbyPbECB2s9vvieBjnb2sKKBAWjoVIOiF0jHW9D+FO
         hbJU/6H/5NVBmZHwpJjIPmmCajp+Vkm1VSI5ttRddK13sa9OsU5HRyIcUFtY30Eo5+Tf
         ZKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASudMKT9RvM8+uOEJ+om2HEpPLO01yunBeLwD2PFAJc=;
        b=Y5nZNqb5+dtLlNFda1xcPMijn17sPE8efZKr1i3xdDrYSzJEz5R8f6kwasoG55R5iu
         dHTbR6sBDTBVZcQ6RdYul+IOhRDlZqx3h07u4wLxM6OYwfxPwqGq9Y8KGa7rdP+85lFr
         GepwT05BIJjdImTE1/5+A2nRQhbf0kBi0BmCJLR5KMchiWHZvJQc8k9cDdN/2z4rbKY8
         SOl4M+b3A7eyIDJb8Z9kDLRQjqIsSVXhwMNyJwy7y87hUIvmfJw+HwjT3U0eBb6uf+zL
         +mIVOEpcuV42XEHOuyf37KIrzwUzNGb0mX0bH92f75J0Ox5q/OO0NVcwAUowf0nZG0y+
         UpHw==
X-Gm-Message-State: APjAAAVXahlfCVnyhpnHnuMCeD1d4NRssF54Osfo/8wKd+f36v50lzPs
        vVYANOlOmxCpeCUU25Kh4d88lchc9iBO5m9MRz5QIg==
X-Google-Smtp-Source: APXvYqy9XFc6i9Ei1l8/pgiZ7fRlyEwn/IPd/gtw9jl+Fsj13MvpzMQ1Czzx4p0iNxwBYpWYIGIEHFQfXkyLyoBw2Kg=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr7762896ljk.77.1576791690711;
 Thu, 19 Dec 2019 13:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-4-dan@dlrobertson.com>
 <CAHp75VeU07TsV2NC5Myvmi7Q6tARbmt9=wQDRnXFqaX2G2Luiw@mail.gmail.com>
In-Reply-To: <CAHp75VeU07TsV2NC5Myvmi7Q6tARbmt9=wQDRnXFqaX2G2Luiw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Dec 2019 22:41:19 +0100
Message-ID: <CACRpkdbTissSRyJ5uh8X6RFTM+VSSML-JmtOC_i8_UY0VTVRAA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] iio: (bma400) basic regulator support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Dec 19, 2019 at 6:28 AM Dan Robertson <dan@dlrobertson.com> wrote:
> >
> > Add support for the VDD and VDDIO regulators using the regulator
> > framework.
> ...
>
> > +       data->vdd_supply = devm_regulator_get(data->dev, "vdd");
>
> > +       data->vddio_supply = devm_regulator_get(data->dev, "vddio");
>
> devm_regulator_bulk_get() ?

I always thought to use regulator_bulk* maybe 3 regulators and
definitely for more that 4 as it also clouds the view bit and is not
as straightforward to read as the single functions, but I suppose
it is a bit subjective :)

Linus Walleij
