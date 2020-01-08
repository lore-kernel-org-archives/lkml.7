Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC20C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8169A20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9ORbN2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgAHWZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:25:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48452 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726548AbgAHWZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578522309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GSanHGt+U3NvBdeaHVTSP3fszF8WdNCIdlIm6BiLV0=;
        b=i9ORbN2ssFRTYIF+XwdkwUhAxUwIU0JWgPiJHqhwt+iHwl0i8uZb6fm0cOBH4CEwKHTT4W
        HfAdRgOwgUgKb6OlTpq0OkVgMlrX3NY+FdREOPwMaCK41x6ZqcmaeWL+FQvYNXs1VrK06X
        R7yIhSdxG039+fMn43hIEjr/uZUgoDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-SYRzmCg4P7m6VRZxPM3KAg-1; Wed, 08 Jan 2020 17:25:05 -0500
X-MC-Unique: SYRzmCg4P7m6VRZxPM3KAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7377510054E3;
        Wed,  8 Jan 2020 22:25:03 +0000 (UTC)
Received: from krava (ovpn-204-121.brq.redhat.com [10.40.204.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E097C5C299;
        Wed,  8 Jan 2020 22:25:00 +0000 (UTC)
Date:   Wed, 8 Jan 2020 23:24:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 8/9] perf top: Add --all-cgroups option
Message-ID: <20200108222458.GF12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-9-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-9-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:35:00PM +0900, Namhyung Kim wrote:
> The --all-cgroups option is to enable cgroup profiling support.  It
> tells kernel to record CGROUP events in the ring buffer so that perf
> report can identify task/cgroup association later.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-top.txt | 4 ++++
>  tools/perf/builtin-top.c              | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 5596129a71cf..c75507f50071 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -266,6 +266,10 @@ Default is to monitor all CPUS.
>  	Record events of type PERF_RECORD_NAMESPACES and display it with the
>  	'cgroup_id' sort key.
>  
> +--cgroup::
> +	Record events of type PERF_RECORD_CGROUP and display it with the
> +	'cgroup' sort key.

should be '--all-cgroups' ?

anyway, we dont have '--cgroups', why not use just this?

jirka

> +
>  --switch-on EVENT_NAME::
>  	Only consider events after this event is found.
>  
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 795e353de095..f6256c533b09 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1244,6 +1244,8 @@ static int __cmd_top(struct perf_top *top)
>  
>  	if (opts->record_namespaces)
>  		top->tool.namespace_events = true;
> +	if (opts->record_cgroup)
> +		top->tool.cgroup_events = true;
>  
>  	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
>  						&top->session->machines.host,
> @@ -1251,6 +1253,11 @@ static int __cmd_top(struct perf_top *top)
>  	if (ret < 0)
>  		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
>  
> +	ret = perf_event__synthesize_cgroups(&top->tool, perf_event__process,
> +					     &top->session->machines.host);
> +	if (ret < 0)
> +		pr_debug("Couldn't synthesize cgroup events.\n");
> +
>  	machine__synthesize_threads(&top->session->machines.host, &opts->target,
>  				    top->evlist->core.threads, false,
>  				    top->nr_threads_synthesize);
> @@ -1539,6 +1546,8 @@ int cmd_top(int argc, const char **argv)
>  			"number of thread to run event synthesize"),
>  	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
>  		    "Record namespaces events"),
> +	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
> +		    "Record cgroup events"),
>  	OPTS_EVSWITCH(&top.evswitch),
>  	OPT_END()
>  	};
> -- 
> 2.24.1.735.g03f4e72817-goog
> 

