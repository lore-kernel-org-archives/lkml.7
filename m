Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B127C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147EA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLrmxlt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfFQT1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:27:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36731 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfFQT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:27:31 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so23931561ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9Oc7ZhRD3F3wXh7rQZIFZBIqOJRb70vgbqk6ZylyKs=;
        b=jLrmxlt5HekviTDg4h9uqSmRgH3b0TRYfXS0MLnsFWdqKx4w7TePcVbPdyGajBZ5T7
         E0/MgkfLKKRFYdi4U/7cMNAC/5BD62ZV7jZDA3ZIlvdPLYG+lUq17VnbFRFmKcxBuijW
         b98VN0Hvx3L/bguKSJU68ZIk28pnHD1YfpnuGcqvMJVT80TFJybKvwSDGmg/WTMGyb5E
         MJajgGG46mMfU5JzBy1BUM19j9gCBKCe7x7XgYhEzhlzBEn1hybyqb59cTV/qpUDXiVo
         QB+ZGIrZuE5tY8P3wtvgueICm2JuGumEi96mvV4Ojoc6WIJs30xltebpiZh+JwiyMFDM
         ySEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9Oc7ZhRD3F3wXh7rQZIFZBIqOJRb70vgbqk6ZylyKs=;
        b=DUMweHcOZiMbM5dnk2hnQ0dNm90SLLVPqHEdHgL74VWgUNhDlpXpb9jh3b854pH12A
         VrcM+1A2rYFWopqdZuxR5g59gDTBZinLAmZ2G7Jp5GE16LezanjA8PMMoMWNjS72Ib55
         Ohi9bH+T97BBJ1k+GABfyD/73xL4GmXLJgwKVfuv2kv1xlSF18NYthSCtX8zTKgUdYQ0
         FxtTrXsJpxuj4uc+3Q0ud/DRqrU0G0JoYQMoYTeT8t4hCWkkOs8fDtCHfpR4QaLm+R6j
         QJUFRSsvvz4Ik/3AZIdC3/8VETbUmpfIPW2l+ArI1R0Ja7+yfSuNzyQ2aLv1DRRXBPdt
         JLjA==
X-Gm-Message-State: APjAAAVm/39NHAfjMs2f6jRTYWqcbcWecnuXANwYNdtl1JjBGUk4y2V0
        cKRbEAElodyTe1HVaLDtLdr9LL867s//jwQ56vnbLg==
X-Google-Smtp-Source: APXvYqwqAHJMpEIe+s+0XLSNvUalfFg//jHiamKU+Pa2/iD933a4OCsuMlXY4LBxYgwVV/deZOGHC6idGCgYYa5QioY=
X-Received: by 2002:a5d:9613:: with SMTP id w19mr10341810iol.140.1560799650660;
 Mon, 17 Jun 2019 12:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190613065815.GF16334@mwanda>
In-Reply-To: <20190613065815.GF16334@mwanda>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 17 Jun 2019 13:27:19 -0600
Message-ID: <CANLsYkxnze-aJXwr6ogR_AjcXefjufgOnwgqnX0vVtkzkzAsVw@mail.gmail.com>
Subject: Re: [PATCH] coresight: potential uninitialized variable in probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 at 00:59, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "drvdata->atclk" clock is optional, but if it gets set to an error
> pointer then we're accidentally return an uninitialized variable instead
> of success.
>
> Fixes: 78e6427b4e7b ("coresight: funnel: Support static funnel")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 5867fcb4503b..fa97cb9ab4f9 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -244,6 +244,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>         }
>
>         pm_runtime_put(dev);
> +       ret = 0;

Applied - thanks.

>
>  out_disable_clk:
>         if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
> --
> 2.20.1
>
