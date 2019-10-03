Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC815C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908DE218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfJCKS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbfJCKS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:18:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92A753098215;
        Thu,  3 Oct 2019 10:18:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 719C4608C2;
        Thu,  3 Oct 2019 10:18:28 +0000 (UTC)
Date:   Thu, 3 Oct 2019 12:18:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf script: Allow --time with --reltime
Message-ID: <20191003101827.GA23291@krava>
References: <20191002164642.1719-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002164642.1719-1-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 03 Oct 2019 10:18:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 09:46:42AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The original --reltime patch forbid --time with --reltime.
> 
> But it turns out --time doesn't really care about --reltime, because
> the relative time is only used at final output, while
> the time filtering always works earlier on absolute time.
> 
> So just remove the check and allow combining the two options.
> 
> Fixes: 90b10f47c0ee ("perf script: Support relative time")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-script.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 32b17d51c982..7481003b2761 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3601,11 +3601,6 @@ int cmd_script(int argc, const char **argv)
>  		}
>  	}
>  
> -	if (script.time_str && reltime) {
> -		fprintf(stderr, "Don't combine --reltime with --time\n");
> -		return -1;
> -	}
> -
>  	if (itrace_synth_opts.callchain &&
>  	    itrace_synth_opts.callchain_sz > scripting_max_stack)
>  		scripting_max_stack = itrace_synth_opts.callchain_sz;
> -- 
> 2.21.0
> 
