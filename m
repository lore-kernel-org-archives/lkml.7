Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD7DC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAAD2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJPUMagw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfGZTFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:05:45 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:34183 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388306AbfGZTFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:05:45 -0400
Received: by mail-qk1-f174.google.com with SMTP id t8so39841476qkt.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZsF7ZJaphMWN9qRy4bD4vHayPMKRYnmzgQEknbb+i0=;
        b=WJPUMagw7mekaMPendP9T8PCqp3BQckjVCLd/rndL+nv6DRii3ypfgbKqyA/+Ft+Xy
         dpzkPuuqAfKJE15w8Osb6Lic9i9WqW2sRZGbLbwk3sHuewiKkYHtXjBtukBUf+EXxF1Q
         6veZXcnwd/9NQ257Kg2/gCMTuXXYoQ6HlAHTrycpTwzv7BX9MtH6BZUI+4e3gAY/V+Nf
         SSCpge7pQhmNGsaqBt6jABGVgEy6VzTamIunWf7XpH1WTtRjkAFfCQMup8C7ZhzwQgd6
         UbrHjeAX6qAfK1qveWIR+ZD7F8BpsQfA8BgRnb9B6x2d7H4rF+/iYZ5tLU6Zk7frCW+5
         bMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZsF7ZJaphMWN9qRy4bD4vHayPMKRYnmzgQEknbb+i0=;
        b=XJGG77p1XNjYxJhIUiD5NdCrXpQvd4Xw7/z1zXYUOilFjIuJHCtagCoZzz3WTsDelY
         G0rnPXjRydXpJEyX5b5IUm6evXZnbeCnsovGeZ9d3q+6h9+n86I0bDvxurt2o/085Bl+
         0s8W7c8yWSdX5J/MzGhQgKDV1TDXUT2D72xBIskDOg49ndr6GdvOJBtVAWHo4A9dTqoh
         x30i16OI0uG8iCji/8u6/0IbfR8A2CeYk4otxSBOBnjYf/oDMHPxwxnenYtA7OVe6O8i
         1ILLhex7pPgXS3mhMAqhDs72l8VmIZRnuYcaDxnIpvpTPZmtCmcFQd4D7I7pc6a7n0an
         S24A==
X-Gm-Message-State: APjAAAXGkLufVoG5MWWYNK0xGfJ9aK8kC9KEu0ip1Ip7CKeIdfsww48y
        1qs7bCJNKaKo8GVjvw0bc0o=
X-Google-Smtp-Source: APXvYqyuJ/vu0VGo8xvzuoUQ6pcwY0rIRCc1+foG0SfHLPs9H5Igpj31+QElSDbEmkEt581vgqC+kw==
X-Received: by 2002:a05:620a:1006:: with SMTP id z6mr31170851qkj.312.1564167944308;
        Fri, 26 Jul 2019 12:05:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i1sm23987910qtb.7.2019.07.26.12.05.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:05:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 846FA40340; Fri, 26 Jul 2019 16:05:41 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:05:41 -0300
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf tool buffer overflow in perf_header__read_build_ids
Message-ID: <20190726190541.GC20482@kernel.org>
References: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
 <alpine.DEB.2.21.1907231639120.14532@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907231639120.14532@macbook-air>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 23, 2019 at 04:42:30PM -0400, Vince Weaver escreveu:
> Hello
> 
> my perf_tool_fuzzer has found another issue, this one a buffer overflow
> in perf_header__read_build_ids.  The build id filename is read in with a 
> filename length read from the perf.data file, but this can be longer than
> PATH_MAX which will smash the stack.
> 
> This might not be the right fix, not sure if filename should be NUL
> terminated or not.
> 
> Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index c24db7f4909c..9a893a26e678 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2001,6 +2001,9 @@ static int perf_header__read_build_ids(struct perf_header *header,
>  			perf_event_header__bswap(&bev.header);
>  
>  		len = bev.header.size - sizeof(bev);
> +
> +		if (len>PATH_MAX) len=PATH_MAX;
> +

Humm, I wonder if we shouldn't just declare the whole file invalid like
you did with the previous patch?

- Arnaldo

>  		if (readn(input, filename, len) != len)
>  			goto out;
>  		/*
