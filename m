Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C333C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D978D213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfETG7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfETG7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:59:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48212356CA;
        Mon, 20 May 2019 06:59:12 +0000 (UTC)
Received: from krava (ovpn-204-182.brq.redhat.com [10.40.204.182])
        by smtp.corp.redhat.com (Postfix) with SMTP id EFBBF2B5A1;
        Mon, 20 May 2019 06:59:07 +0000 (UTC)
Date:   Mon, 20 May 2019 08:59:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [Patch] perf stat: always separate stalled cycles per insn
Message-ID: <20190520065906.GC8068@krava>
References: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 20 May 2019 06:59:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 03:10:39PM -0700, Cong Wang wrote:
> The "stalled cycles per insn" is appended to "instructions" when
> the CPU has this hardware counter directly. We should always make it
> a separate line, which also aligns to the output when we hit the
> "if (total && avg)" branch.
> 
> Before:
> $ sudo perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
> 4565048704,,instructions,64114578096,100.00,1.34,insn per cycle,,
> 3396325133,,cycles,64146628546,100.00,,
> 
> After:
> $ sudo ./tools/perf/perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
> 6721924,,instructions,24026790339,100.00,0.22,insn per cycle
> ,,,,,0.00,stalled cycles per insn
> 30939953,,cycles,24025512526,100.00,,
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/stat-shadow.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 83d8094be4fe..5c5e012e99c4 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -800,7 +800,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  					"stalled cycles per insn",
>  					ratio);
>  		} else if (have_frontend_stalled) {
> -			print_metric(config, ctxp, NULL, NULL,
> +			out->new_line(config, ctxp);
> +			print_metric(config, ctxp, NULL, "%7.2f ",
>  				     "stalled cycles per insn", 0);
>  		}
>  	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
> -- 
> 2.21.0
> 
