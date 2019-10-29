Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C5CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB2F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572367023;
	bh=KJdlbLHm1VGH37tK+hk1pZHeuH/PEPFUuHuXC5yaXOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XTEViRvGJ+7biRPXGhUJNdZgGZu6Uw+NC9jsGM37J0yuE+DMraAKRLBDhLpX0qvd4
	 ECPmqPyOujlP3jh4llO32NELRnVTpiOpNHohrfYG2BnqRSISGAz/6OJeAbles9AeKL
	 ECOELXfOiXFLiIPLMkRezKSJla5Vp5aSnevXy9V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390444AbfJ2QhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:37:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43626 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389940AbfJ2QhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:37:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id s5so9452065oie.10;
        Tue, 29 Oct 2019 09:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ePXMg5ijhyeC6jaORiV5zX4zFPOwmuSgfYr43macyAw=;
        b=cyRIbZ9KAkBYAKnY7JCGCG9w7TsBaDQgePm8vtvKUl2egaHOfYJyYwceY5DukWuQoO
         pWrN8tZ+pFB+Xdj+/Cr38MI+tvr/GPP5lKrMEq1+VKL8KkBDwCo90N/eWOHpOLEL4mGl
         +PV/QNMBb7ba2aW/ks5BL2I1M2wXL711QJeNFcM6I8WS9zwhj5ppnbByNRbnuLwFEa+c
         1peIS+F6D4cXhrlyq8WYlxNsjPfXJJrA8PmsW3jwc8koKeKDyAoxPCbZxsAd2fi/5eIu
         01kv4btzq7m1/y+El2OwExQr67hrn9cCAVRyRfBW6VTIcF026cmvkyW9WUb+E2vAm3Ux
         Jcyg==
X-Gm-Message-State: APjAAAXWp8rg8FOsSJxxJJUYXE60/TYX4lqo2lc142x0ZLgLjXftB2a/
        izPqjkiGUIL6kR1U43udkg==
X-Google-Smtp-Source: APXvYqyIx7CEhxMdJ8BhGIcJhGTHsyz5urxfcj4tU+2dwb1TwtDB3ui2/e/cbYv2juZO3UHWGioOIA==
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr4968969oia.109.1572367021283;
        Tue, 29 Oct 2019 09:37:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 79sm4770880otv.59.2019.10.29.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:37:00 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:36:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ram Prakash Gupta <rampraka@codeaurora.org>
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, vbadigan@codeaurora.org,
        cang@codeaurora.org, ppvk@codeaurora.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC 6/6] dt-bindings: mmc: sdhci-msm: Add clk scaling dt
 parameters
Message-ID: <20191029163659.GC1057@bogus>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
 <1571668177-3766-7-git-send-email-rampraka@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571668177-3766-7-git-send-email-rampraka@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 07:59:37PM +0530, Ram Prakash Gupta wrote:
> Adding clk scaling dt parameters.
> 
> Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index da4edb1..afaf88d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -39,6 +39,21 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional properties:
> +- devfreq,freq-table - specifies supported frequencies for clock scaling.
> +	Clock scaling logic shall toggle between these frequencies based
> +	on card load. In case the defined frequencies are over or below
> +	the supported card frequencies, they will be overridden
> +	during card init. In case this entry is not supplied,
> +	the driver will construct one based on the card
> +	supported max and min frequencies.
> +	The frequencies must be ordered from lowest to highest.

This should be common. Surely we already have something?

> +
> +- scaling-lower-bus-speed-mode - Few hosts can support DDR52 mode at the
> +	same lower system voltage corner as high-speed mode. In such
> +	cases, it is always better to put it in DDR  mode which will
> +	improve the performance without any power impact.

The description sounds like a boolean. Why the string? What are possible 
values?

Also needs a 'qcom' vendor prefix.

> +
>  Example:
>  
>  	sdhc_1: sdhci@f9824900 {
> @@ -56,6 +71,10 @@ Example:
>  
>  		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>  		clock-names = "core", "iface";
> +
> +		devfreq,freq-table = <50000000 200000000>;
> +		scaling-lower-bus-speed-mode = "DDR52"
> +
>  	};
>  
>  	sdhc_2: sdhci@f98a4900 {
> -- 
> 1.9.1
> 
