Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB201C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8380121775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDJqdr0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfK1Sqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 13:46:45 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44518 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1Sqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 13:46:45 -0500
Received: by mail-vk1-f196.google.com with SMTP id u189so5398058vkf.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 10:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAcsdTWTMDRBmGclm59Bby1W0j7rzUU6vpArZy95gbA=;
        b=wDJqdr0iECuvOvYXrL9HYzzNGKueDft0lNsdVIRX2eezSz4hgren7SSeI//ULzKuwF
         7pUShn36jMVG9vgVRoZQlCzrhcBvSFs1StoVVG1NPeC5wdVV2cH1HiaKKocPUGK6f76B
         cSuhdGSmyeTZi5NRXXLZnii3pPapDWvHECs3KTyOV2c3Q6KHbbZ6J05GsvBazmqQbZjH
         k5wuFWlkgFu2oYtM3eB00cML9a8udl9AK3nTaZl6xwP5sjiBRcpcU3Hout+3K8zGlBzQ
         U6yHjx/AsZUYE+8gT258StJX5mWrswzlVOBOD+P7yMw/XNUiUelZCttzRMBOKBfn9RZE
         bIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAcsdTWTMDRBmGclm59Bby1W0j7rzUU6vpArZy95gbA=;
        b=eK66Vb+D6T8/8CtkQy3gkbIHm/FSb4bGPUux6/BDbUqOmEzjVojp1fJw6qzfCOeK5x
         /hsHvVJXhaU1cbLaMI/xVPy3L2oOMchXpXZHp8e+tEN+EeWv6rcuBG1UADBW59kHlmce
         jk7Tw0Lx2tk4Mm+hqJBGIMxxNMU6FV+/os4Rlc48nDqT6e6fVLFB9O19LtS9ZuevsgyW
         3gpSjUq/Sbbwqz4ltv1W6YOeiGFbyCgRi7nNKkDx1eLvpmsIkrVZzmdrX+s7JQfrB6Ca
         C4C0bsoUF0qVns8OOXzpihEgZaL3Gjj3cFr7srly7bmmQ+f/kDqbceJUfB7bRTc1Orps
         vtzQ==
X-Gm-Message-State: APjAAAVqdr5SvkMkioATrg+x1WXvsjWo9/PhESwwCeZJezBjRNoYU9Oq
        7W9pT5fhl59a35dqY/g93lyx77KXn7YhWEyddisUkw==
X-Google-Smtp-Source: APXvYqxTtFBGIqIS6CRYTY3K5IRU2UvrWdyzsvozgnR7oMFzeOT1ctVWePr4bEBK4OmuNgvS6apMCZW1a4GuoxoRds8=
X-Received: by 2002:a1f:fe45:: with SMTP id l66mr7733653vki.9.1574966804202;
 Thu, 28 Nov 2019 10:46:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <4b949a4f401a7f9d403ed0f0c16c7feb083f3524.1573499020.git.amit.kucheria@linaro.org>
 <20191112193852.GC3140946@builder>
In-Reply-To: <20191112193852.GC3140946@builder>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 29 Nov 2019 00:16:33 +0530
Message-ID: <CAHLCerN1VXhU0VQWN15PB2R16mkCV0i6Mn3+LW=xXtB5_7Z6JQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers: thermal: tsens: Add critical interrupt support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 1:08 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 11 Nov 11:21 PST 2019, Amit Kucheria wrote:
>
> > TSENS IP v2.x adds critical threshold interrupt support for each sensor
> > in addition to the upper/lower threshold interrupt. Add support in the
> > driver.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 129 ++++++++++++++++++++++++++--
> >  drivers/thermal/qcom/tsens-v2.c     |   8 +-
> >  drivers/thermal/qcom/tsens.c        |  21 +++++
> >  drivers/thermal/qcom/tsens.h        |  73 ++++++++++++++++
> >  4 files changed, 220 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 4359a4247ac3..2989cb952cdb 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -23,6 +23,10 @@
> >   * @low_thresh:     lower threshold temperature value
> >   * @low_irq_mask:   mask register for lower threshold irqs
> >   * @low_irq_clear:  clear register for lower threshold irqs
> > + * @crit_viol:      critical threshold violated
>
> "violated" as in "temperature is above crit_thresh"?

Yes.

>
> > + * @crit_thresh:    critical threshold temperature value
> > + * @crit_irq_mask:  mask register for critical threshold irqs
> > + * @crit_irq_clear: clear register for critical threshold irqs
> >   *
> [..]
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 7d317660211e..784c4976c4f9 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -121,6 +121,27 @@ static int tsens_register(struct tsens_priv *priv)
> >
> >       enable_irq_wake(irq);
> >
> > +     if (tsens_version(priv) > VER_1_X) {
> > +             irq = platform_get_irq_byname(pdev, "critical");
> > +             if (irq < 0) {
>
> Treating this as a fatal error breaks backwards compatibility with
> current devicetree; and even within your patch series, tsens should fail
> to probe between this patch and the application of patch 3.

Good catch.

> Please flip this around and do:
>
> irq = platform_get_irq_byname(pdev, "critical");
> if (irq >= 0 && tsens_version(priv) > VER_1_X) {
>         request_irq()...
> }

Won't this still break with current devicetree since irq < 0 until
patch 3? Or are you saying we shouldn't check for
platform_get_irq_byname() failure?

I can see two ways out:
1. We patch the dtsi before the code change.
2. We make critical interrupt failure non-fatal by just printing some
messages and still returning success.

Regards,
Amit


> > +                     ret = irq;
> > +                     goto err_put_device;
> > +             }
> > +
> > +             ret = devm_request_threaded_irq(&pdev->dev, irq,
> > +                                             NULL, tsens_critical_irq_thread,
> > +                                             IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +                                             dev_name(&pdev->dev), priv);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "%s: failed to get critical irq\n", __func__);
> > +                     goto err_put_device;
> > +             }
> > +
> > +             enable_irq_wake(irq);
> > +     }
> > +
> > +     return 0;
> > +
> >  err_put_device:
> >       put_device(&pdev->dev);
> >       return ret;
>
> Regards,
> Bjorn
