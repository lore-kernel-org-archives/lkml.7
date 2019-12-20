Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CDC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CC52146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FzuMgYO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTJg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:36:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55170 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLTJg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IeC3Wh4lNy11h5SgeP1/xOYlLb3Jw6kDXhcV/C+ENkU=; b=FzuMgYO0pde3xh1++9b24OYgG
        LCeSCwVdXvQF3MKcL5fdI4Q9y6s0yuwPArFJb0716ETxmW7FgnuBZ3K0VUcTZVqkfyE9xHK+ovcT/
        zw2rPT1YVc+rmhJfj/2GuH+W8nlgLoABVxxiM3WFh6mXslAz3aC8ghImCxCwOnXJMWISdSnsq3hUi
        4ev4QSQ3nSftSsqTebVPslge2m9gIK9L3VkFRtxsRMoOVTFquoL/wi5CmaNXt0Gto9+OZzLydwy4k
        5m584NgatcPfdFYDbnSKhZUnrjUBRedMqNCvdf5tDjwq+hEHeHTF/aXG44S17rhatarrnC/3Q0Ulc
        KyAbwUjKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiEhi-0000IZ-R4; Fri, 20 Dec 2019 09:36:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FFDC3007F2;
        Fri, 20 Dec 2019 10:34:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CAD82B4061AD; Fri, 20 Dec 2019 10:36:13 +0100 (CET)
Date:   Fri, 20 Dec 2019 10:36:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20191220093613.GD2844@hirez.programming.kicks-ass.net>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220043253.3278951-3-namhyung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:32:46PM +0900, Namhyung Kim wrote:
> The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
> in the sample.  It will add a 64-bit id to identify current cgroup and
> it's the file handle in the cgroup file system.  Userspace should use
> this information with PERF_RECORD_CGROUP event to match which cgroup
> it belongs.
> 
> I put it before PERF_SAMPLE_AUX for simplicity since it just needs a
> 64-bit word.  But if we want bigger samples, I can work on that
> direction too.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

> @@ -6895,6 +6901,18 @@ void perf_prepare_sample(struct perf_event_header *header,
>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		data->phys_addr = perf_virt_to_phys(data->addr);
>  
> +	if (sample_type & PERF_SAMPLE_CGROUP) {
> +		u64 cgrp_id = 0;
> +#ifdef CONFIG_CGROUP_PERF
> +		struct cgroup *cgrp;
> +
> +		/* protected by RCU */
> +		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
> +		cgrp_id = cgroup_id(cgrp);
> +#endif
> +		data->cgroup = cgrp_id;
> +	}

Would it make more sense to refuse SAMPLE_CGROUP if !CGROUP_PERF?
