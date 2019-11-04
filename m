Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71E3CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E37D222CD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5QoL30H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfKDGPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:15:35 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43621 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfKDGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:15:35 -0500
Received: by mail-ua1-f66.google.com with SMTP id k11so1941087ual.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 22:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yIKhMPMljW03rsGEF8LljWFKxCpgqs32gHznOzRrkU=;
        b=a5QoL30HvSEZynCl/a1K6RSYVfhOX/6DM8wEnJNPYl1VWwe6nSWllO8JV7myjdbRQh
         t62rimg+Byea+5mVZX5GD6S/F9W/Y2Or8fhRGZm3AlG2qnfj8NCUmImGAQ7DMv8osiQw
         EmdxwKKoChB0+/iRdGQJhWzt4ZWTiSTiswywGX8X5pIxsOf+Kib6d6vghyZxugVK8558
         XKeFOz7xJH9hBzDGiPeaZOuwxfKO6EEOtuv9J044cs+U74fF7fLqm8DP0Hmo5Hnnb7Ei
         r5bW4eXGuf2lmI7ZBPTTOT2pNPzzPpxL4uw1GHGjA11VzU4JsmwCPfe6MI1tUEYNFcj2
         vJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yIKhMPMljW03rsGEF8LljWFKxCpgqs32gHznOzRrkU=;
        b=Wlqn9UVbqAPOBMfUd0BzKaDcQF+CUghkPavM+VT93sGSLCLl7rcF2vg2NjGdLaF23W
         iigE+50dBwfHgyGAvbhi8kX4zxcmsktqQkGtFkDGcEpERjfSEcHExM0ufN+33zHcwLqe
         e5SZ0953EplUh/Fs56Q9xLgYwQ1XydQ6W6SObYXkBgl7v794CrDwv07NlnX15Xp6+CaV
         GAJWNT+PZw7YNZlapsk5Hg2Y4rAQRqqLSY/qi+EShVJstj11jCX4wt7dm/nJaVpH0glc
         GvHOmJQ7arymlIJrLRkcRNFq9BD4qUPb4GuoNaPqsN0DOKEIuHlKWJQROHTSyKSpui+N
         GRdQ==
X-Gm-Message-State: APjAAAW5I9TuB6E5KWj39VOVZao93V3apmbWxAD2POmL/ICt2yX5tZP6
        chAHkBbxS1J/Mz/MI955OUy0Hhnd4bD+E8k/dQR2gQ==
X-Google-Smtp-Source: APXvYqyYHUY+82qcl4WGZkgldt09N+9qQ36Lo/k74j/vgi+PP8mh49yZ4P0PxZK+XtAddRrpT8QrZOnayNJQbpG8XpU=
X-Received: by 2002:ab0:1405:: with SMTP id b5mr11166275uae.94.1572848134047;
 Sun, 03 Nov 2019 22:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20191101100035.25502-1-colin.king@canonical.com>
In-Reply-To: <20191101100035.25502-1-colin.king@canonical.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 4 Nov 2019 11:45:22 +0530
Message-ID: <CAHLCerPX5WPvVRxfgAQyAguomBaEsCyncJUuOafkY2cMjQmsaQ@mail.gmail.com>
Subject: Re: [PATCH][next][V2] drivers: thermal: tsens: fix potential integer
 overflow on multiply
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 3:30 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently a multiply operation is being performed on two int values
> and the result is being assigned to a u64, presumably because the
> end result is expected to be probably larger than an int. However,
> because the multiply is an int multiply one can get overflow. Avoid
> the overflow by casting degc to a u64 to force a u64 multiply.
>
> Also use div_u64 for the divide as suggested by Daniel Lezcano.
>
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: fbfe1a042cfd ("drivers: thermal: tsens: Add interrupt support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>
> V2: use div_u64 for the divide as suggested by Daniel Lezcano.
>
> ---
>  drivers/thermal/qcom/tsens-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 03bf1b8133ea..c6b551ec7323 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -92,7 +92,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>
>  static inline u32 degc_to_code(int degc, const struct tsens_sensor *s)
>  {
> -       u64 code = (degc * s->slope + s->offset) / SLOPE_FACTOR;
> +       u64 code = div_u64(((u64)degc * s->slope + s->offset), SLOPE_FACTOR);
>
>         pr_debug("%s: raw_code: 0x%llx, degc:%d\n", __func__, code, degc);
>         return clamp_val(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);
> --
> 2.20.1
>
