Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC85C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AF7206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7eZqS7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfFJHip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:38:45 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34791 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388034AbfFJHip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:38:45 -0400
Received: by mail-yb1-f194.google.com with SMTP id x32so3421837ybh.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ivYOsIQLaE0sFyLyjt7AVV6ZKC2mGOmSWvKcFrNuPaE=;
        b=P7eZqS7v1jWK7YUf29+8gLaGSSiK7dU3B73uNY5V7CwGXNrkg5QvP+z0Dw1Gtad5ty
         JdlDoiVl4itADcaBgTAVCdh72YIIgQ8/2IzoYFbrKzPvoZIr6l4PuZRstzbBPqdRh6Qd
         XgkslJ1W9RaZccIBn2aVNsQFz5Vj0jmaC8xwazXHG2OpuvdEYV9++05a+qB5BSp6ND3b
         X6jmii2rHoq0tyDkYvzX9oaLpE+ClHmIfKlAqGCOhuTcXib645dFnUNKT+BffM8r6tEf
         n3Qy+M573i+KXP+UD8zITQmhKS9o9VUyF8hPFGFDz4K58ws0cd+hAh/kC9w6PRchjpeN
         b5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ivYOsIQLaE0sFyLyjt7AVV6ZKC2mGOmSWvKcFrNuPaE=;
        b=FtICQ+CM1PqWKwVmYZB78StmIt3bUvQGGn2tYPYqiYsp1W3E0ngq8361eum3mjiEc5
         O/ZpIWbY/UVGO5HlzRmjfJswCE1QM80hCtNdw6u7R4eR2P0QaqY08s66Z106Wwmpy3gu
         R+pchiLk6PgUfwJySCVgLz6q2g4Iwve1v2IQhX0eV0KvUH08yOfezntAzt0A3gUGL3pT
         XgXSdlmpZWYmvDoCYfRPY/0knL2QV2pR8aXR9EARMQc6W1iO8Cson7f8qV0qqOBc582v
         h6rdnGqsp+urdq36W3FisGH/clVw9k3FmnzW/BqR7aPKCruiwCGr+ywaamZ8p/EfG8lX
         FE+g==
X-Gm-Message-State: APjAAAXXnmk7p5lZm58cyZj6k6hv6Vx7RNjrrfiqfM2yTRcR6jn+i1ZF
        OZTcZLrBS74x0YH0mruvvpo0hQ==
X-Google-Smtp-Source: APXvYqyFUdlctc8HdWsYt+J1cb0djjlngW+/MYywRZ0lxsUs4EclvkHMtVtNDgPg8MnKDJqz9Fa6/w==
X-Received: by 2002:a25:d1d5:: with SMTP id i204mr31442488ybg.292.1560152324219;
        Mon, 10 Jun 2019 00:38:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 207sm2821824ywo.98.2019.06.10.00.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 00:38:43 -0700 (PDT)
Date:   Mon, 10 Jun 2019 15:38:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] perf trace: Exit when build eBPF program failure
Message-ID: <20190610073825.GB6140@leoy-ThinkPad-X240s>
References: <20190606094845.4800-1-leo.yan@linaro.org>
 <20190606094845.4800-2-leo.yan@linaro.org>
 <20190606133019.GA30166@kernel.org>
 <20190606133424.GB30166@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606133424.GB30166@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:34:24AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 06, 2019 at 10:30:19AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jun 06, 2019 at 05:48:42PM +0800, Leo Yan escreveu:
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -3664,6 +3664,14 @@ static int trace__config(const char *var, const char *value, void *arg)
> > >  					       "event selector. use 'perf list' to list available events",
> > >  					       parse_events_option);
> > >  		err = parse_events_option(&o, value, 0);
> > > +
> > > +		/*
> > > +		 * When parse option successfully parse_events_option() will
> > > +		 * return 0, otherwise means the paring failure.  And it
> > > +		 * returns 1 for eBPF program building failure; so adjust the
> > > +		 * err value to -1 for the failure.
> > > +		 */
> > > +		err = err ? -1 : 0;
> > 
> > I'll rewrite the comment above to make it more succint and fix things
> > like 'paring' (parsing):
> > 
> > 		/*
> > 		 * parse_events_option() returns !0 to indicate failure
> > 		 * while the perf_config code that calls trace__config()
> > 		 * expects < 0 returns to indicate error, so:
> > 		 */
> > 
> > 		 if (err)
> > 		 	err = -1;
> 
> Even shorter, please let me know if I can keep your
> Signed-off-by/authorship for this one.

Sorry I miss this email.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f7e4e50bddbd..1a2a605cf068 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3703,7 +3703,12 @@ static int trace__config(const char *var, const char *value, void *arg)
>  		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
>  					       "event selector. use 'perf list' to list available events",
>  					       parse_events_option);
> -		err = parse_events_option(&o, value, 0);
> +		/*
> +		 * We can't propagate parse_event_option() return, as it is 1
> +		 * for failure while perf_config() expects -1.
> +		 */
> +		if (parse_events_option(&o, value, 0))
> +			err = -1;
>  	} else if (!strcmp(var, "trace.show_timestamp")) {
>  		trace->show_tstamp = perf_config_bool(var, value);
>  	} else if (!strcmp(var, "trace.show_duration")) {


Yeah, the change looks good to me. And very appreciate your effort to
improve the patch quality.

Thanks,
Leo.
