Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14C0218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOBsczue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfDXFzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:55:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38804 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfDXFzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:55:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so8809700pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ugtYsAGOnQwGjRTiINsguEV7jByE9sPjdAYZfzpXuoo=;
        b=EOBsczue/jE8A72pN7RsFGxI7f7y7cPZxM4QIsdo0M4A/jKHMU2AJJL2Ibynb8kuDQ
         POPphhf9Qqm6H7GriSVw75SaB9Awar4tB5ONp7rWgEnmssFKXdlEe1rHZHhv2yd0p+HR
         PRz4Ew2ZcFLs/P2xLmgJYkpWjEVDGk1nh9MDm+PlKxO6yGkiTgHeBatMhJb7tTzUnQuk
         oEcAbXxpPaPAY1Xmq5mMJ2GLF3FF5XCrDI7R54SfnCuILHj8XFDItbADQqhxFxLRycmN
         8iYzqkFj4hGgOpCzdf2trOCjjsHAO65lCNUrAwUyOgEZh2MZXjk04d+itNRyOsQy1buk
         KCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugtYsAGOnQwGjRTiINsguEV7jByE9sPjdAYZfzpXuoo=;
        b=JeMUoka7oRI3aEI3zOMNoYdubQ++LgtWR2+XRkKHcFUN5oUQHqOCBBp05/LE5EmX9T
         mjg6wmwQmtnff4Cvl0X6mMBRCsEvBEnOTox7OU55nptyCUGbPIRF7oLGmkwkcQuEv99+
         9mpzyAdXxajIGteHuXWeQrf+eIBbQmo9z0WuP9o3lkt1nEndzw+baIMaCCptHlHov4hg
         43FV9bXMtcCDPjs+x41/B35dyMkR3d2idj0YuyAvCQzlAPeybmDHXkwFe6bzLrKdfFUN
         fPOTzXB8TGhxUdn6F5DYqpO2CSSVSFVHqAmtyOU/kaEbne5NG0+6uUtUWI6z4uhRsJQT
         zRWQ==
X-Gm-Message-State: APjAAAVvzRlwL3587F0X96LXdMqRVceDMPCvsCdnvWZUnudawR/8ZijJ
        PnsFTFs0YCVK/vhtR7o3gp+ctQ==
X-Google-Smtp-Source: APXvYqxjcXgM1gRGm0Th9obFaWeIq9O0F7zf4Yoab2ke07TVJG2Cg2OhVLwRV2oyV+63cFnjyFzQVQ==
X-Received: by 2002:a63:6194:: with SMTP id v142mr10848427pgb.411.1556085314623;
        Tue, 23 Apr 2019 22:55:14 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id h19sm28868839pfd.130.2019.04.23.22.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 22:55:13 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:25:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] OPP: Update the bandwidth on OPP frequency changes
Message-ID: <20190424055512.i6hertpilbkdxees@vireshk-i7>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423132823.7915-5-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-19, 16:28, Georgi Djakov wrote:
> If the OPP bandwidth values are populated, we want to switch also the
> interconnect bandwidth in addition to frequency and voltage.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/opp/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 97ee39ecdebd..91d1c2abfb3e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -707,7 +707,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  	unsigned long freq, old_freq;
>  	struct dev_pm_opp *old_opp, *opp;
>  	struct clk *clk;
> -	int ret;
> +	int ret, i;
>  
>  	if (unlikely(!target_freq)) {
>  		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
> @@ -780,6 +780,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		ret = _generic_set_opp_clk_only(dev, clk, freq);
>  	}
>  
> +	if (!ret && !IS_ERR_OR_NULL(opp_table->paths)) {

Can paths ever have a error value ? I believe only checking for NULL
is sufficient ?

> +		for (i = 0; i < opp_table->path_count; i++) {
> +			icc_set_bw(opp_table->paths[i], opp->bandwidth[i].avg,
> +				   opp->bandwidth[i].peak);
> +		}
> +	}
> +

I will set the path after required_opps are set.

>  	/* Scaling down? Configure required OPPs after frequency */
>  	if (!ret && freq < old_freq) {
>  		ret = _set_required_opps(dev, opp_table, opp);

-- 
viresh
