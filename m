Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B5C35280
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E478D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XkqyIgN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfJHQIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:08:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40998 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:08:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id v52so3353071qtb.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxjNZlQYG8jEfpBToUghFIBdvGapeFR+FEJOvIusb4I=;
        b=XkqyIgN+sjsqSnsGeX/hDSf/NTtuGEL2T4gkaXkaZb0PtL5IU9zQR6xV88IuKhuKZ9
         atKiRSWXvqaXj1IZcrMzx1TlI85CagXz5ltl2HhWvSFDVEfyTtQrzfziQlj/NDjUXI/y
         6p1gPSxYKbnLbvUYtweCkZcHjMMddg97dsu7WVdiliG8ovYQgsiTzZFgfM5DjDvdc4NZ
         I9DfQEISLpilKeeMGcoaLVSnOoB4Azd7I8iC8aLbYbZbdqcHrRqzqjaTfVPp8pnJvKHc
         vXIbteZEr0flZuBpODLZW3+6FZX0uKSORezHCWRCq89b8C41cEzkyahnOzMl7MQsktCU
         mKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxjNZlQYG8jEfpBToUghFIBdvGapeFR+FEJOvIusb4I=;
        b=kmnBIQGS6R3DVdI8GDSRPjHNoyg5Gh1+RxvOxQ96/dUPBgkfM8ccuxNaMvrpVMvYqm
         K1gJVJsxQuPUNbgVCVkz8UOebjdzvgSPL7TRRaAoSXk5gJR6xhoyDbxbmgg+4s5eSYhL
         VhrFHIC1D7adpajS9mlXqLoJxfJiw2VL14i2E5DTjtBw4Q71PpbWwGyxgtBD4HEvDkvt
         NDkGHmH4rrbSdK+a8wpqDX98uIS3DqEXMiFHwCEF99Iuz6/6nE5NjFoyZlCpT9NB/DVg
         B9L2deljphcXozvS6QlTYLJJKfEyt63mKQYsW4COxbStTGu6jdHJRSKAYdtIl28+iLyc
         q1Vw==
X-Gm-Message-State: APjAAAWKrAlZzqEeDI2uhLMie5Rk+mkseBRvaQyrDGKNbyBzPJ7xZ9Y/
        pNh+cl9MmWmXwSGji1Kg3m5M7Q==
X-Google-Smtp-Source: APXvYqzCII0QWHQkgFhN+MPx49HGp9mrvu4UNL8QuSZMctxtySoTwd7QQywoMxN66ZiFeQ/6+LOElg==
X-Received: by 2002:ac8:236c:: with SMTP id b41mr36289703qtb.253.1570550920270;
        Tue, 08 Oct 2019 09:08:40 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w14sm8556336qki.73.2019.10.08.09.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:08:39 -0700 (PDT)
Message-ID: <1570550917.5576.303.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 08 Oct 2019 12:08:37 -0400
In-Reply-To: <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <20191007144937.GO2381@dhcp22.suse.cz>
         <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
         <20191008082752.GB6681@dhcp22.suse.cz>
         <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 14:56 +0200, Christian Borntraeger wrote:
> Adding Peter Oberparleiter.
> Peter, can you have a look?
> 
> On 08.10.19 10:27, Michal Hocko wrote:
> > On Tue 08-10-19 09:43:57, Petr Mladek wrote:
> > > On Mon 2019-10-07 16:49:37, Michal Hocko wrote:
> > > > [Cc s390 maintainers - the lockdep is http://lkml.kernel.org/r/1570228005-24979-1-git-send-email-cai@lca.pw
> > > >  Petr has explained it is a false positive
> > > >  http://lkml.kernel.org/r/20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz]
> > > > On Mon 07-10-19 16:30:02, Petr Mladek wrote:
> > > > [...]
> > > > > I believe that it cannot really happen because:
> > > > > 
> > > > > 	static int __init
> > > > > 	sclp_console_init(void)
> > > > > 	{
> > > > > 	[...]
> > > > > 		rc = sclp_rw_init();
> > > > > 	[...]
> > > > > 		register_console(&sclp_console);
> > > > > 		return 0;
> > > > > 	}
> > > > > 
> > > > > sclp_rw_init() is called before register_console(). And
> > > > > console_unlock() will never call sclp_console_write() before
> > > > > the console is registered.
> > > > > 
> > > > > AFAIK, lockdep only compares existing chain of locks. It does
> > > > > not know about console registration that would make some
> > > > > code paths mutually exclusive.
> > > > > 
> > > > > I believe that it is a false positive. I do not know how to
> > > > > avoid this lockdep report. I hope that it will disappear
> > > > > by deferring all printk() calls rather soon.
> > > > 
> > > > Thanks a lot for looking into this Petr. I have also checked the code
> > > > and I really fail to see why the allocation has to be done under the
> > > > lock in the first place. sclp_read_sccb and sclp_init_sccb are global
> > > > variables but I strongly suspect that they need a synchronization during
> > > > early init, callbacks are registered only later IIUC:
> > > 
> > > Good idea. It would work when the init function is called only once.
> > > But see below.
> > > 
> > > > diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> > > > index d2ab3f07c008..4b1c033e3255 100644
> > > > --- a/drivers/s390/char/sclp.c
> > > > +++ b/drivers/s390/char/sclp.c
> > > > @@ -1169,13 +1169,13 @@ sclp_init(void)
> > > >  	unsigned long flags;
> > > >  	int rc = 0;
> > > >  
> > > > +	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > > > +	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > > >  	spin_lock_irqsave(&sclp_lock, flags);
> > > >  	/* Check for previous or running initialization */
> > > >  	if (sclp_init_state != sclp_init_state_uninitialized)
> > > >  		goto fail_unlock;
> > > 
> > > It seems that sclp_init() could be called several times in parallel.
> > > I see it called from sclp_register() and sclp_initcall().
> > 
> > Interesting. Something for s390 people to answer I guess.
> > Anyway, this should be quite trivial to workaround by a cmpxch or alike.
> > 

The above fix is simply insufficient,

00: [    3.654307] WARNING: possible circular locking dependency detected       
00: [    3.654309] 5.4.0-rc1-next-20191004+ #4 Not tainted                      
00: [    3.654311] ------------------------------------------------------       
00: [    3.654313] swapper/0/1 is trying to acquire lock:                       
00: [    3.654314] 00000000553f3fb8 (sclp_lock){-.-.}, at: sclp_add_request+0x34
00: /0x308                                                                      
00: [    3.654320]                                                              
00: [    3.654322] but task is already holding lock:                            
00: [    3.654323] 00000000550c9fc0 (console_owner){....}, at: console_unlock+0x
00: 328/0xa30                                                                   
00: [    3.654329]                                                              
00: [    3.654331] which lock already depends on the new lock.                  
00: [    3.654332]                                                              
00: [    3.654333]                                                              
00: [    3.654335] the existing dependency chain (in reverse order) is:         
00: [    3.654336]                                                              
00: [    3.654337] -> #3 (console_owner){....}:                                 
00: [    3.654343]        lock_acquire+0x21a/0x468                              
00: [    3.654345]        console_unlock+0x3a6/0xa30                            
00: [    3.654346]        vprintk_emit+0x184/0x3c8                              
00: [    3.654348]        vprintk_default+0x44/0x50                             
00: [    3.654349]        printk+0xa8/0xc0                                      
00: [    3.654351]        get_random_u64+0x40/0x108                             
00: [    3.654360]        add_to_free_area_random+0x188/0x1c0                   
00: [    3.654364]        free_one_page+0x72/0x128                              
00: [    3.654366]        __free_pages_ok+0x51c/0xca0                           
00: [    3.654368]        memblock_free_all+0x30a/0x3b0                         
00: [    3.654370]        mem_init+0x84/0x200                                   
00: [    3.654371]        start_kernel+0x384/0x6a0                              
00: [    3.654373]        startup_continue+0x70/0xd0                            
00: [    3.654374]                                                              
00: [    3.654375] -> #2 (&(&zone->lock)->rlock){....}:                         
00: [    3.654382]        lock_acquire+0x21a/0x468                              
00: [    3.654383]        _raw_spin_lock+0x54/0x68                              
00: [    3.654385]        get_page_from_freelist+0x8b6/0x2d28                   
00: [    3.654387]        __alloc_pages_nodemask+0x246/0x658                    
00: [    3.654389]        alloc_slab_page+0x43c/0x858                           
00: [    3.654390]        allocate_slab+0x90/0x6f0                              
00: [    3.654392]        new_slab+0x88/0x90                                    
00: [    3.654393]        ___slab_alloc+0x600/0x988                             
00: [    3.654395]        __slab_alloc+0x5a/0x90                                
00: [    3.654396]        kmem_cache_alloc+0x340/0x4c0                          
00: [    3.654398]        fill_pool+0x27a/0x498                                 
00: [    3.654400]        __debug_object_init+0xa8/0x858                        
00: [    3.654401]        debug_object_activate+0x208/0x370                     
00: [    3.654403]        __call_rcu+0xb6/0x4a8                                 
00: [    3.654405]        unregister_external_irq+0x13a/0x140                   
00: [    3.654406]        sclp_init+0x5e0/0x688                                 
00: [    3.654408]        sclp_register+0x2e/0x248                              
00: [    3.654409]        sclp_rw_init+0x4a/0x70                                
00: [    3.654411]        sclp_console_init+0x4a/0x1b8                          
00: [    3.654413]        console_init+0x2c8/0x410                              
00: [    3.654414]        start_kernel+0x530/0x6a0                              
00: [    3.654416]        startup_continue+0x70/0xd0                            
00: [    3.654417]                                                              
00: [    3.654418] -> #1 (ext_int_hash_lock){....}:                             
00: [    3.654424]        lock_acquire+0x21a/0x468                              
00: [    3.654426]        _raw_spin_lock_irqsave+0xcc/0xe8                      
00: [    3.654427]        register_external_irq+0xb6/0x138                      
00: [    3.654429]        sclp_init+0x212/0x688                                 
00: [    3.654430]        sclp_register+0x2e/0x248                              
00: [    3.654432]        sclp_rw_init+0x4a/0x70                                
00: [    3.654434]        sclp_console_init+0x4a/0x1b8                          
00: [    3.654435]        console_init+0x2c8/0x410                              
00: [    3.654437]        start_kernel+0x530/0x6a0                              
00: [    3.654438]        startup_continue+0x70/0xd0                            
00: [    3.654439]                                                              
00: [    3.654440] -> #0 (sclp_lock){-.-.}:                                     
00: [    3.654446]        check_noncircular+0x338/0x3e0                         
00: [    3.654448]        __lock_acquire+0x1e66/0x2d88                          
00: [    3.654450]        lock_acquire+0x21a/0x468                              
00: [    3.654451]        _raw_spin_lock_irqsave+0xcc/0xe8                      
00: [    3.654453]        sclp_add_request+0x34/0x308                           
00: [    3.654455]        sclp_conbuf_emit+0x100/0x138                          
00: [    3.654456]        sclp_console_write+0x96/0x3b8                         
00: [    3.654458]        console_unlock+0x6dc/0xa30                            
00: [    3.654460]        vprintk_emit+0x184/0x3c8                              
00: [    3.654461]        vprintk_default+0x44/0x50                             
00: [    3.654463]        printk+0xa8/0xc0                                      
00: [    3.654464]        iommu_debugfs_setup+0xf2/0x108                        
00: [    3.654466]        iommu_init+0x6c/0x78                                  
00: [    3.654467]        do_one_initcall+0x162/0x680                           
00: [    3.654469]        kernel_init_freeable+0x4e8/0x5a8                      
00: [    3.654471]        kernel_init+0x2a/0x188                                
00: [    3.654472]        ret_from_fork+0x30/0x34                               
00: [    3.654474]        kernel_thread_starter+0x0/0xc                         
00: [    3.654475]                                                              
00: [    3.654476] other info that might help us debug this:                    
00: [    3.654477]                                                              
00: [    3.654479] Chain exists of:                                             
00: [    3.654480]   sclp_lock --> &(&zone->lock)->rlock --> console_owner      
00: [    3.654488]                                                              
00: [    3.654489]  Possible unsafe locking scenario:                           
00: [    3.654490]                                                              
00: [    3.654492]        CPU0                    CPU1                          
00: [    3.654493]        ----                    ----                          
00: [    3.654495]   lock(console_owner);                                       
00: [    3.654498]                                lock(&(&zone->lock)->rlock);  
00: [    3.654503]                                lock(console_owner);          
00: [    3.654506]   lock(sclp_lock);                                           
00: [    3.654509]                                                              
00: [    3.654511]  *** DEADLOCK ***                                            
00: [    3.654512]                                                              
00: [    3.654513] 2 locks held by swapper/0/1:                                 
00: [    3.654514]  #0: 00000000550ca200 (console_lock){+.+.}, at: vprintk_emit+
00: 0x178/0x3c8                                                                 
00: [    3.654521]  #1: 00000000550c9fc0 (console_owner){....}, at: console_unlo
00: ck+0x328/0xa30                                                              
00: [    3.654529]                                                              
00: [    3.654530] stack backtrace:                                             
00: [    3.654532] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc1-next-2019
00: 1004+ #4                                                                    
00: [    3.654534] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                 
00: [    3.654535] Call Trace:                                                  
00: [    3.654537] ([<000000005431e218>] show_stack+0x110/0x1b0)                
00: [    3.654539]  [<0000000054bdd926>] dump_stack+0x126/0x178                 
00: [    3.654541]  [<0000000054414b08>] check_noncircular+0x338/0x3e0          
00: [    3.654543]  [<000000005441aaf6>] __lock_acquire+0x1e66/0x2d88           
00: [    3.654545]  [<0000000054417e12>] lock_acquire+0x21a/0x468               
00: [    3.654547]  [<0000000054c18cc4>] _raw_spin_lock_irqsave+0xcc/0xe8       
00: [    3.654549]  [<00000000549f2e14>] sclp_add_request+0x34/0x308            
00: [    3.654551]  [<00000000549fa7f0>] sclp_conbuf_emit+0x100/0x138           
00: [    3.654553]  [<00000000549fa90e>] sclp_console_write+0x96/0x3b8          
00: [    3.654554]  [<000000005442b634>] console_unlock+0x6dc/0xa30             
00: [    3.654556]  [<000000005442de2c>] vprintk_emit+0x184/0x3c8               
00: [    3.654558]  [<000000005442e0b4>] vprintk_default+0x44/0x50              
00: [    3.654560]  [<000000005442eb60>] printk+0xa8/0xc0                       
00: [    3.654562]  [<000000005494ca3a>] iommu_debugfs_setup+0xf2/0x108         
00: [    3.654564]  [<000000005557c0ec>] iommu_init+0x6c/0x78                   
00: [    3.654566]  [<0000000054300fda>] do_one_initcall+0x162/0x680            
00: [    3.654568]  [<000000005553b9f0>] kernel_init_freeable+0x4e8/0x5a8       
00: [    3.654569]  [<0000000054c04172>] kernel_init+0x2a/0x188                 
00: [    3.654571]  [<0000000054c19fbc>] ret_from_fork+0x30/0x34                
00: [    3.654573]  [<0000000054c19fc0>] kernel_thread_starter+0x0/0xc 
