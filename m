Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F90C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0C220815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCDOsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:48:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCDOsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:48:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DECAA2DA9A2;
        Mon,  4 Mar 2019 14:48:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 861B760144;
        Mon,  4 Mar 2019 14:48:19 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:48:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 01/11] perf tools: Add utility function to fetch
 executable
Message-ID: <20190304144819.GH30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-2-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 04 Mar 2019 14:48:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:40AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a utility function to fetch executable code. Convert one
> user over to it. There are more places doing that, but they
> do significantly different actions, so they are not
> easy to fit into a single library function.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/Build       |  1 +
>  tools/perf/util/fetch.c     | 28 ++++++++++++++++++++++++++++
>  tools/perf/util/fetch.h     |  7 +++++++
>  tools/perf/util/intel-bts.c | 21 +++------------------
>  4 files changed, 39 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/util/fetch.c
>  create mode 100644 tools/perf/util/fetch.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8dd3102301ea..649321fc3fb9 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -65,6 +65,7 @@ perf-y += trace-event-scripting.o
>  perf-y += trace-event.o
>  perf-y += svghelper.o
>  perf-y += sort.o
> +perf-y += fetch.o
>  perf-y += hist.o
>  perf-y += util.o
>  perf-y += xyarray.o
> diff --git a/tools/perf/util/fetch.c b/tools/perf/util/fetch.c
> new file mode 100644
> index 000000000000..1430083e7eca
> --- /dev/null
> +++ b/tools/perf/util/fetch.c
> @@ -0,0 +1,28 @@
> +#include "perf.h"
> +#include "machine.h"
> +#include "thread.h"
> +#include "symbol.h"
> +#include "map.h"
> +#include "fetch.h"
> +
> +int fetch_exe(u64 ip, struct thread *thread, struct machine *machine,
> +	      char *buf, int len, bool *is64bit)
> +{
> +	struct addr_location al;
> +	u8 cpumode;
> +	long offset;
> +
> +	if (machine__kernel_ip(machine, ip))
> +		cpumode = PERF_RECORD_MISC_KERNEL;
> +	else
> +		cpumode = PERF_RECORD_MISC_USER;
> +	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
> +		return -1;
> +	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR)
> +		return -1;
> +	map__load(al.map);
> +	offset = al.map->map_ip(al.map, ip);
> +	if (is64bit)
> +		*is64bit = al.map->dso->is_64_bit;
> +	return dso__data_read_offset(al.map->dso, machine, offset, (u8 *)buf, len);
> +}
> diff --git a/tools/perf/util/fetch.h b/tools/perf/util/fetch.h
> new file mode 100644
> index 000000000000..7b77b8cee55a
> --- /dev/null
> +++ b/tools/perf/util/fetch.h
> @@ -0,0 +1,7 @@
> +#ifndef FETCH_H
> +#define FETCH_H 1
> +
> +int fetch_exe(u64 ip, struct thread *thread, struct machine *machine,
> +	      char *buf, int len, bool *is64bit);
> +
> +#endif
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 0c0180c67574..915f4662e52e 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -38,6 +38,7 @@
>  #include "auxtrace.h"
>  #include "intel-pt-decoder/intel-pt-insn-decoder.h"
>  #include "intel-bts.h"
> +#include "fetch.h"
>  
>  #define MAX_TIMESTAMP (~0ULL)
>  
> @@ -328,35 +329,19 @@ static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
>  {
>  	struct machine *machine = btsq->bts->machine;
>  	struct thread *thread;
> -	struct addr_location al;
>  	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
>  	ssize_t len;
> -	int x86_64;
> -	uint8_t cpumode;
> +	bool x86_64;
>  	int err = -1;
>  
> -	if (machine__kernel_ip(machine, ip))
> -		cpumode = PERF_RECORD_MISC_KERNEL;
> -	else
> -		cpumode = PERF_RECORD_MISC_USER;
> -
>  	thread = machine__find_thread(machine, -1, btsq->tid);
>  	if (!thread)
>  		return -1;
>  
> -	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
> -		goto out_put;
> -
> -	len = dso__data_read_addr(al.map->dso, al.map, machine, ip, buf,
> -				  INTEL_PT_INSN_BUF_SZ);
> +	len = fetch_exe(ip, thread, machine, (char*)buf, INTEL_PT_INSN_BUF_SZ, &x86_64);
>  	if (len <= 0)
>  		goto out_put;
>  
> -	/* Load maps to ensure dso->is_64_bit has been updated */
> -	map__load(al.map);
> -
> -	x86_64 = al.map->dso->is_64_bit;
> -
>  	if (intel_pt_get_insn(buf, len, x86_64, &btsq->intel_pt_insn))
>  		goto out_put;
>  
> -- 
> 2.17.2
> 
