Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5639C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921FF21841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558682513;
	bh=P0nnI44DVZJnxfL+EfnoxaCulgCU6SZKjH2WRP5JW8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mz/0NVWv5/D+oEiA4q6NsOeApggCE9DIN4fv3+1AfhXgrAWFFX0BKr7F3TjLxeiWY
	 uCUEtG5rFa1QvSxQiauAlZmfuLBSfftDO8Sll+4QER16fOi5Y+/6IY+bzh03OnRMfQ
	 97OVYs34lOhlM8MlOR47AcLPNxXIhi44WEtBI0EE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389092AbfEXHVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:21:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35887 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388979AbfEXHVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:21:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so4558101pgb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fv5+nm9pyA3wW2Yn2fm+/s4r+RxIRtXfbrcB1oGclRQ=;
        b=tQr1+CHLhSxOLxdBf9R6McAd4uQ8rZ1Ua9L6BOM1JAc+hT9gadNjbMJU8W5GgEu+LC
         z6D5XBMOTqpJDXA3TZ/I88MEtXEZ6FpTiUqQRR8ZWUseyiZReAlaYFFVOLju++gBI+o0
         3FzExXa+quM5A7W796fNKHMqI6BK+7ZwY6L6SQDOY+fnPzt4Pu4aFMypL2Mh9IuLSxZU
         rLiFkMRHRcRRoaZsQH3jcdScdW/2qB211cCoqM4hXZDcC+eSE22goJnAUBcbUaiAZBtZ
         xH++SEVfTGL23WCcBSWWZXe+1I90TIympdPo14YFspEhiy8AOOqQzUr95LGsaLoan15i
         /5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fv5+nm9pyA3wW2Yn2fm+/s4r+RxIRtXfbrcB1oGclRQ=;
        b=GoHJHPN5WROeiPV3DYHG2+6w29P1uQDvrhAxRr9m/FLCw9+xFJa2ztrnnYAaZO9HrD
         jfQ3tNjPBrMolyuDTMDJzaxSrYPaO1IODH5mDzVluSstFzqYxL0LgEFJwW50tWDf1aIF
         YHttjhfydAt1zJnX3dszot3ohyxyY9Y5IMwlbWuersturr0gXoE6xvyrFZ7kVRpWoRDz
         y8zyNyCK6kr7kpkWSlhOqEl4Mf6W1Y+iVQpXZ4iCjQ74K7BXV0ZHYep2bdCosSPI0NCC
         I5mfXZsdyOi4FaihzmTHIfny5XyMkZq9bVPhMUMqhyuZLb6YLBYbpeJYiJq7gLYVjrK3
         d04Q==
X-Gm-Message-State: APjAAAVo8D98RrTumnr7VY9qPSJRv544A5Dnpqvb1FEOKH7JZs08t7qZ
        qV93Ym7zE4a8jIVfNMovQMu+3vUi
X-Google-Smtp-Source: APXvYqwTvdGDLS5BHxN58x5vGKEyCb4Q5CzWRoI9yTEqRDPGj3r1pmOuxVt4F2S+eHLXZ/nB2IOLaw==
X-Received: by 2002:a63:1d05:: with SMTP id d5mr102496701pgd.157.1558682510773;
        Fri, 24 May 2019 00:21:50 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id n27sm3036263pfb.129.2019.05.24.00.21.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 00:21:49 -0700 (PDT)
Date:   Fri, 24 May 2019 16:21:45 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@kernel.org,
        Wu Fangsuo <fangsuowu@asrmicro.com>
Subject: Re: [PATCH] mm: fix trying to reclaim unevicable LRU page
Message-ID: <20190524072145.GA106222@google.com>
References: <20190524071114.74202-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524071114.74202-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 04:11:14PM +0900, Minchan Kim wrote:
> There was below bugreport from Wu Fangsuo.
> 
> 7200 [  680.491097] c4 7125 (syz-executor) page:ffffffbf02f33b40 count:86 mapcount:84 mapping:ffffffc08fa7a810 index:0x24
> 7201 [  680.531186] c4 7125 (syz-executor) flags: 0x19040c(referenced|uptodate|arch_1|mappedtodisk|unevictable|mlocked)
> 7202 [  680.544987] c0 7125 (syz-executor) raw: 000000000019040c ffffffc08fa7a810 0000000000000024 0000005600000053
> 7203 [  680.556162] c0 7125 (syz-executor) raw: ffffffc009b05b20 ffffffc009b05b20 0000000000000000 ffffffc09bf3ee80
> 7204 [  680.566860] c0 7125 (syz-executor) page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page))
> 7205 [  680.578038] c0 7125 (syz-executor) page->mem_cgroup:ffffffc09bf3ee80
> 7206 [  680.585467] c0 7125 (syz-executor) ------------[ cut here ]------------
> 7207 [  680.592466] c0 7125 (syz-executor) kernel BUG at /home/build/farmland/adroid9.0/kernel/linux/mm/vmscan.c:1350!
> 7223 [  680.603663] c0 7125 (syz-executor) Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> 7224 [  680.611436] c0 7125 (syz-executor) Modules linked in:
> 7225 [  680.616769] c0 7125 (syz-executor) CPU: 0 PID: 7125 Comm: syz-executor Tainted: G S              4.14.81 #3
> 7226 [  680.626826] c0 7125 (syz-executor) Hardware name: ASR AQUILAC EVB (DT)
> 7227 [  680.633623] c0 7125 (syz-executor) task: ffffffc00a54cd00 task.stack: ffffffc009b00000
> 7228 [  680.641917] c0 7125 (syz-executor) PC is at shrink_page_list+0x1998/0x3240
> 7229 [  680.649144] c0 7125 (syz-executor) LR is at shrink_page_list+0x1998/0x3240
> 7230 [  680.656303] c0 7125 (syz-executor) pc : [<ffffff90083a2158>] lr : [<ffffff90083a2158>] pstate: 60400045
> 7231 [  680.666086] c0 7125 (syz-executor) sp : ffffffc009b05940
> ..
> 7342 [  681.671308] c0 7125 (syz-executor) [<ffffff90083a2158>] shrink_page_list+0x1998/0x3240
> 7343 [  681.679567] c0 7125 (syz-executor) [<ffffff90083a3dc0>] reclaim_clean_pages_from_list+0x3c0/0x4f0
> 7344 [  681.688793] c0 7125 (syz-executor) [<ffffff900837ed64>] alloc_contig_range+0x3bc/0x650
> 7347 [  681.717421] c0 7125 (syz-executor) [<ffffff90084925cc>] cma_alloc+0x214/0x668
> 7348 [  681.724892] c0 7125 (syz-executor) [<ffffff90091e4d78>] ion_cma_allocate+0x98/0x1d8
> 7349 [  681.732872] c0 7125 (syz-executor) [<ffffff90091e0b20>] ion_alloc+0x200/0x7e0
> 7350 [  681.740302] c0 7125 (syz-executor) [<ffffff90091e154c>] ion_ioctl+0x18c/0x378
> 7351 [  681.747738] c0 7125 (syz-executor) [<ffffff90084c6824>] do_vfs_ioctl+0x17c/0x1780
> 7352 [  681.755514] c0 7125 (syz-executor) [<ffffff90084c7ed4>] SyS_ioctl+0xac/0xc0
> 
> Wu found it's due to [1]. Before that, unevictable page goes to cull_mlocked
> routine so that it couldn't reach the VM_BUG_ON_PAGE line.
> 
> To fix the issue, this patch filter out unevictable LRU pages
> from the reclaim_clean_pages_from_list in CMA.
> 
> [1] ad6b67041a45, mm: remove SWAP_MLOCK in ttu
> 
> Cc: <stable@kernel.org>	[4.12+]
> Reported-debugged-by: Wu Fangsuo <fangsuowu@asrmicro.com>
Tested-by: Wu Fangsuo <fangsuowu@asrmicro.com>

I forgot to add his Tested-by. Sorry about that.
