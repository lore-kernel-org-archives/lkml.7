Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF77C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4122173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggAYI70V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfH3Mz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:55:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42917 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfH3Mz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:55:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id f13so5937976qkm.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3dHnzcoojoHzL2SWg/2B9OiF49QGCGHeU9XBtSpt1/g=;
        b=ggAYI70V+meKrKMVNIpbi4PgEiPiQAp8ouJOCDsG72QuGcauKW6Px/EF0qdLiJ71Xk
         lhkevxboE/Otvu+OGsy59LImCDeoGl/dNC+RtRN79H3OSKsOumg+oGA5EyA3zVqw8Crs
         EV3c+/0mbJfqd9CjwDPKxEsJHrYZjRWqx/xrp2Slaa7dQO4pdLoq3V7fiM6SmgrBAEwQ
         aOzk42Wuf7o+4dIG9TXvGWcm/KvvjYl3Kg5rhbKcRuxW7bBsAiOGGmvjLTK8uP7RXkHC
         oHTINx9zSSEIISmHVY4L4/koV3COePTzE9yEGoZXBQUhkf3i09nFSO2D6YHLGRJELIkF
         mJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3dHnzcoojoHzL2SWg/2B9OiF49QGCGHeU9XBtSpt1/g=;
        b=L0FMC8l/8DlFj8oaMjUP7NthHTnrjVtX6IRhpsFM40D0crndWr0bzeXVVg8rU6+7/J
         szgRHy7wKLpYdemH23Wsb9w3APPicS12+FZe86CTpO5sXwm2ycXQ9p/UG2IdMIhMjgnF
         jC01nygUe36Pf+TgEo8smbcQkbsrZ/LH6qab+68tTUG0JuhZIMKORJq5q76yZbSefsPT
         3+JzwNhKXsf9HKw/1/bZ8IiUFRno85M8HworSsC4OOq92nRv9uq7zuYiCIRcLyOWDgb1
         37thpTfQi3zZwkUxmWlgcqie9+nyFn36CmKuoG9eieUdtA/d/Ksn5YDE+wZvx9STtg02
         2tXQ==
X-Gm-Message-State: APjAAAUuxKXLLFNNOQurB1qLbWbVR/WGvQmrslRHlXs0hf95HWH/Z3Df
        lIhrgzCC072QVNu/CB/8O34=
X-Google-Smtp-Source: APXvYqyKXW9NvVbjRcIwhupnN+q1nUEntqL6WpurtqcX9LJJdYOXlPCmudVOIgiJwoQMFc1SmUv7yQ==
X-Received: by 2002:a37:4042:: with SMTP id n63mr13710206qka.428.1567169727123;
        Fri, 30 Aug 2019 05:55:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id v26sm2786319qkj.96.2019.08.30.05.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 05:55:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 129EB41146; Fri, 30 Aug 2019 09:55:24 -0300 (-03)
Date:   Fri, 30 Aug 2019 09:55:24 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/9] perf tools: Basic support for CGROUP event
Message-ID: <20190830125524.GA4082@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828073130.83800-4-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 28, 2019 at 04:31:24PM +0900, Namhyung Kim escreveu:
> Implement basic functionality to support cgroup tracking.  Each cgroup
> can be identified by inode number which can be read from userspace
> too.  The actual cgroup processing will come in the later patch.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/include/uapi/linux/perf_event.h | 17 +++++++++++++++--

Try to have the synchronization of tools/include/ with the kernel to be
done in a separate patch, please, there is a number of projects such as
libbpf and in time libperf that will have a mirror repo outside the
kernel tree and that will get just the needed csets.

- Arnaldo

>  tools/perf/builtin-diff.c             |  1 +
>  tools/perf/builtin-report.c           |  1 +
>  tools/perf/lib/include/perf/event.h   |  7 +++++++
>  tools/perf/util/event.c               | 18 ++++++++++++++++++
>  tools/perf/util/event.h               |  7 +++++++
>  tools/perf/util/evsel.c               |  7 +++++++
>  tools/perf/util/machine.c             | 12 ++++++++++++
>  tools/perf/util/machine.h             |  3 +++
>  tools/perf/util/session.c             |  4 ++++
>  tools/perf/util/tool.h                |  1 +
>  11 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index bb7b271397a6..91a552bf9611 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -141,8 +141,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_TRANSACTION			= 1U << 17,
>  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> +	PERF_SAMPLE_CGROUP			= 1U << 20,
>  
> -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -375,7 +376,8 @@ struct perf_event_attr {
>  				ksymbol        :  1, /* include ksymbol events */
>  				bpf_event      :  1, /* include bpf events */
>  				aux_output     :  1, /* generate AUX records instead of events */
> -				__reserved_1   : 32;
> +				cgroup         :  1, /* include cgroup events */
> +				__reserved_1   : 31;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */
> @@ -1000,6 +1002,17 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_BPF_EVENT			= 18,
>  
> +	/*
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u64				ino;
> +	 *	u64				path_len;
> +	 *	char				path[];
> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_CGROUP			= 19,
> +
>  	PERF_RECORD_MAX,			/* non-ABI */
>  };
>  
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 51c37e53b3d8..ec639340bb65 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -445,6 +445,7 @@ static struct perf_diff pdiff = {
>  		.fork	= perf_event__process_fork,
>  		.lost	= perf_event__process_lost,
>  		.namespaces = perf_event__process_namespaces,
> +		.cgroup = perf_event__process_cgroup,
>  		.ordered_events = true,
>  		.ordering_requires_timestamps = true,
>  	},
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 318b0b95c14c..c65a59fd2a94 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1033,6 +1033,7 @@ int cmd_report(int argc, const char **argv)
>  			.mmap2		 = perf_event__process_mmap2,
>  			.comm		 = perf_event__process_comm,
>  			.namespaces	 = perf_event__process_namespaces,
> +			.cgroup		 = perf_event__process_cgroup,
>  			.exit		 = perf_event__process_exit,
>  			.fork		 = perf_event__process_fork,
>  			.lost		 = perf_event__process_lost,
> diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
> index 36ad3a4a79e6..ec112ad640a1 100644
> --- a/tools/perf/lib/include/perf/event.h
> +++ b/tools/perf/lib/include/perf/event.h
> @@ -104,6 +104,13 @@ struct perf_record_bpf_event {
>  	__u8			 tag[BPF_TAG_SIZE];  // prog tag
>  };
>  
> +struct perf_record_cgroup {
> +	struct perf_event_header header;
> +	__u64			 ino;
> +	__u64			 path_len;
> +	char			 path[PATH_MAX];
> +};
> +
>  struct perf_record_sample {
>  	struct perf_event_header header;
>  	__u64			 array[];
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 33616ea62a47..c19b00c1fc26 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -52,6 +52,7 @@ static const char *perf_event__names[] = {
>  	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
>  	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
>  	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
> +	[PERF_RECORD_CGROUP]			= "CGROUP",
>  	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
>  	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
>  	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
> @@ -1279,6 +1280,12 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp)
>  	return ret;
>  }
>  
> +size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp)
> +{
> +	return fprintf(fp, " cgroup: %" PRI_lu64 " %s\n",
> +		       event->cgroup.ino, event->cgroup.path);
> +}
> +
>  int perf_event__process_comm(struct perf_tool *tool __maybe_unused,
>  			     union perf_event *event,
>  			     struct perf_sample *sample,
> @@ -1295,6 +1302,14 @@ int perf_event__process_namespaces(struct perf_tool *tool __maybe_unused,
>  	return machine__process_namespaces_event(machine, event, sample);
>  }
>  
> +int perf_event__process_cgroup(struct perf_tool *tool __maybe_unused,
> +			       union perf_event *event,
> +			       struct perf_sample *sample,
> +			       struct machine *machine)
> +{
> +	return machine__process_cgroup_event(machine, event, sample);
> +}
> +
>  int perf_event__process_lost(struct perf_tool *tool __maybe_unused,
>  			     union perf_event *event,
>  			     struct perf_sample *sample,
> @@ -1516,6 +1531,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
>  	case PERF_RECORD_NAMESPACES:
>  		ret += perf_event__fprintf_namespaces(event, fp);
>  		break;
> +	case PERF_RECORD_CGROUP:
> +		ret += perf_event__fprintf_cgroup(event, fp);
> +		break;
>  	case PERF_RECORD_MMAP2:
>  		ret += perf_event__fprintf_mmap2(event, fp);
>  		break;
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 429a3fe52d6c..0170435fd1e8 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -123,6 +123,7 @@ struct perf_sample {
>  	u32 raw_size;
>  	u64 data_src;
>  	u64 phys_addr;
> +	u64 cgroup;
>  	u32 flags;
>  	u16 insn_len;
>  	u8  cpumode;
> @@ -554,6 +555,7 @@ union perf_event {
>  	struct perf_record_mmap2	mmap2;
>  	struct perf_record_comm		comm;
>  	struct perf_record_namespaces	namespaces;
> +	struct perf_record_cgroup	cgroup;
>  	struct perf_record_fork		fork;
>  	struct perf_record_lost		lost;
>  	struct perf_record_lost_samples	lost_samples;
> @@ -663,6 +665,10 @@ int perf_event__process_namespaces(struct perf_tool *tool,
>  				   union perf_event *event,
>  				   struct perf_sample *sample,
>  				   struct machine *machine);
> +int perf_event__process_cgroup(struct perf_tool *tool,
> +			       union perf_event *event,
> +			       struct perf_sample *sample,
> +			       struct machine *machine);
>  int perf_event__process_mmap(struct perf_tool *tool,
>  			     union perf_event *event,
>  			     struct perf_sample *sample,
> @@ -750,6 +756,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
> +size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf(union perf_event *event, FILE *fp);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index fa676355559e..86a38679cad1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1593,6 +1593,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(ksymbol, p_unsigned);
>  	PRINT_ATTRf(bpf_event, p_unsigned);
>  	PRINT_ATTRf(aux_output, p_unsigned);
> +	PRINT_ATTRf(cgroup, p_unsigned);
>  
>  	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
>  	PRINT_ATTRf(bp_type, p_unsigned);
> @@ -2369,6 +2370,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		array++;
>  	}
>  
> +	data->cgroup = 0;
> +	if (type & PERF_SAMPLE_CGROUP) {
> +		data->cgroup = *array;
> +		array++;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 93483f1764d3..61c35eef616b 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -642,6 +642,16 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
>  	return err;
>  }
>  
> +int machine__process_cgroup_event(struct machine *machine __maybe_unused,
> +				  union perf_event *event,
> +				  struct perf_sample *sample __maybe_unused)
> +{
> +	if (dump_trace)
> +		perf_event__fprintf_cgroup(event, stdout);
> +
> +	return 0;
> +}
> +
>  int machine__process_lost_event(struct machine *machine __maybe_unused,
>  				union perf_event *event, struct perf_sample *sample __maybe_unused)
>  {
> @@ -1902,6 +1912,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
>  		ret = machine__process_mmap_event(machine, event, sample); break;
>  	case PERF_RECORD_NAMESPACES:
>  		ret = machine__process_namespaces_event(machine, event, sample); break;
> +	case PERF_RECORD_CGROUP:
> +		ret = machine__process_cgroup_event(machine, event, sample); break;
>  	case PERF_RECORD_MMAP2:
>  		ret = machine__process_mmap2_event(machine, event, sample); break;
>  	case PERF_RECORD_FORK:
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 7d69119d0b5d..608813ced0cd 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -127,6 +127,9 @@ int machine__process_switch_event(struct machine *machine,
>  int machine__process_namespaces_event(struct machine *machine,
>  				      union perf_event *event,
>  				      struct perf_sample *sample);
> +int machine__process_cgroup_event(struct machine *machine,
> +				  union perf_event *event,
> +				  struct perf_sample *sample);
>  int machine__process_mmap_event(struct machine *machine, union perf_event *event,
>  				struct perf_sample *sample);
>  int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5786e9c807c5..2cdce7ee228c 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -457,6 +457,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>  		tool->comm = process_event_stub;
>  	if (tool->namespaces == NULL)
>  		tool->namespaces = process_event_stub;
> +	if (tool->cgroup == NULL)
> +		tool->cgroup = process_event_stub;
>  	if (tool->fork == NULL)
>  		tool->fork = process_event_stub;
>  	if (tool->exit == NULL)
> @@ -1417,6 +1419,8 @@ static int machines__deliver_event(struct machines *machines,
>  		return tool->comm(tool, event, sample, machine);
>  	case PERF_RECORD_NAMESPACES:
>  		return tool->namespaces(tool, event, sample, machine);
> +	case PERF_RECORD_CGROUP:
> +		return tool->cgroup(tool, event, sample, machine);
>  	case PERF_RECORD_FORK:
>  		return tool->fork(tool, event, sample, machine);
>  	case PERF_RECORD_EXIT:
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 2abbf668b8de..472ef5eb4068 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -46,6 +46,7 @@ struct perf_tool {
>  			mmap2,
>  			comm,
>  			namespaces,
> +			cgroup,
>  			fork,
>  			exit,
>  			lost,
> -- 
> 2.23.0.187.g17f5b7556c-goog

-- 

- Arnaldo
