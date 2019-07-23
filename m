Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8DCC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A202147A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="il988Img"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfGWKEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:04:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33021 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfGWKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:04:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so20362680plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YpUM1Im+XRL13SexNhkl9pzwji5CXQiG7CSz3y2BWPQ=;
        b=il988Img6c4wKh6uWkXOX+qoaDNsC08/nBXqNp0wwfCmRJqGOdbpGusPcc2mDBESgw
         sbnGpJRaaADtKWcAW9g3X3AmyKTqoJKf+M7vRurOB9HCyRnbGRyM6KVJ1sGbXILS+xD6
         +ehsGxDQjMiGKyaqnyPB6TcpLU88zycboAIrGszRmf+/cUKXS0yqivUvA+ikFN+rh2Ma
         RE0mI9sdVaUpK5epaNfKafiYZjh4T4+Baf7BToZFR5BbDRNa6GvzY7xMzpllTEoDG4OS
         ECy30v1BWaYlim2sft1qt8Pavn3QIj+9YBuUOLDvTu9RVqqWp5GoCDjhOGVQDuhiDy4Q
         q5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YpUM1Im+XRL13SexNhkl9pzwji5CXQiG7CSz3y2BWPQ=;
        b=GQpKohhD+MPvbYuvkYeQDjIMe2OL9FuEg6evQVyO6Rz0AF+d1kgQsf+p0bzqZCt+FK
         Vx1BpazRki0VHeWd+jQ+SaquW/wOp2fPNO6ctsuKYweqSBRtDwU5INE81lMDTKSDxIUw
         Ssjyu9euQH7b0UAI4USET5GJDfijHvQmzbKpc16Mpc6SQP/1aWEaHtDWL7ZDpUnDgqQO
         vO4dbI+kHheSeMBwHwuhtiGDXJ9xewbv8iTXYfkxzGp5/1dwzRynsYHatMYQ+gzxO/2r
         eCciFjVsPhyvqPSdBjVbjPzoloech2QHSErlKiqtIB7aJ8I/vRpJrVnTBigKg8bnVR7I
         bqgA==
X-Gm-Message-State: APjAAAVEPiR4T43OrjvP1uKaWWoHePejAQvUPdZ+D+p622wwFdgY7529
        X5aSqYcljEJ8916975h4r1c5ow==
X-Google-Smtp-Source: APXvYqxL20ZsFOnKLphiCT4Vy4tslrXNuQ4Q67ehYKSMAxdeRlDY8/KD73Moz7KT7p/7p+Ul845UmQ==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr81217864pll.236.1563876249250;
        Tue, 23 Jul 2019 03:04:09 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r9sm23763629pjq.3.2019.07.23.03.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 03:04:08 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:34:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] PM / devfreq: Add required OPPs support to
 passive governor
Message-ID: <20190723100406.7zchvflrmoaipxek@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717222340.137578-6-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-19, 15:23, Saravana Kannan wrote:
> Look at the required OPPs of the "parent" device to determine the OPP that
> is required from the slave device managed by the passive governor. This
> allows having mappings between a parent device and a slave device even when
> they don't have the same number of OPPs.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 58308948b863..24ce94c80f06 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>  	unsigned long child_freq = ULONG_MAX;
> -	struct dev_pm_opp *opp;
> +	struct dev_pm_opp *opp = NULL, *p_opp = NULL;

This won't be required if ...

>  	int i, count, ret = 0;
>  
>  	/*
> @@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 * list of parent device. Because in this case, *freq is temporary
>  	 * value which is decided by ondemand governor.
>  	 */
> -	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> -	if (IS_ERR(opp)) {
> -		ret = PTR_ERR(opp);
> +	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> +	if (IS_ERR(p_opp)) {
> +		ret = PTR_ERR(p_opp);
>  		goto out;
>  	}
>  
> -	dev_pm_opp_put(opp);
> +	if (devfreq->opp_table && parent_devfreq->opp_table)
> +		opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
> +					   devfreq->opp_table, p_opp);

you put p_opp right here.

Also shouldn't you try to get p_opp under the above if block only? As
that is the only user of it ?

> +	if (opp) {
> +		*freq = dev_pm_opp_get_freq(opp);
> +		dev_pm_opp_put(opp);
> +		goto out;
> +	}
>  
>  	/*
>  	 * Get the OPP table's index of decided freqeuncy by governor
> @@ -89,6 +96,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	*freq = child_freq;
>  
>  out:
> +	if (!IS_ERR_OR_NULL(opp))
> +		dev_pm_opp_put(p_opp);
> +
>  	return ret;
>  }
>  
> -- 
> 2.22.0.510.g264f2c817a-goog

-- 
viresh
