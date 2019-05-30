Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FE2C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884DC2441F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559184157;
	bh=fpQwtVYS8Q3fwvlupBdY1DrHvD+ge5LazUo4zJgiUTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hV+JTfSVlhBvjR5GDhj+cmA0mFj7eI+TAhRXMrzzf+IzjBFT6L2b1p8VqXsmcmNuD
	 OifmmHZ4AZ96REcGM6Cxpm2fy/PhDLWoeNrXrUfJQhMGJE+ZpqiVlQUCys20RO8nNp
	 UzN7NWNf1zoXFP1sqbo0gJw5ZkJeIJspK0jVXJ5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfE3Cmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:42:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45945 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3Cmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:42:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so2916249pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cAqqipIPGzpGmQv8QEqqienVSy4sBtVzv6/oGKxRvNw=;
        b=B6mihvkll3Cv/asD+7MCKFcDmWqt5uSxKQQ3LSzu1iASiaf06/7zkpIngAFvLAv0bl
         B+aYF5ytYSaFHBbIGadVj2ljU+kQ0s5yUrKycApUHcYdY4X5BTsiGFUhrjugH4FhzscK
         zpb6NywD0+vPRFEeKhapl0tQVhw0TQv1oLH0sDr1ARE2mlIHBZF/3j88OZ9yt6L9WunP
         s4yjNO8ZH4K1xHVn0CbW7cc6T5p8SkxLfV68bdo+tUZ4B/R8v1OZbhjUKhIXHQF5EsJu
         aO9lB+uNI2MhMvFqE7MGcBlSgy6WEK+DFAhmKdCOtVw8y6jo3RmOeh4wYCGzIwbXduDl
         I+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cAqqipIPGzpGmQv8QEqqienVSy4sBtVzv6/oGKxRvNw=;
        b=GmsK9W4v6a37CE0OC3AgS20SoAuqnFFNcbpwQQtmt5/cvMd+Qrnrdo5jQdq1oJsjUo
         ideNA+jNOm/rd5Yr+azH/VIJnkPsM7lkUDsmRxVPlqm/4G+fU7fvwXujOLGsdv3SEwp1
         4I3BYJqAQHlWGQLiI8tNqrWja+BrlK46tw4x1Vih8xLTxDqslHtmNfkzKSyQZP4xncPm
         4/PAXikLKd/sZtOHz6o/6ec8rqtLSgk30k3IUecLbsaL1iDAnbl0karbTosJBfQ/Htkh
         0Vsa6Cr+HeAMAHAu7ASAGrG54wNfXYQsXHukYxWC27UUMWwWd+Yyw4o37YX0dNAAD5vJ
         v1Zg==
X-Gm-Message-State: APjAAAXGLdkJTRLH6D4wPKLYWGdLi6nbjCrPDV46569bPydWaz6onNPa
        0vqtt1Myz8kcqALPlFIMJMNhpK4c
X-Google-Smtp-Source: APXvYqzpiodDhC19KrjAAAfJJz5B5HC6YSFCqpiu06yRKe4Odk+Fo+ObevDVElvTks6QKFvGWW236A==
X-Received: by 2002:aa7:8598:: with SMTP id w24mr1198933pfn.160.1559184154693;
        Wed, 29 May 2019 19:42:34 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j23sm352061pff.90.2019.05.29.19.42.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 19:42:33 -0700 (PDT)
Date:   Thu, 30 May 2019 11:42:29 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@kernel.org,
        Wu Fangsuo <fangsuowu@asrmicro.com>,
        Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Subject: Re: [PATCH] mm: fix trying to reclaim unevicable LRU page
Message-ID: <20190530024229.GF229459@google.com>
References: <20190524071114.74202-1-minchan@kernel.org>
 <20190528151407.GE1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528151407.GE1658@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 05:14:07PM +0200, Michal Hocko wrote:
> [Cc Pankaj Suryawanshi who has reported a similar problem
> http://lkml.kernel.org/r/SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com]
> 
> On Fri 24-05-19 16:11:14, Minchan Kim wrote:
> > There was below bugreport from Wu Fangsuo.
> > 
> > 7200 [  680.491097] c4 7125 (syz-executor) page:ffffffbf02f33b40 count:86 mapcount:84 mapping:ffffffc08fa7a810 index:0x24
> > 7201 [  680.531186] c4 7125 (syz-executor) flags: 0x19040c(referenced|uptodate|arch_1|mappedtodisk|unevictable|mlocked)
> > 7202 [  680.544987] c0 7125 (syz-executor) raw: 000000000019040c ffffffc08fa7a810 0000000000000024 0000005600000053
> > 7203 [  680.556162] c0 7125 (syz-executor) raw: ffffffc009b05b20 ffffffc009b05b20 0000000000000000 ffffffc09bf3ee80
> > 7204 [  680.566860] c0 7125 (syz-executor) page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page))
> > 7205 [  680.578038] c0 7125 (syz-executor) page->mem_cgroup:ffffffc09bf3ee80
> > 7206 [  680.585467] c0 7125 (syz-executor) ------------[ cut here ]------------
> > 7207 [  680.592466] c0 7125 (syz-executor) kernel BUG at /home/build/farmland/adroid9.0/kernel/linux/mm/vmscan.c:1350!
> > 7223 [  680.603663] c0 7125 (syz-executor) Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > 7224 [  680.611436] c0 7125 (syz-executor) Modules linked in:
> > 7225 [  680.616769] c0 7125 (syz-executor) CPU: 0 PID: 7125 Comm: syz-executor Tainted: G S              4.14.81 #3
> > 7226 [  680.626826] c0 7125 (syz-executor) Hardware name: ASR AQUILAC EVB (DT)
> > 7227 [  680.633623] c0 7125 (syz-executor) task: ffffffc00a54cd00 task.stack: ffffffc009b00000
> > 7228 [  680.641917] c0 7125 (syz-executor) PC is at shrink_page_list+0x1998/0x3240
> > 7229 [  680.649144] c0 7125 (syz-executor) LR is at shrink_page_list+0x1998/0x3240
> > 7230 [  680.656303] c0 7125 (syz-executor) pc : [<ffffff90083a2158>] lr : [<ffffff90083a2158>] pstate: 60400045
> > 7231 [  680.666086] c0 7125 (syz-executor) sp : ffffffc009b05940
> > ..
> > 7342 [  681.671308] c0 7125 (syz-executor) [<ffffff90083a2158>] shrink_page_list+0x1998/0x3240
> > 7343 [  681.679567] c0 7125 (syz-executor) [<ffffff90083a3dc0>] reclaim_clean_pages_from_list+0x3c0/0x4f0
> > 7344 [  681.688793] c0 7125 (syz-executor) [<ffffff900837ed64>] alloc_contig_range+0x3bc/0x650
> > 7347 [  681.717421] c0 7125 (syz-executor) [<ffffff90084925cc>] cma_alloc+0x214/0x668
> > 7348 [  681.724892] c0 7125 (syz-executor) [<ffffff90091e4d78>] ion_cma_allocate+0x98/0x1d8
> > 7349 [  681.732872] c0 7125 (syz-executor) [<ffffff90091e0b20>] ion_alloc+0x200/0x7e0
> > 7350 [  681.740302] c0 7125 (syz-executor) [<ffffff90091e154c>] ion_ioctl+0x18c/0x378
> > 7351 [  681.747738] c0 7125 (syz-executor) [<ffffff90084c6824>] do_vfs_ioctl+0x17c/0x1780
> > 7352 [  681.755514] c0 7125 (syz-executor) [<ffffff90084c7ed4>] SyS_ioctl+0xac/0xc0
> > 
> > Wu found it's due to [1]. Before that, unevictable page goes to cull_mlocked
> > routine so that it couldn't reach the VM_BUG_ON_PAGE line.
> > 
> > To fix the issue, this patch filter out unevictable LRU pages
> > from the reclaim_clean_pages_from_list in CMA.
> 
> The changelog is rather modest on details and I have to confess I have
> little bit hard time to understand it. E.g. why do not we need to handle
> the regular reclaim path?

No need to pass unevictable pages into regular reclaim patch if we are
able to know in advance.

> 
> > [1] ad6b67041a45, mm: remove SWAP_MLOCK in ttu
> > 
> > Cc: <stable@kernel.org>	[4.12+]
> > Reported-debugged-by: Wu Fangsuo <fangsuowu@asrmicro.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d9c3e873eca6..7350afae5c3c 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1505,7 +1505,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> >  
> >  	list_for_each_entry_safe(page, next, page_list, lru) {
> >  		if (page_is_file_cache(page) && !PageDirty(page) &&
> > -		    !__PageMovable(page)) {
> > +		    !__PageMovable(page) && !PageUnevictable(page)) {
> >  			ClearPageActive(page);
> >  			list_move(&page->lru, &clean_pages);
> >  		}
> > -- 
> > 2.22.0.rc1.257.g3120a18244-goog
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
