Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF371C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B339B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lr4zFJbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfLLJvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:51:00 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35887 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfLLJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:50:58 -0500
Received: by mail-ua1-f65.google.com with SMTP id k33so623027uag.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Th0Gxjy39UzyWkgaaSlqfUVGyatOKXBlhrJ1etVX5js=;
        b=Lr4zFJbm8S7HgAMSDwABkA/wyND+xwdWGQnbqBjKgGo7aCnTiK8exjImHHk9GVigub
         OaEkvndf8/JCWjrVQnkebzikIg3uTiUuNMj9PK+Hdz5dbj8KOi1h7JaRhq4Ez9J8mYN8
         7GY99n0HWRrJq8+wjtLytVQYXZpJHijWwBw8hvMh5YDK0gY9LpzoPD4hzf6bjwToMqTF
         BXYVG570RYgua0JseTb5oaqV7jIcHoZd6nBTTnYqs1ev1K36YKDKg2oPPhbyY5JbQT6G
         EQhIA+/kNaa5FMfQh/+KDZ9zr9pZf/sXj42yi6Fu1wwHRpA+yK6HeCzVmaEhNuZBgrh8
         Atmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Th0Gxjy39UzyWkgaaSlqfUVGyatOKXBlhrJ1etVX5js=;
        b=st04N3f8wabBOdk5jIz/7RnshxHfFKMhM4MFcce+0Fw0IB+KapId2RoVTIKpYkIvhI
         zguYeE66V/TxyVJvZSj4p2VxOy4sezMpKKQ9+7Fb0yJsMeixW6dKV2B1rWDAGiHUDhQJ
         0iYoAPYwYKhhonlBoHVaQ01vOHxVaddK1NvREDMnNupy1nd5uOkKgLShiiUyjyoqXNrx
         tY8QDMjdg/UCQylRh4dQ7VXO7ws5bGkCAIXrv08bNfhJ3rbtrJD3gpNV45vRGKHB68tY
         vA/mB+tmjd8rYg8Qg7KLiQy9y7ZRgroX0bK/m7HYfLIu7b/z5JJHSB0z4lSF/+Mo7F8P
         z2Zg==
X-Gm-Message-State: APjAAAU/DZEsbIAvZqKob7iBBpBiRcd+cXDRcvND897QBsrC9HulYniv
        +n6tuGDEZPCSxhtffKH+m8panv1aCcW+BBV1U0ye2g==
X-Google-Smtp-Source: APXvYqwKZRVjkZ142WpeRsqhhDVJVdjOwhdMN2XDbdsfhAIXiWHisLYDXPMxFD1KaEHk4XY7A7F6pkHxDLP4o1kLsjo=
X-Received: by 2002:ab0:7352:: with SMTP id k18mr7176180uap.77.1576144257519;
 Thu, 12 Dec 2019 01:50:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576058136.git.amit.kucheria@linaro.org>
 <39d6b8e4b2cc5836839cfae7cdf0ee3470653b64.1576058136.git.amit.kucheria@linaro.org>
 <aa9174c2-c851-4769-0f9c-5541047a7901@linaro.org>
In-Reply-To: <aa9174c2-c851-4769-0f9c-5541047a7901@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Dec 2019 15:20:44 +0530
Message-ID: <CAHLCerPNMBFgFv6zAdKtzs21p9Y18d8fohJEMJe7o4ufNwdS6Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: tsens: Work with old DTBs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Olof Johansson <olof@lixom.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:42 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/12/2019 10:58, Amit Kucheria wrote:
> > In order for the old DTBs to continue working, the new interrupt code
> > must not return an error if interrupts are not defined.
> >
> > Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 015e7d2015985..d8f51067ed411 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -109,7 +109,7 @@ static int tsens_register(struct tsens_priv *priv)
> >
> >       irq = platform_get_irq_byname(pdev, "uplow");
> >       if (irq < 0) {
> > -             ret = irq;
>
> 'ret' remains uninitialized here.
>
> > +             dev_warn(&pdev->dev, "Missing uplow irq in DT\n");
> >               goto err_put_device;
> >       }
> >
> > @@ -118,7 +118,8 @@ static int tsens_register(struct tsens_priv *priv)
> >                                       IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> >                                       dev_name(&pdev->dev), priv);
> >       if (ret) {
> > -             dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
> > +             dev_warn(&pdev->dev, "%s: failed to get uplow irq\n", __func__);
> > +             ret = 0;
> >               goto err_put_device;
> >       }
>
> The code now is unable to make a distinction between an error in the DT
> and the old DT :/
>
> Why not version the DT?

Versioning the DT is probably overkill for this driver. Just checking
for ENXIO as suggested by Stephan seems to be enough. We don't lose
the error checking for devm_request_threaded_irq either.

Regards,
Amit
