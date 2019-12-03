Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF9AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 04:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF202054F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 04:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzBgzHbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLCE5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 23:57:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44093 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLCE5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 23:57:22 -0500
Received: by mail-vs1-f67.google.com with SMTP id p6so1498880vsj.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 20:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ml7IBhdccfwW8j+1FG8S3XplDMBYZxcPTBvONmJE1w4=;
        b=hzBgzHbtVIyov5zqV3RPememS0AoB5zpkOlw8cfhalKrZwGNpYSLoE0xQf4l02oWrV
         FQIwZiBvAZGZJ/BLUAO+1ElZTAkEskhn665uiBkS/GtVX27yP0iD3c5CkHdCKNx9l6In
         UFupIM/RbBb37lwylN9sEEofwxfW2F/UqYr5luhxyHmAL1N16l9X7W2mEZvw/ZNL6z5H
         Bw0S6R/TIziKvfDb0bRK17RsVL3J33ww8NtVkfr2CaQtHOH+X9xfeD6ku0Dv40XKt/eg
         yOyby/1W9LCUCJpSHehZru40vphONetoeBGtYAtubxFjaRwoy0ue+KAF6POvHQs4DZ9a
         Fwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ml7IBhdccfwW8j+1FG8S3XplDMBYZxcPTBvONmJE1w4=;
        b=qG4yPiJbaoiwSeaDt4Z0OQgoYjwEUmHb4rs7vPn/9WLx2Vl54FUqwP6Brc5XexiAtn
         5J/g+IFMhYwPhcE1yCiUHH1fXKJUkDYb1VezMrMWaX13zIQ/MSwQ1XTcmYWMXfp6QIvL
         IY/AwfcJHQdNdej7KxsG1KcywuUxECE8O8KkK1FBJfjgmK4xWeFEXztzbRb9K+S7TG3X
         WKkhcj9nPctkB7F8yopYhAjdeziDevgGmkfM1oOjPJaqfyZE84AbIAxAijyDOMsTFhC4
         z/A6mOeT/hWGDgv0yKe7fAoDCoZfE5do1miuYi5A9SV8/WQtEJ0tuV7HiBvZ+89Fuda0
         Q5ZQ==
X-Gm-Message-State: APjAAAXEGsPtwsMrsMSO+6BJ2UtUJEM1L1UWLTjLYKZrlD8PuF3S7iWm
        Vxs7PCTk0OPRGK33Nm1YvKnfmbcC0Oka8OiACsWQdQ==
X-Google-Smtp-Source: APXvYqzzuJ7zVrjIE0Y2zaZ/PAovWXEvXm3YYHoOqOoTi9vqEY52XFNHaanurVBB7nEb72UyUNt1t6NXf2SV3i7mJvQ=
X-Received: by 2002:a05:6102:1261:: with SMTP id q1mr1756256vsg.182.1575349040559;
 Mon, 02 Dec 2019 20:57:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <4b949a4f401a7f9d403ed0f0c16c7feb083f3524.1573499020.git.amit.kucheria@linaro.org>
 <5dcdda2a.1c69fb81.27852.ac35@mx.google.com>
In-Reply-To: <5dcdda2a.1c69fb81.27852.ac35@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 3 Dec 2019 10:27:09 +0530
Message-ID: <CAHLCerNw_FuFeqDfckjmsSE+=ZGCn5EkvquUtDn7EEVjrw9aVQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers: thermal: tsens: Add critical interrupt support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sivaa@codeaurora.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 4:20 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-11-11 11:21:27)
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 4359a4247ac3..2989cb952cdb 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -321,6 +357,65 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
> >         return 0;
> >  }
> >
> > +/**
> > + * tsens_critical_irq_thread - Threaded interrupt handler for critical interrupts
> > + * @irq: irq number
> > + * @data: tsens controller private data
> > + *
> > + * Check all sensors to find ones that violated their critical threshold limits.
> > + * Clear and then re-enable the interrupt.
> > + *
> > + * The level-triggered interrupt might deassert if the temperature returned to
> > + * within the threshold limits by the time the handler got scheduled. We
> > + * consider the irq to have been handled in that case.
> > + *
> > + * Return: IRQ_HANDLED
> > + */
> > +irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> > +{
> > +       struct tsens_priv *priv = data;
> > +       struct tsens_irq_data d;
> > +       bool enable = true, disable = false;
>
> Why not just use true and false in the one place these variables are
> used?

Will fix.

> > +       unsigned long flags;
> > +       int temp, ret, i;
> > +
> > +       for (i = 0; i < priv->num_sensors; i++) {
> > +               struct tsens_sensor *s = &priv->sensor[i];
>
> Maybe make this const?

OK.

>
> > +               u32 hw_id = s->hw_id;
> > +
> > +               if (IS_ERR(priv->sensor[i].tzd))
>
> IS_ERR(s->tzd)?

Yup.

>
> > +                       continue;
> > +               if (!tsens_threshold_violated(priv, hw_id, &d))
> > +                       continue;
> > +               ret = get_temp_tsens_valid(s, &temp);
>
> Can this accept a const 's'?

Yes.

> > +               if (ret) {
> > +                       dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
> > +                       continue;
> > +               }
> > +
> > +               spin_lock_irqsave(&priv->ul_lock, flags);
> > +
> > +               tsens_read_irq_state(priv, hw_id, s, &d);
> > +
> > +               if (d.crit_viol &&
> > +                   !masked_irq(hw_id, d.crit_irq_mask, tsens_version(priv))) {
> > +                       tsens_set_interrupt(priv, hw_id, CRITICAL, disable);
> > +                       if (d.crit_thresh > temp) {
> > +                               dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> > +                                       priv->sensor[i].hw_id, __func__);
>
> hw_id instead of priv->sensor...?

Done. Will fixup for older code in a separate patch.

> > +                       } else {
> > +                               dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> > +                                       hw_id, __func__, temp);
> > +                       }
> > +                       tsens_set_interrupt(priv, hw_id, CRITICAL, enable);
> > +               }
> > +
> > +               spin_unlock_irqrestore(&priv->crit_lock, flags);
> > +       }
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> >  /**
> >   * tsens_irq_thread - Threaded interrupt handler for uplow interrupts
> >   * @irq: irq number
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 7d317660211e..784c4976c4f9 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -121,6 +121,27 @@ static int tsens_register(struct tsens_priv *priv)
> >
> >         enable_irq_wake(irq);
> >
> > +       if (tsens_version(priv) > VER_1_X) {
> > +               irq = platform_get_irq_byname(pdev, "critical");
> > +               if (irq < 0) {
> > +                       ret = irq;
> > +                       goto err_put_device;
> > +               }
> > +
> > +               ret = devm_request_threaded_irq(&pdev->dev, irq,
> > +                                               NULL, tsens_critical_irq_thread,
> > +                                               IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +                                               dev_name(&pdev->dev), priv);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "%s: failed to get critical irq\n", __func__);
> > +                       goto err_put_device;
>
> Do we need to disable_irq_wake() for the previous irq here?

Or we could just move the earlier enable_irq_wake() to after
successful registration of the critical interrupt to avoid the error
branch. See v2 posting.



> > +               }
> > +
> > +               enable_irq_wake(irq);
> > +       }
> > +
> > +       return 0;
> > +
> >  err_put_device:
> >         put_device(&pdev->dev);
> >         return ret;
