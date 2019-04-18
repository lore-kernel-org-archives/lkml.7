Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E287DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26782183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555596912;
	bh=jJDW45+DQjquXSK43lkBLQZHZtz7RZyo5LYoKHgrwYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qHeACieN8gaUse0QQVpUtR488ub/LusbOMBQCCjXQy/pKs4LC6ViWPLENi0kepaac
	 SW0K+z0a/2BLn+l1htCGbfsd7KZmQe44ZuleEqPqRqkNoQ05Gkl2ifPCUjaVPyqcWe
	 HPZupAoGmbGOEo+LHGHhTm2WH5b3Oipvm6FRJ+G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbfDROPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:15:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388346AbfDROPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:15:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8DD0B16E;
        Thu, 18 Apr 2019 14:15:08 +0000 (UTC)
Date:   Thu, 18 Apr 2019 16:15:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>, akpm@linux-foundation.org,
        arunks@codeaurora.org, brgl@bgdev.pl, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, rppt@linux.ibm.com, vbabka@suse.cz,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH] prctl_set_mm: downgrade mmap_sem to read lock
Message-ID: <20190418141507.GO6567@dhcp22.suse.cz>
References: <20190417145548.GN5878@dhcp22.suse.cz>
 <20190418135039.19987-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418135039.19987-1-mkoutny@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-04-19 15:50:39, Michal Koutny wrote:
> I learnt, it's, alas, too late to drop the non PRCTL_SET_MM_MAP calls
> [1], so at least downgrade the write acquisition of mmap_sem as in the
> patch below (that should be stacked on the previous one or squashed).
> 
> Cyrill, you mentioned lock changes in [1] but the link seems empty. Is
> it supposed to be [2]? That could be an alternative to this patch after
> some refreshments and clarifications.
> 
> 
> [1] https://lore.kernel.org/lkml/20190417165632.GC3040@uranus.lan/
> [2] https://lore.kernel.org/lkml/20180507075606.870903028@gmail.com/
> 
> ========
> 
> Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect
> arg_start|end and env_start|end in mm_struct") we use arg_lock for
> boundaries modifications. Synchronize prctl_set_mm with this lock and
> keep mmap_sem for reading only (analogous to what we already do in
> prctl_set_mm_map).
> 
> Also, save few cycles by looking up VMA only after performing basic
> arguments validation.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Looks good to me. Please send both patches in one series once you get a
review feedback from other people.

> ---
>  kernel/sys.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..bbce0f26d707 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2125,8 +2125,12 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  
>  	error = -EINVAL;
>  
> -	down_write(&mm->mmap_sem);
> -	vma = find_vma(mm, addr);
> +	/*
> +	 * arg_lock protects concurent updates of arg boundaries, we need mmap_sem for
> +	 * a) concurrent sys_brk, b) finding VMA for addr validation.
> +	 */
> +	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>  
>  	prctl_map.start_code	= mm->start_code;
>  	prctl_map.end_code	= mm->end_code;
> @@ -2185,6 +2189,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  	if (error)
>  		goto out;
>  
> +	vma = find_vma(mm, addr);
>  	switch (opt) {
>  	/*
>  	 * If command line arguments and environment
> @@ -2218,7 +2223,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  
>  	error = 0;
>  out:
> -	up_write(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
> +	up_read(&mm->mmap_sem);
>  	return error;
>  }
>  
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs
