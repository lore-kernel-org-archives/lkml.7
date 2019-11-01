Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E46CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 23:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D8A21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 23:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="yYriT6h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKAXHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 19:07:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41182 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKAXHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 19:07:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so4978603plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 16:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xp3A8vdh1NO+887OUg4MRpz1hgoXlnInMjaDscwcRX4=;
        b=yYriT6h58xv7hTXRzRB5iUZbmOc5hfCHewM2Mn+UNE2HN6q4ot/vtr6GVE9xr9Jq7v
         rTmrjCeexwllHIjaJ0T9qdR+VD4y89F7Zd1DNeouk0nXPojIgyGe4P9Jkb1L01bZk0Br
         MBif6u0NSdZpeTSvrepGMxTj5dlUg8gB2hYfkF4XDyPXffagLnSq9b66FkDavj5E4gsG
         WeworxdV9zPAcmnaMW6Bwwy+zXiFrtoHAytsvZ9iQNf5LVCBgJd+DxxwHjuJ2FjllLQc
         WHjW27/Vg4xxU7lMx4LeqLGpmdqnmy9VnqNtQRCld93taP9KRm5poqrJpna8obEFlAhy
         QKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xp3A8vdh1NO+887OUg4MRpz1hgoXlnInMjaDscwcRX4=;
        b=aVAVMNoAj9xNshEuNZ+dzhu7Jdj9YDQssY7yqsFLpQR1ybeMcRgDfkTRUe7PoYNQ3E
         EWjLU9fWbMTkNSLvjkZiElzCFgzM3gm/tARl15nlmNuSAfSx1+H1TBmvVI7VPtDQdWoI
         g+XJMp+C2M7OfNUiYF8FfXRswAh32ipB8Xa4yVNZjiKh3GVuZxvnCnfHLmnNodwwp+lj
         EDq1tvwVXyYXpMEB1ePFvZ3RXfAZTyRZAWWD72mtM6g2XdC8EC8w+c3k1TZs4Oz3hT+u
         Fa9yFNj4UVkJbK68u5s9ZzdPsu2lLfijZrqbUr18wRYGvgkUOGi9geJyb1C3HI0cWHLH
         +63w==
X-Gm-Message-State: APjAAAXnQCh0a8XxstbvAoR96Q7CjcJjmHa2oB8/OtNeKIkrdf+69ung
        PMHaO6NIUpp98d9/hBuVJx14RA==
X-Google-Smtp-Source: APXvYqxnsTZAEt4O+FvzghWOLNmYefTtpIpLZBMMy0wB7jnrlC85ie0yvSHdvkcDZFGQbFUhj+6ObQ==
X-Received: by 2002:a17:902:349:: with SMTP id 67mr2206815pld.221.1572649651082;
        Fri, 01 Nov 2019 16:07:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v15sm8798149pfc.85.2019.11.01.16.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 16:07:29 -0700 (PDT)
Date:   Fri, 01 Nov 2019 16:07:29 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Nov 2019 15:53:59 PDT (-0700)
Subject:     Re: [PATCH] spi: sifive: disable clk when probe fails and remove
In-Reply-To: <20191101121745.13413-1-hslester96@gmail.com>
CC:     broonie@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, hslester96@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hslester96@gmail.com
Message-ID: <mhng-3be3dc4e-15f2-4ad2-b156-ea5439e729bd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Nov 2019 05:17:45 PDT (-0700), hslester96@gmail.com wrote:
> The driver forgets to disable and unprepare clk when probe fails and
> remove.
> Add the calls to fix the problem.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/spi/spi-sifive.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index 35254bdc42c4..f7c1e20432e0 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -357,14 +357,14 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  	if (!cs_bits) {
>  		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
>  		ret = -EINVAL;
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	num_cs = ilog2(cs_bits) + 1;
>  	if (num_cs > SIFIVE_SPI_MAX_CS) {
>  		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
>  		ret = -EINVAL;
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	/* Define our master */
> @@ -393,7 +393,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  			       dev_name(&pdev->dev), spi);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
> @@ -402,11 +402,13 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "spi_register_master failed\n");
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	return 0;
>
> +disable_clk:
> +	clk_disable_unprepare(spi->clk);
>  put_master:
>  	spi_master_put(master);
>
> @@ -420,6 +422,7 @@ static int sifive_spi_remove(struct platform_device *pdev)
>
>  	/* Disable all the interrupts just in case */
>  	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
> +	clk_disable_unprepare(spi->clk);
>
>  	return 0;
>  }

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
