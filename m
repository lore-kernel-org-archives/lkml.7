Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3390C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9879820879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh5Pi8TT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfEVQHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:07:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46864 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:07:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id z19so146141qtz.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8P4Dh5lJgyxVlTm40LkteoVckoCNNjzoVM4I22gNWnc=;
        b=Qh5Pi8TTXVIu25z/OBTFLI24/oOUlto4DR+kAjM05vZvyxSIi7EcH51/YrcGErCCYJ
         U+9RC8zemcWi30U4+6jFSRtahnTlZm2HbLBp7p+XhV8orfqy+Wem1Ms6Z1a/lMbR3npc
         5s3xAxe6XZWIvEqFNeQ45SepkcQPTrmXAxrh/4sCWmJuR6+T94ZUa4uCTPw00EUC/sFc
         CL2V6e88/6akh/lJaF0lWoqM6hoJ1TI73THBpYjiHIjmOjwJk4uHQ0Dc30gBRC0sJzH1
         kIO3ups/DcxjAGfSzTICZdqihH+1YZSh8AkPX3HMOP5xhNe/hHmgW/C7Tu21oyJbpdv0
         MvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8P4Dh5lJgyxVlTm40LkteoVckoCNNjzoVM4I22gNWnc=;
        b=G5CiZ2dsD4ampBU2wqnqH04gpombvsQD9YlCq1SommpWSpkLcxyDketvCxY+SJkw7j
         msk1RaXUSGjT+xrapAs3d9PO/7wI+E33wzX+LbX6arhSBo+UXiPbulLT0k7ONTNzqCFO
         PDx6e1qX/3YSFYfxXvNB1Vq0oZ45rnf3gQYqtUdT/+NRDgtly8AVtUmjcBA/MYdN/WRh
         KL0BCgO5dEXeIqTXwgfvUYDFlkGKr2TCeYJjAYLEtERiYe0uEXRskvwS76kvpI5gUGvV
         wmJ0d22vJHsHR3J9I2QkatASyQxWN6DrYSreBvnH2vX+KFDRM0EZayQTkNE8mdk7jMoi
         5w+Q==
X-Gm-Message-State: APjAAAXNNB7ooGmOFUB7wb2UXptvpH/8UAI1dxL4AVjnwZTCzBQCyyXL
        BMRo9eW7IK3GVxizjVngeYg=
X-Google-Smtp-Source: APXvYqyS0QuxNmDkXO+04BDuTWYf4cEH5USwc8kiir8tRed3dTJiZOSl/0ur9tR4LG3oAcjudjuruQ==
X-Received: by 2002:a0c:984b:: with SMTP id e11mr8679595qvd.174.1558541221963;
        Wed, 22 May 2019 09:07:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.94.38])
        by smtp.gmail.com with ESMTPSA id d58sm18627877qtb.11.2019.05.22.09.06.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 09:07:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38C5B404A1; Wed, 22 May 2019 13:06:57 -0300 (-03)
Date:   Wed, 22 May 2019 13:06:57 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 08/12] perf tools: Preserve eBPF maps when loading kcore
Message-ID: <20190522160657.GF30271@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508132010.14512-9-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 08, 2019 at 03:20:06PM +0200, Jiri Olsa escreveu:
> We need to preserve eBPF maps even if they are
> covered by kcore, because we need to access
> eBPF dso for source data.

So, I reordered this one with the previous, as to get the output you
added to 07/12 we need what is in 08/12, and they are otherwise
completely independent, right?

- Arnaldo
 
> Adding map_groups__merge_in function to do that.
> It merges map into map_groups by splitting the
> new map within the existing map regions.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Link: http://lkml.kernel.org/n/tip-mlu13e9zl6rbsz4fa00x7mfa@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/symbol.c | 97 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 93 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5cbad55cd99d..29780fcd049c 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1166,6 +1166,85 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
>  	return 0;
>  }
>  
> +/*
> + * Merges map into map_groups by splitting the new map
> + * within the existing map regions.
> + */
> +static int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
> +{
> +	struct map *old_map;
> +	LIST_HEAD(merged);
> +
> +	for (old_map = map_groups__first(kmaps); old_map;
> +	     old_map = map_groups__next(old_map)) {
> +
> +		/* no overload with this one */
> +		if (new_map->end < old_map->start ||
> +		    new_map->start >= old_map->end)
> +			continue;
> +
> +		if (new_map->start < old_map->start) {
> +			/*
> +			 * |new......
> +			 *       |old....
> +			 */
> +			if (new_map->end < old_map->end) {
> +				/*
> +				 * |new......|     -> |new..|
> +				 *       |old....| ->       |old....|
> +				 */
> +				new_map->end = old_map->start;
> +			} else {
> +				/*
> +				 * |new.............| -> |new..|       |new..|
> +				 *       |old....|    ->       |old....|
> +				 */
> +				struct map *m = map__clone(new_map);
> +
> +				if (!m)
> +					return -ENOMEM;
> +
> +				m->end = old_map->start;
> +				list_add_tail(&m->node, &merged);
> +				new_map->start = old_map->end;
> +			}
> +		} else {
> +			/*
> +			 *      |new......
> +			 * |old....
> +			 */
> +			if (new_map->end < old_map->end) {
> +				/*
> +				 *      |new..|   -> x
> +				 * |old.........| -> |old.........|
> +				 */
> +				map__put(new_map);
> +				new_map = NULL;
> +				break;
> +			} else {
> +				/*
> +				 *      |new......| ->         |new...|
> +				 * |old....|        -> |old....|
> +				 */
> +				new_map->start = old_map->end;
> +			}
> +		}
> +	}
> +
> +	while (!list_empty(&merged)) {
> +		old_map = list_entry(merged.next, struct map, node);
> +		list_del_init(&old_map->node);
> +		map_groups__insert(kmaps, old_map);
> +		map__put(old_map);
> +	}
> +
> +	if (new_map) {
> +		map_groups__insert(kmaps, new_map);
> +		map__put(new_map);
> +	}
> +	return 0;
> +}
> +
>  static int dso__load_kcore(struct dso *dso, struct map *map,
>  			   const char *kallsyms_filename)
>  {
> @@ -1222,7 +1301,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  	while (old_map) {
>  		struct map *next = map_groups__next(old_map);
>  
> -		if (old_map != map)
> +		/*
> +		 * We need to preserve eBPF maps even if they are
> +		 * covered by kcore, because we need to access
> +		 * eBPF dso for source data.
> +		 */
> +		if (old_map != map && !__map__is_bpf_prog(old_map))
>  			map_groups__remove(kmaps, old_map);
>  		old_map = next;
>  	}
> @@ -1256,11 +1340,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  			map_groups__remove(kmaps, map);
>  			map_groups__insert(kmaps, map);
>  			map__put(map);
> +			map__put(new_map);
>  		} else {
> -			map_groups__insert(kmaps, new_map);
> +			/*
> +			 * Merge kcore map into existing maps,
> +			 * and ensure that current maps (eBPF)
> +			 * stay intact.
> +			 */
> +			if (map_groups__merge_in(kmaps, new_map))
> +				goto out_err;
>  		}
> -
> -		map__put(new_map);
>  	}
>  
>  	if (machine__is(machine, "x86_64")) {
> -- 
> 2.20.1

-- 

- Arnaldo
