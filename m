Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCDCC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33082072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="bZc9isEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgAFSKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:10:03 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37491 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:10:02 -0500
Received: by mail-qv1-f66.google.com with SMTP id f16so19409193qvi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Scg+5c1bo7BzriOdYCjzy69y4LMw3hBOSsv5RxX0B2s=;
        b=bZc9isEtCO4q9pUWW9qXKMRW92eYNSKQQ5G3t4oSCu+AcoFlX77fXSICadA+EstGuE
         mwOf7VGZnRi2uoNfC/XkOx57rnwoRAD6P9P4mqOovetU8iiMnCDQ659d5iJJRoWo0l1x
         YUD2XYBKKm9GdEac4aQ2udYBy2l88uzsUpqF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Scg+5c1bo7BzriOdYCjzy69y4LMw3hBOSsv5RxX0B2s=;
        b=d633nZZHVnd5y6Oy46jTbUZigu+qr9zNoIwdNpS6HlvYUliVs7Z9UjMEKztXZm9bOz
         QgZBeRiv3jqFQl4QQ3hDe1A8lMMFiNcFvK/nHgOwh0o+JAIGJIXPIvOH9wd+whxTB5zM
         5pRbk0I5I1a+sd30a/PyF/ezPlZHjX9lTXAIKCUiJr5Ea35uSdzJgscdI7drNrLqVVVc
         iNylCTMgRRH7KI90SgnVzR9DMXld2njgdOfWEu0/y5mn2crYVyWBPYzrkRjhFcnuPMEX
         0U94Ha4RAQKa3MsiRBUm8FmmA1HCv/gxQSbMLt8amjacrk2wfOiZZ2t6zbghVpOEI6Pl
         +u7w==
X-Gm-Message-State: APjAAAVbTVLXsmWp3mrlBgLaN6VyP2ILjd7xt4PrqOGkMLbOX22r9Ori
        7hF0NPnDp//mSyBXMiqyDm4A6A==
X-Google-Smtp-Source: APXvYqzmhklHEURmGoUCV7OQeyLhJEQsJxjm1/nr9I2i+hrSd4AvvgtiPt3xFydR2A7cSzP/8ZkNRg==
X-Received: by 2002:a05:6214:1745:: with SMTP id dc5mr77634297qvb.230.1578334201693;
        Mon, 06 Jan 2020 10:10:01 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id r10sm21007469qkm.23.2020.01.06.10.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:10:00 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Mon, 6 Jan 2020 13:09:56 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Mark Rutland <mark.rutland@arm.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: correctly handle failed perf_get_aux_event() (was:
 Re: [perf] perf_event_open() sometimes returning 0)
In-Reply-To: <20200106120338.GC9630@lakrids.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.2001061307460.24675@macbook-air>
References: <alpine.DEB.2.21.2001021349390.11372@macbook-air> <alpine.DEB.2.21.2001021418590.11372@macbook-air> <20200106120338.GC9630@lakrids.cambridge.arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020, Mark Rutland wrote:

> On Thu, Jan 02, 2020 at 02:22:47PM -0500, Vince Weaver wrote:
> > On Thu, 2 Jan 2020, Vince Weaver wrote:
> > 
> Vince, does the below (untested) patch work for you?


yes, this patch fixes things for me.

Tested-by: Vince Weaver <vincent.weaver@maine.edu>



> ---->8----
> From c79f31b42aaf85f3a924af9218794b3bc8b79892 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 6 Jan 2020 11:51:06 +0000
> Subject: [PATCH] perf: correctly handle failed perf_get_aux_event()
> 
> Vince reports a worrying issue:
> 
> | so I was tracking down some odd behavior in the perf_fuzzer which turns
> | out to be because perf_even_open() sometimes returns 0 (indicating a file
> | descriptor of 0) even though as far as I can tell stdin is still open.
> 
> ... and further the cause:
> 
> | error is triggered if aux_sample_size has non-zero value.
> |
> | seems to be this line in kernel/events/core.c:
> |
> | if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
> |                goto err_locked;
> |
> | (note, err is never set)
> 
> This seems to be a thinko in commit:
> 
>   ab43762ef010967e ("perf: Allow normal events to output AUX data")
> 
> ... and we should probably return -EINVAL here, as this should only
> happen when the new event is mis-configured or does not have a
> compatible aux_event group leader.
> 
> Fixes: ab43762ef010967e ("perf: Allow normal events to output AUX data")
> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  kernel/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a1f8bde19b56..2173c23c25b4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11465,8 +11465,10 @@ SYSCALL_DEFINE5(perf_event_open,
>  		}
>  	}
>  
> -	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
> +	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader)) {
> +		err = -EINVAL;
>  		goto err_locked;
> +	}
>  
>  	/*
>  	 * Must be under the same ctx::mutex as perf_install_in_context(),
> -- 
> 2.11.0
> 
> 

