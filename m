Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D61C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BA4206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCLLNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLLNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:13:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F92B59458;
        Tue, 12 Mar 2019 11:13:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 246C41973B;
        Tue, 12 Mar 2019 11:13:42 +0000 (UTC)
Date:   Tue, 12 Mar 2019 12:13:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] perf, tools, report: Pass on -f to child perf script
Message-ID: <20190312111341.GB24700@krava>
References: <20190312035224.30350-1-andi@firstfloor.org>
 <20190312035224.30350-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312035224.30350-3-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 12 Mar 2019 11:13:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 08:52:23PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Pass on -f to the child perf script, so that it can read the perf.data
> file if it's owned by a different user.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/ui/browsers/res_sample.c | 3 ++-
>  tools/perf/ui/browsers/scripts.c    | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
> index c450a3536f10..6e17e11a2ab9 100644
> --- a/tools/perf/ui/browsers/res_sample.c
> +++ b/tools/perf/ui/browsers/res_sample.c
> @@ -70,7 +70,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>  
>  	attr_to_script(extra_format, &evsel->attr);
>  
> -	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s %s %s %s | less +/%s",
> +	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s %s %s %s %s | less +/%s",
>  		     perf,
>  		     input_name ? "-i " : "",
>  		     input_name ? input_name : "",
> @@ -85,6 +85,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>  		     symbol_conf.inline_name ? "--inline" : "",
>  		     "--show-lost-events ",
>  		     r->tid ? "--show-switch-events --show-task-events " : "",
> +		     symbol_conf.force ? "-f" : "",
>  		     tsample) < 0)
>  		return -1;
>  	run_script(cmd);
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 27cf3ab88d13..f4c438dead66 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -171,12 +171,13 @@ int script_browse(const char *script_opt, struct perf_evsel *evsel)
>  	if (list_scripts(script_name, &custom, evsel))
>  		return -1;
>  
> -	if (asprintf(&cmd, "%s%s %s %s%s 2>&1 | less",
> +	if (asprintf(&cmd, "%s%s %s %s%s %s 2>&1 | less",
>  			custom ? "perf script -s " : "",
>  			script_name,
>  			script_opt ? script_opt : "",
>  			input_name ? "-i " : "",
> -			input_name ? input_name : "") < 0)
> +			input_name ? input_name : "",
> +			symbol_conf.force ? "-f " : "") < 0)
>  		return -1;
>  
>  	run_script(cmd);
> -- 
> 2.20.1
> 
