Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A230CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D14205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQvc+BZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfJUMRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:17:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfJUMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:17:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so3912315wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hZljA+dtCsePA/iZyqwzyUZyRoaJRHbObtpBgiUn+x8=;
        b=MQvc+BZdTDX8Xvo5doelJuZ/qBRiUvIgXwY4oYkUhUoVZR0Jat2CPrGCAplvy6eflY
         OIwkmZAdWLKL8KNDxxI7OeE4k9b2LmeU77w5NDM88GKPSIFL6uWyAD1m+g4vta0OhKGH
         lUWZRT80UT/G+/1neqHkHWdB71ItZzIYz3Q/jRqmQb1xrNsEWbZIGReXh11NBP1GLhml
         Pc/IfmQPBRbDF3k0OETojmsMRT5PyplCOYWq2AkJi12Qz+cSCcD2mr+si7QAFT8HrUgn
         9YczpPA/KAO0eq0pDb5A6Uf27n66lXwZly3trFkQOpDZtZj7YJDfTLWon07uaGCLtBZ7
         832Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZljA+dtCsePA/iZyqwzyUZyRoaJRHbObtpBgiUn+x8=;
        b=oYHWOEqKjJfPIJONnQnFwkX6UYIYfaRfAKF0RtEN1rXDQlIsiIR3pDTL4BQi/MT6cn
         qgTMgjj41QX7DzuvjG6ADjR6RGN7olc01mzii2rdXnCLe5J1aEdqN7sFQQpKEu4Oa5LN
         1SjtS0SVOWDFwMU2kDjGBHYUzC6ETwpDtUj/Og43IvymLw5Fz0HsOCjK5zGAzIRRjNrC
         K6ltz1pqD6ACOvJsOnGjmt5d6AfGjp5mWNzb/caWcKTYSW7Ajw4NRWYAub8G5kqhsp1M
         CaGyFKU9wDNtzhTrK2kd4++5pzgMi8sovobeawcqKb4VSBzeUgN5GZe6VHcwb74ChwUM
         XRUw==
X-Gm-Message-State: APjAAAX5+5TRUfseA3pk2p90kGxmsTIvKHL7nwPdRWWLCRpvp6KRMB8u
        iqIcjS4WIgVdEUbbnJJa8CF3yKyo6B7qZQ==
X-Google-Smtp-Source: APXvYqwqtNfSpfsopIRiU5NwEUG3rQEKyNf0micqrK/sSBNoIaRsmPcb4wKYWAaWgivufyrK0+9RDg==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr20368028wro.378.1571660234547;
        Mon, 21 Oct 2019 05:17:14 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u10sm3403341wmj.0.2019.10.21.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:17:13 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:17:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 6/9] x86: olpc: Remove invocation of MFD's
 .enable()/.disable() call-backs
Message-ID: <20191021121712.rnmqerizclaabm3w@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-7-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:19AM +0100, Lee Jones wrote:
> IO regions are now requested and released by this device's parent.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/x86/platform/olpc/olpc-xo1-pm.c | 6 ------

Why doesn't olpc-xo1-sci.c need a similar update.


Daniel.

>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
> index e1a32062a375..0fc57b59743c 100644
> --- a/arch/x86/platform/olpc/olpc-xo1-pm.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
> @@ -126,10 +126,6 @@ static int xo1_pm_probe(struct platform_device *pdev)
>  	if (!machine_is_olpc())
>  		return -ENODEV;
>  
> -	err = mfd_cell_enable(pdev);
> -	if (err)
> -		return err;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "can't fetch device resource info\n");
> @@ -152,8 +148,6 @@ static int xo1_pm_probe(struct platform_device *pdev)
>  
>  static int xo1_pm_remove(struct platform_device *pdev)
>  {
> -	mfd_cell_disable(pdev);
> -
>  	if (strcmp(pdev->name, "cs5535-pms") == 0)
>  		pms_base = 0;
>  	else if (strcmp(pdev->name, "olpc-xo1-pm-acpi") == 0)
> -- 
> 2.17.1
> 
