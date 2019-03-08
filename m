Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE8720661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b/gI5hPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCHA7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:59:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45942 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCHA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:59:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so12794816pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=EXlBlsg6QHN0F9pOJ3q3ORW/InRBYEI8MN3sEPcgq+A=;
        b=b/gI5hPDVQJaY34qrLutwpIH+t73J8aBxiDQt+0rUH8wwIfU5Is6FcziStlk9QGcXD
         yOPJQB3/tyx9D2QbWXfz/A8O9vLTICDaxQgGB47o0AHtcE+C3XhhutbESf9pnHGIytCf
         Zp5TqV3coTc7708tcHBx15p3lPKQK9C+w8mnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=EXlBlsg6QHN0F9pOJ3q3ORW/InRBYEI8MN3sEPcgq+A=;
        b=k0iVLo+9Emp/JRvKczt7uUVw5d7bP3O5HdL/KWP9kipFCpGEdvV5aTej7aR5gAc56G
         Q+31iVgZ2fVcq8iQ9woCLNpWiImpTYckQhuWFhnu9jbhBu0hI+5RjRLXkCjOgjpxzqkT
         JakPgC314PEEByWkiEIGfDiHJoTuKyXHMvpdZtRsN+LEKtEUcO06alhINCnJQ5L81++0
         Ds3jCxGMzb0Nd+j9IweoXwZdfheyscr3xFJs+7/fc3WtTQI9oUpofko4zwqc5vKoX/9e
         YKkzfObBShnyKy2ZmsNvm8Xy8yBnbCwY/UA8mX1AI0M/7HWurg0Nu4EoC1VbkAJumAgH
         +Rqw==
X-Gm-Message-State: APjAAAU+wIm01AAsUGV2b1ToJlM+rn9uIP3U1jKukQJ+KqXITr+3cYC1
        //od4JcNIYlnD214bbJEdCpt/5Y1HeqSnw==
X-Google-Smtp-Source: APXvYqydyPfi68OnurlL6tiYkoUMevggrif5nKF40LdGrY9k7KBIpegbp/iNuiKBbzOQpQlEiWCTyw==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr15314708plb.172.1552006776331;
        Thu, 07 Mar 2019 16:59:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s79sm11782921pfa.61.2019.03.07.16.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 16:59:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190222221850.26939-7-ilina@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org> <20190222221850.26939-7-ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3 6/9] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        marc.zyngier@arm.com
Message-ID: <155200677430.20095.14337964669558394653@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 07 Mar 2019 16:59:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-02-22 14:18:47)
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pi=
nctrl-msm.c
> index ee8119879c4c..83053b45982e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -890,6 +918,9 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, =
unsigned int on)
> =20
>         raw_spin_unlock_irqrestore(&pctrl->lock, flags);

Can we remove the above hunk of code in this function? From what I can
tell we're trying to set wake on the GIC SPI line and that won't ever
work because it doesn't support wakeup support. Furthermore, I get a
lockdep splat when I try to set wake on a GPIO irq with this patchset
applied. It's probably a false positive though because it's warning
about an AA deadlock with the irq descriptor lock, which is aliased
between the two controllers.

> =20
> +       if (d->parent_data)
> +               irq_chip_set_wake_parent(d, on);
> +
>         return 0;
>  }
> =20

Here's a patch on top. If you need my signed-off-by please feel free to
add it:

Signed-off-by: Stephen Boyd <swboyd@chromium.org>

-----8<-------
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinc=
trl-msm.c
index cdbc06ec5e96..4e81dad80a4d 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -852,20 +852,10 @@ static int msm_gpio_irq_set_type(struct irq_data *d, =
unsigned int type)
=20
 static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
-	struct msm_pinctrl *pctrl =3D gpiochip_get_data(gc);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
-
-	irq_set_irq_wake(pctrl->irq, on);
-
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-
 	if (d->parent_data)
-		irq_chip_set_wake_parent(d, on);
+		return irq_chip_set_wake_parent(d, on);
=20
-	return 0;
+	return -ENOSYS;
 }
=20
 static int msm_gpio_irq_reqres(struct irq_data *d)
