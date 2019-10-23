Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB5CCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A5C2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F59zCQmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404728AbfJWLZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:25:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38450 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404612AbfJWLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:25:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so11973772pgt.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CMbUesWrEBI4umlhGm4RX5JKBMDct6YIIfX5NPakVec=;
        b=F59zCQmMZ8PGnVxppmEJ1cQ9+Ru2hgprfou80/UTpJDSpK/s5dEAh4fD0/KLRESMQV
         9fpsdghcO2ZIyAkWok4ZGaXXaJqeaFuASZSO7kJeaBKkdNq8QhLvxHvMyNxFBrUbXgKr
         uwp0BAgyf7Urc40k1QC0scuLSc6ch3y4cwaUJdUjQgWgEFNObAc5NVKdC13CNQlkrmgq
         yDSOSVsud0Hz/Vj3vS4Tga6CQH1nqR1eoOnBKvsC7768baqyYK65HpPPC2jOOE/e4oug
         a9aOQLaeqKIIbbmnyXoWhHbGZkIhALc3EuQM8FQ6NhKblgzipTEE+45RlvpSP18ETm33
         FvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CMbUesWrEBI4umlhGm4RX5JKBMDct6YIIfX5NPakVec=;
        b=Lhfdx7NfsFnRhRO48hhkfBOLTS8I7Tp6VtjnfEMzU1lx6h5gwmEC/+HbF7kZN5OvaN
         LtSb1x3LAsyQjySLfjphIe+YJ5/u6Jzfu8QiKsbaKdNdElwWQDIYK5DKLlfeiS8TBIa3
         I6wRSjYU3tD/p60K1UVlJsdY5pZXDIILnjymrqkc2R/e2hUYTT0lFAkzzUJA21VJQXRs
         0RPlZMb5WoDGeLKyGQwnWmuXFotX0DYbxHY4zMDddhbHMjsO3bnYpygyGZVWSOYyHwnN
         YB+MSBY7VJT/wZe9rLgmiD8GKYJAtFgzzjbVrgplZBQVu+GlC03Zf98rlQfA0tFFwsTy
         fN9A==
X-Gm-Message-State: APjAAAUqLIAZCumljrCWUbk7uEb/xKn+9+zAkf77ZjAAqiHTLZUTrYnI
        cK2rezq/TbR0wFRg9EFImyv/S4fkKIU=
X-Google-Smtp-Source: APXvYqzxhzsRny5uh2R2JdrXKYiUCBZlYE60w6K6/wJCw7cMH69UZFHcridk5yb6oiGxufLe6QDfIw==
X-Received: by 2002:a63:b5b:: with SMTP id a27mr9661769pgl.262.1571829941207;
        Wed, 23 Oct 2019 04:25:41 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id j11sm11855535pgk.3.2019.10.23.04.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 04:25:40 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:55:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: vexpress-spc: find and skip duplicates when
 merging frequencies
Message-ID: <20191023112537.pywnhihvmokcveeu@vireshk-i7>
References: <20191023110811.15086-1-sudeep.holla@arm.com>
 <20191023110811.15086-2-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023110811.15086-2-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 12:08, Sudeep Holla wrote:
> Currently the cpufreq core aborts the validation and return error
> immediately when it encounter duplicate frequency table entries.
> This change was introduced long back since commit da0c6dc00c69
> ("cpufreq: Handle sorted frequency tables more efficiently").
> 
> However, this missed the testing with modified firmware for long time.
> Inorder to make it work with default settings, we need to ensure the
> merged table for bL switcher contains no duplicates. Find the duplicates
> and skip them when merging the frequenct tables of A15 and A7 clusters.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 35 ++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> index 093ef8d3a8d4..921dbd42b3bb 100644
> --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -242,6 +242,19 @@ static inline u32 get_table_max(struct cpufreq_frequency_table *table)
>  	return max_freq;
>  }
>  
> +static bool search_frequency(struct cpufreq_frequency_table *table, int size,
> +			     unsigned int freq)
> +{
> +	int count;
> +
> +	for (count = 0; count < size; count++) {
> +		if (table[count].frequency == freq)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int merge_cluster_tables(void)
>  {
>  	int i, j, k = 0, count = 1;
> @@ -256,13 +269,21 @@ static int merge_cluster_tables(void)
>  
>  	freq_table[MAX_CLUSTERS] = table;
>  
> -	/* Add in reverse order to get freqs in increasing order */
> -	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
> -		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
> -		     j++, k++) {
> -			table[k].frequency =
> -				VIRT_FREQ(i, freq_table[i][j].frequency);
> -		}

I think we can still use this single loop, which already starts from
A7 cluster. Just that we can add an if (A15) block inside it as the
first line.

> +	/* Add A7_CLUSTER first to get freqs in increasing order */
> +	for (j = 0; freq_table[A7_CLUSTER][j].frequency != CPUFREQ_TABLE_END;
> +	     j++, k++) {
> +		table[k].frequency =
> +			VIRT_FREQ(A7_CLUSTER, freq_table[A7_CLUSTER][j].frequency);
> +	}
> +	count = k;
> +
> +	/* And then A15_CLUSTER checking for duplicates */
> +	for (j = 0; freq_table[A15_CLUSTER][j].frequency != CPUFREQ_TABLE_END;
> +	     j++) {
> +		if (search_frequency(table, count,
> +				     freq_table[A15_CLUSTER][j].frequency))
> +			continue; /* skip duplicates */
> +		table[k++].frequency = freq_table[A15_CLUSTER][j].frequency;
>  	}

How many duplicate entries are there anyway in the firmware? Or do we
really need to make it that generic? I mean, only the last of A7 and
first of A15 should be overlapping, in that case why search entire
table again ?

>  
>  	table[k].driver_data = k;
> -- 
> 2.17.1

-- 
viresh
