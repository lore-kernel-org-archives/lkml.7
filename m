Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B159C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF51E20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="f2zpZBa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbfJDM4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:56:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35238 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfJDM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:56:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so5678942qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5kwGEONOr8AOSn6EFEvVHjQeyOn2OhP0M5v8WbfNWw=;
        b=f2zpZBa/vbJqe19iIFj6HGRQhA+LQpU+u6pYvW3yCGXvgF4L13qIVyjCxcY5Bii96X
         p7a1+R8DBav8dUB2TzTNMViX8X/0wl5PoU12IqQ+OLBS8SgLyXWhUhhVI39Z+ap1okbo
         5qlEBUtTDgWUQ7Gd4a9KSHLCZ6ofJVwglagVo4TQ3AkIhABY5tYwAUURf7sh5xNrPBtJ
         v6ou9tgEZvF0ZPaVN9ei73xSkj4LzdofemBLXOKSph6d7xacPqPrmPMmzE6mMx6AlnIQ
         IwCUOtmO8UxsAJ1W88MfzFN8dKrNKCGxSSc9BfBecGdWnaC7qyc9m2v5XEgUw2miEJpY
         SnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5kwGEONOr8AOSn6EFEvVHjQeyOn2OhP0M5v8WbfNWw=;
        b=CFvjoHSFKO//7KRe+sI05La+dZhjIWeQ+C57+EppXad4T714l059Ge1y6xxJsImATp
         uxEv1xn2jG7ZOK2o2mMo0yn46YDjPZpFAvXjY3q689gS0hwoMPJVOMrgNoxAj1sWk/Hl
         mDC+saMuEE9rRSWCURYR5gZnWwEpS6kxQN75/FFNso/5MCXHEjQ74dpfQIuT2f4bsiNG
         iOcfYzy5EgP7f/Cle6/pP3GXoijBXwCqlNXw0MuSY55XFfUBZ6RY3loTTgos1Rh4j5I/
         tYfCF7Qwq69OrlqfF5EZ3HiNorxiJj2//CUpk7WVG3fQb+Rpn42tIonS/Dc5zaIHpNXS
         dIkg==
X-Gm-Message-State: APjAAAXxLMRq0aVeBU1LYeoUGgIGjFm2d0zS8TBh4zaW1WE7qFLYr+R3
        6T7BqTNssdpz23h/2EYSyNWrNLneMXY=
X-Google-Smtp-Source: APXvYqymXdr8hEkPhwmVfii6CHwxxGtzid/3UCvVAGE2G9jO5AMLuK4lSlzHCvT3XgxJ62J/W7pgRA==
X-Received: by 2002:a37:a24f:: with SMTP id l76mr9558669qke.91.1570193778970;
        Fri, 04 Oct 2019 05:56:18 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 194sm2525376qkm.62.2019.10.04.05.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 05:56:18 -0700 (PDT)
Message-ID: <1570193776.5576.270.camel@lca.pw>
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
From:   Qian Cai <cai@lca.pw>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Oct 2019 08:56:16 -0400
In-Reply-To: <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
         <20191004105824.GD9578@dhcp22.suse.cz>
         <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 17:14 +0530, Anshuman Khandual wrote:
> 
> On 10/04/2019 04:28 PM, Michal Hocko wrote:
> > On Thu 03-10-19 13:40:57, Anshuman Khandual wrote:
> > > Having unmovable pages on a given pageblock should be reported correctly
> > > when required with REPORT_FAILURE flag. But there can be a scenario where a
> > > reserved page in the page block will get reported as a generic "unmovable"
> > > reason code. Instead this should be changed to a more appropriate reason
> > > code like "Reserved page".
> > 
> > Others have already pointed out this is just redundant but I will have a
> 
> Sure.
> 
> > more generic comment on the changelog. There is essentially no
> > information why the current state is bad/unhelpful and why the chnage is
> 
> The current state is not necessarily bad or unhelpful. I just though that it
> could be improved upon. Some how calling out explicitly only the CMA page
> failure case just felt adhoc, where as there are other reasons like HugeTLB
> immovability which might depend on other factors apart from just page flags
> (though I did not propose that originally).
> 
> > needed. All you claim is that something is a certain way and then assert
> > that it should be done differently. That is not how changelogs should
> > look like.
> > 
> 
> Okay, probably I should have explained more on why "unmovable" is less than
> adequate to capture the exact reason for specific failure cases and how
> "Reserved Page" instead would been better. But got the point, will improve.
> 

It might be a good time to rethink if it is really a good idea to dump_page()
at all inside has_unmovable_pages(). As it is right now, it is a a potential
deadlock between console vs memory offline. More details are in this thread,

https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/

01: [  672.875392] WARNING: possible circular locking dependency detected       
01: [  672.875394] 5.4.0-rc1-next-20191004+ #64 Not tainted                     
01: [  672.875396] ------------------------------------------------------       
01: [  672.875398] test.sh/1724 is trying to acquire lock:                      
01: [  672.875400] 0000000052059ec0 (console_owner){-...}, at: console_unlock+0x
01: 328/0xa30                                                                   
01: [  672.875406]                                                              
01: [  672.875408] but task is already holding lock:                            
01: [  672.875409] 000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at: start_iso
01: late_page_range+0x216/0x538                                                 
01: [  672.875415]                                                              
01: [  672.875417] which lock already depends on the new lock.                  
01: [  672.875418]                                                              
01: [  672.875419]                                                              
01: [  672.875421] the existing dependency chain (in reverse order) is:         
01: [  672.875423]                                                              
01: [  672.875424] -> #2 (&(&zone->lock)->rlock){-.-.}:                         
01: [  672.875430]        lock_acquire+0x21a/0x468                              
01: [  672.875431]        _raw_spin_lock+0x54/0x68                              
01: [  672.875433]        get_page_from_freelist+0x8b6/0x2d28                   
01: [  672.875435]        __alloc_pages_nodemask+0x246/0x658                    
01: [  672.875437]        __get_free_pages+0x34/0x78                            
01: [  672.875438]        sclp_init+0x106/0x690                                 
01: [  672.875440]        sclp_register+0x2e/0x248                              
01: [  672.875442]        sclp_rw_init+0x4a/0x70                                
01: [  672.875443]        sclp_console_init+0x4a/0x1b8                          
01: [  672.875445]        console_init+0x2c8/0x410                              
01: [  672.875447]        start_kernel+0x530/0x6a0                              
01: [  672.875448]        startup_continue+0x70/0xd0                            
01: [  672.875449]                                                              
01: [  672.875450] -> #1 (sclp_lock){-.-.}:                                     
01: [  672.875458]        lock_acquire+0x21a/0x468                              
01: [  672.875460]        _raw_spin_lock_irqsave+0xcc/0xe8                      
01: [  672.875462]        sclp_add_request+0x34/0x308                           
01: [  672.875464]        sclp_conbuf_emit+0x100/0x138                          
01: [  672.875465]        sclp_console_write+0x96/0x3b8                         
01: [  672.875467]        console_unlock+0x6dc/0xa30                            
01: [  672.875469]        vprintk_emit+0x184/0x3c8                              
01: [  672.875470]        vprintk_default+0x44/0x50                             
01: [  672.875472]        printk+0xa8/0xc0                                      
01: [  672.875473]        iommu_debugfs_setup+0xf2/0x108                        
01: [  672.875475]        iommu_init+0x6c/0x78                                  
01: [  672.875477]        do_one_initcall+0x162/0x680                           
01: [  672.875478]        kernel_init_freeable+0x4e8/0x5a8                      
01: [  672.875480]        kernel_init+0x2a/0x188                                
01: [  672.875484]        ret_from_fork+0x30/0x34                               
01: [  672.875486]        kernel_thread_starter+0x0/0xc                         
01: [  672.875487]                                                              
01: [  672.875488] -> #0 (console_owner){-...}:                                 
01: [  672.875495]        check_noncircular+0x338/0x3e0                         
01: [  672.875496]        __lock_acquire+0x1e66/0x2d88                          
01: [  672.875498]        lock_acquire+0x21a/0x468                              
01: [  672.875499]        console_unlock+0x3a6/0xa30                            
01: [  672.875501]        vprintk_emit+0x184/0x3c8                              
01: [  672.875503]        vprintk_default+0x44/0x50                             
01: [  672.875504]        printk+0xa8/0xc0                                      
01: [  672.875506]        __dump_page+0x1dc/0x710                               
01: [  672.875507]        dump_page+0x2e/0x58                                   
01: [  672.875509]        has_unmovable_pages+0x2e8/0x470                       
01: [  672.875511]        start_isolate_page_range+0x404/0x538                  
01: [  672.875513]        __offline_pages+0x22c/0x1338                          
01: [  672.875514]        memory_subsys_offline+0xa6/0xe8                       
01: [  672.875516]        device_offline+0xe6/0x118                             
01: [  672.875517]        state_store+0xf0/0x110                                
01: [  672.875519]        kernfs_fop_write+0x1bc/0x270                          
01: [  672.875521]        vfs_write+0xce/0x220                                  
01: [  672.875522]        ksys_write+0xea/0x190                                 
01: [  672.875524]        system_call+0xd8/0x2b4                                
01: [  672.875525]                                                              
01: [  672.875527] other info that might help us debug this:                    
01: [  672.875528]                                                              
01: [  672.875529] Chain exists of:                                             
01: [  672.875530]   console_owner --> sclp_lock --> &(&zone->lock)->rlock      
01: [  672.875538]                                                              
01: [  672.875540]  Possible unsafe locking scenario:                           
01: [  672.875541]                                                              
01: [  672.875543]        CPU0                    CPU1                          
01: [  672.875544]        ----                    ----                          
01: [  672.875545]   lock(&(&zone->lock)->rlock);                               
01: [  672.875549]                                lock(sclp_lock);              
01: [  672.875553]                                lock(&(&zone->lock)->rlock);  
01: [  672.875557]   lock(console_owner);                                       
01: [  672.875560]                                                              
01: [  672.875562]  *** DEADLOCK ***                                            
01: [  672.875563]                                                              
01: [  672.875564] 9 locks held by test.sh/1724:                                
01: [  672.875565]  #0: 000000000e925408 (sb_writers#4){.+.+}, at: vfs_write+0x2
01: 06/0x220                                                                    
01: [  672.875574]  #1: 0000000050aa4280 (&of->mutex){+.+.}, at: kernfs_fop_writ
01: e+0x154/0x270                                                               
01: [  672.875581]  #2: 0000000062e5c628 (kn->count#198){.+.+}, at: kernfs_fop_w
01: rite+0x16a/0x270                                                            
01: [  672.875590]  #3: 00000000523236a0 (device_hotplug_lock){+.+.}, at: lock_d
01: evice_hotplug_sysfs+0x30/0x80                                               
01: [  672.875598]  #4: 0000000062e70990 (&dev->mutex){....}, at: device_offline
01: +0x78/0x118                                                                 
01: [  672.875605]  #5: 0000000051fd36b0 (cpu_hotplug_lock.rw_sem){++++}, at: __
01: offline_pages+0xec/0x1338                                                   
01: [  672.875613]  #6: 00000000521ca470 (mem_hotplug_lock.rw_sem){++++}, at: pe
01: rcpu_down_write+0x38/0x210                                                  
01: [  672.875620]  #7: 000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at: star
01: t_isolate_page_range+0x216/0x538                                            
01: [  672.875628]  #8: 000000005205a100 (console_lock){+.+.}, at: vprintk_emit+
01: 0x178/0x3c8                                                                 
01: [  672.875635]                                                              
01: [  672.875636] stack backtrace:                                             
01: [  672.875639] CPU: 1 PID: 1724 Comm: test.sh Not tainted 5.4.0-rc1-next-201
01: 91004+ #64                                                                  
01: [  672.875640] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                 
01: [  672.875642] Call Trace:                                                  
01: [  672.875644] ([<00000000512ae218>] show_stack+0x110/0x1b0)                
01: [  672.875645]  [<0000000051b6d506>] dump_stack+0x126/0x178                 
01: [  672.875648]  [<00000000513a4b08>] check_noncircular+0x338/0x3e0          
01: [  672.875650]  [<00000000513aaaf6>] __lock_acquire+0x1e66/0x2d88           
01: [  672.875652]  [<00000000513a7e12>] lock_acquire+0x21a/0x468               
01: [  672.875654]  [<00000000513bb2fe>] console_unlock+0x3a6/0xa30             
01: [  672.875655]  [<00000000513bde2c>] vprintk_emit+0x184/0x3c8               
01: [  672.875657]  [<00000000513be0b4>] vprintk_default+0x44/0x50              
01: [  672.875659]  [<00000000513beb60>] printk+0xa8/0xc0                       
01: [  672.875661]  [<000000005158c364>] __dump_page+0x1dc/0x710                
01: [  672.875663]  [<000000005158c8c6>] dump_page+0x2e/0x58                    
01: [  672.875665]  [<00000000515d87c8>] has_unmovable_pages+0x2e8/0x470        
01: [  672.875667]  [<000000005167072c>] start_isolate_page_range+0x404/0x538   
01: [  672.875669]  [<0000000051b96de4>] __offline_pages+0x22c/0x1338           
01: [  672.875671]  [<0000000051908586>] memory_subsys_offline+0xa6/0xe8        
01: [  672.875673]  [<00000000518e561e>] device_offline+0xe6/0x118              
01: [  672.875675]  [<0000000051908170>] state_store+0xf0/0x110                 
01: [  672.875677]  [<0000000051796384>] kernfs_fop_write+0x1bc/0x270           
01: [  672.875679]  [<000000005168972e>] vfs_write+0xce/0x220                   
01: [  672.875681]  [<0000000051689b9a>] ksys_write+0xea/0x190                  
01: [  672.875685]  [<0000000051ba9990>] system_call+0xd8/0x2b4                 
01: [  672.875687] INFO: lockdep is turned off.
