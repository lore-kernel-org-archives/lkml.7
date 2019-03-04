Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8014C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3520652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfCDNxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:53:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfCDNxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:53:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4DE983F51;
        Mon,  4 Mar 2019 13:53:17 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1AC92CFD6;
        Mon,  4 Mar 2019 13:53:15 +0000 (UTC)
Date:   Mon, 4 Mar 2019 14:53:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v5 perf,bpf 13/15] perf, bpf: process
 PERF_BPF_EVENT_PROG_LOAD for annotation
Message-ID: <20190304135315.GI19809@krava>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-14-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228050643.958685-14-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Mar 2019 13:53:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:06:41PM -0800, Song Liu wrote:
> This patch adds processing of PERF_BPF_EVENT_PROG_LOAD, which sets proper
> DSO type/id/etc of memory regions mapped to BPF programs to
> DSO_BINARY_TYPE__BPF_PROG_INFO
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/bpf-event.c | 53 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 370b830f2433..048ef00371ad 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -25,12 +25,65 @@ static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
>  	return ret;
>  }
>  
> +static int machine__process_bpf_event_load(struct machine *machine __maybe_unused,

machine is used 

jirka

> +					   union perf_event *event,
> +					   struct perf_sample *sample __maybe_unused)
> +{
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_info_node *info_node;
> +	struct perf_env *env = machine->env;
> +	int id = event->bpf_event.id;
> +	unsigned int i;
> +
> +	/* perf-record, no need to handle bpf-event */
> +	if (env == NULL)
> +		return 0;
> +
> +	info_node = perf_env__find_bpf_prog_info(env, id);
> +	if (!info_node)
> +		return 0;
> +	info_linear = info_node->info_linear;
> +
> +	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
> +		u64 *addrs = (u64 *)(info_linear->info.jited_ksyms);
> +		u64 addr = addrs[i];
> +		struct map *map;
> +
> +		map = map_groups__find(&machine->kmaps, addr);
> +
> +		if (map) {
> +			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
> +			map->dso->bpf_prog.id = id;
> +			map->dso->bpf_prog.sub_id = i;
> +			map->dso->bpf_prog.env = env;
> +		}
> +	}
> +	return 0;
> +}
> +
>  int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  			       union perf_event *event,
>  			       struct perf_sample *sample __maybe_unused)
>  {
>  	if (dump_trace)
>  		perf_event__fprintf_bpf_event(event, stdout);
> +
> +	switch (event->bpf_event.type) {
> +	case PERF_BPF_EVENT_PROG_LOAD:
> +		return machine__process_bpf_event_load(machine, event, sample);
> +
> +	case PERF_BPF_EVENT_PROG_UNLOAD:
> +		/*
> +		 * Do not free bpf_prog_info and btf of the program here,
> +		 * as annotation still need them. They will be freed at
> +		 * the end of the session.
> +		 */
> +		break;
> +	default:
> +		pr_debug("unexpected bpf_event type of %d\n",
> +			 event->bpf_event.type);
> +		break;
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
