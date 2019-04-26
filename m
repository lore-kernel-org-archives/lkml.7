Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF62C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D20D206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C7bZ9Z6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfDZONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:13:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33906 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8loiSRaoh42DXeIQjNbiN1USZ8a/MszR2dkFDWexf7M=; b=C7bZ9Z6FeUKzezmLte/+hl18t
        WPZPTSc/CNVYLtOHh+QwJ9EhnP+5MRcFpeXW/VL/H/IshT0ASW/jIcigeiwlZenHmKkkubIVdfTHd
        1PeBE4jgon6yovfndpr2GVv4WeNQwAJnip69qn7vfTrr+2khfzwSdm+furkG8jshuob0pdrEJ7N5/
        kpTNq5WFvD+63NZ7DcH0ShNEJmIZarFdWO2V+xTIpByKIqau12/RZKhtwH0YdA57jnXi/x4IilPZ5
        vP+CjAlbf54tfy8R0VLDmmiEvADfLtS+cHETma56rZLdZZVovrgJiXGJzlJ21qRrt2Fj6AJxNPy5P
        d0ugIAUgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK1bB-0000qi-CT; Fri, 26 Apr 2019 14:13:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D69DF28B70B85; Fri, 26 Apr 2019 16:13:07 +0200 (CEST)
Date:   Fri, 26 Apr 2019 16:13:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 12/17] sched: A quick and dirty cgroup tagging
 interface
Message-ID: <20190426141307.GB2623@hirez.programming.kicks-ass.net>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <b058b74f303fe40e5822925c90a5b0161c4a0a2d.1556025155.git.vpillai@digitalocean.com>
 <20190425142652.GA979@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425142652.GA979@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:26:53AM -0400, Phil Auld wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e8e5f26db052..b312ea1e28a4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7541,6 +7541,9 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
>         if (val > 1)
>                 return -ERANGE;
>  
> +       if (num_online_cpus() <= 1) 
> +               return -EINVAL;

We actually know if there SMT on the system or not, which is much better
indication still:

	if (!static_branch_likely(&sched_smt_present))
		return -EINVAL;

>         if (tg->tagged == !!val)
>                 return 0;
>  
> 
> 
> 
> -- 
