Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0C9C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523F12075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfE1JAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfE1JAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:00:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 089A67EBDC;
        Tue, 28 May 2019 09:00:23 +0000 (UTC)
Received: from krava (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 82835611B1;
        Tue, 28 May 2019 09:00:21 +0000 (UTC)
Date:   Tue, 28 May 2019 11:00:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH 2/3] perf stat: Support per-die aggregation
Message-ID: <20190528090020.GG27906@krava>
References: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
 <1558644081-17738-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558644081-17738-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 28 May 2019 09:00:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:41:20PM -0700, kan.liang@linux.intel.com wrote:

SNIP

>  		if (cpu_map__build_core_map(evsel_list->cpus, &stat_config.aggr_map)) {
>  			perror("cannot build core map");
> @@ -936,21 +957,41 @@ static int perf_env__get_socket(struct cpu_map *map, int idx, void *data)
>  	return cpu == -1 ? -1 : env->cpu[cpu].socket_id;
>  }
>  
> +static int perf_env__get_die(struct cpu_map *map, int idx, void *data)
> +{
> +	struct perf_env *env = data;
> +	int die = -1, cpu = perf_env__get_cpu(env, map, idx);
> +
> +	if (cpu != -1) {
> +		/*
> +		 * Encode socket in upper 8 bits
> +		 * die_id is relative to socket,
> +		 * we need a global id. So we combine
> +		 * socket + die id
> +		 */
> +		die = (env->cpu[cpu].socket_id << 8) |
> +		      (env->cpu[cpu].die_id & 0xff);
> +	}
> +
> +	return die;
> +}
> +
>  static int perf_env__get_core(struct cpu_map *map, int idx, void *data)
>  {
>  	struct perf_env *env = data;
>  	int core = -1, cpu = perf_env__get_cpu(env, map, idx);
>  
>  	if (cpu != -1) {
> -		int socket_id = env->cpu[cpu].socket_id;
> -
>  		/*
> -		 * Encode socket in upper 16 bits
> -		 * core_id is relative to socket, and
> +		 * Encode socket in upper 24 bits
> +		 * encode die id in upper 16 bits
> +		 * core_id is relative to socket and die,
>  		 * we need a global id. So we combine
> -		 * socket + core id.
> +		 * socket + die id + core id
>  		 */
> -		core = (socket_id << 16) | (env->cpu[cpu].core_id & 0xffff);
> +		core = (env->cpu[cpu].socket_id << 24) |
> +		       (env->cpu[cpu].die_id << 16) |
> +		       (env->cpu[cpu].core_id & 0xffff);

I guess we're still safe with 1 byte for socket and die id,
but could we still check the size fits, and warn and bail
out otherwise?

thanks,
jirka
