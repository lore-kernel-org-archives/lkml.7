Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB687C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888E120645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZW4fnM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfDWIeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:34:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37360 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWIeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:34:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so17663854wmf.2;
        Tue, 23 Apr 2019 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=faI8d3sk5W2GvXrBFVQ9tJaO4sXRhQyDKbVWY7XXzi8=;
        b=fZW4fnM9xOfJXqCfH6wuFPmscJzQhPHukUFG3YPESRuUS52WqZqCMAsHU5bgobGc07
         XETRw9f6L4K8RUqXLJ7X8Hy/1YBGMod6DFAbun2/OzzJ7Hf/13dJgid/U+cErY0KDuKC
         zcQV117yeO370JNVUu8vjUGSGxxMXw2jLch/gATmCFIrSqEd4BDDLSLZo8vRb/ak1HQH
         DsKTVwXeFQugH70s8WKOcqkk8CgoeS3aAYehdCrtEnEukFT5Qskhrfu+hHZVEH16m1Y6
         jyN+4zfklwHVJ63alZc+epK3r9splNLeyq4lsYjPT/1DtVeU+ODHk+mSzkpTll9AsFJg
         k8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=faI8d3sk5W2GvXrBFVQ9tJaO4sXRhQyDKbVWY7XXzi8=;
        b=kwHBZ12IP1nVk2YPS/tJUY/mODsX+tdrw3EweFffNQlYr3dvo9eBJFVy4NAYLa6RtD
         JpW+ucsK4BYPdU/YT1wAOl6eXe6icl16nKYyrHCHuVDF6chJbp5UhWt8zsCIxE8ftmPY
         Z7ebWXusKY1h8T4NnfHTx/tvQKssA55gXduvM8K2YjxtYBInIWJ3+Akpb1G7oKXaFbp+
         pm/enLPpIMeMCbHbr4Ve3aiaWeuQxJsvqBOqCItDysQtACHzjQJlwEgzYf37eqkuJaGG
         W7rU+66AoVP5vzqvRUf8kJKdT1qhGaISNblz9rF1pOd7ofonoaQVyso9TLVIotvBkaz6
         3wnw==
X-Gm-Message-State: APjAAAWDI6X7ke0Zm+UhFMgGBxgXp5FUNyXe3sVMbavzzQ9fJOahzs7Y
        eH6k7jRN6+19sxOytPEpf8+Rf8Op2RU=
X-Google-Smtp-Source: APXvYqy8xdlL0gC035rJWjYfM7x5UKqbnnZAYPUagygXRruLf6Ug8VUfATKJ7o1nucgsJI8CfC7TnQ==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr1324868wmt.33.1556008445993;
        Tue, 23 Apr 2019 01:34:05 -0700 (PDT)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id z13sm7716276wrh.41.2019.04.23.01.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:34:04 -0700 (PDT)
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com> <20190423075020.173734-23-wangkefeng.wang@huawei.com>
User-agent: mu4e 1.2.0; emacs 27.0.50
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Steve Longerbeam" <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH next 22/25] media: staging/imx7: Use dev_get_drvdata()
In-reply-to: <20190423075020.173734-23-wangkefeng.wang@huawei.com>
Date:   Tue, 23 Apr 2019 09:34:03 +0100
Message-ID: <m3y3412k90.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,
Thanks for the patch.

On Tue 23 Apr 2019 at 08:50, Kefeng Wang wrote:
> Using dev_get_drvdata directly.
>
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>

There was already a patch sent by Wolfram that does the same thing
[0].

Thanks anyway.

---
Cheers,
	Rui

[0]: https://lore.kernel.org/linux-media/20190319163622.30607-1-wsa+renesas@sang-engineering.com/

> Cc: Steve Longerbeam <slongerbeam@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/staging/media/imx/imx7-mipi-csis.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
> index 6cae2960eea1..19455f425416 100644
> --- a/drivers/staging/media/imx/imx7-mipi-csis.c
> +++ b/drivers/staging/media/imx/imx7-mipi-csis.c
> @@ -1027,8 +1027,7 @@ static int mipi_csis_probe(struct platform_device *pdev)
>  
>  static int mipi_csis_pm_suspend(struct device *dev, bool runtime)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct v4l2_subdev *mipi_sd = platform_get_drvdata(pdev);
> +	struct v4l2_subdev *mipi_sd = dev_get_drvdata(dev);
>  	struct csi_state *state = mipi_sd_to_csis_state(mipi_sd);
>  	int ret = 0;
>  
> @@ -1052,8 +1051,7 @@ static int mipi_csis_pm_suspend(struct device *dev, bool runtime)
>  
>  static int mipi_csis_pm_resume(struct device *dev, bool runtime)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct v4l2_subdev *mipi_sd = platform_get_drvdata(pdev);
> +	struct v4l2_subdev *mipi_sd = dev_get_drvdata(dev);
>  	struct csi_state *state = mipi_sd_to_csis_state(mipi_sd);
>  	int ret = 0;

