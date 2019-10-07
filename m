Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52951C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233D320867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWhFRV0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfJGVV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:21:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46054 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfJGVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:21:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so15248145ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VLA+DypLeafYgMw73YxMrbPmQsxALingE4Zwjp+3ro=;
        b=AWhFRV0UXf0UR44y+lps7DWiRDgcwTAKSPuFnQuRcaRad76GF2KfIOGkxzP0TbPSFN
         Slzj7O4yTkaekbF+DQG8a7x9UcPNvTsVlvXCvxLxKORld/I0xD2pNfPkT9lUG8BfX3+z
         ra21vWXRFvFnLWfftuIS9k4vqQbXMx5UVJm4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VLA+DypLeafYgMw73YxMrbPmQsxALingE4Zwjp+3ro=;
        b=gqtjdL5SB8XmssKVrYLx57BaaI6aX5PX7IYtbzLmB/DOcCw4GaMmaoUveZjF32QZJb
         qVwbkMigm2MOsYcXV6p8Tnu978yx5NafnVv9OjgBNftuDTjFmUEg2wzHsV+ITiQh7P1C
         bjeHjftDCs3y0VAiIHjvJEPjROOz3DJG6Ljcj0aYV/h62NFnFCkoyQjRjdAX3tsL0wBe
         i8PuxpHqIfXlAs/0gkpP6YNpelUmfAhVMK83L3N8HI3zhJ7gaVhbRNhYhJU4dm3fhU3h
         jBW5aVTpE30W5UFljMCGoWgC2JsolC58173r4NZbEDPZim9pgDauNtKRf5IyI4FPo9fk
         uTxw==
X-Gm-Message-State: APjAAAWUUMJnRZjCzONPj4DCKSyMNZ38c4HCG94C1ILEYp5SdYjye0hX
        L6/7OaSgciVe70gtKuFREAzlvZx0RxI=
X-Google-Smtp-Source: APXvYqzddEXhfBcPaBcbff1TLf4okqUlvJS//S18S/IrDRNFOox7t1RX4XxNEb1+sdRh64dhu84f1w==
X-Received: by 2002:a2e:904c:: with SMTP id n12mr19105133ljg.139.1570483284959;
        Mon, 07 Oct 2019 14:21:24 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q5sm3073974lfm.93.2019.10.07.14.21.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 14:21:24 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id b20so15268440ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:21:23 -0700 (PDT)
X-Received: by 2002:a2e:878b:: with SMTP id n11mr18063490lji.13.1570483283303;
 Mon, 07 Oct 2019 14:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191004233132.194336-1-swboyd@chromium.org>
In-Reply-To: <20191004233132.194336-1-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 7 Oct 2019 14:20:47 -0700
X-Gmail-Original-Message-ID: <CAE=gft4Rp_GmoVc1iRFH3tiu_taC=i72_Y+xXzk6eU6J80YhQw@mail.gmail.com>
Message-ID: <CAE=gft4Rp_GmoVc1iRFH3tiu_taC=i72_Y+xXzk6eU6J80YhQw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: llcc: Name regmaps to avoid collisions
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 4:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We'll end up with debugfs collisions if we don't give names to the
> regmaps created inside this driver. Copy the template config over into
> this function and give the regmap the same name as the resource name.
>
> Fixes: 7f9c136216c7 ("soc: qcom: Add broadcast base for Last Level Cache Controller (LLCC)")
> Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/llcc-slice.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
> index 9090ea12eaf3..aa342938c403 100644
> --- a/drivers/soc/qcom/llcc-slice.c
> +++ b/drivers/soc/qcom/llcc-slice.c
> @@ -48,13 +48,6 @@
>
>  static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>
> -static const struct regmap_config llcc_regmap_config = {
> -       .reg_bits = 32,
> -       .reg_stride = 4,
> -       .val_bits = 32,
> -       .fast_io = true,
> -};
> -
>  /**
>   * llcc_slice_getd - get llcc slice descriptor
>   * @uid: usecase_id for the client
> @@ -314,6 +307,12 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
>  {
>         struct resource *res;
>         void __iomem *base;
> +       static struct regmap_config llcc_regmap_config = {
> +               .reg_bits = 32,
> +               .reg_stride = 4,
> +               .val_bits = 32,
> +               .fast_io = true,
> +       };

Why did you move this to be a static local? I think it works, but it
makes it look like this is a local variable that's possibly used out
of scope. Maybe leave it as a global?
