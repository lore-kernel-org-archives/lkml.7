Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E975AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98B120657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392943AbfHBNGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388240AbfHBNGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:06:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A2603082E20;
        Fri,  2 Aug 2019 13:06:10 +0000 (UTC)
Received: from krava (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id D4E1160BF4;
        Fri,  2 Aug 2019 13:06:07 +0000 (UTC)
Date:   Fri, 2 Aug 2019 15:06:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     zhe.he@windriver.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        kan.liang@linux.intel.com, eranian@google.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: Fix failure to set cpumask when only one cpu
Message-ID: <20190802130607.GA27223@krava>
References: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 02 Aug 2019 13:06:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 04:29:51PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> The buffer containing string used to set cpumask is overwritten by end of
> string later in cpu_map__snprint_mask due to not enough memory space, when
> there is only one cpu. And thus causes the following failure.
> 
> $ perf ftrace ls
> failed to reset ftrace
> 
> This patch fixes the calculation of cpumask string size.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 66d5a66..0193128 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -173,7 +173,7 @@ static int set_tracing_cpumask(struct cpu_map *cpumap)
>  	int last_cpu;
>  
>  	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
> -	mask_size = (last_cpu + 3) / 4 + 1;
> +	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
>  	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */

ugh..  why do we care about last_cpu value in here at all?

feels like using static buffer would be more reasonable

jirka

>  
>  	cpumask = malloc(mask_size);
> -- 
> 2.7.4
> 
