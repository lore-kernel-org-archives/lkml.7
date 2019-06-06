Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56CAC28D1A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CD820673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFFHZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:25:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfFFHZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46381330247;
        Thu,  6 Jun 2019 07:25:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0EA3A579A7;
        Thu,  6 Jun 2019 07:25:16 +0000 (UTC)
Date:   Thu, 6 Jun 2019 09:25:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20190606072516.GA28792@krava>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 06 Jun 2019 07:25:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 02:29:22PM +0100, ufo19890607 wrote:
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

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


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
> +
> +--user-callchains::
> +Collect callchains from user space.
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
> 
