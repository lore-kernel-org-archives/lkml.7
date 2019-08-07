Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96A3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8954F22305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsPlvCGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfHGJFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:05:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfHGJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:05:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so39799103plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J4ZFvTXe+zTVR2M5ZBZS8AXmh/aoWceUxNcpzmTU7Uw=;
        b=NsPlvCGahqKL6UxzvtvcHQ/HirhN9BDf2ppat0hC9TPHLVHpLY9s95fX53JbOZhIPv
         Z5XqIT9H203n8G5v+pSp8n0/cBfYjp2MuhBO5wrt6xGk3Tfkrkx7ezxyYP2PEUC7ad0h
         89yaIBfX97z/Gmvkc3MkqlFkxhhlVROqzzJ/N5yrKpCOFHGeKlvAYExc7qHGZ522Fi2U
         Wd9eS+4FG6mg/W+Tw5mmnd3tJhOABj3QAEV8GuNja20qzp4WsEK1RiayBgMNBz6psTj4
         1yu4jjzu/fWjMbycIl+hd3h3GJ3rXM7uJsTVcXiGvcxH5H3lFqGbwJzBKQiYBTkLjxhq
         A+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4ZFvTXe+zTVR2M5ZBZS8AXmh/aoWceUxNcpzmTU7Uw=;
        b=VuQC2NOVgwUElagVNPNPpsH1F2oNBpUMbIus3+4nQbxiwuKWEIzZzbzsBxn2LAyxG5
         T2aWgcnbAZP2yVhUNMAPAlhwHCRZKvxEZmfeawJq3jAvtS1V1gjv7cz6IyEroLn6UY/Q
         lTUViRtUB7NjG1yD7iAS+kJ3FqkO0i4T3BhOpqG/lOPMuGVZKLrwSdcEfzyPKqMvB2UI
         N5nfDPMyby4EoaZ/aiylhk10hlgoivwXE7eNVh2UEL+2yS3v9fcRrCdlPfg6MKd6BVch
         CcjAN1m0ujc6raLwI2NOGgi9C13Rpcg/yby5ZwmdDeihtDhktkforcG9B4J3PWNgYCF2
         fbEg==
X-Gm-Message-State: APjAAAXocOEjJmrUjmChSRbF0xqd2Le7sozAVEcmutI5wl55vXyxwP01
        t0KuHeQebmmlBXaDNNHEP8+Zlw==
X-Google-Smtp-Source: APXvYqwfH6D7XhoDyWG2BYBL/s5POj834n5L7zMUmOgrJb8o7wh9ak/X/IpezahPVk9H4JXKtlfOkA==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr6855707pgt.337.1565168711202;
        Wed, 07 Aug 2019 02:05:11 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id 33sm103194231pgy.22.2019.08.07.02.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 02:05:10 -0700 (PDT)
Date:   Wed, 7 Aug 2019 14:35:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     rjw@rjwysocki.net, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek-cpufreq: Add compatible for MT8516
Message-ID: <20190807090508.vhc3o3jhmiooyr4m@vireshk-i7>
References: <20190806095029.4758-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806095029.4758-1-fparent@baylibre.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-08-19, 11:50, Fabien Parent wrote:
> Add the compatible for MT8516 in order to take advantage of the
> MediaTek CPUFreq driver for Mediatek's MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index f14f3a85f2f7..10bc06f5dd45 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -535,6 +535,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> +	{ .compatible = "mediatek,mt8516", },
>  
>  	{ }
>  };

Applied. Thanks.

-- 
viresh
