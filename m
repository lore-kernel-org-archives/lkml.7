Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D57C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56002075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H2h3SrVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgAGMvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:51:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lq+UUJnax/VcA5CeCoVByHJ2hdj/ix0RJ3YWI/FR/2g=; b=H2h3SrVD1nfgb9FKWU0xlBAjQ
        Ol0e/hYuc7qygGSpNWBLMhhWbwu4Dd3ztl4vLDH92rMKR0tS8nXxyWJoWNEZdNI0AJrgMxLow7ybd
        8u6ZDumVXgDE+5TudqetMo/coDGcU+GJ2FWi9MQ0oyeG53NVqWRjZAYemBv3pVyodEW1Yk/e4uc46
        INOaA/pFe4o+VxT1HS2q9LDfprC1lmsLmh7wn51qwLyifTx/GPLqxEg+4SPwX+5MqQ8cHlnUX1Fud
        2jqJ587KIZJZJObg4U4uf7cBSVAB2ggoCzeclcGrpjoOHrJJ7HKf6F28PpQWxKaMHwtLkng7TVbJX
        wLF4TJ/BA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iooKb-0005hi-MR; Tue, 07 Jan 2020 12:51:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC49E30025A;
        Tue,  7 Jan 2020 13:49:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 566F920D3D423; Tue,  7 Jan 2020 13:51:31 +0100 (CET)
Date:   Tue, 7 Jan 2020 13:51:31 +0100
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Message-ID: <20200107125131.GZ2844@hirez.programming.kicks-ass.net>
References: <20191223060759.841176-1-namhyung@kernel.org>
 <20191223060759.841176-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223060759.841176-2-namhyung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 03:07:51PM +0900, Namhyung Kim wrote:

> @@ -7564,6 +7567,105 @@ void perf_event_namespaces(struct task_struct *task)
>  			NULL);
>  }
>  
> +/*
> + * cgroup tracking
> + */
> +#ifdef CONFIG_CGROUPS
> +

<snip>

> +
> +#endif
> +
>  /*
>   * mmap tracking
>   */

> @@ -12581,6 +12685,12 @@ static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
>  	kfree(jc);
>  }
>  
> +static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
> +{
> +	perf_event_cgroup(css->cgroup);
> +	return 0;
> +}
> +
>  static int __perf_cgroup_move(void *info)
>  {
>  	struct task_struct *task = info;
> @@ -12602,6 +12712,7 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
>  struct cgroup_subsys perf_event_cgrp_subsys = {
>  	.css_alloc	= perf_cgroup_css_alloc,
>  	.css_free	= perf_cgroup_css_free,
> +	.css_online	= perf_cgroup_css_online,
>  	.attach		= perf_cgroup_attach,
>  	/*
>  	 * Implicitly enable on dfl hierarchy so that perf events can

CONFIG_CGROUPS vs CONFIG_CGROUP_PERF ?

Other than that, I see nothing wrong here.
