Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8BC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A70217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onK1uDlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfGQRkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:40:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34212 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQRkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:40:36 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so47154120iot.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtprvX2m2jiKjt40HUaqm6DF0L2XmUgvKFNwlwgfe5s=;
        b=onK1uDlvUzpAH0JWEzYwI7Gvf91+DZjaIi9SPNFqZfxsb53+3NAu9LR1/dWib49xfe
         uLFyJ7FMnIQIEGQ0aAA+BOeKB0M4zkzQtNBj+FPZfXsvN+zJTblXWCFNbsMLdd87p1PR
         f1FYO8LUIwH3rWdYJcjYDHTdKo7cRweLAnYd5imd3r9/s3Kn8G7/qyVZ1kGVccRhQv5q
         e/0VOtTsNvHhAcAE9qQ8EBKMHPWb1ByA5GRMc9o5r+lh1AT4G4zCxJxc7maGfwIzw2bi
         Voqkjz3HnbhFHZQhBQxtLooaZKPUcCXzbifFxSHKQy2lB7vIH/Kk9T3ucsueYKFKCEo8
         EZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtprvX2m2jiKjt40HUaqm6DF0L2XmUgvKFNwlwgfe5s=;
        b=oKYEYSVrpknZomiwT5SBceFNrUFL775G3xoJnaJ7F2PqFR3y8Azwsq69u5TMlTNtqu
         HMB6ceINN5o7NgF/qdGjDdDfXh6KHLnOVKRhzCaBpu57q179gfATXNbjIFHXtgSx1Dqe
         RBRIwMzvly36kzS3KmB95JuqX0E78PrQD44Lyo2aXo2O1lNRhwKsmGTCm5fDnTYf61og
         i2JeLQNLyD2OBT7sw1Wr+y5T4ijfH/i4ET0AWg4H4UGyIFNcWilzpHk/DP1dOUJihuoL
         jiyx1skfUGkTUrzcEVjncqcNSMEeHM+l6QcWyH2AERFDt0WIUijUgBR6tn6oq+C/i0lw
         m/kQ==
X-Gm-Message-State: APjAAAVvVJtSp7EbK2YqQHxBRa8y0tVszNHa/De29mUvenQzSGrRXt8W
        /jzwwed3LeSEfZTADSngVd9LVxnVpHqNKT5fFCp9Tg==
X-Google-Smtp-Source: APXvYqz7WG1PnvWMnC23sD+cAu0oINpZh2KIZQ4xQZPYqy1GNt03lquLmfPyqP+Hp51HDnWuG4zkofIf1ZyJXjMZovg=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr39088762ioo.237.1563385235830;
 Wed, 17 Jul 2019 10:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562940244.git.saiprakash.ranjan@codeaurora.org> <2694eae0731a07eeda11f666526ccff8c6b5842e.1562940244.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <2694eae0731a07eeda11f666526ccff8c6b5842e.1562940244.git.saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 17 Jul 2019 11:40:24 -0600
Message-ID: <CANLsYkw=pAmwoEmXCjLtrUtxLnE8KY5o72Of3aq_-_JHeHyhTA@mail.gmail.com>
Subject: Re: [PATCHv8 4/5] coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 at 08:17, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Instead of overriding the peripheral id(PID) check in AMBA
> by hardcoding them in DT, add the PIDs to the ETM4x driver.
> Here we use Unique Component Identifier(UCI) for MSM8996
> since the ETM and CPU debug module shares the same PIDs.
> SDM845 does not support CPU debug module.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 7bcac8896fc1..28bcc0e58d7a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1192,11 +1192,15 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>  };
>
>  static const struct amba_id etm4_ids[] = {
> -       CS_AMBA_ID(0x000bb95d),         /* Cortex-A53 */
> -       CS_AMBA_ID(0x000bb95e),         /* Cortex-A57 */
> -       CS_AMBA_ID(0x000bb95a),         /* Cortex-A72 */
> -       CS_AMBA_ID(0x000bb959),         /* Cortex-A73 */
> -       CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),        /* Cortex-A35 */
> +       CS_AMBA_ID(0x000bb95d),                 /* Cortex-A53 */
> +       CS_AMBA_ID(0x000bb95e),                 /* Cortex-A57 */
> +       CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
> +       CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
> +       CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
> +       CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
> +       CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
> +       CS_AMBA_ID(0x000bb802),                 /* Qualcomm Kryo 385 Cortex-A55 */
> +       CS_AMBA_ID(0x000bb803),                 /* Qualcomm Kryo 385 Cortex-A75 */
>         {},
>  };
>

I have also queued this patch.

> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
