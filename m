Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FEEC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35D920726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="pmn0xhN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLIHl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:41:58 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39551 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLIHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:41:57 -0500
Received: by mail-vs1-f68.google.com with SMTP id p21so9578447vsq.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8x9z5IK3e1jLIYvYQLpPPPTrSa/xPbdbpcJwZ5RslgE=;
        b=pmn0xhN6Tb+kX0BCG0uXmcoqG1PzozNOPt10tuMFI22HOYdzAzYOdKDB/plA1snGDK
         Otsn3JiTjkyuuaBE0ZVIToFtEJRshz9dFzG8Chharzz8YaItxWj/H81zLPoCk/q4Na23
         paro+DokcNAtGu+4c6AJk4PUpR8Y0/MCdxV33fFY4CNzPjECPhnt1CyP/uPvFw7zw61D
         LaY7MKYg41sBBXBYtj7dBgMw1K7/uLnI5TaoO1LLNSiMYJdTBEFwE2KD0CgIEE1+bxbc
         SKDlhEgDaM8dlQf4fx2ZTaG4vhOMmQHDgJDeeDOZqzt5nOsSc5hoRtMXybBJEuGeWjV2
         2uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8x9z5IK3e1jLIYvYQLpPPPTrSa/xPbdbpcJwZ5RslgE=;
        b=tVnMBv51Txas6uOEmSAUs8r/MeFGkVK1VuHLLL0J0bRZhqSY3IFa8r/+8AQjDWhFlg
         Cs77SYGXJImIKo4Gxlp4RZlTUrWf61zBCTOfnw7Xm51F7bz4hjKju9sXFHz1Y6u++Fc8
         zTKhHkRyWZ3mu4hkbpyvCEfT88Fj/fyBdBLoOnGAaizXDsabvOSAfKq6GE+TCR3FSKAi
         PdNKfQGNogvtTlCqNfJMAbgLN8s0hhV26LSW+TaqmQrwCdoiXmkIETaGFCvSUx5jZlM9
         /cJqH5GTL170WcjyC7js4Zz93EnIL6QrJWmFNLUU/nwVkF6ynEs3s4N9Kom7S4qsw95u
         11vw==
X-Gm-Message-State: APjAAAURFxw0crzamwccDgX2lKRx6fkPj+aFmXWmAnW2GTDvHOirMhS8
        0/+Vuh1Nf68q9gW/1beKBiX4r3u9TZCyYFqQvY0gor4M+j6O7w==
X-Google-Smtp-Source: APXvYqzibvLQiYU/9XhXADboJGPQVfHnCc7v9B8G307Ku9so1UCHwb95zqnPu46yFD9lgRFp7QQvnrT7eW3mPNMga3w=
X-Received: by 2002:a67:fb41:: with SMTP id e1mr12561823vsr.159.1575877316661;
 Sun, 08 Dec 2019 23:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <20191205071953.121511-3-wvw@google.com>
In-Reply-To: <20191205071953.121511-3-wvw@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 9 Dec 2019 13:11:45 +0530
Message-ID: <CAHLCerOWxjG2nhyQFDy8=xXWhupL=7=juAzzTvnbAeutF=pU=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] thermal: improve error message in thermal zone registration
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 12:50 PM Wei Wang <wvw@google.com> wrote:
>
> Follow up with commit 67eed44b8a8a ("thermal: Add some error messages")
> to clean up checkpatch warning on line length and also add more message
> for developers.
>
> Signed-off-by: Wei Wang <wvw@google.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 974e2d91c30b..9db7f72e70f8 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1255,29 +1255,33 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>         int count;
>         struct thermal_governor *governor;
>
> -       if (!type || strlen(type) == 0) {
> +       if (!type || !type[0]) {
>                 pr_err("Error: No thermal zone type defined\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> -               pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
> -                      type, THERMAL_NAME_LENGTH);
> +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> +               pr_err("Error: Thermal zone name over %d chars: %s\n",
> +                       THERMAL_NAME_LENGTH, type);
>                 return ERR_PTR(-EINVAL);
>         }
>
>         if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
> -               pr_err("Error: Incorrect number of thermal trips\n");
> +               pr_err("Error: Incorrect number of thermal trips: %s\n", type);
>                 return ERR_PTR(-EINVAL);
>         }
>
>         if (!ops) {
> -               pr_err("Error: Thermal zone device ops not defined\n");
> +               pr_err("Error: Thermal zone device ops not defined: %s\n",
> +                       type);
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
> +       if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp)) {
> +               pr_err("Error: Thermal zone device missing callback: %s\n",
> +                       type);
>                 return ERR_PTR(-EINVAL);
> +       }
>
>         tz = kzalloc(sizeof(*tz), GFP_KERNEL);
>         if (!tz)
> --
> 2.24.0.393.g34dc348eaf-goog
>
