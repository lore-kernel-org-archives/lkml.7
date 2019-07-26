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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627ABC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3675C22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfckVklk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfGZTeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:34:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36132 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfGZTdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:33:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so53795020qtc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ez0JvEiAj5MWdDF3a6VF7PrE8VgGnXwGxp/XalijZ4g=;
        b=rfckVklkSndyYIN7aG/W1w8sOxxaj3w/SwlHbAQABT76sNwx6TJykgkyVJ4Li6NxO2
         YMgm0tOyHAqB1CZKZ38tWldogUSjTh2zS0FLpiRjdkLg3CC6RozFTWOQX4W4igWquB97
         Zhsj9GZNfREIzqmDSAZusKDR9lFNx2bfFbXe753d/LbT5OB5U0E+W2E1K6uplJG6u2DK
         2xjosphDR0Tdc6L2lp1ICzY4lv3x2hmzhPK8OietFHcQgUvTkJbSGX9Zi4Laij/wchfs
         FynFuAUJYTRgeALCe4Sefi3StOxcPruWhhCyZDRL0tROX1GbYjcs1dIM+oYqw8z9sVUx
         N4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ez0JvEiAj5MWdDF3a6VF7PrE8VgGnXwGxp/XalijZ4g=;
        b=D7BOlvMH6pAXm3Dq6wvJgNACNbUBXFtJM3KorHhFd+E51R8xP1WAv8vEZBE2ZjSRUo
         ysB7OAKMT5zbkm5m/JLZPr2VMydR8lTFtNC56IBL8WjoT5TiHW4z+FPjgsF8Tu7sJ4dK
         /7sBXMT469xsFrfb2bly/VySkWWoj02VOHCBeUC9u9T1tXPjB5PNphe+B+LUHHhOeOdC
         5RDtFCQnKHriTpH4//OsbYnZIp8CfhsOx/J93rxljqptfEC/r+7xZ3IAh61G0M0djo7s
         JWajh5c9TdRKZ25O9uEtsKxSGkGwZVF3ChUGNKQvIJ+qeYgWRPSqOcmb70m5fL00qWPY
         fMAg==
X-Gm-Message-State: APjAAAXWTpjGNVuydJ6ZUNu/mQn61WtJX8fQ14laYUab9obtlp7Duhy3
        EsMNnDYgAPAcF+q8yQFGkqk=
X-Google-Smtp-Source: APXvYqx/88n7uEGJhdzhk92u9Mao0F3xEs7XqdQL9Iel6FKMr0Rew+eqQ+l07JqgrON8v//T8NWAfw==
X-Received: by 2002:ac8:282b:: with SMTP id 40mr68497424qtq.49.1564169634522;
        Fri, 26 Jul 2019 12:33:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o33sm24939589qtd.72.2019.07.26.12.33.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:33:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 06F3440340; Fri, 26 Jul 2019 16:33:52 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:33:52 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 2/3] Fix ordered-events.c array-bounds error
Message-ID: <20190726193352.GI20482@kernel.org>
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-3-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724184512.162887-3-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 11:45:11AM -0700, Numfor Mbiziwo-Tiapo escreveu:
> Perf does not build with the ubsan (undefined behavior sanitizer)
> and there is an error that says:
> 
> tools/perf/util/debug.h:38:2:
>  error: array subscript is above array bounds [-Werror=array-bounds]
>   eprintf_time(n, var, t, fmt, ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> tools/perf/util/debug.h:40:34:
>  note: in expansion of macro ‘pr_time_N’
>  #define pr_oe_time(t, fmt, ...)  pr_time_N(1, debug_ordered_events,
>  t, pr_fmt(fmt), ##__VA_ARGS__)
> 
> util/ordered-events.c:329:2: note: in expansion of macro ‘pr_oe_time’
>   pr_oe_time(oe->next_flush, "next_flush - ordered_events__flush
>   POST %s, nr_events %u\n",
> 
> This can be reproduced by running (from the tip directory):
> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
> 
> The error stems from the 'str' array in the __ordered_events__flush
> function in tools/perf/util/ordered-events.c. On line 319 of this
> file, they use values of the variable 'how' (which has the type enum
> oeflush - defined in ordered-events.h) as indices for the 'str' array.
> Since 'how' has 5 values and the 'str' array only has 3, when the 4th
> and 5th values of 'how' (OE_FLUSH__TOP and OE_FLUSH__TIME) are used as
> indices, this will go out of the bounds of the 'str' array.
> Adding the matching strings from the enum values into the 'str' array
> fixes this.

^[[acme@quaco perf]$ patch -p1 < /wb/1.patch
patching file tools/perf/util/ordered-events.c
patch: **** malformed patch at line 146: s *oe, enum oe_flush how,

[acme@quaco perf]$ git dif



Applying by hand
 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/util/ordered-events.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index 897589507d97..c092b0c39d2b 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -270,6 +270,8 @@ static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
>  		"FINAL",
>  		"ROUND",
>  		"HALF ",
> +		"TOP",
> +		"TIME",
>  	};
>  	int err;
>  	bool show_progress = false;
> -- 
> 2.22.0.657.g960e92d24f-goog

-- 

- Arnaldo
