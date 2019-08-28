Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE65C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D373F22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRrIlcrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfH1NJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:09:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41847 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfH1NJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:09:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id g17so2286274qkk.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bwuEgAE2RupXoQeOwdm0bnhsR6637Jokup42rsGe8NM=;
        b=TRrIlcrlhCOoJYyBAoYqN7DW3d/ENCn39Bwt+SkwD16DhzGbKTJntaSmwZxTU6vLBG
         HjqHEiD3EEHzuIFHWR1GRYSEk6fhtCr2XPSW+1MKqsuqH8WJAmps2rIiFl9Cga0b5XU3
         vGBfF612t3uxVPcM9seCtxrOu1FzjLktCgXKm3EuB+gnBkH2JrP54ZqEAliECTS7XuIJ
         QL0G4C9YZRUrfveq2aueqmXAY8L7GspRiEXR6rl0/edJg0mbsHwOTrsHdEizkMh5Z7J8
         OPMp+Jzc7uo49t5WYOznRkJnxZHH6oHgXcC4hCmFQVdMn47IYcj/Jd0WwYw1wskb6hNw
         H+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwuEgAE2RupXoQeOwdm0bnhsR6637Jokup42rsGe8NM=;
        b=UIpGcV29zotQNG2zYtia4NJc6AnZJzyRjDfcveCQEE4vVl2lFDaaHJpAh6nljfwDQv
         6FGe98xMwQmhugqJGlrrqiHC/iDkO9g7oAAGr3JOyn3AsCOC3StmZn/y4wt5K+UId2o8
         qnAabFbMuzc8bgGulWsA4qFioq9NQ10FKrbwF2zKx8NwVBEAe8T/FEC/xJkJQFmKYr03
         9CpPHiOKJtenYN1upq52lejTsM4Mm42SU3pUhXo+jbOE2lPZfg+J73CuZUJjgMsJ7+zD
         nflnbGpHz4lYMetVdPz4DY0jl6Hqx2S3/TbjgwwVX23SdP13BDRWc5iaUvMAn4Y1nWQj
         DK8A==
X-Gm-Message-State: APjAAAWoF4GvKooSZg6CdV3cecFLnHID6F0BPJLySLGxtYhxUUo/ttFP
        Dy+UfcNCQojVweMfST3oxKs=
X-Google-Smtp-Source: APXvYqwiSwwj3uBq7aUx1P3/MdoBghYcg6O1hVA4yz7NhLEpy28e3Wdqvdt5D2exgUafUjbLr6kS4g==
X-Received: by 2002:a37:4a88:: with SMTP id x130mr3791678qka.501.1566997762092;
        Wed, 28 Aug 2019 06:09:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q16sm610180qkj.125.2019.08.28.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:09:21 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 999F140916; Wed, 28 Aug 2019 09:49:49 -0300 (-03)
Date:   Wed, 28 Aug 2019 09:49:49 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf top: Decay all events in the evlist
Message-ID: <20190828124949.GA14025@kernel.org>
References: <20190827231555.121411-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827231555.121411-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 28, 2019 at 08:15:54AM +0900, Namhyung Kim escreveu:
> Currently perf top only decays entries in a selected evsel.  I don't
> know whether it's intended (maybe due to performance reason?) but
> anyway it might show incorrect output when event group is used since
> users will see leader event is decayed but others are not.
> 
> This patch moves the decay code into evlist__resort_hists() so that
> stdio and tui code shared the logic.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-top.c | 38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 5970723cd55a..9d3059d2029d 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -264,13 +264,23 @@ static void perf_top__show_details(struct perf_top *top)
>  	pthread_mutex_unlock(&notes->lock);
>  }
>  
> -static void evlist__resort_hists(struct evlist *evlist)
> +static void evlist__resort_hists(struct perf_top *t)

Since this now operates on the perf_top struct, I'll rename it to
perf_top__resort_hists(), ok? No need to send an updated patch.

- Arnaldo

>  {
> +	struct evlist *evlist = t->evlist;
>  	struct evsel *pos;
>  
>  	evlist__for_each_entry(evlist, pos) {
>  		struct hists *hists = evsel__hists(pos);
>  
> +		if (evlist->enabled) {
> +			if (t->zero) {
> +				hists__delete_entries(hists);
> +			} else {
> +				hists__decay_entries(hists, t->hide_user_symbols,
> +						     t->hide_kernel_symbols);
> +			}
> +		}
> +
>  		hists__collapse_resort(hists, NULL);
>  
>  		/* Non-group events are considered as leader */
> @@ -319,16 +329,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
>  		return;
>  	}
>  
> -	if (top->evlist->enabled) {
> -		if (top->zero) {
> -			hists__delete_entries(hists);
> -		} else {
> -			hists__decay_entries(hists, top->hide_user_symbols,
> -					     top->hide_kernel_symbols);
> -		}
> -	}
> -
> -	evlist__resort_hists(top->evlist);
> +	evlist__resort_hists(top);
>  
>  	hists__output_recalc_col_len(hists, top->print_entries - printed);
>  	putchar('\n');
> @@ -576,24 +577,11 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
>  static void perf_top__sort_new_samples(void *arg)
>  {
>  	struct perf_top *t = arg;
> -	struct evsel *evsel = t->sym_evsel;
> -	struct hists *hists;
>  
>  	if (t->evlist->selected != NULL)
>  		t->sym_evsel = t->evlist->selected;
>  
> -	hists = evsel__hists(evsel);
> -
> -	if (t->evlist->enabled) {
> -		if (t->zero) {
> -			hists__delete_entries(hists);
> -		} else {
> -			hists__decay_entries(hists, t->hide_user_symbols,
> -					     t->hide_kernel_symbols);
> -		}
> -	}
> -
> -	evlist__resort_hists(t->evlist);
> +	evlist__resort_hists(t);
>  
>  	if (t->lost || t->drop)
>  		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
> -- 
> 2.23.0.187.g17f5b7556c-goog

-- 

- Arnaldo
