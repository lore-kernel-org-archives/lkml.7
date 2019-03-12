Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD75C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D882B214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCLKa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:30:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLKaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:30:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CE8C30833C2;
        Tue, 12 Mar 2019 10:30:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id E89F15D70E;
        Tue, 12 Mar 2019 10:30:23 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:30:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 04/10] perf, tools, record: Clarify help for
 --switch-output
Message-ID: <20190312103022.GA13071@krava>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-5-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311202446.10210-5-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 12 Mar 2019 10:30:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:24:40PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The help description for --switch-output looks like there
> are multiple comma separated fields. But it's actually a choice
> of different options. Make it clear and less confusing.
> 
> Before:
> 
> % perf report -h

s/report/record/


> ...
>         --switch-output[=<signal,size,time>]
>                           Switch output when receive SIGUSR2 or cross size,time threshold
> 
> After:
> 
> % perf report -h

ditto

jirka

> ...
> 
>         --switch-output[=<signal or size[BKMG] or time[smhd]>]
>                           Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 02d7c40b2d10..e7144a1c1c82 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1989,8 +1989,8 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
>  		    "Record timestamp boundary (time of first/last samples)"),
>  	OPT_STRING_OPTARG_SET(0, "switch-output", &record.switch_output.str,
> -			  &record.switch_output.set, "signal,size,time",
> -			  "Switch output when receive SIGUSR2 or cross size,time threshold",
> +			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
> +			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
>  			  "signal"),
>  	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
>  		   "Limit number of switch output generated files"),
> -- 
> 2.20.1
> 
