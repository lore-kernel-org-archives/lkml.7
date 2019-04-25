Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57638C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E412084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ese7lQ3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDYJkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:40:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39597 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfDYJj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:39:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id e92so9021642plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vf7Zn7KMLMoZ0RYUtCRVpms6y/BhA3GPtFM/1HI1Gbg=;
        b=Ese7lQ3bWvZup6DEGsL2zQgfsjDa3eno4Krr05MPhvTp5GGy1JyS7cNlWPLuNbeJVK
         UKCHtclHaZ0MzophLAqUQtxtGPnyt30NL0Fu7AHGAvChJhXkkHX4wJN8b/E9uuuV/QJM
         1BBXIXCMMdhOEMeaCA7GTjb+qddngBKujTMqwCH1vJzkQzL32g8blLU5lnynsplnZwqT
         +xZxbMrDvwBtT78XRycauBGD2g5NyqjhT95DFm65TIxZfJcQMtbuPX7lCWFwMCvaXf/K
         ogLXH2SuUq5952AB72cvbfgWmvRCFCHwXLCjtYkw405A8qIUfWEhR/ZJgzFsZ6LJzw/j
         HBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vf7Zn7KMLMoZ0RYUtCRVpms6y/BhA3GPtFM/1HI1Gbg=;
        b=b193D70zAMqTTYAIYD0g1TrZOae1lbJAw+E1vo/Gd9MpMy++/C1wfum3KVY+0cQ/uu
         lIJsPJMOpU6b+szGcLSzQJpdSAKyt401KlBbN8NiWqIy469f5PvtIe2IBjat06UDYRHm
         y3PoBls3IMM+0285IKPPO5M/DSm7Z86FvYf03M7ELiXHSnh+/5sep2Q9+B1uRjArBdXd
         pAo5xijCE0Mbxph6Q1SlLYg61RhCQNGUhcb4StlUr/6j4aHyQJYeEiAo+NbKkBnpKBFL
         IeG4K6Htg9HDSktuYKBJj++0vWmUlroa/33jWz72qT+ZM7ApzXiJ770yctyUn6HQ/Adp
         p1OA==
X-Gm-Message-State: APjAAAVet4ef9xuAy6y7NLkFptAnyttOwpqaVwfPN45BH//531aw3Nfq
        yKXRVcu/H2sONf6AMLV3Gn6Ffw==
X-Google-Smtp-Source: APXvYqyn/KgEtyc7m040pVTQkYTV43H+hHkX/yN44oOyiEBsUwzSkDAD9JEoQxqE3tQjG2EI6Hr2kA==
X-Received: by 2002:a17:902:7085:: with SMTP id z5mr28275322plk.78.1556185198768;
        Thu, 25 Apr 2019 02:39:58 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id j14sm27777615pfa.57.2019.04.25.02.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:39:57 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:09:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] PM / Domains: Use the base device for
 driver_deferred_probe_check_state()
Message-ID: <20190425093956.upvslvsxobtv2w3y@vireshk-i7>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <20190425090413.10700-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425090413.10700-2-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-19, 11:04, Ulf Hansson wrote:
> When genpd fails to attach a device to one of its multiple PM domains, we
> end up calling driver_deferred_probe_check_state() for the recently
> allocated virtual device. This is wrong, as it's the base device that is
> being probed. Fix this, by passing along the base device to
> __genpd_dev_pm_attach() and use that instead.
> 
> Fixes: e01afc325025 ("PM / Domains: Stop deferring probe at the end of initcall")
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 8362dfe187f5..8aca1c9b4406 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2405,8 +2405,8 @@ static void genpd_dev_pm_sync(struct device *dev)
>  	genpd_queue_power_off_work(pd);
>  }
>  
> -static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
> -				 bool power_on)
> +static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> +				 unsigned int index, bool power_on)
>  {
>  	struct of_phandle_args pd_args;
>  	struct generic_pm_domain *pd;
> @@ -2424,7 +2424,7 @@ static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
>  		mutex_unlock(&gpd_list_lock);
>  		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>  			__func__, PTR_ERR(pd));
> -		return driver_deferred_probe_check_state(dev);
> +		return driver_deferred_probe_check_state(base_dev);
>  	}
>  
>  	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> @@ -2480,7 +2480,7 @@ int genpd_dev_pm_attach(struct device *dev)
>  				       "#power-domain-cells") != 1)
>  		return 0;
>  
> -	return __genpd_dev_pm_attach(dev, 0, true);
> +	return __genpd_dev_pm_attach(dev, dev, 0, true);
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  
> @@ -2533,7 +2533,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	}
>  
>  	/* Try to attach the device to the PM domain at the specified index. */
> -	ret = __genpd_dev_pm_attach(virt_dev, index, false);
> +	ret = __genpd_dev_pm_attach(virt_dev, dev, index, false);
>  	if (ret < 1) {
>  		device_unregister(virt_dev);
>  		return ret ? ERR_PTR(ret) : NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
