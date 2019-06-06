Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFFCC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBAE20673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVapb+43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfFFO0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:26:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35708 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfFFO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:26:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so1574658qke.2;
        Thu, 06 Jun 2019 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EL6fST0IEpAe23eXRoL7mRwGg6/fGrUhHmYwHhthu0A=;
        b=UVapb+43wGvvCsc+kG4MG5kvonn8uO8rWUpbPmU6fIjW2vSoOgb0J5h7znCgcwDsv5
         UHS9vO28OYZV2cr9XhX1GGACiFq7Owue+3Btmm6YLVSvDzEpinA+v3M6zdjg9ZEupcgu
         9YAE6o9NvWi7+CHQpjyzyGazp+dcKfytut55QLNQpuIOcsq03ShbOgCrjO2FTTgURpMj
         hfgN2zC0AUWR3UvQ9qdrhvbpwXEcdW7Y44ZSHl9uwYJh+dUJpGd1H8+P8kJEXcBzL4r5
         PUwL7hzyHCq7QGF13TvXgaMgZpXMDfuARYo9s3z/PaVPNmekOuULwLgEoG2AsaKx2oqf
         LY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EL6fST0IEpAe23eXRoL7mRwGg6/fGrUhHmYwHhthu0A=;
        b=QRYb4ta2/GW35wtPhmf2ar61FCFuivQPvrxmeZ8oToItZ3yVjmmMHhFiAeHnL7KmgI
         dETerjmxpB3cSupGDZ3sI8V2E8RZa9iBysG63gsVimwSfiv/3fnf8TBywCTLaRLya4di
         nOzkrYQMWYW/mGgZaFFfWa2KgxxAfIY7giSKyAONyidyphjtdTriQsfCSizDDzHyKHvI
         mILYHAcNdVCkVG9gTEj71RmZDbx7LNLV5Tl50JCPeieuWJmzhdPaxB/ifGioJZEXnOQB
         H+CJYfle5PfAZZGGvzT5cHnOXMejI0rmwXgwhsNrXKvCElA7uuyPA4AFuzU12lv+BkOs
         mAGw==
X-Gm-Message-State: APjAAAX1AJCW9O17Lg/mt/b7e8nMALH4IjAcGMQ0WAccKvBiDpm80KR0
        b2r6heW8NTDV27yzov+5q2w=
X-Google-Smtp-Source: APXvYqxHO5HmDbCJvO4EJIBAH9+TzwduXojXt1Wznd7ngmH0tFUkeQTP+EroYO8ELjc4Pwc+yx2MaA==
X-Received: by 2002:a37:634f:: with SMTP id x76mr37966820qkb.205.1559831210047;
        Thu, 06 Jun 2019 07:26:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.208.82])
        by smtp.gmail.com with ESMTPSA id p62sm902920qkc.42.2019.06.06.07.26.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 07:26:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96BEA41149; Thu,  6 Jun 2019 11:26:44 -0300 (-03)
Date:   Thu, 6 Jun 2019 11:26:44 -0300
To:     ufo19890607 <ufo19890607@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com,
        arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com,
        adrian.hunter@intel.com, wangnan0@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
Message-ID: <20190606142644.GA21245@kernel.org>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 30, 2019 at 02:29:22PM +0100, ufo19890607 escreveu:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> One can just record callchains in the kernel or user space with
> this new options. We can use it together with "--all-kernel" options.
> This two options is used just like print_stack(sys) or print_ustack(usr)
> for systemtap.
> 
> Show below is the usage of this new option combined with "--all-kernel"
> options.
> 	1. Configure all used events to run in kernel space and just
> collect kernel callchains.
> 	$ perf record -a -g --all-kernel --kernel-callchains
> 	2. Configure all used events to run in kernel space and just
> collect user callchains.
> 	$ perf record -a -g --all-kernel --user-callchains
> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 6 ++++++
>  tools/perf/builtin-record.c              | 4 ++++
>  tools/perf/perf.h                        | 2 ++
>  tools/perf/util/evsel.c                  | 4 ++++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index de269430720a..b647eb3db0c6 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -490,6 +490,12 @@ Configure all used events to run in kernel space.
>  --all-user::
>  Configure all used events to run in user space.
>  
> +--kernel-callchains::
> +Collect callchains from kernel space.

Ok, changing this to:

Collect callchains only from kernel space. I.e. this option sets
perf_event_attr.exclude_callchain_user to 1,
perf_event_attr.exclude_callchain_kernel to 0.

> +
> +--user-callchains::
> +Collect callchains from user space.

And this one to:
Collect callchains only from user space. I.e. this option sets

perf_event_attr.exclude_callchain_kernel to 1,
perf_event_attr.exclude_callchain_user to 0.


So that the user don't try using:

    pref record --user-callchains --kernel-callchains

expecting to get both user and kernel callchains and instead gets
nothing.

Ok?

- Arnaldo

> +
>  --timestamp-filename
>  Append timestamp to output file name.
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e2c3a585a61e..dca55997934e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2191,6 +2191,10 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN_FLAG(0, "all-user", &record.opts.all_user,
>  			 "Configure all used events to run in user space.",
>  			 PARSE_OPT_EXCLUSIVE),
> +	OPT_BOOLEAN(0, "kernel-callchains", &record.opts.kernel_callchains,
> +		    "collect kernel callchains"),
> +	OPT_BOOLEAN(0, "user-callchains", &record.opts.user_callchains,
> +		    "collect user callchains"),
>  	OPT_STRING(0, "clang-path", &llvm_param.clang_path, "clang path",
>  		   "clang binary to use for compiling BPF scriptlets"),
>  	OPT_STRING(0, "clang-opt", &llvm_param.clang_opt, "clang options",
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index d59dee61b64d..711e009381ec 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -61,6 +61,8 @@ struct record_opts {
>  	bool	     record_switch_events;
>  	bool	     all_kernel;
>  	bool	     all_user;
> +	bool	     kernel_callchains;
> +	bool	     user_callchains;
>  	bool	     tail_synthesize;
>  	bool	     overwrite;
>  	bool	     ignore_missing_thread;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a6f572a40deb..a606b2833e27 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -680,6 +680,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>  
>  	attr->sample_max_stack = param->max_stack;
>  
> +	if (opts->kernel_callchains)
> +		attr->exclude_callchain_user = 1;
> +	if (opts->user_callchains)
> +		attr->exclude_callchain_kernel = 1;
>  	if (param->record_mode == CALLCHAIN_LBR) {
>  		if (!opts->branch_stack) {
>  			if (attr->exclude_user) {
> -- 
> 2.14.1

-- 

- Arnaldo
