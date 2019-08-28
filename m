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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B016C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F622080F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXaGW+X7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH1Ogu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:36:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43143 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1Ogt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:36:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so2554876qkd.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xxyX7yo6+G5f+AD74LDRbZQzzfxZUSub40LXVwYiYiM=;
        b=IXaGW+X70ao+FP6Dd4hPep02hqYQXTePMc4Jw6Qa1miNNflYdPY+Z5GcLypHShipLy
         LpDPCP/oUmJXmPl8Fj57Ee11jAcwOlPkX9ezuTmn4cvM5cJYuXLahstDcD5VJHQpxbU9
         ZM2+2buFosn+G2NO37447JFQxGIimtFVAfIN99AEzjd4UleTNAwBU+dSL1FcjCPyBKvG
         vXzPYUtndPqCCL1PcuRyEM3udjTgc7P52miOIKsvyBmfVwaUze9VOdGNOVTBbLUWiW9P
         X201+8aEEsfAuqFZ7kfJ7rok0jrIjPahsVl+jj5zUaXGNCw6QaJZXc/+PlMg5TZHFmym
         DHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xxyX7yo6+G5f+AD74LDRbZQzzfxZUSub40LXVwYiYiM=;
        b=LZZ4aSBJzIycGi7fgKXAMQ2GoVgyPbGNKPdY0LkOiqPnSt7vTTHolcC+JQfkemjzu1
         KsX36NXmdBB4D69RlycEY9Shg6hDPY3Uszo21Nsi0p97D3zeSG3p1Hgjo2nXK0g7nmBU
         SI5fma4KAdpJyDiyH8ywCyiYGMyxYexUA0s1qnp650f0XLPPZ78JuNi3XGeQDbcedM/c
         CWfN40kn1ZFCsTHHVxgIyAkZydkxLR2qvcMA24fbibvzQDwxyg/WdIYeZfSDUcWrchRh
         l2IBLpQa9FlA0gv9s10tR5oGPasubuoOr0xW2/A7q4nAmUq8xgkvA1z4zE0uQOt0cFCP
         VRxw==
X-Gm-Message-State: APjAAAW2pp8zHONa3TAlL2ZB3MY79VUJF6OUGobut/j9fxSDAwPnBkYx
        ODrdxDgiBhvLLJwJs/8bIxJ0Pa5i
X-Google-Smtp-Source: APXvYqyUMFLS6rGQp7VmJgrtOhuj2y8My1rdYAf/BjFPRRa69PVjhMBj2pImYwvdHWNj/vlas7zNIg==
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr4291879qkm.30.1567003008383;
        Wed, 28 Aug 2019 07:36:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id a5sm1296232qkk.19.2019.08.28.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:36:47 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1359640916; Wed, 28 Aug 2019 11:36:45 -0300 (-03)
Date:   Wed, 28 Aug 2019 11:36:44 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/2] perf top: Fix event group with more than two events
Message-ID: <20190828143644.GC5632@kernel.org>
References: <20190827231555.121411-1-namhyung@kernel.org>
 <20190827231555.121411-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827231555.121411-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 28, 2019 at 08:15:55AM +0900, Namhyung Kim escreveu:
> The event group feature links relevant hist entries among events so
> that they can be displayed together.  During the link process, each
> hist entry in non-leader events is connected to a hist entry in the
> leader event.  This is done in order of events specified in the
> command line so it assumes that events are linked in the order.
> 
> But perf top can break the assumption since it does the link process
> multiple times.  For example, a hist entry can be in the third event
> only at first so it's linked after the leader.  Some time later,
> second event has a hist entry for it and it'll be linked after the
> entry of the third event.
> 
> This makes the code compilicated to deal with such unordered entries.
> This patch simply unlink all the entries after it's printed so that
> they can assume the correct order after the repeated link process.
> Also it'd be easy to deal with decaying old entries IMHO.

Excellent, I just tested it with:

# perf top --show-total-period -e '{cycles,instructions,cache-references,cache-misses}'

And the total period goes down for all evsels when that symbol is
quiescent between screen refreshes, and no crash, all seems to be
working as expected, thanks for fixing this!

Also when pressing 'A' the annotation also seems to be working.

All applied.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-top.c |  6 ++++++
>  tools/perf/util/hist.c   | 39 +++++++++++++++++++++------------------
>  tools/perf/util/hist.h   |  1 +
>  3 files changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 9d3059d2029d..b871dd72e4bd 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -272,6 +272,12 @@ static void evlist__resort_hists(struct perf_top *t)
>  	evlist__for_each_entry(evlist, pos) {
>  		struct hists *hists = evsel__hists(pos);
>  
> +		/*
> +		 * unlink existing entries so that they can be linked
> +		 * in a correct order in hists__match() below.
> +		 */
> +		hists__unlink(hists);
> +
>  		if (evlist->enabled) {
>  			if (t->zero) {
>  				hists__delete_entries(hists);
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 8efbf58dc3d0..47401210e087 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2436,7 +2436,7 @@ void hists__match(struct hists *leader, struct hists *other)
>  {
>  	struct rb_root_cached *root;
>  	struct rb_node *nd;
> -	struct hist_entry *pos, *pair, *pos_pair, *tmp_pair;
> +	struct hist_entry *pos, *pair;
>  
>  	if (symbol_conf.report_hierarchy) {
>  		/* hierarchy report always collapses entries */
> @@ -2453,24 +2453,8 @@ void hists__match(struct hists *leader, struct hists *other)
>  		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
>  		pair = hists__find_entry(other, pos);
>  
> -		if (pair && list_empty(&pair->pairs.node)) {
> -			list_for_each_entry_safe(pos_pair, tmp_pair, &pos->pairs.head, pairs.node) {
> -				if (pos_pair->hists == other) {
> -					/*
> -					 * XXX maybe decayed entries can appear
> -					 * here?  but then we would have use
> -					 * after free, as decayed entries are
> -					 * freed see hists__delete_entry
> -					 */
> -					BUG_ON(!pos_pair->dummy);
> -					list_del_init(&pos_pair->pairs.node);
> -					hist_entry__delete(pos_pair);
> -					break;
> -				}
> -			}
> -
> +		if (pair)
>  			hist_entry__add_pair(pair, pos);
> -		}
>  	}
>  }
>  
> @@ -2555,6 +2539,25 @@ int hists__link(struct hists *leader, struct hists *other)
>  	return 0;
>  }
>  
> +int hists__unlink(struct hists *hists)
> +{
> +	struct rb_root_cached *root;
> +	struct rb_node *nd;
> +	struct hist_entry *pos;
> +
> +	if (hists__has(hists, need_collapse))
> +		root = &hists->entries_collapsed;
> +	else
> +		root = hists->entries_in;
> +
> +	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
> +		pos = rb_entry(nd, struct hist_entry, rb_node_in);
> +		list_del_init(&pos->pairs.node);
> +	}
> +
> +	return 0;
> +}
> +
>  void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>  			  struct perf_sample *sample, bool nonany_branch_mode)
>  {
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 83d5fc15429c..7b9267ebebeb 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -217,6 +217,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *he);
>  
>  void hists__match(struct hists *leader, struct hists *other);
>  int hists__link(struct hists *leader, struct hists *other);
> +int hists__unlink(struct hists *hists);
>  
>  struct hists_evsel {
>  	struct evsel evsel;
> -- 
> 2.23.0.187.g17f5b7556c-goog

-- 

- Arnaldo
