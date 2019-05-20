Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0103C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ACD20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558344485;
	bh=EKfPNsMFWQzoi30nh+a2rg7J8OUMcq40Yfw5vVIDYIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O7i0JR/gaMSfgSGLkUfkdPXw59gzPzA1AhO0DOPpiTkw5diF2csLyqO5BwcXWZIgm
	 sYmgWbAQ5y9tSZhsdadoaQWaa4qROZlOnUF+Vsb4wn+u5rHALWa8YPK50YxEnFVhws
	 IowihsX1K1ae6QaRE5GguEIm756MBzAdB8y24a8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfETJ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:28:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731436AbfETJ2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:28:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAA62ABD7;
        Mon, 20 May 2019 09:28:02 +0000 (UTC)
Date:   Mon, 20 May 2019 11:28:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190520092801.GA6836@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-8-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc linux-api]

On Mon 20-05-19 12:52:54, Minchan Kim wrote:
> System could have much faster swap device like zRAM. In that case, swapping
> is extremely cheaper than file-IO on the low-end storage.
> In this configuration, userspace could handle different strategy for each
> kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
> while it keeps file-backed pages in inactive LRU by MADV_COOL because
> file IO is more expensive in this case so want to keep them in memory
> until memory pressure happens.
> 
> To support such strategy easier, this patch introduces
> MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
> that /proc/<pid>/clear_refs already has supported same filters.
> They are filters could be Ored with other existing hints using top two bits
> of (int behavior).

madvise operates on top of ranges and it is quite trivial to do the
filtering from the userspace so why do we need any additional filtering?

> Once either of them is set, the hint could affect only the interested vma
> either anonymous or file-backed.
> 
> With that, user could call a process_madvise syscall simply with a entire
> range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> MADV_FILE_FILTER so there is no need to call the syscall range by range.

OK, so here is the reason you want that. The immediate question is why
cannot the monitor do the filtering from the userspace. Slightly more
work, all right, but less of an API to expose and that itself is a
strong argument against.

> * from v1r2
>   * use consistent check with clear_refs to identify anon/file vma - surenb
> 
> * from v1r1
>   * use naming "filter" for new madvise option - dancol
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/uapi/asm-generic/mman-common.h |  5 +++++
>  mm/madvise.c                           | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index b8e230de84a6..be59a1b90284 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -66,6 +66,11 @@
>  #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>  #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
>  
> +#define MADV_BEHAVIOR_MASK (~(MADV_ANONYMOUS_FILTER|MADV_FILE_FILTER))
> +
> +#define MADV_ANONYMOUS_FILTER	(1<<31)	/* works for only anonymous vma */
> +#define MADV_FILE_FILTER	(1<<30)	/* works for only file-backed vma */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f4f569dac2bd..116131243540 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1002,7 +1002,15 @@ static int madvise_core(struct task_struct *tsk, unsigned long start,
>  	int write;
>  	size_t len;
>  	struct blk_plug plug;
> +	bool anon_only, file_only;
>  
> +	anon_only = behavior & MADV_ANONYMOUS_FILTER;
> +	file_only = behavior & MADV_FILE_FILTER;
> +
> +	if (anon_only && file_only)
> +		return error;
> +
> +	behavior = behavior & MADV_BEHAVIOR_MASK;
>  	if (!madvise_behavior_valid(behavior))
>  		return error;
>  
> @@ -1067,12 +1075,18 @@ static int madvise_core(struct task_struct *tsk, unsigned long start,
>  		if (end < tmp)
>  			tmp = end;
>  
> +		if (anon_only && vma->vm_file)
> +			goto next;
> +		if (file_only && !vma->vm_file)
> +			goto next;
> +
>  		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
>  		error = madvise_vma(tsk, vma, &prev, start, tmp,
>  					behavior, &pages);
>  		if (error)
>  			goto out;
>  		*nr_pages += pages;
> +next:
>  		start = tmp;
>  		if (prev && start < prev->vm_end)
>  			start = prev->vm_end;
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Michal Hocko
SUSE Labs
