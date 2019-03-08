Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D78DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1D620652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEm+WSjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCHAXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:23:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38613 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCHAXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:23:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id n125so12739945pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaNdzHpyRelc1q6DAUQduEKVIQS51OywdxHKs2nMskI=;
        b=fEm+WSjHWCDawX2h2dXYzP8tCkuM+h0f22IxWfTUxqjZVaxRTqRoOCZnMLMQkfbyje
         BmT3ohnGxA52DiFcYJIlVa5T0VZVbx0knJNAwDfzZY4wzrCImyOTQfQ1x6MXIBdV14kA
         mcf5NkR/qQ66NA/plPa/LP1+xznSko61zRpFQOhU61WpEmOT52lePE8OKKIoau28ajdR
         iFRkEtX4Z83TrA8Tt0kHP2MUYSgb358X5yaFhZoaSjVFOXbHDQsq/rICyw8EkbCuU6bU
         zbIybSOT52hsyrm5Nsk7CvvsNxdiFPOB6Tb9Rgvyx5nvQtduI+o8/BBXt6EtxfpjlPpB
         6A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaNdzHpyRelc1q6DAUQduEKVIQS51OywdxHKs2nMskI=;
        b=sxFGcRi08gmi3mVOXPPCnqroZh+PzrsND0AhcIpxsjQkKxho1esB92trqNNd6G0oJa
         l+6EvFspXDG3g9GEBarNefTAcwIACO+juIVNvQ/4DHyAoa0mjI+tyF0VrHDvEm/BmAv6
         lJ5+eJKlpdOqArwGJFk841TvZQI/BDFo/+UHMgmQS7xuS0iYg+U5Wvat0PohSblnGk/J
         19HlcOGk1eOId9sNXyns12Jm9+mDP4rAxNn2nGtCeUfqVHa3rEXyi76Vtu65GR5u48f2
         erMP5Fff4i7jl0WVvbz8T7MQf/gNBhH4PVfCdMk7HwPlmvMh50FrPUMlx/u6j0XkUqEZ
         KlGg==
X-Gm-Message-State: APjAAAVUVi2BRBOHTuQ5JbKwWPkI8NrvKZLaQ0Bm0r4eByLNWwXooCt1
        vwn2YmklkmFP62sOdnMqwdWBupanYm6dCd1nR4nLtA==
X-Google-Smtp-Source: APXvYqyCbfSnEse9L+9zhyt64or6nyhigIMAb7ZOoFLr22g0N+h0Fb8aAeHW3wHp2Vh7nOYcSJOvFM8rtIydplm+J6A=
X-Received: by 2002:a63:c70c:: with SMTP id n12mr14210612pgg.302.1552004620101;
 Thu, 07 Mar 2019 16:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20190307223628.21270-1-natechancellor@gmail.com>
In-Reply-To: <20190307223628.21270-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 16:23:29 -0800
Message-ID: <CAKwvOdkrDcfOnf8gevj4-83Kk2o-hyX56A-cpJMf-hnWJe5hXg@mail.gmail.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in img_pwm_config
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:36 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
>
> The final else if functions as an else; make that explicit so that Clang
> understands that timebase cannot be used uninitialized.

A welcome simplification! Thank you.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/400
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pwm/pwm-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index 815f5333bb8f..1cc5fbe1e1d3 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>         } else if (mul <= max_timebase * 512) {
>                 div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
>                 timebase = DIV_ROUND_UP(mul, 512);
> -       } else if (mul > max_timebase * 512) {
> +       } else {
>                 dev_err(chip->dev,
>                         "failed to configure timebase steps/divider value\n");
>                 return -EINVAL;
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
