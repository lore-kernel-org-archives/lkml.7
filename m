Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9409FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6406621881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOw/3B7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfH0MJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:09:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51273 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbfH0MJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:09:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so2838158wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kG73YssMPFpHboph8IgubAuVgxjSOuHAqxxT96cCM2Q=;
        b=kOw/3B7+sid32pB59rUZflzkjSnwP23rI6gbVyEXcR21a7bnWm2Kx/la6Hir1r3Z/k
         XyolpsAJmnUxv2wcRAuSXQ/EG9L3udHbjTh2D7NxYKZmkQoiU5zLMdtrLtXaydiTwiTE
         vMla6o/QueM+UE8coc5gOvzeT3SKVYfHGg/rbVjF86kQl9Qg20rHbkF/8axYE6hudP6W
         pE3i3V+5F29DRWsO4rcO5AubA4QMLS1tuury1DwIFVZmc9/hn2a/fCPLz8T0WyXculA9
         wMNM2GCd/m2sBA4JmgUj0Rb6IMKW8DIHS5wTAtSaflT01n/6kulKNxwtwllyUp4TL+BB
         mieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kG73YssMPFpHboph8IgubAuVgxjSOuHAqxxT96cCM2Q=;
        b=PrIPnoX7mzndjfQjTxvqmZtXm3V3+Jar5eowJ/OMml5cEWmq3m5mUoy1P0aRiL2kqN
         OsHDmy+xB7tTS4fbh19V64oDkNO1Zko/ETW12iIFrypcW8ceW1YMr/Pf/dKU6THZjkgX
         w2fBm5ywt+NumdfnJZK2kpoGndou/qJN0qxlCkuQaPlxHAQY7Z+9jIqwI+FzLKLulklQ
         ZJo3WLasfXnwpd++I0Fs1Fcs9fi1jHfPNd+2Wa503H+qRIYAaXkXoYNZm+mtjUD5CyJi
         LuFIvfKR8k9Cq0ypGNmGBoz2t7FgBloVBjU/WjMSBzRTJOotN3Jd3iIkJ/iS4FQ6uA6u
         kVmA==
X-Gm-Message-State: APjAAAXYdBbcUj1CfkznbOYX5o1pOPQGDPJtQO4jNHPGVd5eLfYrUJAr
        6+8Gmxwn5V9u0fAbHZxXhi10jjqAawUH8IqKTxw=
X-Google-Smtp-Source: APXvYqx1mySRuuMcf6ImCtUwR4sdXMy95MXfkCQCRN+9owUbpXAKxVScFgRvPxIpEPbW/FiNmjurcC+CkKlR4cQ/EBs=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr28903280wmj.13.1566907775637;
 Tue, 27 Aug 2019 05:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 27 Aug 2019 15:09:23 +0300
Message-ID: <CAEnQRZC9+ZiEUq-X34xv0L-QV4k1_XDbnBgdu8b8Kqo7wiT7CQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42xx8: Force suspend/resume during
 system suspend/resume
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     brian.austin@cirrus.com, Paul.Handrigan@cirrus.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 1:15 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Use force_suspend/resume to make sure clocks are disabled/enabled
> accordingly during system suspend/resume.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/codecs/cs42xx8.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
> index 5b049fcdba20..94b1adb088fd 100644
> --- a/sound/soc/codecs/cs42xx8.c
> +++ b/sound/soc/codecs/cs42xx8.c
> @@ -684,6 +684,8 @@ static int cs42xx8_runtime_suspend(struct device *dev)
>  #endif
>
>  const struct dev_pm_ops cs42xx8_pm = {
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(cs42xx8_runtime_suspend, cs42xx8_runtime_resume, NULL)
>  };
>  EXPORT_SYMBOL_GPL(cs42xx8_pm);
> --
> 2.21.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
