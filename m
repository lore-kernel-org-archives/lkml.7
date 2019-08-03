Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28FC32750
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C172075C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jA7Ho25H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbfHCMs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 08:48:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42926 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389830AbfHCMs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 08:48:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so37411697pgb.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPBzboYRcSiBqM/IaS9KHDrYF6HIPHgc+gMKUe1oePc=;
        b=jA7Ho25HlEsNJGaLyKpTv9u/2TBmHzNo9vDOc/DAdt8UhJUAu0FM2uQ54dffS63Bxc
         n1Ys28HE7q4lznjuvN7w7tua6QTs8ToC7a4qXQT0nTQ6uYM1g+V1oYEUmcNh4rR4r9Ml
         90qvG5GCiHaW4OpazMgiQpXWV+IA5hT0XuHn+VIZmhdWZ3NRaCY05QpMM0sCUDcAUDFV
         xLSNjwwfXKr9/7e6m8YBN+BRBCib1uSymIPrwf4a46otvSHChzvHRtX03TW9hZGkNGak
         owulhoIfTVBaR4my+w/Fa0Nq82+A+f6VuE7gK7HZAm09Lqf9OSTM6vdheeE0HchL9+KA
         eWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPBzboYRcSiBqM/IaS9KHDrYF6HIPHgc+gMKUe1oePc=;
        b=Vyg4oT6RoaoHQwL9ldLdn0I8pRu/kmjUdQ2uBU0RPPSRtpOv0+pWEhsVQmh6KV656g
         IS+8F7JxQoqDJ7kvOggJIDKp3ajTcgxlkCtLkINufk71jXthqgNvpEsoY2zZmmtSMw4Q
         tWSq1HmtKL24k8mQaK7UJG89rBa6X+9PiBKB98RRgjWIjiKBka+4azRKJz3t4ZTfB3+v
         24mvp7Akpj7LmWA3NWoJsH1IncCdqyO1Wa/KzXfTnMuZ1LnNeQnw8wQ/k/+eCLVnL7A7
         hdweOq9h6fKLoeu0UpEDNm+gdqQuE8sz8cb2EA9VZEHM45FpXkKzORPMRCRyjiBeQPa/
         i4ew==
X-Gm-Message-State: APjAAAVEyAAcxhxfWq0Gs1Q4pimziU834d8TOrOLEkFOV9R2zKjmJIAW
        URMa0xz5GxrPJHGxVqAoyN1R
X-Google-Smtp-Source: APXvYqzg/vdX3hd8IM1upuWxyfqFud/2R8eWcmRII4bh4fJaTYTu9UtaTyHvaFflbm2AmnG6EKCr4w==
X-Received: by 2002:a62:3c3:: with SMTP id 186mr64445790pfd.21.1564836535369;
        Sat, 03 Aug 2019 05:48:55 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:618e:61ce:f0f1:2151:3036:855b])
        by smtp.gmail.com with ESMTPSA id l1sm105106428pfl.9.2019.08.03.05.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Aug 2019 05:48:54 -0700 (PDT)
Date:   Sat, 3 Aug 2019 18:18:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/9] clk: actions: Don't reference clk_init_data after
 registration
Message-ID: <20190803124849.GB11140@Mani-XPS-13-9360>
References: <20190731193517.237136-1-sboyd@kernel.org>
 <20190731193517.237136-2-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731193517.237136-2-sboyd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:35:09PM -0700, Stephen Boyd wrote:
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
> Please ack so I can take this through clk tree
> 
>  drivers/clk/actions/owl-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
> index 32dd29e0a37e..71b683c4e643 100644
> --- a/drivers/clk/actions/owl-common.c
> +++ b/drivers/clk/actions/owl-common.c
> @@ -68,6 +68,7 @@ int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks)
>  	struct clk_hw *hw;
>  
>  	for (i = 0; i < hw_clks->num; i++) {
> +		const char *name = hw->init->name;
>  
>  		hw = hw_clks->hws[i];
>  
> @@ -77,7 +78,7 @@ int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks)
>  		ret = devm_clk_hw_register(dev, hw);
>  		if (ret) {
>  			dev_err(dev, "Couldn't register clock %d - %s\n",
> -				i, hw->init->name);
> +				i, name);
>  			return ret;
>  		}
>  	}
> -- 
> Sent by a computer through tubes
> 
