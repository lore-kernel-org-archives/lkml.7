Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B4C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615F521537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWE8YcZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfGKPGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:06:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44994 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfGKPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:06:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so3072393pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4c2dc7FdeZlI40XoYW7oVDGG9akgiuTr8uhcWS8yCeY=;
        b=CWE8YcZB0HKcuadLXbtPYj6kQ5wYic026seg1ZVQ3b+ApPmyoYWwNSd0mnKX9ohNXA
         jpxMK9+dbpVEbUI8ATFDIvQDf0YLM4pcNS0tuYQfjyYMQ9NfKSEQb0kpeWX2PcE0azhP
         egtlCiDuPqnWZQfcZmZw8J8u1YU62gkqkX+RoS1F5r5stTmEDfwxaEJUrA2j+shkdq7J
         r1Zl9gWRixLrdySBL2nCQPmP0Yn4vXIIDqBK1U6Wt2gTvksAnTxve2JEFWdcui5vuI+t
         56OIfwXw9RWrVLjsLcOJcFZOxIuRgyrOIDLi4Enun9yZVkuRjv1UVNzCypwA0pYfGrzv
         s/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4c2dc7FdeZlI40XoYW7oVDGG9akgiuTr8uhcWS8yCeY=;
        b=XlRSQsovDQSjbeV3glyXhfpQwRYtGf0aPFtV/fn6W2TAnjuq+i3qMOP3Ix9rzSWqlt
         Fj+xEaXp2+Kl3tQxboPy+Pz86vAODCTyq8UPJTv/7skjoPdFP7MTTDn3/md/JiYcur2p
         M8+4CUZ1rF2zjYdWAjt8aeIeGzi/joQWuLHKxzHB3Qnmb/G6n0HEaPWt8gS0yNzayMGY
         bSYxZpOBRDjXmExC2JoQ05D6K3cZHOSivyAe8cLPg1pcMxnIaQlwILg6AYVnb1LKrxE0
         wlPvNItYH1CelxjXv2Gfm80wygAXoHemPojUTmjkdrcE0H6vb2OwACSYnqcvz7Pq65oL
         2nJQ==
X-Gm-Message-State: APjAAAVttgFSoRgXTknZ3VJVr9Buw3Y4KkQwvWsyUVK3e6nf3UAbTg3W
        8o0aUxFfOSnu7CA6QQ9Jb+V3pQ==
X-Google-Smtp-Source: APXvYqyTRN38u90ThnFEWr3vJtVT6c/7HeHr0dQPeDSpuUgsAlIZ8GEDPOCwlDn7VSwfNYWXYmf7JA==
X-Received: by 2002:a17:90a:2008:: with SMTP id n8mr5346113pjc.4.1562857573492;
        Thu, 11 Jul 2019 08:06:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s6sm9401870pfs.122.2019.07.11.08.06.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:06:12 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:07:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v3 06/14] clk: qcom: hfpll: get parent clock names from DT
Message-ID: <20190711150723.GG7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-7-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-7-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> Allow accessing the parent clock name required for the driver
> operation using the device tree node.
> 
> This permits extending the driver to other platforms without having to
> modify its source code.
> 
> For backwards compatibility leave the previous value as default.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

The driver should be updated to use parent_data instead, but I consider
that's an independent change.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/clk/qcom/hfpll.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index a6de7101430c..87b7f46d27e0 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -52,6 +52,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	struct regmap *regmap;
>  	struct clk_hfpll *h;
> +	struct clk *pclk;
>  	struct clk_init_data init = {
>  		.parent_names = (const char *[]){ "xo" },
>  		.num_parents = 1,
> @@ -75,6 +76,13 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  					  0, &init.name))
>  		return -ENODEV;
>  
> +	/* get parent clock from device tree (optional) */
> +	pclk = devm_clk_get(dev, "xo");
> +	if (!IS_ERR(pclk))
> +		init.parent_names = (const char *[]){ __clk_get_name(pclk) };
> +	else if (PTR_ERR(pclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	h->d = &hdata;
>  	h->clkr.hw.init = &init;
>  	spin_lock_init(&h->lock);
> -- 
> 2.21.0
> 
