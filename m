Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EBC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87165208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJ+Ri6Ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfEMOG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:06:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46574 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfEMOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:06:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so5884147qtz.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8tZxdI15W1D6mJk0HAaFb0wo+ED+NRU5tORxMmllL4=;
        b=CJ+Ri6Ly+a/q37XshOSG/9do5P5goVfnmqK0CuPVFmOrWq6huSadlQNMbvAHur+CrB
         m4gA2LHBt+r6utYdHrb8yvETWRUXcxzfGFA08nq40duKGh3gGMsh4G15I4lA0xGkw8hn
         oNoTeIBHt82uG+dxFmrjFiX9+YMJ68+edJ8AUP5JaLjCVYQzAwC/LcaWG7YeOq+feau1
         f+UZyEYDRcxCwKV2ll0VoRjqQ4MXAteI58BvfurlKjZF02308sEaJ+smlMyRmXz8HHWq
         uom2riUhCoYrZi3n9HkGmxS1KY7f84OVJR1Y/icWiWJ9lUmJM/brWzboZuPfnbYuumrV
         g41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8tZxdI15W1D6mJk0HAaFb0wo+ED+NRU5tORxMmllL4=;
        b=n6nAw55ZLo7wVq5XNxTkD3lvMCSSdcjY1pdniQaZQ5aZ4lFaW8FHEwUYfNh7Lm5AIG
         4JKs4SmKbi6EqPK8SX11DxJrWnVuntdkyElDgDDyazY9e/ktkJfj1A40qfJIaHImYhWI
         h4+cNKzrf5Kt2K+uDunTNHD+BcMyhjylW1lOfcxXLswVjaQHxk8URtBXqDHGUbk7jdLL
         FJh859ONSMMDokQwqrksOr5IUyH+aCd0vpYGXDwPLfBYTcQ0gv8tZjfqjBt3k/s4XHfR
         l2hCY6raEXIuUJ38xdgHwjEvt425ZmSyPOOyPSCRZRDfDyP6xE32zrwob2JVLQaACeOy
         I0AQ==
X-Gm-Message-State: APjAAAWi9iL+T7MN3fVbReoXb2uo1kwaoPOG1eeBECD4s9iX6llvaLeR
        +S6VxX2mqUbLlHM6FV7Ys6Zbnw/vg5DDMPfuYexoog==
X-Google-Smtp-Source: APXvYqyxwQxdPtpP5BL6x5r/sbn5YT96liPwfUPaqcrfDSILFVVXKx4K0R0CAvSTLrdgNEoUaErFrlXhPhke+rskx0s=
X-Received: by 2002:ac8:3884:: with SMTP id f4mr24754460qtc.300.1557756385298;
 Mon, 13 May 2019 07:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190513135216.23540-1-yuehaibing@huawei.com>
In-Reply-To: <20190513135216.23540-1-yuehaibing@huawei.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 13 May 2019 19:36:14 +0530
Message-ID: <CAP245DXAjc1Ozg7HYRumJ7_Ys4pBry8O0Y5rj1hRsQeXqjX1sQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: tsens: Make some symbols static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 7:31 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/thermal/qcom/tsens-v0_1.c:322:29: warning: symbol 'tsens_v0_1_feat' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:330:24: warning: symbol 'tsens_v0_1_regfields' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v1.c:147:29: warning: symbol 'tsens_v1_feat' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v1.c:155:24: warning: symbol 'tsens_v1_regfields' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v2.c:30:29: warning: symbol 'tsens_v2_feat' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v2.c:38:24: warning: symbol 'tsens_v2_regfields' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>

Hi Hulk Robot,

Thanks for the report. kbuild test robot beat you to catching these
warnings (see email from 30th April). :-)

Good to see you're becoming bigger and look forward to you beating the
kbuild test robot someday.

Regards,
Amit


> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 4 ++--
>  drivers/thermal/qcom/tsens-v1.c   | 4 ++--
>  drivers/thermal/qcom/tsens-v2.c   | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index b3a63d7..a319283 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -319,7 +319,7 @@ static int calibrate_8974(struct tsens_priv *priv)
>
>  /* v0.1: 8916, 8974 */
>
> -const struct tsens_features tsens_v0_1_feat = {
> +static const struct tsens_features tsens_v0_1_feat = {
>         .ver_major      = VER_0_1,
>         .crit_int       = 0,
>         .adc            = 1,
> @@ -327,7 +327,7 @@ const struct tsens_features tsens_v0_1_feat = {
>         .max_sensors    = 11,
>  };
>
> -const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
> +static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
>         /* ----- SROT ------ */
>         /* No VERSION information */
>
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index a1221ef..10b595d 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -144,7 +144,7 @@ static int calibrate_v1(struct tsens_priv *priv)
>
>  /* v1.x: qcs404,405 */
>
> -const struct tsens_features tsens_v1_feat = {
> +static const struct tsens_features tsens_v1_feat = {
>         .ver_major      = VER_1_X,
>         .crit_int       = 0,
>         .adc            = 1,
> @@ -152,7 +152,7 @@ const struct tsens_features tsens_v1_feat = {
>         .max_sensors    = 11,
>  };
>
> -const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> +static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>         /* ----- SROT ------ */
>         /* VERSION */
>         [VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 36fbfa6..1099069 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -27,7 +27,7 @@
>
>  /* v2.x: 8996, 8998, sdm845 */
>
> -const struct tsens_features tsens_v2_feat = {
> +static const struct tsens_features tsens_v2_feat = {
>         .ver_major      = VER_2_X,
>         .crit_int       = 1,
>         .adc            = 0,
> @@ -35,7 +35,7 @@ const struct tsens_features tsens_v2_feat = {
>         .max_sensors    = 16,
>  };
>
> -const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
> +static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>         /* ----- SROT ------ */
>         /* VERSION */
>         [VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
> --
> 2.7.4
>
>
