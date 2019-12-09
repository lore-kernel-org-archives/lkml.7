Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2731C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C281A20692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmNUfmS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfLIJA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:00:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:00:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so15141819wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gkH5Q1TDIhutmwVILX/T3rPDHFrWSbZAiAIDjIzKqME=;
        b=NmNUfmS7PtRbGmJj1h58B8NvLJb8RwTIrnaF03qB9TYrNgwdcLO4PzqTkwJaXexQMR
         jRkPyNrCpTNYQbFMsyyQI/zidB1NZlv7BxNJ21tklQfvWbHSCinb0WAk3njzcSc671Ti
         NT6A8SeeJzsX9g/txt0Hu32WFHC8gvCfpUxgafdmjoLK5B4S+0jjXeDiq+PffnxAgeQr
         oyz3Q//7zOAt3X4GIp/4joZW7KSqVFd31mAPSqGaPTgKilcVj1+YlnLKQWMx00GGShu7
         k5+0ppXzi1QzUFxI1xX1Ulajt/1/HzFW6mdqrcdobslGAXVG/nFOJBhz+41aEcEmbkVk
         fMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gkH5Q1TDIhutmwVILX/T3rPDHFrWSbZAiAIDjIzKqME=;
        b=B6p2mHR/g6lO6jdopdlLCy4GibmNQbDf42pKVF0JQVhYmmJYwBVp6zV8Tuo8cpOG3d
         dEdydJ7jzWYWVv8MMq7WCbMJQUILu9z9FygiU7pThVCCRa0n1D99ZaJlklXX9f/Yjbje
         5q/pMc6mKnWrWkLcmlYlUg/NlXIg1dd9fOltbZ5O1HLLW+KLKKAhEx+NvAOZuRt/p0gR
         79xxSnx8wRo3QdljhTILNpeJGvLIHIMsLnYh5EdwUXeypCQaRwqwTrPN7F8ilf5FwAKw
         YsJtBXHC5pgKQF4s2qQowCdLLvxfjX7nT8H0qpgXdX/JnMsGBcly0Am8NLOly3Pq0eZY
         ivqA==
X-Gm-Message-State: APjAAAXTFJPy3LKMePIGrn2Zm5NamViouijY3qpThJMo6l0iEfXUHzHx
        cDQYjgeHlOew9xJGjBd4h/PMwQ==
X-Google-Smtp-Source: APXvYqyH+27hC9KyYJ2JktHBApq1RpWdfXlWq5Z1m+CXad2sFcOR5QULeC3H4IfKt7qp/0kyJqtRVw==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr829863wru.296.1575882027154;
        Mon, 09 Dec 2019 01:00:27 -0800 (PST)
Received: from dell ([2.27.35.145])
        by smtp.gmail.com with ESMTPSA id w19sm1965157wmc.22.2019.12.09.01.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 01:00:26 -0800 (PST)
Date:   Mon, 9 Dec 2019 09:00:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sm501: fix mismatches of request_mem_region
Message-ID: <20191209090020.GG3468@dell>
References: <20191116151308.17817-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191116151308.17817-1-hslester96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2019, Chuhong Yuan wrote:

> This driver misuses release_resource + kfree to match request_mem_region,
> which is incorrect.
> The right way is to use release_mem_region.
> Replace the mismatched calls with the right ones to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/mfd/sm501.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index 154270f8d8d7..e49787e6bb93 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -1086,8 +1086,7 @@ static int sm501_register_gpio(struct sm501_devdata *sm)
>  	iounmap(gpio->regs);
>  
>   err_claimed:
> -	release_resource(gpio->regs_res);
> -	kfree(gpio->regs_res);
> +	release_mem_region(iobase, 0x20);
>  
>  	return ret;
>  }
> @@ -1095,6 +1094,7 @@ static int sm501_register_gpio(struct sm501_devdata *sm)
>  static void sm501_gpio_remove(struct sm501_devdata *sm)
>  {
>  	struct sm501_gpio *gpio = &sm->gpio;
> +	resource_size_t iobase = sm->io_res->start + SM501_GPIO;

Shouldn't this be 'struct resource *'?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
