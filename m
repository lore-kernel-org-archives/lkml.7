Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C1AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B92184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpPBwhHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKKXQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:16:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41491 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:16:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id d29so8474965plj.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 15:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4lpvhxVanbUmuLaCYCnS2N3Od4Bkz/gpjYlGGXEOpI=;
        b=TpPBwhHshE/2lY2KwonEc6KRbw/6a/LvDVOs86AYmM7zwuEYDZYomb7WGVLKdzdaRL
         LiZham1Xq33xUquLBi1xB+DExgoJvkYAKAfczS3kf8OkWUvpVwpOpBD/DP804uySzS3Z
         6ixsx6M9+aQr3Q3TG9R2vZFPvPf3a7Da7gM5aXfRQOkyIN9gMBg8ShoNEUUNPFIIQyFM
         UzHVjQdjAWLlIqOp0XHWRjY8WHXvTs75RrlMXbyqA9u11WGlviOZgORg4O2ozw/Y5/rI
         Wrq/r5mQ+Vc5vepIIJPYtwBCB3aRNa9KusDT70hGoJe+6v3pCUZwihSOG5JtOm1WzNUY
         LVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4lpvhxVanbUmuLaCYCnS2N3Od4Bkz/gpjYlGGXEOpI=;
        b=Rm6dMhAhONibXBVQkQxIAFt0rbFh7eRDqhbZ93b+S6rh3AMd9cDHh7Pdlu6/eGeuZT
         z8q0BH2JItMqA1HNge69hMtbltWKXTHFCeVxuPOhUosG6B/u3zzrLGWS6raHPQMhCaD/
         mJv2VscrdTpLie0qfbG8Wwe6nNXHWPVSioOQLwhGMz0chL04rQfqHfcDZkA3Jl5LUrtN
         gR94iObpDwF3+cLAutDbrGqWUSsxHEtq02cQAa2n7ulvDAT9EjxTyEJiF2mStoo7p2Iv
         flPzGeyez66QomxQdwRgTLfHGL84ooREchO/XzG59D8jfnTKABxhga2P8EdpD4H7PvAA
         Vr/w==
X-Gm-Message-State: APjAAAWYGVtMp74LhroQH8TNwnsoVYANub264AO0Dmq0aIXcpgXz+PnO
        T9zuDXovR3zf3qUYSfB7litb3w==
X-Google-Smtp-Source: APXvYqy0ju9xUVUiWXpEs7ylar4031d6mFFBaUCCpPNPZmUihqSVxFMDYC5iIS0g8fkuZUlG5jtl8w==
X-Received: by 2002:a17:902:6e02:: with SMTP id u2mr28700878plk.234.1573514213621;
        Mon, 11 Nov 2019 15:16:53 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a145sm17084624pfa.7.2019.11.11.15.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 15:16:52 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:16:50 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/17] remoteproc/omap: Add device tree support
Message-ID: <20191111231650.GE3108315@builder>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-4-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028124238.19224-4-t-kristo@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
[..]
> +static int omap_rproc_get_boot_data(struct platform_device *pdev,
> +				    struct rproc *rproc)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct omap_rproc *oproc = rproc->priv;
> +	int ret;
> +
> +	if (!of_device_is_compatible(np, "ti,omap4-dsp") &&
> +	    !of_device_is_compatible(np, "ti,omap5-dsp"))
> +		return 0;

I think it would be cleaner if you added a "has_bootreg" bool to your
omap_rproc_dev_data, do of_device_get_match_data() in omap_rproc_probe()
and pass that here.

> +
> +	oproc->boot_data = devm_kzalloc(&pdev->dev, sizeof(*oproc->boot_data),
> +					GFP_KERNEL);
> +	if (!oproc->boot_data)
> +		return -ENOMEM;
> +
> +	if (!of_property_read_bool(np, "syscon-bootreg")) {
> +		dev_err(&pdev->dev, "syscon-bootreg property is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	oproc->boot_data->syscon =
> +			syscon_regmap_lookup_by_phandle(np, "syscon-bootreg");

You updated the dt binding document, but this needs to be updated as
well.

Regards,
Bjorn
