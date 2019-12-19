Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C1C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCEF222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dm+K4tCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLSLKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:10:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35091 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:10:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so4724240qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SJiLbsEyOxS8sGorfLAOU4xJKF3nGQf0Amv/oVqLTpM=;
        b=dm+K4tCbb0SMvVMAS0DtrlIoPpBOu2T6hGIWa5e7atlrpaJCuIes0zfCXr3T5q7nLs
         kCwvc1d1itkC2VjSGzn3qrkyXgtOkoW08YOAl0CKzd/ah4172kFKW0LPoSUpbNkC2RGH
         0P1kMf7/C/K9ig+o3VoEDpj/Q6kZT6fARM7OvSkMLaGKMQCDctwCGNw0G5H/PhVzOrT9
         rCj0biTH7OWie/kAr3zTxePDI0/x1GwlbSYqrOXqbTzt8WRXgp4EniJHAr8AS/WK2mbX
         SvOY2W2dEstfqvrnKwKZg0hg5YNAa4d+UqyBTP0C2ybhrvg78unmXrWyrRHP9DhjDsGx
         teUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SJiLbsEyOxS8sGorfLAOU4xJKF3nGQf0Amv/oVqLTpM=;
        b=PFkRgCVkqPQ5cfmFljKVQbooTF5UYtTGbMRMBinX/pns63I4EZStul+pRo/hu/FBqM
         g5rHAXCY9DzJnBqdRmB3NuqkRHNWlykvkeTpXwJZ2HY2oNwIHoTROOdk4Ip5LbO5aTSv
         LWjmCL5ait6AvU/CLBLnx5aNK3fzI8OS+lIuHAQ9s5MBgF0dIYezZtfITFsR5JLrkpea
         lidvRjVdmXnDywVDFvMTFE8NaPWqXB/Pv3nbVtTLgRiRKYerw1U1WJBgbpJXPEJl0zE4
         g6Gxwsu4D29GpIQbk0IvQHIbX2WGDlg6nlVnGCcQOPxL03ZhCR4a7uLY5uKcVg7xK3Kn
         fmQA==
X-Gm-Message-State: APjAAAXxcg5QFlPICSeNZWIZWhe5E0vchZQFCCOIdzd6oYXogGxyCJGV
        amloZTfkE6HWrRU/JbezBnEQFEPNvsuabCU+vp0MsA==
X-Google-Smtp-Source: APXvYqz2qAh5BXMI++n+PMlkR+N2stu371MGABqkdfpkG3bOIyTOMjLKw7m81VpyLOpj10ZoKe2TibEs4vNq/2Jzheo=
X-Received: by 2002:aed:3b6e:: with SMTP id q43mr6255037qte.57.1576753839903;
 Thu, 19 Dec 2019 03:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20191218132551.10537-1-baijiaju1990@gmail.com>
In-Reply-To: <20191218132551.10537-1-baijiaju1990@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 19 Dec 2019 12:10:29 +0100
Message-ID: <CAMpxmJXZKZYg_B_EpGbnoCEfdKw756KF5gurC4ck6RwjNd7A-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-grgpio: fix possible sleep-in-atomic-context
 bugs in grgpio_remove()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 18 gru 2019 o 14:26 Jia-Ju Bai <baijiaju1990@gmail.com> napisa=C5=
=82(a):
>
> The driver may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
>
> drivers/gpio/gpiolib-sysfs.c, 796:
>         mutex_lock in gpiochip_sysfs_unregister
> drivers/gpio/gpiolib.c, 1455:
>         gpiochip_sysfs_unregister in gpiochip_remove
> drivers/gpio/gpio-grgpio.c, 460:
>         gpiochip_remove in grgpio_remove
> drivers/gpio/gpio-grgpio.c, 449:
>         _raw_spin_lock_irqsave in grgpio_remove
>
> kernel/irq/irqdomain.c, 243:
>         mutex_lock in irq_domain_remove
> drivers/gpio/gpio-grgpio.c, 463:
>         irq_domain_remove in grgpio_remove
> drivers/gpio/gpio-grgpio.c, 449:
>         _raw_spin_lock_irqsave in grgpio_remove
>
> mutex_lock() can sleep at runtime.
>
> To fix these bugs, gpiochip_remove() and irq_domain_remove() are called
> without holding the spinlock.
>
> These bugs are found by a static analysis tool STCheck written by myself.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/gpio/gpio-grgpio.c      | 5 ++++-
>  sound/soc/sti/uniperif_player.c | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
> index 08234e64993a..60a2871c5ba7 100644
> --- a/drivers/gpio/gpio-grgpio.c
> +++ b/drivers/gpio/gpio-grgpio.c
> @@ -448,13 +448,16 @@ static int grgpio_remove(struct platform_device *of=
dev)
>                 }
>         }
>
> +       spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
> +
>         gpiochip_remove(&priv->gc);
>
>         if (priv->domain)
>                 irq_domain_remove(priv->domain);
>
>  out:
> -       spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
> +       if (ret)
> +               spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);

In general there is no need for locking in remove() callbacks. I guess
you can safely remove the spinlock here all together.

>
>         return ret;
>  }
> diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_pla=
yer.c
> index 48ea915b24ba..62244e207679 100644
> --- a/sound/soc/sti/uniperif_player.c
> +++ b/sound/soc/sti/uniperif_player.c
> @@ -601,13 +601,14 @@ static int uni_player_ctl_iec958_put(struct snd_kco=
ntrol *kcontrol,
>         mutex_unlock(&player->ctrl_lock);
>
>         spin_lock_irqsave(&player->irq_lock, flags);
> +       spin_unlock_irqrestore(&player->irq_lock, flags);

Yeah I can tell this was generated automatically - what does this line
is expected to achieve?

Bart

> +
>         if (player->substream && player->substream->runtime)
>                 uni_player_set_channel_status(player,
>                                               player->substream->runtime)=
;
>         else
>                 uni_player_set_channel_status(player, NULL);
>
> -       spin_unlock_irqrestore(&player->irq_lock, flags);
>         return 0;
>  }
>
> --
> 2.17.1
>
