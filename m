Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5F3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF8E2253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEFtpMy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgACHrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:47:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44549 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:47:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so18756593plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 23:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TYmR7Su3TQRhxaGSs/Gmy519O0CuGnaDkzrvLms+94Q=;
        b=XEFtpMy5dirtZBAqM+HlhZxWmFJs8HM7yAX4hIvs1uimxFANWi/fN275Yyz0CfOQZn
         VKiiTqf2W6g4Eug26y3EBVgcQiGR4E1Lv28ZNhY3cNo7bcsThg2VG3jNwU4hX8LsKa7Y
         +x9xhrdzgZPuLS7t/3yM4jrcK/t3npeui8yU9zzihZCfmNiXppGIIFxle1dS8JC0fVhw
         Zs4sLyPsqJHT/fr1v2/7dO8AVfCUoLeb5OdPcNoMrD8BRFfJGra8meReEPPIkK0OXyLM
         hD+vWP0pgKG/8VXUOQTVDq0FzW6a8Qa55dAXGTZW63b7HFulGhCwrMkJ3vuqwGCsaOOz
         /SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYmR7Su3TQRhxaGSs/Gmy519O0CuGnaDkzrvLms+94Q=;
        b=RMQXhn5Nj2KE8emmOSFEHhJFK/hLmcX9zCM6IRW+ipWzf0fZH7xNnYruHmilMZ4JCW
         hUgelgjmv2r4BKfusSCS+O7VNmgjAPIpyPEzJhCJswnCOJsH+XMWrupzw8es9It/bQGZ
         VhPaGnV0iDAJPvGTMy/EBqmxjt70HDSCykBYo86fzFJyTBTeHXdztW+4r+5s+A1ryBt3
         wij9kOj8qfxMU11goJbiDquax0E0s8RmCbZBcE80ikDtXN0Foneeke0DzvgaBGMhv4XW
         a6qj+vldzf/09Vgvc69PsGmhiJBgwKdwu9j0lHfsqADK+m+smYtfKefqgc7rKCST9t1Y
         Ph0w==
X-Gm-Message-State: APjAAAXd6stp1q9budZGiOt8AR23nO3GN2Ocsze2gPtaO61EE/FOfjxb
        VmtIpwfCOK/TIoq9QKQkfzM/Vg==
X-Google-Smtp-Source: APXvYqxz0tmqTG4nkUi/jqHamIprde+Yghm55ERkvI/ApLP+eEKBlyIgUlbqqmbMFNvps9rmIp6gCw==
X-Received: by 2002:a17:90a:c388:: with SMTP id h8mr24798177pjt.83.1578037670646;
        Thu, 02 Jan 2020 23:47:50 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k16sm13727175pje.18.2020.01.02.23.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 23:47:49 -0800 (PST)
Date:   Thu, 2 Jan 2020 23:47:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, sboyd@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clk: qcom: apcs-msm8916: use clk_parent_data to
 specify the parent
Message-ID: <20200103074747.GN988120@minitux>
References: <20191125135910.679310-1-niklas.cassel@linaro.org>
 <20191125135910.679310-8-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125135910.679310-8-niklas.cassel@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Nov 05:59 PST 2019, Niklas Cassel wrote:

> Allow accessing the parent clock names required for the driver
> operation by using the device tree node, while falling back to
> the previous method of using names in the global name space.
> 
> This permits extending the driver to other platforms without having to
> modify its source code.
> 
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
> Changes since v2:
> -Use clk_parent_data when specifying clock parents.
> 
>  drivers/clk/qcom/apcs-msm8916.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
> index 46061b3d230e..bb91644edc00 100644
> --- a/drivers/clk/qcom/apcs-msm8916.c
> +++ b/drivers/clk/qcom/apcs-msm8916.c
> @@ -19,9 +19,9 @@
>  
>  static const u32 gpll0_a53cc_map[] = { 4, 5 };
>  
> -static const char * const gpll0_a53cc[] = {
> -	"gpll0_vote",
> -	"a53pll",
> +static const struct clk_parent_data pdata[] = {
> +	{ .fw_name = "aux", .name = "gpll0_vote", },
> +	{ .fw_name = "pll", .name = "a53pll", },
>  };
>  
>  /*
> @@ -51,6 +51,19 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>  	struct clk_init_data init = { };
>  	int ret = -ENODEV;
>  
> +	/*
> +	 * This driver is defined by the devicetree binding
> +	 * Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt,
> +	 * however, this driver is registered as a platform device by
> +	 * qcom-apcs-ipc-mailbox.c. Because of this, when this driver
> +	 * uses dev_get_regmap() and devm_clk_get(), it has to send the parent
> +	 * device as argument.
> +	 * When registering with the clock framework, we cannot use this trick,
> +	 * since the clock framework always looks at dev->of_node when it tries
> +	 * to find parent clock names using clk_parent_data.
> +	 */
> +	dev->of_node = parent->of_node;
> +

With this hunk replaced by Stephen's patch for handling this in the
clock core I did some basic tests and things seems to work as expected.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  	regmap = dev_get_regmap(parent, NULL);
>  	if (!regmap) {
>  		dev_err(dev, "failed to get regmap: %d\n", ret);
> @@ -62,8 +75,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	init.name = "a53mux";
> -	init.parent_names = gpll0_a53cc;
> -	init.num_parents = ARRAY_SIZE(gpll0_a53cc);
> +	init.parent_data = pdata;
> +	init.num_parents = ARRAY_SIZE(pdata);
>  	init.ops = &clk_regmap_mux_div_ops;
>  	init.flags = CLK_SET_RATE_PARENT;
>  
> -- 
> 2.23.0
> 
