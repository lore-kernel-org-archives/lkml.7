Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2207FC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E024A20848
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKvJX8Fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgACIYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:24:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46364 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgACIYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:24:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id k8so43053569otl.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 00:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ok/DbFXVu8wcBRwH+beyd5PbGJNXRfNGB1s9COJzI9E=;
        b=wKvJX8Ferqck9I+7PoBaITCDwBkj7ryjyhQtBbibNQR7CfFkW7wfJtBy9XVltBaeG/
         h6uzxCerB4A4grZDAdlglceHzGArmkxIluH1hsdKETyorB8RBfWPqbwN+PDlO0DRWSbP
         U7yX0D7qGmRV1MTwQ2uBdmzT7Y8NOSexe6F+LrENvtdf81wvyT+l2ZNKIifw1+HOODVu
         JbKL+9pT8IixibifAjh6NTOhVk8mqz3+qAaHjYn/iBcHVXyblV8ctPmUdsbSaZ22oy26
         Qu7GY5v3Pqlia1jzV8W4xg750MX71FcUsEe9qGR4GhCsy9d4TKUVurN2eE+dWpouDhzt
         F7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ok/DbFXVu8wcBRwH+beyd5PbGJNXRfNGB1s9COJzI9E=;
        b=hvLsIWfEAvrMSDXQmm9ZXM31YVLXCSu/J1fxSWD0n+zAFFdEbVVNP88Bh8F34PYzaY
         //3M9bxYFQpKHiW5S2JOK6FkVGGcZqroTRJJzXz4LOF5cmlo7KlcgMZhbdrmZ7i4pYvC
         ppJOF46lPAB7YRccRpcglFEgDJTND7m5S1KXqATGLSFaUGuVP+BDHYGLVE2Qjo8oCnu8
         z40WfK3dUPNfCLekDZAcfvDp7saM31c4jReHgccsWrTy5r/vDOeX1YQDQPHDfoBkEwBD
         rZFxdB8B0RgTGpgsJ3SlEw1NYPCeUJL+wxIXji7mvu4SarySpuykQ/BW2xBsrinjh7Mk
         rWyQ==
X-Gm-Message-State: APjAAAUlbpzmlkBPMlgnekhzNSacnAWFLEI8brgJY1Z9A+eDnJyGTmzo
        sy2rBhaS6AkSehGk6ggQCYEe0g==
X-Google-Smtp-Source: APXvYqxuemnu0llRogokHXXjQJi+v9XwQzB0b8xkAyY83elisGn2yIB2n7L32ydeWU2kRNX80462SA==
X-Received: by 2002:a05:6830:159a:: with SMTP id i26mr98528670otr.3.1578039863198;
        Fri, 03 Jan 2020 00:24:23 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id 97sm20434990otx.29.2020.01.03.00.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 00:24:22 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:24:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, ilubashe@akamai.com,
        peterz@infradead.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com
Subject: Re: [RFC PATCH] perf tools: cs-etm: fix endless record after being
 terminated
Message-ID: <20200103082414.GB9814@leoy-ThinkPad-X240s>
References: <20200102074144.10407-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102074144.10407-1-liwei391@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Thu, Jan 02, 2020 at 03:41:44PM +0800, Wei Li wrote:
> In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
> be set and the event list will be disabled by evlist__disable() once.
> 
> While in auxtrace_record.read_finish(), the related events will be
> enabled again, if they are continuous, the recording seems to be endless.
> 
> If the cs_etm event is disabled, we don't enable it again here.
> 
> Note: This patch is NOT tested since i don't have such a machine with
> coresight feature, but the code seems buggy same as arm-spe and intel-pt.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index ede040cf82ad..1893a0e3b1e1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -865,9 +865,13 @@ static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
> -			return perf_evlist__enable_event_idx(ptr->evlist,
> -							     evsel, idx);
> +		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
> +			if (evsel->disabled)
> +				return 0;
> +			else
> +				return perf_evlist__enable_event_idx(
> +						ptr->evlist, evsel, idx);
> +		}
>  	}

I took some time to test on Arm CoreSight, the perf program can be
terminated by Ctrl+c with SIGINT signal on the mainline kernel.

And after capturing ftrace data with below log:

5242      migration/2-19    [002] d..3  4648.383155: sched_migrate_task: comm=perf pid=1692 prio=120 orig_cpu=2 dest_cpu=0
5243      migration/2-19    [002] d..2  4648.383167: sched_switch: prev_comm=migration/2 prev_pid=19 prev_prio=0 prev_state=S ==> next_comm=swapper/2 next_pid=0 next_prio=120
5244           <idle>-0     [000] d..2  4648.383167: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=1692 next_prio=120
5245             perf-1692  [000] d..2  4648.383193: sched_stat_runtime: comm=perf pid=1692 runtime=35420 [ns] vruntime=1636633943 [ns]
5246             perf-1692  [000] d..3  4648.383200: sched_waking: comm=migration/0 pid=11 prio=0 target_cpu=000
5247             perf-1692  [000] dN.4  4648.383203: sched_wakeup: comm=migration/0 pid=11 prio=0 target_cpu=000
5248             perf-1692  [000] dN.2  4648.383205: sched_stat_runtime: comm=perf pid=1692 runtime=9340 [ns] vruntime=1636643283 [ns]
5249             perf-1692  [000] d..2  4648.383208: sched_switch: prev_comm=perf prev_pid=1692 prev_prio=120 prev_state=R+ ==> next_comm=migration/0 next_pid=11 next_prio=0
5250      migration/0-11    [000] d..3  4648.383215: sched_migrate_task: comm=perf pid=1692 prio=120 orig_cpu=0 dest_cpu=1
5251       algorithm1-721   [001] dN.2  4648.383225: sched_stat_runtime: comm=algorithm1 pid=721 runtime=2906000 [ns] vruntime=3501282256244 [ns]
5252       algorithm1-721   [001] d..2  4648.383229: sched_switch: prev_comm=algorithm1 prev_pid=721 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=1692 next_prio=120
5253      migration/0-11    [000] d..2  4648.383235: sched_switch: prev_comm=migration/0 prev_pid=11 prev_prio=0 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
5254       algorithm1-721   [001] d..4  4648.383241: <stack trace>
5255  => kprobe_breakpoint_handler
5256  => call_break_hook
5257  => brk_handler
5258  => do_debug_exception
5259  => el1_sync_handler
5260  => el1_sync
5261  => etm_event_stop
5262  => event_sched_out.isra.106
5263  => group_sched_out.part.108
5264  => ctx_sched_out
5265  => task_ctx_sched_out
5266  => __perf_event_task_sched_out
5267  => __schedule
5268  => schedule
5269  => do_notify_resume
5270  => work_pending

We can see after send SIGINT signal, the process 'perf' will be
migrated from CPU2 to CPU0 (line 5242) and it will preempt process
'algorithm1' (line 5252); after the process 'algorithm1' is scheduled
out, the function etm_event_stop() will be invoked to stop tracing.

If we connect with the code in cs_etm_read_finish(), it tries to call
ioctl PERF_EVENT_IOC_ENABLE, but because the process 'algorithm1' is
scheduled out, so the perf event should not be enabled afterwards.

I may miss something at here ... Could you confirm what's the type of
attached process?  normal process or RT process?

Thanks,
Leo

P.s. I tested IntelPT with 5.2-rc3 kernel, it also can be terminated
properly.

>  	return -EINVAL;
> -- 
> 2.17.1
> 
