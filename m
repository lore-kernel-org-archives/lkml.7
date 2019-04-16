Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E0E206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="Equ2u3qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfDPRRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:17:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37603 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPRRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:17:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so10655004pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4if/nt2tHvb7ZR/GcjznTNmFZDClzCvbOGHsqoQ9dc=;
        b=Equ2u3qPiyp5D8arG6HBn4QW3xL53iKpstvaviriRvp2By7IBElsf5H+MWfM4Ogn8v
         oiNyKOoDemldMpwg1gVWJf2adPElUdbiH1j229rRTdm2b6WYfDrqwcL91ejfcm6ciKMI
         GIm31g/fkfOvtv7QjvCrJVkSjPgplPiTjGWKb38AQb2EyMGf6l8jSugDBep9ZJY2ypJ9
         ppNVYF0I9dHummLpiAfBqOeSIiXr5XM+hMnpVjjpkRxM+QBZoxpaVa+lu+NhFavx8NSn
         Fuogcnf7BN3LYLcGSMLccUF85+ISm4jfMctKZIbn4C+Pt2/+jPt7d4qe5OAhRezq1g/V
         pZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4if/nt2tHvb7ZR/GcjznTNmFZDClzCvbOGHsqoQ9dc=;
        b=Ih3u2YbDDHfEzK5GsxyqiGrhGfoOakAEI3CIFERfItzMqNc6XA/Iel9rU1Os/fHSDp
         LK7/VjNlbLvFiC/rXN7KpLZinbLd7+8l+RgZZoK5c3x2XgS1W9tyP6wfZos5GvA4q7yL
         w3FUq5O0o9br+Ypdz0BReSNfI4mwjEMV2y26IkLmrLwS/1oJTfhKdV9fdJGAOcG3Qxl3
         /GOhvdrPSlT5nx52Yf4qWUe6uHBv2lbMlmRt+BBesiiloHoAQ7wjBNDkWk+ioylunkXZ
         hp5pzFEWqH11ugmDpjgJAQLaW+tK5EPWSg+bIALzRljo0xuSnhIYIqzEUdGXXDQUV/zM
         GEWA==
X-Gm-Message-State: APjAAAW02Bpy4rq6Kt5zwFYOrF8UWHrBBKRzImly3gP1bnuIo24d1Xv3
        c3EMTa1t6tHQ5SuMu9CcQVrwBJMPAK0=
X-Google-Smtp-Source: APXvYqwHtpTn9+1WACzmM75wgDjmoVglpvbxkjnz1DjhUbN7yQVHC1dC4DweTx7z9K1wf/fOIAjeSQ==
X-Received: by 2002:a65:4247:: with SMTP id d7mr73181537pgq.114.1555435034699;
        Tue, 16 Apr 2019 10:17:14 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id z21sm74225602pfn.139.2019.04.16.10.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 10:17:13 -0700 (PDT)
Date:   Tue, 16 Apr 2019 10:17:13 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 02/12] perf tools: Separate generic code in
 dso_cache__read
Message-ID: <20190416171712.GB8631@mini-arch.hsd1.ca.comcast.net>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416160127.30203-3-jolsa@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16, Jiri Olsa wrote:
> Moving file specific code in dso_cache__read function
> into separate file_read function. I'll add bpf specific
> code in following patches.
> 
> Link: http://lkml.kernel.org/n/tip-7f7d717uzrqt5ka2xp29ige3@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/dso.c | 47 ++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index cb6199c1390a..6baad22ec8a9 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -794,6 +794,30 @@ dso_cache__memcpy(struct dso_cache *cache, u64 offset,
>  	return cache_size;
>  }
>  
> +static ssize_t file_read(struct dso *dso, struct machine *machine,
> +			 u64 offset, char *data)
> +{
> +	ssize_t ret;
> +
> +	pthread_mutex_lock(&dso__data_open_lock);
> +
> +	/*
> +	 * dso->data.fd might be closed if other thread opened another
> +	 * file (dso) due to open file limit (RLIMIT_NOFILE).
> +	 */
> +	try_to_open_dso(dso, machine);
> +
> +	if (dso->data.fd < 0) {
> +		dso->data.status = DSO_DATA_STATUS_ERROR;
pthread_mutex_unlock(&dso__data_open_lock) here?

> +		return -errno;
> +	}
> +
> +	ret = pread(dso->data.fd, data, DSO__DATA_CACHE_SIZE, offset);
> +	pthread_mutex_unlock(&dso__data_open_lock);
> +
> +	return ret;
> +}
> +
>  static ssize_t
>  dso_cache__read(struct dso *dso, struct machine *machine,
>  		u64 offset, u8 *data, ssize_t size)
> @@ -803,37 +827,18 @@ dso_cache__read(struct dso *dso, struct machine *machine,
>  	ssize_t ret;
>  
>  	do {
> -		u64 cache_offset;
> +		u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
>  
>  		cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
>  		if (!cache)
>  			return -ENOMEM;
>  
> -		pthread_mutex_lock(&dso__data_open_lock);
> -
> -		/*
> -		 * dso->data.fd might be closed if other thread opened another
> -		 * file (dso) due to open file limit (RLIMIT_NOFILE).
> -		 */
> -		try_to_open_dso(dso, machine);
> -
> -		if (dso->data.fd < 0) {
> -			ret = -errno;
> -			dso->data.status = DSO_DATA_STATUS_ERROR;
> -			break;
> -		}
> -
> -		cache_offset = offset & DSO__DATA_CACHE_MASK;
> -
> -		ret = pread(dso->data.fd, cache->data, DSO__DATA_CACHE_SIZE, cache_offset);
> -		if (ret <= 0)
> -			break;
> +		ret = file_read(dso, machine, cache_offset, cache->data);
>  
>  		cache->offset = cache_offset;
>  		cache->size   = ret;
>  	} while (0);
>  
> -	pthread_mutex_unlock(&dso__data_open_lock);
>  
>  	if (ret > 0) {
>  		old = dso_cache__insert(dso, cache);
> -- 
> 2.17.2
> 
