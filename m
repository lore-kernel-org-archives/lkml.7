Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5185C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23EA2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFhnOJLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfC0WGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:06:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39111 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC0WGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:06:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so6888292pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZOx33OYFA1qAirWQjmNch0TlrFLLXtjFQ1Sv3zU3lrU=;
        b=pFhnOJLBGGwgp1zTfimIzI9QfvwhuoJyQn2Bptx7KC/qzw+D473uzpJIhJh/VGWRHy
         51a9j3HY7NI7kRYlrcGidKaHBnS48kkVot2DihJVU5Aq5NVZ4gf/gQrsS/s/hNond0CU
         hk2RenxZUHIMcr+GBjT5O718OyX0DUiFfHfQotVQFweJ7V/6BF+Qpdhp9Q1suDeAEsMx
         2b+Oh9+1eh9o+c8Baclf7qDrgEbn0xLg9O2pLaztW7oBnl4OUVNUDtaBzP8LXv8UaEsu
         zmQ0G3DDNbQwrQtClMqM3LdX1cNRHdh6P5UaCoAZjFpJHGf9jjw6tZIcNSHbpIjtyjoF
         DU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOx33OYFA1qAirWQjmNch0TlrFLLXtjFQ1Sv3zU3lrU=;
        b=BIwQBUTyRy04XuUb+NsDUwakygOStGZ8teTLyitwZ5V3nB4vovpTunQ04R45UjAY7J
         R7tcLqIvBCxfT00Aat5IRBhyG408jLyldcvhDSat2qNAlbTPYDxpE7P2KCDBYdpdzY3u
         RlRsbrCVeiN+wNH+0Pu3sjqcSC1oDGWL2CYA1drd5KHgq1JeXz8k0p+Dfe1jcu3N2e77
         jJTOV23SKxHrYdJuIJwoYPgqsm6fzv5IeqaW2DRa5u/JLO2Alz98F1xI4J/1pQA6PoVI
         ZbYdt8//0kIAz3qoAz58AcPlt0skWxoFdYSb/78O+vBK+k6tPT9g/le2NbcfrCuWdWEb
         DDog==
X-Gm-Message-State: APjAAAX66kX09E0/Rxv26rUHKD3asE4ASRq0Wc1g9gg0l1+OwIk4Be+u
        x9Bo21mTy0clJ1VXAdanWLgM9w==
X-Google-Smtp-Source: APXvYqw0FB8TCtFvD1sAwSz+g1Vo9B6wQdp52HOjHhCBKlJhTyM/IjPUjJxjjsGAcyfJMiwjF25LTQ==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr37400447pgb.302.1553724362120;
        Wed, 27 Mar 2019 15:06:02 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u10sm25959873pgr.2.2019.03.27.15.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 15:06:01 -0700 (PDT)
Date:   Wed, 27 Mar 2019 16:05:59 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
Subject: Re: [PATCH 15/25] coresight: etm3x: Rearrange cp14 access detection
Message-ID: <20190327220559.GB778@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-16-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553107783-3340-16-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:32PM +0000, Suzuki K Poulose wrote:
> As we are about to about refactor the platform specific handling,

s/about//

> move the DT property handling to generic helpers.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 1b9ae3a..7137f06 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -800,9 +800,9 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  			return PTR_ERR(pdata);
>  
>  		adev->dev.platform_data = pdata;
> -		drvdata->use_cp14 = of_property_read_bool(np, "arm,cp14");
>  	}
>  
> +	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
>  	dev_set_drvdata(dev, drvdata);
>  
>  	/* Validity for the resource is already checked by the AMBA core */
> -- 
> 2.7.4
> 
