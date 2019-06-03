Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62174C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D712730E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfFCQgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfFCQgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FBD530821FF;
        Mon,  3 Jun 2019 16:36:44 +0000 (UTC)
Received: from krava (ovpn-204-51.brq.redhat.com [10.40.204.51])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5FC746108E;
        Mon,  3 Jun 2019 16:36:39 +0000 (UTC)
Date:   Mon, 3 Jun 2019 18:36:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH V2 3/5] perf stat: Support per-die aggregation
Message-ID: <20190603163636.GC12203@krava>
References: <1559228029-5876-1-git-send-email-kan.liang@linux.intel.com>
 <1559228029-5876-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559228029-5876-3-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 03 Jun 2019 16:36:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 07:53:47AM -0700, kan.liang@linux.intel.com wrote:

SNIP

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

please note we use upper 8 bits for socket number,
the comments suggests it's 24 bits

> +		 * encode die id in upper 16 bits
> +		 * core_id is relative to socket and die,
>  		 * we need a global id. So we combine
> -		 * socket + core id.
> +		 * socket + die id + core id
>  		 */
> -		core = (socket_id << 16) | (env->cpu[cpu].core_id & 0xffff);
> +		if (WARN_ONCE(env->cpu[cpu].socket_id >> 8,
> +		    "The socket_id number is too big. Please upgrade the perf tool.\n"))

hum, how's perf tool upgrade going to help in here?

> +			return -1;
> +
> +		if (WARN_ONCE(env->cpu[cpu].die_id >> 8,
> +		    "The die_id number is too big. Please upgrade the perf tool.\n"))
> +			return -1;
> +
> +		core = (env->cpu[cpu].socket_id << 24) |
> +		       (env->cpu[cpu].die_id << 16) |
> +		       (env->cpu[cpu].core_id & 0xffff);
>  	}

other than comments above, the patchset looks good to me

thanks,
jirka
