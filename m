Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A22C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BBE2183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap0qyhUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfDORWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:22:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42506 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfDORWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:22:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so20024036qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jspgZBYs0/J4vB6N7GaQYGPWDJJa3LoxlDeEaiw+dc=;
        b=ap0qyhUmaresb9PwhMhZexEIjSMz4fNenZ6e8No4T8gIYUTJ6BsF0dp4tLhIAeNDGU
         6tYzJuAm913GCmRE4uCNkg8VA6pm5rfxd0BQP1rd7anggY5WwJ2xYAJOSkxeG5sUIYeh
         1G1/F2e3PYRCJa9JVfpI1Iu5ITnJk3iTUeTRCBKUGDeISUqGcHq0NAZvCeBgzSLWMjgY
         P7t+UfBan7veJVRhtOknIqddiW3bpu/ctKT9WaiLrQOw374pqpMzdFzrhCBOcyJgOi97
         taQUZ2YmVsGTzK6wm0qLfwXH5b1YYKIM8lhUt0uihnyBkjin08Ggia2Qh1t6jIkeghEi
         Z0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jspgZBYs0/J4vB6N7GaQYGPWDJJa3LoxlDeEaiw+dc=;
        b=ofEDv2o1x8cyDm1X1uRHHSGPgvrIoSYRty11BirJhggK752EbYaqEWeonmjY+hmu3u
         UKX5WDxjZXrf1+XpQ4fY61e9xydxIPc59DF4y3DVaelsaRSZpuWKGlyDS7u8FMFcvVbz
         6HBPMKCqyvwWr+n3UJ7aXRvDx59q6M0+HnmS8Tn16ktxpJm/6tvludgMhZJgbzrhyQ3X
         RFUBqMV+VnwkXdIR1wdEYD7q5qkjUerbUKavJyZL/pBwy+scf/qdqZ5KXb/IaUeW5eGS
         DD/chCt6kJAuIeoLceVqscAgad5h5dyrohqNReekxEY7QQ9b5YzANJh2FsYEBAlAl/QT
         KvoA==
X-Gm-Message-State: APjAAAVaXg6aPt3DDIhdrcVl9vjQQtxlgLRLhQF7gVpN2dt9NEgdO/+8
        3S8WM0X2ZKNOmKeptXr5Alc=
X-Google-Smtp-Source: APXvYqxzMgYJCt5fZlsl+7MQivlU8tRuNMYrexNS/Hkfsky4HGWKVs5MaHMypeb+jAfsGuv9tbpeRg==
X-Received: by 2002:ac8:2d02:: with SMTP id n2mr60997922qta.229.1555348940575;
        Mon, 15 Apr 2019 10:22:20 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id v58sm32405890qtv.66.2019.04.15.10.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 10:22:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02E264039C; Mon, 15 Apr 2019 14:22:15 -0300 (-03)
Date:   Mon, 15 Apr 2019 14:22:15 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Bastian Beischer <bastian.beischer@rwth-aachen.de>
Subject: Re: [PATCH perf/urgent] perf top: Always sample time
Message-ID: <20190415172215.GB11294@kernel.org>
References: <20190415125333.27160-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415125333.27160-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 15, 2019 at 02:53:33PM +0200, Jiri Olsa escreveu:
> Bastian reported broken perf top -p PID command, it won't
> display any data.
> 
> The problem is that for -p option we monitor single thread,
> so we don't enable time in samples, because it's not needed.
> 
> However since commit 16c66bc167cc we use ordered queues to
> stash data plus later commits added logic for dropping samples
> in case there's big load and we don't keep up. All this needs
> timestamp for sample. Enabling it unconditionally for perf top.

Thanks, tested and applied.

- Arnaldo
 
> Fixes: 16c66bc167cc ("perf top: Add processing thread")
> Reported-by: Bastian Beischer <bastian.beischer@rwth-aachen.de>
> Link: http://lkml.kernel.org/n/tip-zhn7jg8hqpl9547g7vqjini7@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-top.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1999d6533d12..fbbb0da43abb 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1377,6 +1377,7 @@ int cmd_top(int argc, const char **argv)
>  			 * */
>  			.overwrite	= 0,
>  			.sample_time	= true,
> +			.sample_time_set = true,
>  		},
>  		.max_stack	     = sysctl__max_stack(),
>  		.annotation_opts     = annotation__default_options,
> -- 
> 2.17.2

-- 

- Arnaldo
