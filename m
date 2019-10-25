Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BDACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3CC222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1PQRrk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394795AbfJYOyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:54:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39719 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393570AbfJYOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:54:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id t8so3636184qtc.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ijm0blWuTqCPrt3AHESsOOMLUajJAALCORs7J+IA15c=;
        b=u1PQRrk+PAFahIyvU6+vy3OQWTKW+IfJyoiQVTkoa7rbQ5ESxhtXSiwv1jWU/PeB2K
         WcryEsCDO95lryWA5wzCBY1eFS7jnOOozbUYBVydpQDBidQeIhZyFdyebIDYU3iC3tNs
         1vRhI8IhbYpMigTQLaGu+gNiEyDxjEmynAmG7Ng1Q37mW+wJ9ssIkL4xabj1DoLcYqN5
         xHR8Gs4AnO4OZL6vceeJX80uYARm5AxIUNRP1i0dszRzQ13pjM1erFfnj23hKM+INTFL
         pl7uokTb/xzcGdRqmP9gpP0N/hK31iWX5WEboMJ5wxljO9cSzIuGjE/mxXsAS8SEE6d8
         +9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijm0blWuTqCPrt3AHESsOOMLUajJAALCORs7J+IA15c=;
        b=GeFVW58iy4wYrM0pzjHeLqcqiuEc4aCt99xZHUl0Y/fcE9jzxaoPLsFPY0qUo5xtL6
         /YnlJC7FvV9bdsr4mXh0JajJunzaz0RHWq8oBYEI0QlEMEbVGldopNU4XHmknGHsR4SH
         ws2+QHw4m58l/HO/48E+a03huAjTfn8m+wPYLsD2Ay5qEBybjfDyNlMWVvdC4MvQ05Us
         DfX936ZeEuR7fhx+e8mPi/hm+vtdAUdBq+HKAkJdDjuZIEG/C34fay1ZcobWdhFPgRt8
         BSY/Uwoq2fc1sO5pEhnW0I91xZUZx+btke9bT48tMXomUWAsApUN6GuyANNnyWlTuRLd
         K2TQ==
X-Gm-Message-State: APjAAAXs70W0xe6daW43swwxsvMZC+Eg0W0LHITtxY/FA+pnSV/NpTVh
        0kZ5QnVALnhueHXmfeuXC+E=
X-Google-Smtp-Source: APXvYqyLrN4xfBkvH86yk7UXSrJhudy/Ak3vSeV4zysy5G7WrS8GWFVvPrLtlPDzxMRKFlJqNUdAeQ==
X-Received: by 2002:ac8:378d:: with SMTP id d13mr3452789qtc.69.1572015243963;
        Fri, 25 Oct 2019 07:54:03 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 4sm1194083qtf.87.2019.10.25.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:54:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A71F741199; Fri, 25 Oct 2019 11:54:00 -0300 (-03)
Date:   Fri, 25 Oct 2019 11:54:00 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] perf dso: Refactor dso_cache__read()
Message-ID: <20191025145400.GB24735@kernel.org>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025130000.13032-3-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 25, 2019 at 03:59:56PM +0300, Adrian Hunter escreveu:
> Refactor dso_cache__read() to separate populating the cache from copying
> data from it.  This is preparation for adding a cache "write" that will
> update the data in the cache.

Ditto for 2/6 and 3/6, i.e. applying them now.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/dso.c | 64 +++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index e11ddf86f2b3..460330d125b6 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -768,7 +768,7 @@ dso_cache__free(struct dso *dso)
>  	pthread_mutex_unlock(&dso->lock);
>  }
>  
> -static struct dso_cache *dso_cache__find(struct dso *dso, u64 offset)
> +static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
>  {
>  	const struct rb_root *root = &dso->data.cache;
>  	struct rb_node * const *p = &root->rb_node;
> @@ -863,54 +863,64 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
>  	return ret;
>  }
>  
> -static ssize_t
> -dso_cache__read(struct dso *dso, struct machine *machine,
> -		u64 offset, u8 *data, ssize_t size)
> +static struct dso_cache *dso_cache__populate(struct dso *dso,
> +					     struct machine *machine,
> +					     u64 offset, ssize_t *ret)
>  {
>  	u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
>  	struct dso_cache *cache;
>  	struct dso_cache *old;
> -	ssize_t ret;
>  
>  	cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
> -	if (!cache)
> -		return -ENOMEM;
> +	if (!cache) {
> +		*ret = -ENOMEM;
> +		return NULL;
> +	}
>  
>  	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
> -		ret = bpf_read(dso, cache_offset, cache->data);
> +		*ret = bpf_read(dso, cache_offset, cache->data);
>  	else
> -		ret = file_read(dso, machine, cache_offset, cache->data);
> +		*ret = file_read(dso, machine, cache_offset, cache->data);
>  
> -	if (ret > 0) {
> -		cache->offset = cache_offset;
> -		cache->size   = ret;
> +	if (*ret <= 0) {
> +		free(cache);
> +		return NULL;
> +	}
>  
> -		old = dso_cache__insert(dso, cache);
> -		if (old) {
> -			/* we lose the race */
> -			free(cache);
> -			cache = old;
> -		}
> +	cache->offset = cache_offset;
> +	cache->size   = *ret;
>  
> -		ret = dso_cache__memcpy(cache, offset, data, size);
> +	old = dso_cache__insert(dso, cache);
> +	if (old) {
> +		/* we lose the race */
> +		free(cache);
> +		cache = old;
>  	}
>  
> -	if (ret <= 0)
> -		free(cache);
> +	return cache;
> +}
>  
> -	return ret;
> +static struct dso_cache *dso_cache__find(struct dso *dso,
> +					 struct machine *machine,
> +					 u64 offset,
> +					 ssize_t *ret)
> +{
> +	struct dso_cache *cache = __dso_cache__find(dso, offset);
> +
> +	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
>  }
>  
>  static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
>  			      u64 offset, u8 *data, ssize_t size)
>  {
>  	struct dso_cache *cache;
> +	ssize_t ret = 0;
>  
> -	cache = dso_cache__find(dso, offset);
> -	if (cache)
> -		return dso_cache__memcpy(cache, offset, data, size);
> -	else
> -		return dso_cache__read(dso, machine, offset, data, size);
> +	cache = dso_cache__find(dso, machine, offset, &ret);
> +	if (!cache)
> +		return ret;
> +
> +	return dso_cache__memcpy(cache, offset, data, size);
>  }
>  
>  /*
> -- 
> 2.17.1

-- 

- Arnaldo
