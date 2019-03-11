Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4972084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="A0QAa7xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfCKRZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:25:30 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44485 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfCKRZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:25:28 -0400
Received: by mail-yw1-f65.google.com with SMTP id c4so4525501ywa.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f/08Cea8rl1auJ0ztvMCqTFjGtaWSYM7AUW8AvuH/RU=;
        b=A0QAa7xgCQYBpQuFa1awMJf38b2jg+etnRfvYDr66i3IXqdjSawonGGo2ICZM74Asr
         o6S9TIyGUWOIBts5qq8xc1Z+kfHH66CYpNPsnj0aD/swB3Mg/4e2FlUeZRc3AgJpmtN0
         EFs2KR9cIITJLbNZ+C9dIONuJuEtvYFmjYFOLLHLytrhz+mNIcKz8MgkzLxc2P77eagQ
         n5MyurlbC5t4Y4MYhS+bn1v7sDxmqHD1IboTDMXPedkG/tkwapmjtNAxtQ5v4Qh1pP7z
         jRivnC6dNZuA7NqLiNGo8mjZzjGgRp4THrZqVPPP0JFC02BcFhJKRmygRZOZ4MqAMfr/
         svog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/08Cea8rl1auJ0ztvMCqTFjGtaWSYM7AUW8AvuH/RU=;
        b=PNulpm3xfP6XJn3rptoXS7eYD99XXsgX/2OCF/2nZuRpJTv2jxBOp/iIzaZ3qbuVrc
         TPFDKoDZUxbWSqF3EmVQFYFiiqWCwV08BmF7nEeT3GSXVfwqjo/sjTIYYipIcMgCdzWW
         WPuLb/fZoyFy+5xVRqv9FMLt/nq06bAGBzMYry6c6B0VqzvrFs91Jp7u6ArXkxkAnj7W
         a0mGnCyRKrFTbsaoAzmm+uwhORtiPooHKLIS+TNkdxaVXIRmS4mBqXgGVrNJqaWrx2at
         2FtwG7taZLqIIrmSx+VkkQRAeE6CPAJ9pOvo5SIXepUZhqZigLDYDGxz0VITpcRnpBPU
         VPjA==
X-Gm-Message-State: APjAAAXmaZGFwCwc1wVnBJz+jUU6+AJ/6DBpBFc0m6jXJBm1yy4hie9o
        3+LaG+Syd5AqLIUIPX8nBhdhkw==
X-Google-Smtp-Source: APXvYqwZgrQea8FmLekPNMPenwnIlyxxrt87gJ6eaPSRwYTYSYUXxhPpQFzlD+GmKLLIR7+mqlCnqA==
X-Received: by 2002:a25:61c8:: with SMTP id v191mr27629102ybb.489.1552325127865;
        Mon, 11 Mar 2019 10:25:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:3c60])
        by smtp.gmail.com with ESMTPSA id b7sm2994000ywa.86.2019.03.11.10.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:25:27 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:25:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 3/5] mm: release memcg percpu data prematurely
Message-ID: <20190311172526.GC10823@cmpxchg.org>
References: <20190307230033.31975-1-guro@fb.com>
 <20190307230033.31975-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307230033.31975-4-guro@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:00:31PM -0800, Roman Gushchin wrote:
> To reduce the memory footprint of a dying memory cgroup, let's
> release massive percpu data (vmstats_percpu) as early as possible,
> and use atomic counterparts instead.
> 
> A dying cgroup can remain in the dying state for quite a long
> time, being pinned in memory by any reference. For example,
> if a page mlocked by some other cgroup, is charged to the dying
> cgroup, it won't go away until the page will be released.
> 
> A dying memory cgroup can have some memory activity (e.g. dirty
> pages can be flushed after cgroup removal), but in general it's
> not expected to be very active in comparison to living cgroups.
> 
> So reducing the memory footprint by releasing percpu data
> and switching over to atomics seems to be a good trade off.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

One nitpick below:

> @@ -4612,6 +4612,26 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	return 0;
>  }
>  
> +static void mem_cgroup_free_percpu(struct rcu_head *rcu)
> +{
> +	struct mem_cgroup *memcg = container_of(rcu, struct mem_cgroup, rcu);
> +
> +	free_percpu(memcg->vmstats_percpu_offlined);
> +	WARN_ON_ONCE(memcg->vmstats_percpu);
> +
> +	css_put(&memcg->css);

Nitpick: I had to double take seeing a "mem_cgroup_free_*" function
that does css_put(). We use "free" terminology (mem_cgroup_css_free,
memcg_free_kmem, memcg_free_shrinker_maps, mem_cgroup_free) from the
.css_free callback, which only happens when the last reference is put.

Can we go with something less ambigous? We can add "rcu" and drop the
mem_cgroup prefix since it's narrowly scoped. "percpu_rcu_free"?

> +static void mem_cgroup_offline_percpu(struct mem_cgroup *memcg)
> +{
> +	memcg->vmstats_percpu_offlined = (struct memcg_vmstats_percpu __percpu*)
> +		rcu_dereference(memcg->vmstats_percpu);
> +	rcu_assign_pointer(memcg->vmstats_percpu, NULL);
> +
> +	css_get(&memcg->css);
> +	call_rcu(&memcg->rcu, mem_cgroup_free_percpu);
> +}
> +
>  static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
