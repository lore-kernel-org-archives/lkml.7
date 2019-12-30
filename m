Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2737EC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 01:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2710208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 01:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiKcmfv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfL3BFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 20:05:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39116 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfL3BFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 20:05:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so44246242oty.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 17:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1uou/b60cIOsMB3DzOtWATQEv5uMUtNiIAyfu0e/7RU=;
        b=aiKcmfv+dEWo2le/tjhTAw8tcKlQ0CqkPBBHpVEJh7FgnksKRQ3+hLp0toLsq9RsYK
         CztWSrHHddNxP+qLAFQQEwsU2JX7my6RqveTx38RdovRZGe7CM1LBq5T/j4W8IdUmfSJ
         SdF2Bq+gg7r/0zAA0tHGRrmtabNkGkuCDOwU1H/rQ0LSZFVE+7qcNXHq1qyj1FjOJsES
         8HJTTK0LDo7QfVpfOSk5MnnY3Kcezzg6Q0a4tTfkQUQ/8geqnKdwgL4382LucumngyXB
         wfRe/fTehXCvD8htrQa36Fh5ZsMFYQ3P6ul9f9caoovpRKGiukaiVC3R67RiYPuTkr+f
         7Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1uou/b60cIOsMB3DzOtWATQEv5uMUtNiIAyfu0e/7RU=;
        b=Fw9yK7e+E8ARaOY8C1U+FBYZaXkKUGUaPLNBpkSvzFxqjb8zt11EfWLGBrSxT8ldhx
         nWOxP+whrecAg4kesrpC+bKLF387Xis2Y3iazdWJFBThOrO0sx3GQ6feuKsHqR3+t9nz
         RluRx8FaOKUIQBIKTicHtf865cycUx82pZM1hOnTfbKITkcUNIp7M1Xh08U9T1ibvcC/
         /fKF1/xGIf6abOdscTM0b1G6yh+Z/D1SgczH17odlBFVgCqAxKU2HgKvvOY4McRqnRpT
         v6yIoP6LHnqhsKumykyiOE1jWYnOZ1vplbyYKdRVRQu97QigJg1+RNHMiAKZHoh/xxHh
         z/1g==
X-Gm-Message-State: APjAAAWWwULlx2SCV1WidLMsZXqsJyM734bGlhXWwQPu5fKRKatzKerl
        UVzLlv0NQ0rTVDInFW/RrivUnw==
X-Google-Smtp-Source: APXvYqxjgsyQVJ4CLBiKYs6InxnmHCMDH1KJmdUI1mQYT+Cx0caVrZ1wXctdMcb1AJLR38bGRw+0+A==
X-Received: by 2002:a05:6830:304c:: with SMTP id p12mr41031309otr.214.1577667905418;
        Sun, 29 Dec 2019 17:05:05 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id j10sm10043384otr.64.2019.12.29.17.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 17:05:04 -0800 (PST)
Date:   Mon, 30 Dec 2019 09:04:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     jassisinghbrar@gmail.com, nsaenzjulienne@suse.de,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, lftan@altera.com,
        matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        nios2-dev@lists.rocketboards.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 06/13] mailbox: hi3660: convert to
 devm_platform_ioremap_resource
Message-ID: <20191230010455.GC4552@leoy-ThinkPad-X240s>
References: <20191228183538.26189-1-tiny.windzz@gmail.com>
 <20191228183538.26189-6-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228183538.26189-6-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 06:35:31PM +0000, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/mailbox/hi3660-mailbox.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> index 53f4bc2488c5..97e2c4ed807d 100644
> --- a/drivers/mailbox/hi3660-mailbox.c
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -240,7 +240,6 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct hi3660_mbox *mbox;
>  	struct mbox_chan *chan;
> -	struct resource *res;
>  	unsigned long ch;
>  	int err;
>  
> @@ -248,8 +247,7 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
>  	if (!mbox)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mbox->base = devm_ioremap_resource(dev, res);
> +	mbox->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mbox->base))
>  		return PTR_ERR(mbox->base);
>  
> -- 
> 2.17.1
> 
