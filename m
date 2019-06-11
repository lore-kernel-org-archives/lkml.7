Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33EBC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D092173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsAEGERk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405684AbfFKTkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:40:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41216 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391080AbfFKTkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:40:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so7522458pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Tl9Z0NsfgrApufoe2WUbK2OeIisauNIixsAGf/fSmk=;
        b=vsAEGERkAaoThhFQXBii705fmbt72E/99Uu7FZajp8SUf8GTc9LlYBfAC9HjBDp5sL
         4EKL6GI9Rp7rOn2WJp0TItbwY1VpF5bcED6xmFO6HO1yjnxBmgJQRVff+Szsd7nDo52k
         o1KbxC6jfKkSBlesArxZfIgVWHOPkeVNKjzoOo2dLBfe0tMVlsJMNhicCRnqqzah4M1p
         nQ+X+wveo4NUY1wN8RdZqJ6VXO8ZpGZsQhfe115nX9JanaBCN6VcbYPC8c0LrFdvg90V
         DNFLgkX/ED/WENER8nOIEnsilSeYqIY4TNFJg1PXRtIJq4SgPMjABUQl+T2ZO2lY8t8G
         +ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Tl9Z0NsfgrApufoe2WUbK2OeIisauNIixsAGf/fSmk=;
        b=UONft3txat0VxlsNcME3YBdr3igBziNbK1Ohiq4i8/04tBUikXizQZtXI1C34mVOim
         QwMl6T3BvooTkM7eW+GJqSYMuWDCcJu3/R65Q3DjBd3yGx9D15QHK/y53JlLwPaWvS9+
         NuGJbMhJKXKVLRy8lsqE+mzIj/Zbt42r+SVsIocGuutNvAiM41XwvAVb50qDqZ/Cw7x+
         nMjxObHzTrTCbybC3vmRHNWswHzeuJZuL81uY25eArgwS0vQO5CeJF3MNGiktXsP9Q7P
         0J2BIjwPqRsmVJ7KiNbWu7ot3j8MvDYp3y2jhqc5+cxxdCK0YOds9L4c6uO7gxfX5kYt
         gnFg==
X-Gm-Message-State: APjAAAXdvAOr1klwc6La8uklcMsBsRqejZQ7gHEif0Xt4H8Cmj40Xi/E
        dHnffqzRVoO29T/vBYZk+ccf3Q==
X-Google-Smtp-Source: APXvYqzXVcc6fXXOJJq5bogayd4145zzm/qfoD7KDrsL3o2QfDRsySAjhmLpJFJJtPni27dVTOe/2Q==
X-Received: by 2002:a62:2a0a:: with SMTP id q10mr77972329pfq.79.1560282051640;
        Tue, 11 Jun 2019 12:40:51 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c133sm18710319pfb.111.2019.06.11.12.40.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 12:40:51 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:40:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        linus.walleij@linaro.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] i2c: i2c-qcom-geni: Signify successful driver
 probe
Message-ID: <20190611194048.GR4814@minitux>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190610084213.1052-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610084213.1052-2-lee.jones@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10 Jun 01:42 PDT 2019, Lee Jones wrote:

> The Qualcomm Geni I2C driver currently probes silently which can be
> confusing when debugging potential issues.  Add a low level (INFO)
> print when each I2C controller is successfully initially set-up.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 9e3b8a98688d..a89bfce5388e 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -596,6 +596,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	dev_dbg(&pdev->dev, "Geni-I2C adaptor successfully added\n");
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
