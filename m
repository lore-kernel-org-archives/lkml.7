Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC74AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A013E21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfJILjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:39:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbfJILjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:39:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 430DBAFD4;
        Wed,  9 Oct 2019 11:39:16 +0000 (UTC)
Date:   Wed, 9 Oct 2019 13:39:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191009113915.xhjswocremwmdum7@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <20191008183525.GQ6681@dhcp22.suse.cz>
 <1570561573.5576.307.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570561573.5576.307.camel@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-10-08 15:06:13, Qian Cai wrote:
> On Tue, 2019-10-08 at 20:35 +0200, Michal Hocko wrote:
> > On Tue 08-10-19 12:08:37, Qian Cai wrote:
> > > On Tue, 2019-10-08 at 14:56 +0200, Christian Borntraeger wrote:
> > > > Adding Peter Oberparleiter.
> > > > Peter, can you have a look?
> > > > 
> > > > On 08.10.19 10:27, Michal Hocko wrote:
> > > > > On Tue 08-10-19 09:43:57, Petr Mladek wrote:
> > > > > > On Mon 2019-10-07 16:49:37, Michal Hocko wrote:
> > > > > > > [Cc s390 maintainers - the lockdep is http://lkml.kernel.org/r/1570228005-24979-1-git-send-email-cai@lca.pw
> > > > > > >  Petr has explained it is a false positive
> > > > > > >  http://lkml.kernel.org/r/20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz]
> > > > > > > On Mon 07-10-19 16:30:02, Petr Mladek wrote:
> > > > > > > [...]
> > > > > > > > I believe that it cannot really happen because:
> > > > > > > > 
> > > > > > > > 	static int __init
> > > > > > > > 	sclp_console_init(void)
> > > > > > > > 	{
> > > > > > > > 	[...]
> > > > > > > > 		rc = sclp_rw_init();
> > > > > > > > 	[...]
> > > > > > > > 		register_console(&sclp_console);
> > > > > > > > 		return 0;
> > > > > > > > 	}
> > > > > > > > 
> > > > > > > > sclp_rw_init() is called before register_console(). And
> > > > > > > > console_unlock() will never call sclp_console_write() before
> > > > > > > > the console is registered.
> > > > > > > > 
> > > > > > > > AFAIK, lockdep only compares existing chain of locks. It does
> > > > > > > > not know about console registration that would make some
> > > > > > > > code paths mutually exclusive.
> > > > > > > > 
> > > > > > > > I believe that it is a false positive. I do not know how to
> > > > > > > > avoid this lockdep report. I hope that it will disappear
> > > > > > > > by deferring all printk() calls rather soon.
> > > > > > > 
> > > > > > > Thanks a lot for looking into this Petr. I have also checked the code
> > > > > > > and I really fail to see why the allocation has to be done under the
> > > > > > > lock in the first place. sclp_read_sccb and sclp_init_sccb are global
> > > > > > > variables but I strongly suspect that they need a synchronization during
> > > > > > > early init, callbacks are registered only later IIUC:
> > > > > > 
> > > > > > Good idea. It would work when the init function is called only once.
> > > > > > But see below.
> > > > > > 
> > > > > > > diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> > > > > > > index d2ab3f07c008..4b1c033e3255 100644
> > > > > > > --- a/drivers/s390/char/sclp.c
> > > > > > > +++ b/drivers/s390/char/sclp.c
> > > > > > > @@ -1169,13 +1169,13 @@ sclp_init(void)
> > > > > > >  	unsigned long flags;
> > > > > > >  	int rc = 0;
> > > > > > >  
> > > > > > > +	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > > > > > > +	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > > > > > >  	spin_lock_irqsave(&sclp_lock, flags);
> > > > > > >  	/* Check for previous or running initialization */
> > > > > > >  	if (sclp_init_state != sclp_init_state_uninitialized)
> > > > > > >  		goto fail_unlock;
> > > > > > 
> > > > > > It seems that sclp_init() could be called several times in parallel.
> > > > > > I see it called from sclp_register() and sclp_initcall().
> > > > > 
> > > > > Interesting. Something for s390 people to answer I guess.
> > > > > Anyway, this should be quite trivial to workaround by a cmpxch or alike.
> > > > > 
> > > 
> > > The above fix is simply insufficient,
> > 
> > Isn't this yet another init time lockdep false possitive?
> 
> Again, this is not 100% false positive for sure yet.
> 
> > 
> > > 00: [    3.654337] -> #3 (console_owner){....}:                                 
> > > 00: [    3.654343]        lock_acquire+0x21a/0x468                              
> > > 00: [    3.654345]        console_unlock+0x3a6/0xa30                            
> > > 00: [    3.654346]        vprintk_emit+0x184/0x3c8                              
> > > 00: [    3.654348]        vprintk_default+0x44/0x50                             
> > > 00: [    3.654349]        printk+0xa8/0xc0                                      
> > > 00: [    3.654351]        get_random_u64+0x40/0x108                             
> > > 00: [    3.654360]        add_to_free_area_random+0x188/0x1c0                   
> > > 00: [    3.654364]        free_one_page+0x72/0x128                              
> > > 00: [    3.654366]        __free_pages_ok+0x51c/0xca0                           
> > > 00: [    3.654368]        memblock_free_all+0x30a/0x3b0                         
> > > 00: [    3.654370]        mem_init+0x84/0x200                                   
> > > 00: [    3.654371]        start_kernel+0x384/0x6a0                              
> > > 00: [    3.654373]        startup_continue+0x70/0xd0                            
> > 
> > This one is actually a nice example why trying to get printk out of the
> > zone->lock is simply not viable. This one is likely a printk to warn
> > that the random pool is not fully intiailized. Just because the
> > allocator tries to randomize the initial free memory pool. You are not
> > going to remove that printk, right?
> 
> Well, Sergey had a patch to convert that one to printk_deferred(), but even with
> his patch, it will still trigger the lockdep splat here because the lock
> dependency between zone->lock --> console_owner is still there from memory
> offline.

Is's this another printk() that might need to become printk_deferred()?

Best Regards,
Petr
