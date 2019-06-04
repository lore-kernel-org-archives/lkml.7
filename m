Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A33C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4C523F50
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559651291;
	bh=pIKD4xwISJcMzjs4SplHZMMR4uGLluBI2kEPK1CoxQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YVbfz0r+a1MwpVSuDuUNKhZ5oHpXvtsdstkii3NMHYv9hW2MXrNqQW+W3MzRvaP0C
	 QtyVXYr3U2HuhYeCu2xv+glkxNtF8Mbof/Mxt84PCYfeC4AgtptBmeWVI6ls/4Hhcy
	 74FCk1hcPOucqKRoms2d429sSEUq/XKTPw1Rj2ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfFDM2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:28:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbfFDM2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:28:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 042C8AFBE;
        Tue,  4 Jun 2019 12:28:07 +0000 (UTC)
Date:   Tue, 4 Jun 2019 14:28:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@kernel.org,
        Wu Fangsuo <fangsuowu@asrmicro.com>,
        Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Subject: Re: [PATCH] mm: fix trying to reclaim unevicable LRU page
Message-ID: <20190604122806.GH4669@dhcp22.suse.cz>
References: <20190524071114.74202-1-minchan@kernel.org>
 <20190528151407.GE1658@dhcp22.suse.cz>
 <20190530024229.GF229459@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530024229.GF229459@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-05-19 11:42:29, Minchan Kim wrote:
> On Tue, May 28, 2019 at 05:14:07PM +0200, Michal Hocko wrote:
> > [Cc Pankaj Suryawanshi who has reported a similar problem
> > http://lkml.kernel.org/r/SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com]
> > 
> > On Fri 24-05-19 16:11:14, Minchan Kim wrote:
> > > There was below bugreport from Wu Fangsuo.
> > > 
> > > 7200 [  680.491097] c4 7125 (syz-executor) page:ffffffbf02f33b40 count:86 mapcount:84 mapping:ffffffc08fa7a810 index:0x24
> > > 7201 [  680.531186] c4 7125 (syz-executor) flags: 0x19040c(referenced|uptodate|arch_1|mappedtodisk|unevictable|mlocked)
> > > 7202 [  680.544987] c0 7125 (syz-executor) raw: 000000000019040c ffffffc08fa7a810 0000000000000024 0000005600000053
> > > 7203 [  680.556162] c0 7125 (syz-executor) raw: ffffffc009b05b20 ffffffc009b05b20 0000000000000000 ffffffc09bf3ee80
> > > 7204 [  680.566860] c0 7125 (syz-executor) page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page))
> > > 7205 [  680.578038] c0 7125 (syz-executor) page->mem_cgroup:ffffffc09bf3ee80
> > > 7206 [  680.585467] c0 7125 (syz-executor) ------------[ cut here ]------------
> > > 7207 [  680.592466] c0 7125 (syz-executor) kernel BUG at /home/build/farmland/adroid9.0/kernel/linux/mm/vmscan.c:1350!
> > > 7223 [  680.603663] c0 7125 (syz-executor) Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > > 7224 [  680.611436] c0 7125 (syz-executor) Modules linked in:
> > > 7225 [  680.616769] c0 7125 (syz-executor) CPU: 0 PID: 7125 Comm: syz-executor Tainted: G S              4.14.81 #3
> > > 7226 [  680.626826] c0 7125 (syz-executor) Hardware name: ASR AQUILAC EVB (DT)
> > > 7227 [  680.633623] c0 7125 (syz-executor) task: ffffffc00a54cd00 task.stack: ffffffc009b00000
> > > 7228 [  680.641917] c0 7125 (syz-executor) PC is at shrink_page_list+0x1998/0x3240
> > > 7229 [  680.649144] c0 7125 (syz-executor) LR is at shrink_page_list+0x1998/0x3240
> > > 7230 [  680.656303] c0 7125 (syz-executor) pc : [<ffffff90083a2158>] lr : [<ffffff90083a2158>] pstate: 60400045
> > > 7231 [  680.666086] c0 7125 (syz-executor) sp : ffffffc009b05940
> > > ..
> > > 7342 [  681.671308] c0 7125 (syz-executor) [<ffffff90083a2158>] shrink_page_list+0x1998/0x3240
> > > 7343 [  681.679567] c0 7125 (syz-executor) [<ffffff90083a3dc0>] reclaim_clean_pages_from_list+0x3c0/0x4f0
> > > 7344 [  681.688793] c0 7125 (syz-executor) [<ffffff900837ed64>] alloc_contig_range+0x3bc/0x650
> > > 7347 [  681.717421] c0 7125 (syz-executor) [<ffffff90084925cc>] cma_alloc+0x214/0x668
> > > 7348 [  681.724892] c0 7125 (syz-executor) [<ffffff90091e4d78>] ion_cma_allocate+0x98/0x1d8
> > > 7349 [  681.732872] c0 7125 (syz-executor) [<ffffff90091e0b20>] ion_alloc+0x200/0x7e0
> > > 7350 [  681.740302] c0 7125 (syz-executor) [<ffffff90091e154c>] ion_ioctl+0x18c/0x378
> > > 7351 [  681.747738] c0 7125 (syz-executor) [<ffffff90084c6824>] do_vfs_ioctl+0x17c/0x1780
> > > 7352 [  681.755514] c0 7125 (syz-executor) [<ffffff90084c7ed4>] SyS_ioctl+0xac/0xc0
> > > 
> > > Wu found it's due to [1]. Before that, unevictable page goes to cull_mlocked
> > > routine so that it couldn't reach the VM_BUG_ON_PAGE line.
> > > 
> > > To fix the issue, this patch filter out unevictable LRU pages
> > > from the reclaim_clean_pages_from_list in CMA.
> > 
> > The changelog is rather modest on details and I have to confess I have
> > little bit hard time to understand it. E.g. why do not we need to handle
> > the regular reclaim path?
> 
> No need to pass unevictable pages into regular reclaim patch if we are
> able to know in advance.

I am sorry to be dense here. So what is the difference in the CMA path?
Am I right that the pfn walk (CMA) rather than LRU isolation (reclaim)
is the key differentiator?

-- 
Michal Hocko
SUSE Labs
