Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCA5C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1633208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560788227;
	bh=mCCRkIvL5kJhAiDDG/gzQ5DHa8C16hLCNzTszkcEajs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qvZkr/GvfparbJWL1wwRp4gA6mWKS8l1AraxOxKTKuqrApmLLhuCB8NiECuRPxC+t
	 HjqjqV5G3oJcTJo+MK/O1tfcWfV0Vn5/pKK8kZExYrBnu0h3xs+zWbAL1QkKkH4Zba
	 5TqU7x/PbaHq6gGHix6dwFEFwukBOO1H5koTN4ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfFQQRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:17:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbfFQQRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:17:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D5E8AB7F;
        Mon, 17 Jun 2019 16:17:04 +0000 (UTC)
Date:   Mon, 17 Jun 2019 18:17:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, oom: fix oom_unkillable_task for memcg OOMs
Message-ID: <20190617161702.GE1492@dhcp22.suse.cz>
References: <20190617155954.155791-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617155954.155791-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-06-19 08:59:54, Shakeel Butt wrote:
> Currently oom_unkillable_task() checks mems_allowed even for memcg OOMs
> which does not make sense as memcg OOMs can not be triggered due to
> numa constraints. Fixing that.
> 
> Also if memcg is given, oom_unkillable_task() will check the task's
> memcg membership as well to detect oom killability. However all the
> memcg related code paths leading to oom_unkillable_task(), other than
> dump_tasks(), come through mem_cgroup_scan_tasks() which traverses
> tasks through memcgs. Once dump_tasks() is converted to use
> mem_cgroup_scan_tasks(), there is no need to do memcg membership check
> in oom_unkillable_task().

I think this patch just does too much in one go. Could you split out
the dump_tasks part and the oom_unkillable_task parts into two patches
please? It should be slightly easier to review.

[...]
> +static bool oom_unkillable_task(struct task_struct *p, struct oom_control *oc)
>  {
>  	if (is_global_init(p))
>  		return true;
>  	if (p->flags & PF_KTHREAD)
>  		return true;
> +	if (!oc)
> +		return false;

Bah, this is just too ugly. AFAICS this is only because oom_score still
uses oom_unkillable_task which is kinda dubious, no? While you are
touching this code, can we remove this part as well? I would be really
surprised if any code really depends on ineligible tasks reporting 0
oom_score.

Other than that it looks reasonable to me from a quick glance but I have
to look more carefuly.
-- 
Michal Hocko
SUSE Labs
