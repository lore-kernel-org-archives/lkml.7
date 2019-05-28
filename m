Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8EEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1092075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfE1I75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10973 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1I75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:59:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E14FC3084294;
        Tue, 28 May 2019 08:59:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 72C1D5D9CD;
        Tue, 28 May 2019 08:59:55 +0000 (UTC)
Date:   Tue, 28 May 2019 10:59:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf header: Add die information in CPU topology
Message-ID: <20190528085954.GC27906@krava>
References: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 28 May 2019 08:59:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:41:19PM -0700, kan.liang@linux.intel.com wrote:

SNIP

> 
> Add cpu_map__get_die_id() in cpumap.c to fetch die id information.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/Documentation/perf.data-file-format.txt |   9 +-
>  tools/perf/util/cpumap.c                           |   7 ++
>  tools/perf/util/cpumap.h                           |   1 +
>  tools/perf/util/cputopo.c                          |  83 ++++++++++++++--
>  tools/perf/util/cputopo.h                          |   7 +-
>  tools/perf/util/env.c                              |   1 +
>  tools/perf/util/env.h                              |   3 +
>  tools/perf/util/header.c                           | 104 +++++++++++++++++++--
>  8 files changed, 193 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index 6967e9b..c731416 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -153,7 +153,7 @@ struct {
>  
>  String lists defining the core and CPU threads topology.
>  The string lists are followed by a variable length array
> -which contains core_id and socket_id of each cpu.
> +which contains core_id, die_id (for x86) and socket_id of each cpu.
>  The number of entries can be determined by the size of the
>  section minus the sizes of both string lists.
>  
> @@ -162,14 +162,19 @@ struct {
>         struct perf_header_string_list threads; /* Variable length */
>         struct {
>  	      uint32_t core_id;
> +	      uint32_t die_id;
>  	      uint32_t socket_id;
>         } cpus[nr]; /* Variable length records */
>  };
>  
>  Example:
> -	sibling cores   : 0-3
> +	sibling cores   : 0-8
> +	sibling dies	: 0-3
> +	sibling dies	: 4-7
>  	sibling threads : 0-1
>  	sibling threads : 2-3
> +	sibling threads : 4-5
> +	sibling threads : 6-7
>  
>  	HEADER_NUMA_TOPOLOGY = 14,
>  
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 0b59922..7db1365 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -373,6 +373,13 @@ int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
>  	return 0;
>  }
>  
> +int cpu_map__get_die_id(int cpu)
> +{
> +	int value, ret = cpu__get_topology_int(cpu, "die_id", &value);
> +
> +	return ret ?: value;
> +}

please put 'adding cpu_map__get_die_id function' into separate patch

thanks,
jirka

> +
>  int cpu_map__get_core_id(int cpu)
>  {
>  	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index f00ce62..6762ff9 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -25,6 +25,7 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size);
>  size_t cpu_map__fprintf(struct cpu_map *map, FILE *fp);
>  int cpu_map__get_socket_id(int cpu);
>  int cpu_map__get_socket(struct cpu_map *map, int idx, void *data);
> +int cpu_map__get_die_id(int cpu);
>  int cpu_map__get_core_id(int cpu);
>  int cpu_map__get_core(struct cpu_map *map, int idx, void *data);
>  int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp);
> diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c

SNIP
