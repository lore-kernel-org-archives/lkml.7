Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F46C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAC12075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfFEJJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFEJJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:09:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AD5A30BC569;
        Wed,  5 Jun 2019 09:09:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2B2F019C65;
        Wed,  5 Jun 2019 09:09:07 +0000 (UTC)
Date:   Wed, 5 Jun 2019 11:09:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH V3 1/5] perf cpumap: Retrieve die id information
Message-ID: <20190605090907.GC23116@krava>
References: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 05 Jun 2019 09:09:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 03:50:40PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> There is no function to retrieve die id information of a given CPU.
> 
> Add cpu_map__get_die_id() to retrieve die id information.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> No changes since V2.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

for the whole patchset

thanks,
jirka

> 
>  tools/perf/util/cpumap.c | 7 +++++++
>  tools/perf/util/cpumap.h | 1 +
>  2 files changed, 8 insertions(+)
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
> -- 
> 2.7.4
> 
