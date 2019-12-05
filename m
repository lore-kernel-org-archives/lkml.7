Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AAAC2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AD221744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FJorzEs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfLEA2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:28:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44854 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEA2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:28:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id d199so675893pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGY5BaGmXPT4uINL+GyoXg56qoXAYBQaLO6/xgRHma4=;
        b=FJorzEs/rvBItm1FmCRV2mBoSNDcbOQvwQ4LVJuPXo5sTum/hnaH7R4hHLaeCJ2wPD
         9YrUlr4QdbumgMqE5/sMPclp2qVp/ke49xnD/E+3xOjZoIf/Zy9iSxVdq6TxZvejeSbp
         1FrtCc1i1yZYBH97fZRUPA0CHGv4jfbqZ3tPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGY5BaGmXPT4uINL+GyoXg56qoXAYBQaLO6/xgRHma4=;
        b=ErtL4E0YMd8qibD01aNTqPeYLMnKgIlFRIupRvpPUyIPDDwvxmtl1k4eferg6R2UAN
         6ThK4v2EzApPkSZReC4CL/wC3eQdDu/MmRagk9l6PjyIm+cIy82Y7TJw/eyaqP1hhqum
         Sdfg6UUcMR8P2KVk3gPO93rnFmDc8FgMU+wlOAY1hg2v6ONEg+Di6o6b50/cpxIBmtEQ
         qSPHqpb0pmwbPepv0bciR+VlUuogifsczbxKqy9oLqh9He3tQgxujLnPKY8yR51JigjY
         Up7DzykGMHNDt3zAAxxnCB5hJS4ItWbAKOuWuRSJr2sJHZWm1LxAvs1yYd7xyyYTmPhy
         x70Q==
X-Gm-Message-State: APjAAAWTgcv45VMeTgRuv9JBnLn6ip0DQw06F8JfMSQo/EBsBgVg2cF/
        fg5uE2WtIGrcL22n7Bt+lvyw7g==
X-Google-Smtp-Source: APXvYqwpgYDILUAMuwTZDSGEg6W50s5IG9cah1dtrGom1AZPWmk7U9Vykphx+N7HiXjhGFaZSx/dZw==
X-Received: by 2002:a63:480f:: with SMTP id v15mr6310765pga.201.1575505734304;
        Wed, 04 Dec 2019 16:28:54 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d6sm7108603pju.8.2019.12.04.16.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 16:28:53 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:28:52 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 3/3] devfreq: move statistics to separate struct
Message-ID: <20191205002852.GJ228856@google.com>
References: <20191204150018.5234-1-k.konieczny@samsung.com>
 <CGME20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750@eucas1p1.samsung.com>
 <20191204150018.5234-4-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191204150018.5234-4-k.konieczny@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 04, 2019 at 04:00:18PM +0100, Kamil Konieczny wrote:
> Count time and transitions between devfreq frequencies in separate struct
> for improved code readability and maintenance.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
> Changes in v2:
>  squash three patches into one, do not modify devfreq_profile and separate stats
>  into devfreq_stats
> 
>  drivers/devfreq/devfreq.c | 68 +++++++++++++++++++++++----------------
>  include/linux/devfreq.h   | 31 ++++++++++++------
>  2 files changed, 62 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 901af3b66a76..4d50c8f10bd2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -198,6 +198,7 @@ static int set_freq_table(struct devfreq *devfreq)
>   */
>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
> +	struct devfreq_stats *stats = devfreq->stats;
>  	int lev, prev_lev, ret = 0;
>  	unsigned long long cur_time;
>  
> @@ -214,8 +215,8 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  		goto out;
>  	}
>  
> -	devfreq->time_in_state[prev_lev] +=
> -			 cur_time - devfreq->last_stat_updated;
> +	stats->time_in_state[prev_lev] +=
> +			 cur_time - stats->last_stat_updated;
>  
>  	lev = devfreq_get_freq_level(devfreq, freq);
>  	if (lev < 0) {
> @@ -224,13 +225,12 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	}
>  
>  	if (lev != prev_lev) {
> -		devfreq->trans_table[(prev_lev *
> -				devfreq->profile->max_state) + lev]++;
> -		devfreq->total_trans++;
> +		stats->trans_table[(prev_lev * stats->max_state) + lev]++;
> +		stats->total_trans++;
>  	}
>  
>  out:
> -	devfreq->last_stat_updated = cur_time;
> +	stats->last_stat_updated = cur_time;
>  	return ret;
>  }
>  EXPORT_SYMBOL(devfreq_update_status);
> @@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  out_update:
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->stats->last_stat_updated = get_jiffies_64();
>  	devfreq->stop_polling = false;
>  
>  	if (devfreq->profile->get_cur_freq &&
> @@ -735,28 +735,38 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +	devfreq->stats = devm_kzalloc(&devfreq->dev, sizeof(*devfreq->stats),
> +				      GFP_KERNEL);
> +	if (!devfreq->stats) {
> +		mutex_unlock(&devfreq->lock);
> +		err = -ENOMEM;
> +		goto err_devfreq;
> +	}
> +
> +	devfreq->stats->freq_table = devfreq->profile->freq_table;
> +	devfreq->stats->max_state = devfreq->profile->max_state;
> +	devfreq->stats->trans_table = devm_kzalloc(&devfreq->dev,
>  			array3_size(sizeof(unsigned int),
> -				    devfreq->profile->max_state,
> -				    devfreq->profile->max_state),
> +				    devfreq->stats->max_state,
> +				    devfreq->stats->max_state),
>  			GFP_KERNEL);
> -	if (!devfreq->trans_table) {
> +	if (!devfreq->stats->trans_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -			devfreq->profile->max_state,
> -			sizeof(*devfreq->time_in_state),
> +	devfreq->stats->time_in_state = devm_kcalloc(&devfreq->dev,
> +			devfreq->stats->max_state,
> +			sizeof(*devfreq->stats->time_in_state),
>  			GFP_KERNEL);
> -	if (!devfreq->time_in_state) {
> +	if (!devfreq->stats->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->stats->last_stat_updated = get_jiffies_64();
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1435,9 +1445,10 @@ static ssize_t trans_stat_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
> +	struct devfreq_stats *stats = devfreq->stats;
> +	unsigned int max_state = stats->max_state;
>  	ssize_t len;
>  	int i, j;
> -	unsigned int max_state = devfreq->profile->max_state;
>  
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
> @@ -1454,28 +1465,28 @@ static ssize_t trans_stat_show(struct device *dev,
>  	len += sprintf(buf + len, "           :");
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
> -				devfreq->profile->freq_table[i]);
> +				stats->freq_table[i]);
>  
>  	len += sprintf(buf + len, "   time(ms)\n");
>  
>  	for (i = 0; i < max_state; i++) {
> -		if (devfreq->profile->freq_table[i]
> +		if (stats->freq_table[i]
>  					== devfreq->previous_freq) {
>  			len += sprintf(buf + len, "*");
>  		} else {
>  			len += sprintf(buf + len, " ");
>  		}
>  		len += sprintf(buf + len, "%10lu:",
> -				devfreq->profile->freq_table[i]);
> +				stats->freq_table[i]);
>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
> -				devfreq->trans_table[(i * max_state) + j]);
> +				stats->trans_table[(i * max_state) + j]);
>  		len += sprintf(buf + len, "%10llu\n", (u64)
> -			jiffies64_to_msecs(devfreq->time_in_state[i]));
> +			jiffies64_to_msecs(stats->time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
> -					devfreq->total_trans);
> +					stats->total_trans);
>  	return len;
>  }
>  
> @@ -1484,16 +1495,17 @@ static ssize_t trans_stat_store(struct device *dev,
>  				const char *buf, size_t count)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> -	unsigned int cnt = df->profile->max_state;
> +	struct devfreq_stats *stats = df->stats;
> +	unsigned int cnt = stats->max_state;
>  
>  	if (cnt == 0)
>  		return count;
>  
>  	mutex_lock(&df->lock);
> -	memset(df->time_in_state, 0, cnt * sizeof(u64));
> -	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
> -	df->last_stat_updated = get_jiffies_64();
> -	df->total_trans = 0;
> +	memset(stats->time_in_state, 0, cnt * sizeof(u64));
> +	memset(stats->trans_table, 0, cnt * cnt * sizeof(int));
> +	stats->last_stat_updated = get_jiffies_64();
> +	stats->total_trans = 0;
>  	mutex_unlock(&df->lock);
>  
>  	return count;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index b81a86e47fb9..2715719924e7 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -106,6 +106,25 @@ struct devfreq_dev_profile {
>  	unsigned int max_state;
>  };
>  
> +/**
> + * struct devfreq_stats - Devfreq's transitions stats counters
> + * @freq_table:		List of frequencies in ascending order.
> + * @max_state:		The size of freq_table.
> + * @total_trans:	Number of devfreq transitions.
> + * @trans_table:	Statistics of devfreq transitions.
> + * @time_in_state:	Statistics of devfreq states.
> + * @last_stat_updated:	The last time stats were updated.
> + */
> +struct devfreq_stats {
> +	unsigned long *freq_table;

nit: trans_stat_show() is the only place where 'freq_table' is
used. Instead of 'duplicating' it (I know, it's just a pointer)
you could use a local pointer 'freq_table' in trans_stat_show().

> +	unsigned int max_state;

nit: max_state is also a bit of a corner case. It's not really a 'stat' and
it is already available in struct devfreq_dev_profile, it doesn't seem a
huge inconvenient to take it from there.

> +
> +	unsigned int total_trans;
> +	unsigned int *trans_table;
> +	u64 *time_in_state;
> +	unsigned long long last_stat_updated;

nit: the name 'last_stat_updated' is somewhat redundant, since the
field is part of a struct called 'devfreq_stats'. 'last_updated' or
'last_update' would be concise enough IMO.

> +};
> +
>  /**
>   * struct devfreq - Device devfreq structure
>   * @node:	list node - contains the devices with devfreq that have been
> @@ -131,10 +150,7 @@ struct devfreq_dev_profile {
>   * @suspend_freq:	 frequency of a device set during suspend phase.
>   * @resume_freq:	 frequency of a device set in resume phase.
>   * @suspend_count:	 suspend requests counter for a device.
> - * @total_trans:	Number of devfreq transitions
> - * @trans_table:	Statistics of devfreq transitions
> - * @time_in_state:	Statistics of devfreq states
> - * @last_stat_updated:	The last time stat updated
> + * @stats:	Statistics of devfreq transitions and states times
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>   *
>   * This structure stores the devfreq information for a give device.
> @@ -171,11 +187,8 @@ struct devfreq {
>  	unsigned long resume_freq;
>  	atomic_t suspend_count;
>  
> -	/* information for device frequency transition */
> -	unsigned int total_trans;
> -	unsigned int *trans_table;
> -	u64 *time_in_state;
> -	unsigned long long last_stat_updated;
> +	/* information for device frequency transitions */
> +	struct devfreq_stats *stats;
>  
>  	struct srcu_notifier_head transition_notifier_list;
>  };

My comments above are just suggestions:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

