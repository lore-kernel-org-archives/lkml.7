Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A74C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB8921655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzTTwoTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgABTzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:55:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37783 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgABTzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:55:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so22505512pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igV6CZWYQjf1LVtyKan0Ijhco4fWPffH1BY87cHRc3A=;
        b=DzTTwoTxJ2OtAth8F1Jg5gCr+jplykJuYOx4JXRaqjbkO17pU1IJ8FhCeC8TSFr32C
         pRZw889tmeEAvqWlCEGgOvwKLsEu45f5W3ur5xBCvGdjecZ+UiX0MY3WVwFfYyvEeLmQ
         WBFZ3dSKr8nsRZ8VrRhzqZxpWlg/mQLqtfCB5KTtHI9DvjqNmWiy1RCQYU/HWiY9uiaC
         bt90OnCyLSqcPA8dSlkd8KMxXNpkxjZ9DCSweTd1E3ZqH6mS/R1hhShH+wsoE0nEtfmq
         T5jxtgEV7d3uijHOAkdjWWNla4zMYpfAwpqpyWzDwuoTe8bZbJM7qpYolg6NS3q9Kpej
         OZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igV6CZWYQjf1LVtyKan0Ijhco4fWPffH1BY87cHRc3A=;
        b=DC5EMZA/+1oNfM3mGEI0PbfAtWk1PuwIjCh+WfJrcjzEuAFWy+VaR1dC/12MP1SEan
         +2YABx11LJruu4lb5q/Od6P+P22JjuLKjXyxOM3T72K1JG4Q/D24ww0J313Kg5Gcyb+1
         Sj1B9v4pN7O+DW7b38zE+2YIHQ74908YM7XNGp4HqThT5IyfPaljEg3r8CtkadRHGqr6
         4pUgSeTsH5UrvKbBZpg2Rs0CEejnXLpRQ3PipewpVNDEfnfypyiw1ZgunNaVPVgVWoJK
         czpt2+hi3HNXoEHkdK5olnbJjaew18S6aAqh8rVUAQfocCgC3bcIRZDnqNOk3iwcfr23
         CI8Q==
X-Gm-Message-State: APjAAAUgcigOwx2uGmZYBY4EA1HOKjP0H7NHZ37dQRwtkFS/arjwZvtI
        34arkCNfI5xO7OjUdol6lcR9UQ==
X-Google-Smtp-Source: APXvYqxzQe0lpMlLyuY1HY7igrS5kjETmRqdME9JDKzGN2B1sZLlt2A8drNa/jNEPj0inZczTi34iQ==
X-Received: by 2002:a65:538b:: with SMTP id x11mr90220053pgq.395.1577994940592;
        Thu, 02 Jan 2020 11:55:40 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y20sm9662pfe.107.2020.01.02.11.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 11:55:39 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:55:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/9] drivers: thermal: tsens: Add watchdog support
Message-ID: <20200102195537.GE988120@minitux>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
 <a63edff9a3c02a542d36fdd28fe774a5c3bf3b8d.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63edff9a3c02a542d36fdd28fe774a5c3bf3b8d.1577976221.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02 Jan 06:54 PST 2020, Amit Kucheria wrote:
[..]
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 4cf550766cf6..ecbc722eb348 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -377,6 +377,24 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
>  	struct tsens_irq_data d;
>  	unsigned long flags;
>  	int temp, ret, i;
> +	u32 wdog_status, wdog_count;
> +
> +	if (priv->feat->has_watchdog) {
> +		/* Watchdog is present only on v2.3+ */

Please omit this comment, you're carrying the motivation for this
decision when you set has_watchdog already.

> +		ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS], &wdog_status);
> +		if (ret)
> +			return ret;
> +
> +		/* Clear WDOG interrupt */
> +		regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
> +		regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);

Are you sure you need to zero the clear register?

> +
> +		ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT], &wdog_count);
> +		if (ret)
> +			return ret;
> +		if (wdog_count)
> +			dev_dbg(priv->dev, "%s: watchdog count: %d\n", __func__, wdog_count);
> +	}
>  
[..]
> @@ -793,6 +815,22 @@ int __init init_common(struct tsens_priv *priv)
>  		}
>  	}
>  
> +	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> +		/* Watchdog is present only on v2.3+ */
> +		priv->feat->has_watchdog = 1;
> +		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
> +			priv->rf[i] = devm_regmap_field_alloc(dev, priv->tm_map,
> +							      priv->fields[i]);
> +			if (IS_ERR(priv->rf[i])) {
> +				ret = PTR_ERR(priv->rf[i]);
> +				goto err_put_device;
> +			}
> +		}
> +		/* Enable WDOG and disable cycle completion monitoring */

Commit message says you're not enabling it. Should this say "WDOG is
already configured, unmask the bark" or something along those lines?

> +		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> +		regmap_field_write(priv->rf[CC_MON_MASK], 1);
> +	}
> +
>  	spin_lock_init(&priv->ul_lock);
>  	tsens_enable_irq(priv);
>  	tsens_debug_init(op);

Regards,
Bjorn
