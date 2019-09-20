Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7890EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B67720717
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXRJJaoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406418AbfITSUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:20:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34591 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404824AbfITSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:20:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so7290989qta.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BIubZ3kYt7dH1/RtsD6F5kXEz8+uvn6yz+nDzQe8HSU=;
        b=GXRJJaoZ1oAFbWlFHRhhyQvz4Gg4QOwivzd0lQoS3O2SDxjMXXoKmbSjjAhRQxGhEV
         tkJ7ItCh9u2tB2DxXCXyk7PWopIPjSB8PnuiocH9gAsvVOMP5JnAMNi1Axfmrs7/lQaf
         c0cEe5HrPI+z5mXoYkGGlj2ATKROtYLZgn1PXgzIOTIo/ihJUCu5g1j31vb3aegAYQaU
         eatqI26aa9LndL5QmD1AxWfV5sDwWnhx49JlHfnJyEFnWeTXLI77McM0OQhsPLENZVta
         kWHfiP5nba1GhPBwf/hRwJOqfSL8/m0U6CDcdbc/AzLIa0aw8eIe+boOmHlo78iZurAY
         Xznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BIubZ3kYt7dH1/RtsD6F5kXEz8+uvn6yz+nDzQe8HSU=;
        b=kEgjOSL8OlPgssd1KJrtLoK1ozCgh22OZXIGl6QN3lFA7AOYXU0LJpnZwOB22o3mAR
         LPP96Gklh618OGmwvTsMPUHk3+BuUV82kRWxg76uxh4+xpcU07DJPDUpFVTzKKdWhJPb
         kT7xgixSAeci1wpFEHBh8q0BBoSBwVr29I5d8+IOy6YukD6MJazkebc2PMzyfCeHJvw4
         W0u6m9vXGKl8zZZByX3HWpgdINdhwefEsjvksusGfC6F3N5uGxjmbiVt1SFjRTIoSvFt
         g8SrrY2VLfQsHR9DoWoOAa4AqY0sii3PU98bgOR2LEE9+ge8NQE+kJ5mU5nOuPUU2hZD
         Cmrg==
X-Gm-Message-State: APjAAAUJucKUVGQ9qPTfMjeyhvWZ/oLcw/wRWfvZoAAnsZ5RdBp71js+
        mEPpHYvuRZ2pP0OKL/DvEJQ=
X-Google-Smtp-Source: APXvYqwSILGeHd4aPgMLJ6F/MWSuU7YC7fOR2ZbLckJ5mVR79Xiv3w6GX0uCVqRnfsPlSjT7BsVNSg==
X-Received: by 2002:ac8:5152:: with SMTP id h18mr4644841qtn.210.1569003630053;
        Fri, 20 Sep 2019 11:20:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.7.29])
        by smtp.gmail.com with ESMTPSA id 54sm1645480qts.75.2019.09.20.11.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:20:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FCAE40340; Fri, 20 Sep 2019 15:20:26 -0300 (-03)
Date:   Fri, 20 Sep 2019 15:20:26 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix segfault in cpu_cache_level__read
Message-ID: <20190920182026.GA4865@kernel.org>
References: <20190912105235.10689-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912105235.10689-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 12, 2019 at 12:52:35PM +0200, Jiri Olsa escreveu:
> We release wrong pointer on error path in
> cpu_cache_level__read function, leading to
> segfault:
> 
>   (gdb) r record ls
>   Starting program: /root/perf/tools/perf/perf record ls
>   ...
>   [ perf record: Woken up 1 times to write data ]
>   double free or corruption (out)
> 
>   Thread 1 "perf" received signal SIGABRT, Aborted.
>   0x00007ffff7463798 in raise () from /lib64/power9/libc.so.6
>   (gdb) bt
>   #0  0x00007ffff7463798 in raise () from /lib64/power9/libc.so.6
>   #1  0x00007ffff7443bac in abort () from /lib64/power9/libc.so.6
>   #2  0x00007ffff74af8bc in __libc_message () from /lib64/power9/libc.so.6
>   #3  0x00007ffff74b92b8 in malloc_printerr () from /lib64/power9/libc.so.6
>   #4  0x00007ffff74bb874 in _int_free () from /lib64/power9/libc.so.6
>   #5  0x0000000010271260 in __zfree (ptr=0x7fffffffa0b0) at ../../lib/zalloc..
>   #6  0x0000000010139340 in cpu_cache_level__read (cache=0x7fffffffa090, cac..
>   #7  0x0000000010143c90 in build_caches (cntp=0x7fffffffa118, size=<optimiz..
>   ...
> 
> Releasing the proper pointer.

You forgot to add:

Fixes: 720e98b5faf1 ("perf tools: Add perf data cache feature")
Cc: stable@vger.kernel.org: # v4.6+

I did it, please consider doing it next time,

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-e7js6xoi4y18kydxqehh0ihx@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index b0c34dda30a0..3527b9897b6f 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1081,7 +1081,7 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
>  
>  	scnprintf(file, PATH_MAX, "%s/shared_cpu_list", path);
>  	if (sysfs__read_str(file, &cache->map, &len)) {
> -		zfree(&cache->map);
> +		zfree(&cache->size);
>  		zfree(&cache->type);
>  		return -1;
>  	}
> -- 
> 2.21.0

-- 

- Arnaldo
