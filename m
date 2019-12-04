Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5EFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC03F2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575426601;
	bh=LFLa7LXATFqm4FwnTSkWP+G8kfSJa+rUzWTwZVV5nOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SyoD4SUL+ot21LLTA+YOEYNPJb8wvL5q5+G9UihG9haP03AFWpEVvgAAKDML8Bt3l
	 8kCIWyhotSKpLZSnAsTCcbGe87z/EPRFgRHka5q70rieb8uk+dmw3vwHMOheU/jUh9
	 U3yCQsaLqr1Hdzv5b2ZHX8Ya5n1wfbQJjfEm2y1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLDCaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLDC37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:29:59 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A668A2068E;
        Wed,  4 Dec 2019 02:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575426599;
        bh=LFLa7LXATFqm4FwnTSkWP+G8kfSJa+rUzWTwZVV5nOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R+YxnsXoS/HkZ0FByatns65KPfKH6w5CznCxFTck9jmaCre014TeLDw+GUL1pDSCn
         wtXE7htGIVw7kxjn4QpTjc87CEuvhbhwCWr9UvU92TDUvLmoJQ27wUNp/AabLPmSGx
         yidQuQJLa5gFSosC3vjjwZcjlYqOsrtG3Zclu4NA=
Date:   Wed, 4 Dec 2019 11:29:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf probe: Fix to delete multiple probe event
Message-Id: <20191204112952.7b7d61feb2b14173ae625378@kernel.org>
In-Reply-To: <157536011452.29277.3647564438675346431.stgit@devnote2>
References: <157536011452.29277.3647564438675346431.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 17:01:54 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix to delete multiple probe event with filter correctly.
> 
> When we put an event with multiple probes, perf-probe fails
> to delete with filters. This comes from a failure to list
> up the event name because of overwrapping its name.
> 
> To fix this issue, skip to list up the event which has
> same name.
> 
> Without this patch:
>   # perf probe -l \*
>     probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:21@
>     probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:25@
>     probe_perf:map__map_ip (on append_inlines:12@util/machine.c in
>     probe_perf:map__map_ip (on unwind_entry:19@util/machine.c in /
>     probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
>     probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
>   # perf probe -d \*
>   "*" does not hit any event.
>     Error: Failed to delete events. Reason: No such file or directory (Code: -2)
> 
> With this:
>   # perf probe -d \*
>   Removed event: probe_perf:map__map_ip
> 

Oops, I missed Fixed tag.

Fixes: 72363540c009 ("perf probe: Support multiprobe event")

Thanks,

> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-file.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 5003ba403345..c03a591d41a4 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -206,6 +206,9 @@ static struct strlist *__probe_file__get_namelist(int fd, bool include_group)
>  		} else
>  			ret = strlist__add(sl, tev.event);
>  		clear_probe_trace_event(&tev);
> +		/* Skip if there is same name multi-probe event in the list */
> +		if (ret == -EEXIST)
> +			ret = 0;
>  		if (ret < 0)
>  			break;
>  	}
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
