Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F071C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3844208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436740AbfITTM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:12:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406909AbfITTM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88181307D84D;
        Fri, 20 Sep 2019 19:12:26 +0000 (UTC)
Received: from krava (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 66C915D9C3;
        Fri, 20 Sep 2019 19:12:24 +0000 (UTC)
Date:   Fri, 20 Sep 2019 21:12:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        acme@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH] perf record: fix priv level with branch sampling for
 paranoid=2
Message-ID: <20190920191223.GC26850@krava>
References: <20190904062603.90165-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904062603.90165-1-eranian@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 20 Sep 2019 19:12:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 11:26:03PM -0700, Stephane Eranian wrote:
> Now that the default perf_events paranoid level is set to 2, a regular user
> cannot monitor kernel level activity anymore. As such, with the following
> cmdline:
> 
> $ perf record -e cycles date
> 
> The perf tool first tries cycles:uk but then falls back to cycles:u
> as can be seen in the perf report --header-only output:
> 
>   cmdline : /export/hda3/tmp/perf.tip record -e cycles ls
>   event : name = cycles:u, , id = { 436186, ... }
> 
> This is okay as long as there is way to learn the priv level was changed
> internally by the tool.
> 
> But consider a similar example:
> 
> $ perf record -b -e cycles date
> Error:
> You may not have permission to collect stats.
> 
> Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> which controls use of the performance events system by
> unprivileged users (without CAP_SYS_ADMIN).
> ...
> 
> Why is that treated differently given that the branch sampling inherits the
> priv level of the first event in this case, i.e., cycles:u? It turns out
> that the branch sampling code is more picky and also checks exclude_hv.
> 
> In the fallback path, perf record is setting exclude_kernel = 1, but it
> does not change exclude_hv. This does not seem to match the restriction
> imposed by paranoid = 2.
> 
> This patch fixes the problem by forcing exclude_hv = 1 in the fallback
> for paranoid=2. With this in place:
> 
> $ perf record -b -e cycles date
>   cmdline : /export/hda3/tmp/perf.tip record -b -e cycles ls
>   event : name = cycles:u, , id = { 436847, ... }
> 
> And the command succeeds as expected.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/util/evsel.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 85825384f9e8..3cbe06fdf7f7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2811,9 +2811,11 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>  		if (evsel->name)
>  			free(evsel->name);
>  		evsel->name = new_name;
> -		scnprintf(msg, msgsize,
> -"kernel.perf_event_paranoid=%d, trying to fall back to excluding kernel samples", paranoid);
> +		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
> +			  "to fall back to excluding kernel and hypervisor "
> +			  " samples", paranoid);

extra space in here        ^

	Warning:
	kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples

other than that it looks good to me

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
