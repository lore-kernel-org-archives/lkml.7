Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5011020873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AW+3V3g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfJUMpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:45:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46256 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfJUMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:45:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so3021814wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I8rkz9wni1PLYTJYS1CHHJxzqvPcnSWI9WK6axWmJfM=;
        b=AW+3V3g7BTEklmfuK/i+EY2s9qLVJXAYy0fpcJM/wgGxWc66ja7A848n7hu/YebqvC
         cGn8QpIu13IAMy9QCkCg8wuiEv+BWTHW27o4lqD2dg2krKmQLjbIZPTQd7H1cT4BZ35q
         09qOewOkfv/mN3lSElOw8XSsmQHi0HinSZCOm79vwSpyIyTtpZAio19SmtL5L3Alh49d
         xwgadWESW2+8eOEHvvuc3/WieljrvTrJLQgeHoSpxKvFzAUytaNHoGNXoyEwg/NSnie9
         qcebNcVhvgTcRLFsLpZnDWfQsPm5YwiSDcFHrdpUbZNcrHlO8DDm15gpH6HLN4rMeA8M
         qFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I8rkz9wni1PLYTJYS1CHHJxzqvPcnSWI9WK6axWmJfM=;
        b=ptXy2k5sDRi+/QsfQFTK0ldSaQbcT1QKqfETYEmA+QieNUntmdW7NuV4VrtBitt7VR
         pVSFVbe2r87EX5lp5UmBI3pQmi6bWAVjECagmihYE+h3G6BnsnKIhWOGagxm8N6Uu/cc
         I/+NrvggY5o1MzbBJXGLuFRO4dVXj0Yj7upfS3fzu5U1t2BlEBydEKf0qbHl1K99PBdr
         xSGrL12HBQ/Bnsy1rwakDQLSduSLYZsYGEuJ1quhVo8sTwpG6liAMwtt7Olu9E5BEjai
         98xWrSgwd+YOrjuDgkAsp5HkjQXHQ8NaQ9k921/t3ZKVfuLCBJ0gO0OnunMRdHfMy1d4
         Tuqg==
X-Gm-Message-State: APjAAAWl41cSJAZWhlqwWLmUD54qYaIyAwB596O0C+slNXHhuWGef0TS
        Bs9XOEyZ7ZVp3ceiA+f8QyJNbg8na+t+ng==
X-Google-Smtp-Source: APXvYqxxYpfRu1R8MBd49BbDXNITCFzDHKp8X4m9mEedi4UuDplAZkkVe28aVRwif4Kzf+g9k1iTgw==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr18991524wri.130.1571661929630;
        Mon, 21 Oct 2019 05:45:29 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q66sm15560273wme.39.2019.10.21.05.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:45:28 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:45:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 9/9] mfd: mfd-core: Move pdev->mfd_cell creation back
 into mfd_add_device()
Message-ID: <20191021124527.dr4mpys5vovfkk2e@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-10-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-10-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:22AM +0100, Lee Jones wrote:
> Most of the complexity of mfd_platform_add_cell() has been removed. The
> only functionality left duplicates cell memory into the child's platform
> device. Since it's only a few lines, moving it to the main thread and
> removing the superfluous function makes sense.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/mfd/mfd-core.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 5d56015baeeb..849dbe3798b0 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -49,19 +49,6 @@ int mfd_cell_disable(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL(mfd_cell_disable);
>  
> -static int mfd_platform_add_cell(struct platform_device *pdev,
> -				 const struct mfd_cell *cell)
> -{
> -	if (!cell)
> -		return 0;
> -
> -	pdev->mfd_cell = kmemdup(cell, sizeof(*cell), GFP_KERNEL);
> -	if (!pdev->mfd_cell)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
>  #if IS_ENABLED(CONFIG_ACPI)
>  static void mfd_acpi_add_device(const struct mfd_cell *cell,
>  				struct platform_device *pdev)
> @@ -141,6 +128,10 @@ static int mfd_add_device(struct device *parent, int id,
>  	if (!pdev)
>  		goto fail_alloc;
>  
> +	pdev->mfd_cell = kmemdup(cell, sizeof(*cell), GFP_KERNEL);
> +	if (!pdev->mfd_cell)
> +		goto fail_device;
> +
>  	res = kcalloc(cell->num_resources, sizeof(*res), GFP_KERNEL);
>  	if (!res)
>  		goto fail_device;
> @@ -183,10 +174,6 @@ static int mfd_add_device(struct device *parent, int id,
>  			goto fail_alias;
>  	}
>  
> -	ret = mfd_platform_add_cell(pdev, cell);
> -	if (ret)
> -		goto fail_alias;
> -
>  	for (r = 0; r < cell->num_resources; r++) {
>  		res[r].name = cell->resources[r].name;
>  		res[r].flags = cell->resources[r].flags;
> -- 
> 2.17.1
> 
