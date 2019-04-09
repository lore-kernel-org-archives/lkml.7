Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7874C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9630520857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7oWjjj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDIFsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:48:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37629 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfDIFsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:48:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so9026137pfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 22:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fk7ySHxspoQihk8H1hUCQ6mXk911Jd5AiLjmPFk57ng=;
        b=b7oWjjj8wtAUlON+nhLUHiPwGpU30IK4b+8JQ6KUOB84LK1dbWga+pyVL8g+Jf8Gp/
         IRqjQXy//wIGc/M7zk2xQzwoozAcM6dfFPV814aeMMtcASPxFcn1jb7RgHn/duVasTDC
         zUo3D+lp1qAoj5P1sHjT3l/wOOW+RLAyUgMFOjS/kE4DLFXW4lJStu03mDr/3/tBD6jx
         c1pxpIUwCKOeW8rtSmS6vNu4swoolVjJaOGECpfvqRQt7EFQ23bF6s93TL2XUacvgvEi
         4uyVLm0dsT6Chq6VSp3T7X8r9jlSr3KJ3vZ3/39JN3wXK2uRMxqlh8CUlMi82JvLIwL3
         QTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fk7ySHxspoQihk8H1hUCQ6mXk911Jd5AiLjmPFk57ng=;
        b=qhnJqPRVhU40HOb2yE85V6LjteIeG8P2Wdgxlr2tZxQ5/CxGpnToWcmcgenhSq5uRO
         osyLm0N554LYb964DdivUIKqsvaum1C/Ipt5ruNRZ1wNCC7P+TFw2LLwWl2HAkCRvrIi
         d0b9l6PBlLVz6ATbxzmMAUJ4JeZpc2/Mjbnlx8XAgAe8kfoNqiRWudQpJyLipwe5fSX0
         Cgertg0KXpec1p7X/QYiMzR58NnjgpfN0HhfNgHdLbOnwxRl6swsjwLfGY6irhqcr8s1
         BQbdQsWWELQPP5f3pOLItMn6j8HHnDfFLTJeuRyQGuFBPsin3ttzt8M5mQLUlvc06wgD
         lNSw==
X-Gm-Message-State: APjAAAV3Mg+Wc/asbIEy3+z58HN64aIBaGxF7s2+BqEWdOKBZRcfMySu
        /K58YgoTUGT1G6RNgaP/qLCKQQ==
X-Google-Smtp-Source: APXvYqzPczeXhlAD01YGNI5f4m3UhJyYYe1Ma0ggwIGWktlC++t8UvxBeHtaROccWgH/uwecLeFdgg==
X-Received: by 2002:a63:1659:: with SMTP id 25mr31609522pgw.275.1554788886343;
        Mon, 08 Apr 2019 22:48:06 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id c1sm37639959pgk.44.2019.04.08.22.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 22:48:05 -0700 (PDT)
Date:   Tue, 9 Apr 2019 11:18:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] cpufreq: qcom: support qcs404 on nvmem driver
Message-ID: <20190409054803.m24qucluqtxmd4vq@vireshk-i7>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-5-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-5-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-19, 07:09, Niklas Cassel wrote:
> From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> 

Always have something here, even for the simplest of the patches.

> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 366c65a7132a..7fdc38218390 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
> @@ -79,6 +80,13 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  	return version;
>  }
>  
> +static int qcom_cpufreq_qcs404_name_version(struct device *cpu_dev,
> +					    struct nvmem_cell *speedbin_nvmem,
> +					    struct qcom_cpufreq_drv *drv)
> +{
> +	return 0;
> +}
> +

Why provide empty stubs? Rather check for get_version() in probe and call only
if it is supported.

>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct nvmem_cell *speedbin_nvmem,
>  					  struct qcom_cpufreq_drv *drv)
> @@ -191,6 +199,14 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  			dev_err(cpu_dev, "Failed to set supported hardware\n");
>  			goto free_opp;
>  		}
> +
> +		ret = dev_pm_domain_attach(cpu_dev, false);

Why is it required specially for this platform and not earlier ?

And I was hoping for the attach-by-name thing to be present here instead because
of multiple domain thing.

> +		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				goto free_opp;
> +			dev_err(cpu_dev, "Could not attach to pm_domain: %d\n",
> +				ret);

And it is okay if we couldn't attach the domain ?

> +		}
>  	}
>  
>  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> @@ -247,6 +263,8 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>  	  .data = qcom_cpufreq_kryo_name_version },
>  	{ .compatible = "qcom,msm8996",
>  	  .data = qcom_cpufreq_kryo_name_version },
> +	{ .compatible = "qcom,qcs404",
> +	  .data = qcom_cpufreq_qcs404_name_version },
>  	{},
>  };
>  
> -- 
> 2.20.1

-- 
viresh
