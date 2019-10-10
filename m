Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B9C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883B6206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b697RvLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfJJNLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:11:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43889 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbfJJNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:11:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so3237873qtr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ynQpPtUZ+/Dwh99O0vNfivFGwbWMd+jPnCKl3gN7cx8=;
        b=b697RvLpgD66fNL0sRDJxb4EoUm6P7eGUeDYU07IKU6/c+tPsR6BEAPJSKBdy+XRmT
         xdi1+eWPKxje2ZvIE0l2pIXaIuj8pj+XzHo8TGBYyPMnVzV90VTyWmBHUu43tVfbXSYM
         Zs2nBHjFhwb6yXo7RkhVe9gOaLVMUuP4j8Y4IOkCGXDis3gxLmWXI48iHR5HlANJb2XL
         WX23yIrLaGjkUHMh2z+vJIeJF9S3FRkJ/Htqx1Gv9oxMEyGZYglT3+LYcmSh6oorazy8
         w7vnwI4j/V1nQNE+xNY3Ix+un+t8NjsdSGZIcnUZ/7HYfrWjQuFd6TrwiaSsv9CerYZN
         2UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ynQpPtUZ+/Dwh99O0vNfivFGwbWMd+jPnCKl3gN7cx8=;
        b=V1qoRmMpT5pytjQS643bWdAN65ay05syQQBxkaW02M7g228sQz9s9gd4mtgmRswlJI
         7g6MWFOmnD2oRyvQR+jz5mGW5XoXLFqqZ+p2rTqoUzjA6nxy0aBYiWDq/ipiY8ong4QJ
         7+O/d78dAGdh8ukLpLQwyS1KJukF4ioj2BPrZ8Zn3VzLhgmKWfJ5ovyWKkIijtNbf77r
         89J6oX3ZwDwfgxmtD0W6Gs72LJCFHAtFFc35A4dWBVx2qPXRfYG/D3W3d9lIhHuWd4td
         pWHz+gWXrKOeyqnJoDL5Rbr+k8AptJAdLQ2+voL+zMLMANVJMjFWxhAEh9aUBHJTkvdp
         6jRw==
X-Gm-Message-State: APjAAAU63Ybmt9PFVYn3pUiJ67eAhWwIzVGSLO0+XN6/W2hkEtKqHVMq
        1WmyEkUkXZP80eAxSQMkHug=
X-Google-Smtp-Source: APXvYqx5y17Qn2bPjuGFkqnn6qy5/92KGenFApJBv35FNTs6CusBAAr6pSrdHInSEr/rnYn5OC5DqA==
X-Received: by 2002:ac8:259a:: with SMTP id e26mr10210612qte.134.1570713069082;
        Thu, 10 Oct 2019 06:11:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l23sm4094753qta.53.2019.10.10.06.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:11:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 69C164DD66; Thu, 10 Oct 2019 10:11:04 -0300 (-03)
Date:   Thu, 10 Oct 2019 10:11:04 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 07/36] libperf: Add perf_mmap__put() function
Message-ID: <20191010131104.GA11638@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
 <20191007125344.14268-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007125344.14268-8-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 07, 2019 at 02:53:15PM +0200, Jiri Olsa escreveu:
> +++ b/tools/perf/lib/mmap.c
> @@ -3,10 +3,12 @@
>  #include <internal/mmap.h>
>  #include <internal/lib.h>
>  
> -void perf_mmap__init(struct perf_mmap *map, bool overwrite)
> +void perf_mmap__init(struct perf_mmap *map, bool overwrite,
> +		     libperf_unmap_cb_t unmap_cb)
>  {
>  	map->fd = -1;
>  	map->overwrite = overwrite;
> +	map->unmap_cb  = unmap_cb;
>  	refcount_set(&map->refcnt, 0);
>  }
>  
> @@ -40,9 +42,19 @@ void perf_mmap__munmap(struct perf_mmap *map)
>  		map->fd = -1;
>  		refcount_set(&map->refcnt, 0);
>  	}
> +	if (map && map->unmap_cb)
> +		map->unmap_cb(map);
>  }
>  
>  void perf_mmap__get(struct perf_mmap *map)
>  {
>  	refcount_inc(&map->refcnt);
>  }
> +
> +void perf_mmap__put(struct perf_mmap *map)
> +{
> +	BUG_ON(map->base && refcount_read(&map->refcnt) == 0);

Added missing linux/kernel.h to this file to pick up BUG_ON().

- Arnaldo
