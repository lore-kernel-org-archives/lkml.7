Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D628C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E5220665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uuxWthZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391270AbfGHPpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:45:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbfGHPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=02LebEonQEm8s4H9wfANLjV5fLft7vqIhRuHDWcgIq0=; b=uuxWthZYHeDmwO+HPaphehmge
        Z9yf6zdfzrIasFn442hod6zlTKYx7AqT5xj4L+lza0eMoC5zGZx1ZnZaKlhPEDgp2e9ccq7E0KHuh
        5ZQUns/OW9z5zCZX7Y/v1UhyS9dycmNBhQy8pDjZ9hUPlRizOxH0/l3FWENmzAJHkqt4BRfDM4Xb2
        963W2B86KLWw+OiH0PjWvJ3FTQrLIKRiOajQ89rY8wLqGu5/HbLHD4ETd1RCxK+M+q1MSj18wsn8J
        S9acx6ergxXuV03bEmQhU2jbLP5w5O41qM+En4lC7d0fJUoU0okunWT5wA/SRzKIAnbIij81VFSZ6
        nJY8sHsZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkVpa-0000K3-1q; Mon, 08 Jul 2019 15:45:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FC4E20976D60; Mon,  8 Jul 2019 17:45:28 +0200 (CEST)
Date:   Mon, 8 Jul 2019 17:45:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/7] perf/cgroup: order events in RB tree by cgroup id
Message-ID: <20190708154528.GD3419@hirez.programming.kicks-ass.net>
References: <20190702065955.165738-1-irogers@google.com>
 <20190702065955.165738-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702065955.165738-3-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:59:50PM -0700, Ian Rogers wrote:
> +perf_event_groups_first(struct perf_event_groups *groups, int cpu,
> +			struct cgroup *cgrp)
>  {
>  	struct perf_event *node_event = NULL, *match = NULL;
>  	struct rb_node *node = groups->tree.rb_node;
> +#ifdef CONFIG_CGROUP_PERF
> +	int node_cgrp_id, cgrp_id = 0;
> +
> +	if (cgrp)
> +		cgrp_id = cgrp->id;
> +#endif

Is 0 ever a valid cgroup.id ? If so, should we perhaps use -1 to denote
'none' ? Ether way around a little comment here couldn't hurt, saves one
from digging into the cgroup code.
