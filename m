Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E916AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B8A21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2f/kpHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKLLkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:40:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36735 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:40:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so18175218wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SLuhtJEUY90bkqc19DKt+xd8yq8xw26lU1HTC8t+5Ww=;
        b=v2f/kpHAG3P+dAelw27PbhnuN6PPubaQHKMkdlBuTKEATOxTzOE7QC7sKigDqDWOp9
         /PomLsUcwsoNHkQ/+GUWD7yAHlQPDRoQ5D8eyMkFySsjDD4VISYFgaN77lqF9YUphhhu
         Qz4lXcfjVX3e0gFkFiC1WAIBeq8/XOvMzJn3L3NnYO4ui/VDr7tTu6LpqiYfQTCCmKk0
         L8SfAkihIdipXkrVlomuho9sj64bXeQ/WhJBZyJ2kYfy2gjKCLqU/IIWSoudQCjf3dX+
         vUqg/veoDt7yVZpKAndlUgDs4sAkWdwoRdojufDpxpacK2UUDW2HtLqPGzhkWiVtldG8
         d73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SLuhtJEUY90bkqc19DKt+xd8yq8xw26lU1HTC8t+5Ww=;
        b=M4fKCQ6i8O68+t9xZNE1lNmaUan5/jXrGxebA3BNktAJPEQW49pEVUnWVG/aTCz9hg
         wR8CC9ARLjyEed2XmC091jaf3de/Shcptv77XsdwFQGym/Q6sYOpkCnXEZOzIAHNOW87
         e5ckZg6/aOOSgYdDOgk3qgbVZyvNMn90wVwV6S/tD1MXDuKBqSWc3WcD60rf43R9ou+N
         OpphmRF2YTnLFQvyNnf83g5s+N7v3wlji/qPnnom2OWONYu6Cy1V+/pHqsNxRFbW/65d
         RFWEdhCtv+UdI+jL++8zXnSWmSoEidvyi07bWcO7pREWakKfhzV2itzNrPVopvIbUT4L
         7eJg==
X-Gm-Message-State: APjAAAWoFSezmmHa/pGvNbvtBXW7NSaEMYhiJRVbWYeUeG5PCI4p2Am0
        DPxnbEO9j+joYD58eYeGw4l7og==
X-Google-Smtp-Source: APXvYqwt3tNaS/uT92o7K3rM2wGyefBrcWVvOCdsSmuV5mHmF/CHpgdD2v2b3xmUuttwQkFy9ND83A==
X-Received: by 2002:adf:f744:: with SMTP id z4mr16993048wrp.205.1573558808635;
        Tue, 12 Nov 2019 03:40:08 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v81sm3331292wmg.4.2019.11.12.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:40:07 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:40:06 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] backlight: qcom-wled: fix spelling mistake
 "trigged" -> "triggered"
Message-ID: <20191112114006.wxjsrcmhrjyeai6e@holly.lan>
References: <20191112093025.98638-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112093025.98638-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 09:30:25AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/qcom-wled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 33b6007c5e55..d46052d8ff41 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -322,7 +322,7 @@ static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
>  		wled->short_count = 1;
>  
>  	if (wled->short_count > WLED_SHORT_CNT_MAX) {
> -		dev_err(wled->dev, "Short trigged %d times, disabling WLED forever!\n",
> +		dev_err(wled->dev, "Short triggered %d times, disabling WLED forever!\n",
>  			wled->short_count);
>  		wled->disabled_by_short = true;
>  		goto unlock_mutex;
> -- 
> 2.20.1
> 
