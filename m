Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3831C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F8924E78
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559196751;
	bh=Fuzshm/DcTbPdPi9T17KQW/GV9LQ8KI8VCEL5hyK49Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mrOUKJJLCmL9NbmD4BdnVYEfYMpRXsYYS2S1mUULle7bVdSRK6EykGZ/kYQC5gvzL
	 uwwtj2Z4GJTjVF6MbLawbGKuiP3i3nsfie4uCkBxcslqZih6QvdFOmJO7sRuFoIbuq
	 z5YjcXhDi1ZpbxjY8gfySD39vLbKy3ZhTISRSPiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfE3GM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:12:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:44078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3GM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:12:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF839B01C;
        Thu, 30 May 2019 06:12:24 +0000 (UTC)
Date:   Thu, 30 May 2019 08:12:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190530061221.GA6703@dhcp22.suse.cz>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322160307.GA3316@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for a late reply]

On Fri 22-03-19 16:03:07, Chris Down wrote:
[...]
> With this patch, memory.low and memory.min affect reclaim pressure in a
> more understandable and composable way. For example, from a user
> standpoint, "protected" memory now remains untouchable from a reclaim
> aggression standpoint, and users can also have more confidence that
> bursty workloads will still receive some amount of guaranteed
> protection.

Maybe I am missing something so correct me if I am wrong but the new
calculation actually means that we always allow to scan even min
protected memcgs right?

Because ...

[...]

> +static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
> +						  bool in_low_reclaim)
>  {
> -	if (mem_cgroup_disabled()) {
> -		*min = 0;
> -		*low = 0;
> -		return;
> -	}
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
> +	if (in_low_reclaim)
> +		return READ_ONCE(memcg->memory.emin);
>  
> -	*min = READ_ONCE(memcg->memory.emin);
> -	*low = READ_ONCE(memcg->memory.elow);
> +	return max(READ_ONCE(memcg->memory.emin),
> +		   READ_ONCE(memcg->memory.elow));
>  }
[...]
> +			unsigned long cgroup_size = mem_cgroup_size(memcg);
> +
> +			/* Avoid TOCTOU with earlier protection check */
> +			cgroup_size = max(cgroup_size, protection);
> +
> +			scan = lruvec_size - lruvec_size * protection /
> +				cgroup_size;
>  
[...]
> -			scan = clamp(scan, SWAP_CLUSTER_MAX, lruvec_size);
> +			scan = max(scan, SWAP_CLUSTER_MAX);

here the zero or sub SWAP_CLUSTER_MAX scan target gets extended to
SWAP_CLUSTER_MAX. Unless I am missing something this is not correct
because min protection should be a guarantee even in in_low_reclaim
mode.

>  		} else {
>  			scan = lruvec_size;
>  		}
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
