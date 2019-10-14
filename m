Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04BCECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B86220854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLKwzAAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfJNOHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:07:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36337 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbfJNOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:07:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id o12so25615922qtf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CZh/4+0Z8RBRsTGb7kMQmVAyPDPVIRlZbYr5vCA4tD4=;
        b=rLKwzAAjQHr/4u7K4ivWpY5wVS9RWG4cki1/3zbfWZKdYSFzFAstHlkISKGrJQE5uN
         s3rQxRCQEIXR2CZZjTcRDzfetRTtAwadYijfKIgtXOBGOc1YilnL7dQUKomDfOLtX0Td
         0M5+jcMVHgGVX+4LII33kh/nmrFpNh3lmUXPgnOcBpjipUFSDfpmlla64rjbG7s0v1of
         pOw5R7W8ysWOpDPzRG2BYBD7QduJR5ip9AXv4pt+hV68NnjI5oD5VOaieo+R575UD/EM
         X3wFdeXwtFfbC76IOKyql4tbOdeJrFHdSGpj5OyP48n5N3cLP6VHxYQ0GW8iaVrAk74X
         EZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZh/4+0Z8RBRsTGb7kMQmVAyPDPVIRlZbYr5vCA4tD4=;
        b=YmK7vLBQQR1BgEjKhPGfw8zDwKzmPrkk3u2TZfAftS/gSBNHZHGZm1rfWEIgCvpsXA
         QoWrtOAhepqF7PKm6IkKzpssZ4V+jrsKke7RMC1andjJfvSz5LkG4D7XSyDEzXOOEUX1
         WGJc3rFAdtRwNSE480IRnrC2gVIkgNMA7RsYnOt5o5TIPr66+G/uq3eGouSJE5t1UtGY
         r+GqKA/uQxlEVvTV4jiWdNH1WuzrAAkBqQRqJLtKHX+62W6hNlreiDifHUwPKQ8SuBSy
         X0+StBiKsHyIgAeJm8+jqEEdDhNYgxhjj5iXemsK+ZDjr/t+tHLp1WyiyqJDw7v7xNP3
         WYnw==
X-Gm-Message-State: APjAAAUdgY2qzXZfOmRHE2+C57jz5P1l19IERJvTkBvDkVqAxdIOgpKl
        xw2uK9qhmnSAxu45BrQs9ynzGH1K
X-Google-Smtp-Source: APXvYqygjxCuBYkTFKuldqagTIrPIxyaXxImxNLJNBCS7cOJV2MWyEEAyYitaOprHX0F3PZVaLLWIg==
X-Received: by 2002:ac8:6686:: with SMTP id d6mr31073251qtp.332.1571062031536;
        Mon, 14 Oct 2019 07:07:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 62sm8758567qki.130.2019.10.14.07.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:07:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 010674DD66; Mon, 14 Oct 2019 11:07:07 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:07:07 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf script: Fix --reltime with --time
Message-ID: <20191014140707.GB19627@kernel.org>
References: <20191011182140.8353-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011182140.8353-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 11, 2019 at 11:21:39AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> My earlier patch to just enable --reltime with --time was a little too optimistic.
> The --time parsing would accept absolute time, which is very confusing to the user.
> 
> Support relative time in --time parsing too. This only works with recent perf
> record that records the first sample time. Otherwise we error out.

Thanks, applied both patches.

- Arnaldo
 
> Fixes: 3714437d3fcc ("perf script: Allow --time with --reltime")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c  |  5 +++--
>  tools/perf/util/time-utils.c | 27 ++++++++++++++++++++++++---
>  tools/perf/util/time-utils.h |  5 +++++
>  3 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 1c797a948ada..f86c5cce5b2c 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3864,10 +3864,11 @@ int cmd_script(int argc, const char **argv)
>  		goto out_delete;
>  
>  	if (script.time_str) {
> -		err = perf_time__parse_for_ranges(script.time_str, session,
> +		err = perf_time__parse_for_ranges_reltime(script.time_str, session,
>  						  &script.ptime_range,
>  						  &script.range_size,
> -						  &script.range_num);
> +						  &script.range_num,
> +						  reltime);
>  		if (err < 0)
>  			goto out_delete;
>  
> diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
> index 9796a2e43f67..302443921681 100644
> --- a/tools/perf/util/time-utils.c
> +++ b/tools/perf/util/time-utils.c
> @@ -458,10 +458,11 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
>  	return true;
>  }
>  
> -int perf_time__parse_for_ranges(const char *time_str,
> +int perf_time__parse_for_ranges_reltime(const char *time_str,
>  				struct perf_session *session,
>  				struct perf_time_interval **ranges,
> -				int *range_size, int *range_num)
> +				int *range_size, int *range_num,
> +				bool reltime)
>  {
>  	bool has_percent = strchr(time_str, '%');
>  	struct perf_time_interval *ptime_range;
> @@ -471,7 +472,7 @@ int perf_time__parse_for_ranges(const char *time_str,
>  	if (!ptime_range)
>  		return -ENOMEM;
>  
> -	if (has_percent) {
> +	if (has_percent || reltime) {
>  		if (session->evlist->first_sample_time == 0 &&
>  		    session->evlist->last_sample_time == 0) {
>  			pr_err("HINT: no first/last sample time found in perf data.\n"
> @@ -479,7 +480,9 @@ int perf_time__parse_for_ranges(const char *time_str,
>  			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
>  			goto error;
>  		}
> +	}
>  
> +	if (has_percent) {
>  		num = perf_time__percent_parse_str(
>  				ptime_range, size,
>  				time_str,
> @@ -492,6 +495,15 @@ int perf_time__parse_for_ranges(const char *time_str,
>  	if (num < 0)
>  		goto error_invalid;
>  
> +	if (reltime) {
> +		int i;
> +
> +		for (i = 0; i < num; i++) {
> +			ptime_range[i].start += session->evlist->first_sample_time;
> +			ptime_range[i].end += session->evlist->first_sample_time;
> +		}
> +	}
> +
>  	*range_size = size;
>  	*range_num = num;
>  	*ranges = ptime_range;
> @@ -504,6 +516,15 @@ int perf_time__parse_for_ranges(const char *time_str,
>  	return ret;
>  }
>  
> +int perf_time__parse_for_ranges(const char *time_str,
> +				struct perf_session *session,
> +				struct perf_time_interval **ranges,
> +				int *range_size, int *range_num)
> +{
> +	return perf_time__parse_for_ranges_reltime(time_str, session, ranges,
> +					range_size, range_num, false);
> +}
> +
>  int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
>  {
>  	u64  sec = timestamp / NSEC_PER_SEC;
> diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
> index 4f42988eb2f7..1142b0bddd5e 100644
> --- a/tools/perf/util/time-utils.h
> +++ b/tools/perf/util/time-utils.h
> @@ -26,6 +26,11 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
>  
>  struct perf_session;
>  
> +int perf_time__parse_for_ranges_reltime(const char *str, struct perf_session *session,
> +				struct perf_time_interval **ranges,
> +				int *range_size, int *range_num,
> +				bool reltime);
> +
>  int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
>  				struct perf_time_interval **ranges,
>  				int *range_size, int *range_num);
> -- 
> 2.21.0

-- 

- Arnaldo
