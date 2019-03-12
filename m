Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C533EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A0C206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfCLLO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:14:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfCLLO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:14:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 269733680A;
        Tue, 12 Mar 2019 11:14:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id C1B705D71A;
        Tue, 12 Mar 2019 11:14:25 +0000 (UTC)
Date:   Tue, 12 Mar 2019 12:14:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3] perf, tools, report: Handle samples without time
Message-ID: <20190312111424.GC24700@krava>
References: <20190312035224.30350-1-andi@firstfloor.org>
 <20190312035224.30350-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312035224.30350-2-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 12 Mar 2019 11:14:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 08:52:22PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When a sample doesn't have a time stamp (e.g. from --no-time),
> show the beginning of the trace for res samples instead of generating
> an impossible time range that errors out.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/ui/browsers/res_sample.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
> index c0dd73176d42..c450a3536f10 100644
> --- a/tools/perf/ui/browsers/res_sample.c
> +++ b/tools/perf/ui/browsers/res_sample.c
> @@ -60,7 +60,9 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>  		return -1;
>  	r = &res_samples[choice];
>  
> -	n = timestamp__scnprintf_nsec(r->time - context_len, trange, sizeof trange);
> +	n = timestamp__scnprintf_nsec(r->time > context_len ?
> +				      r->time - context_len : r->time,
> +				      trange, sizeof trange);
>  	trange[n++] = ',';
>  	timestamp__scnprintf_nsec(r->time + context_len, trange + n, sizeof trange - n);
>  
> -- 
> 2.20.1
> 
