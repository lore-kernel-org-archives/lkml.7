Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE4BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7EC21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfOV/TLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfDXL2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:28:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46671 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfDXL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:28:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id k18so14343089lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JLAt8vXpMzvmVMwhnN+jHxhJwJGzPfS5OLUsC0yAZUA=;
        b=CfOV/TLnhnkg1juwsOsG01zyv6OsZwNul3cYLmIlKkBzEQNPYchHfDfrA1XG8UFTZg
         Zisj5nIZLhM5tsg9LCkTabeJAL5U33AcPixX04OkFH2k3arFVBKKp+2akXurJEtquQUy
         GuvVvkrTVxnu7DUYUqccHH4sT3+2335dtWIAIpfiCRNtZucw1BbUXUwGPq/BheyfH1Eq
         i+P6br0gOv+2BaX+ESt1RsRyC1Kn+sKjV5oxki+OrER8yjkdywfBuT+NEEhbzwG6raKa
         0SQ2cX5uNo+4DKF4BKovq2QuYusUJyWNjlNDpn3kyxrCuEHFV47CrLGFnz4A0rv6vhWr
         fpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JLAt8vXpMzvmVMwhnN+jHxhJwJGzPfS5OLUsC0yAZUA=;
        b=XMQ64oLZvMLUMoUnzywT7jObgieQl8TeR3HEa2AfHs8FlXQmYShtaikJplKJqgTlJb
         nW+4q+1ZA7+wmGkKuQ6BakelELg1139tdkcmseDj1UWRwTLzj0xdpA8pl5Fp8PzJcTzF
         J9B5uHQXz4UYJ9ZxuOoQO1Ls0F0aB9tJi/s26cJY1xFOiESt6OOZgvXzoISvGDovXoVO
         egN9H6xAqcQkpkJBvUTJT/Sp6phHFM43a7VjOcQ1nXVKhN1/+wRFiiGlGWHEub1ooht3
         tzvzzHmoYCI0ybgsT0qNxlfMvd5BqJ9o1ov/1apGSfx8BA+SJrip7bY1V9gFAs30Qqk/
         /Ing==
X-Gm-Message-State: APjAAAX84Z5XX+KJqz46SCrYqb9gloj7eu2AQkycDc9GmvDlL5lsA6T1
        zsR9aUl4+Mc5OAM4PHWCLJ5geg==
X-Google-Smtp-Source: APXvYqyXYE+d2mJ/Y3bIRxfDu7tFy+jH5o51AUMUHYw2Dw0uZUcir5eojjpE21qgwwPUcicQTdEiCw==
X-Received: by 2002:a19:4b51:: with SMTP id y78mr16907674lfa.152.1556105319570;
        Wed, 24 Apr 2019 04:28:39 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id g5sm1179521ljk.59.2019.04.24.04.28.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 04:28:38 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:28:31 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] PM / Domains: Allow OF lookup for multi PM domain
 case from ->attach_dev()
Message-ID: <20190424112831.GB30710@centauri.ideon.se>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:27:56PM +0200, Ulf Hansson wrote:
> A genpd provider that uses the ->attach_dev() callback to lookup resources
> for a device, fails to do so when the device has multiple PM domains. This
> is because when genpd invokes the ->attach_dev() callback, it passes the
> allocated virtual device as the in-parameter.
> 
> To address this problem, let's simply assign the dev->of_node for the
> virtual device, based upon the original device's OF node.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7fec69aebf46..801f31c87d16 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2345,6 +2345,7 @@ EXPORT_SYMBOL_GPL(of_genpd_remove_last);
>  
>  static void genpd_release_dev(struct device *dev)
>  {
> +	of_node_put(dev->of_node);
>  	kfree(dev);
>  }
>  
> @@ -2406,14 +2407,14 @@ static void genpd_dev_pm_sync(struct device *dev)
>  	genpd_queue_power_off_work(pd);
>  }
>  
> -static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
> -				 unsigned int index, bool power_on)
> +static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
> +				 bool power_on)
>  {
>  	struct of_phandle_args pd_args;
>  	struct generic_pm_domain *pd;
>  	int ret;
>  
> -	ret = of_parse_phandle_with_args(np, "power-domains",
> +	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>  				"#power-domain-cells", index, &pd_args);
>  	if (ret < 0)
>  		return ret;
> @@ -2481,7 +2482,7 @@ int genpd_dev_pm_attach(struct device *dev)
>  				       "#power-domain-cells") != 1)
>  		return 0;
>  
> -	return __genpd_dev_pm_attach(dev, dev->of_node, 0, true);
> +	return __genpd_dev_pm_attach(dev, 0, true);
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  
> @@ -2525,6 +2526,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
>  	virt_dev->bus = &genpd_bus_type;
>  	virt_dev->release = genpd_release_dev;
> +	virt_dev->of_node = of_node_get(dev->of_node);
>  
>  	ret = device_register(virt_dev);
>  	if (ret) {
> @@ -2533,7 +2535,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	}
>  
>  	/* Try to attach the device to the PM domain at the specified index. */
> -	ret = __genpd_dev_pm_attach(virt_dev, dev->of_node, index, false);
> +	ret = __genpd_dev_pm_attach(virt_dev, index, false);
>  	if (ret < 1) {
>  		device_unregister(virt_dev);
>  		return ret ? ERR_PTR(ret) : NULL;
> -- 
> 2.17.1
> 

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
