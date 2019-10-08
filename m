Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B719DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FFD206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hUg06ZRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfJHTGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:06:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35758 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:06:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so26916738qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEHy0LqfQYezFUAL4y0Jud/jb8GNwlETVuuWl+duy9U=;
        b=hUg06ZRTxQUAYHnpHo9oNxpakjT9uXkh8KrVTGzFF3rae6KaKOqr8Zk7vJlVTQoVdU
         B58xVuav9XT2gdT2LPOjx+7hIf+1XdoZI9BFRSjoPNaeye6QoNmeEeDD5/Z4QzC9/7+o
         JgC8dSoyKTI9Ty0+/6bEuEY/N9CRFErNx/qPB3vHtiBxIGXL95qGY1kpXrEtrtsYpvSh
         rbFYw3HNpJ5bd2A2gL9ZCw8CDQDmSmv/lXz7nSAcBKHtCe/t41rmzFcKyH2vGk511BV7
         Nj+3ogB3AtjoOVJmW0+do7VBqUUfus+ckWtB6J5kV9i+g61JdjG0swnvNYE6VI9+pOEr
         k2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEHy0LqfQYezFUAL4y0Jud/jb8GNwlETVuuWl+duy9U=;
        b=Xa7CARPTN5ikVihomw9g5D3jMZy8M2J7qzdpNH7l+zrDazezkUt2GP+GkSGIIMryGE
         197fT0J4g3U5SRtTeWf3XaQu9RGhSlkBq3m1KVmBa9hCeILzFANOig8h+QHMG/TCSC51
         LC/BejzO7vVUTHbJ2Re/JiOju7iWrMCtEzMICOECXpcfGWJ8KInRWhaVYqUgNnj4JGvf
         wD4EJVBXHf5daKq6UKD/nmBeiEh7UqzZPBvcv7cjgOrcAoW5v7c59KaOAh9abC16TeRh
         9BHxqget+DWktFMBqIZmvYXOh1J0xo8TdpZDf1biTmKB1HSoxwkKGBQJpfkXbP/nn/Lh
         n3Xw==
X-Gm-Message-State: APjAAAVMWXSTzgbOKQhO2Jtnlpl/okkdvJFyu0Hu/euOWHD/j0ZB7yBo
        q7RO8Eijk9HSjS5URH7rtG/gxw==
X-Google-Smtp-Source: APXvYqwoSsU9q/h+zKqV9Lp2EUueseEvYqy1MGNRKRShqnHobg+k+WZqVk7ISv/p4SVWALhZiQc5hQ==
X-Received: by 2002:ac8:37cb:: with SMTP id e11mr38483393qtc.22.1570561575487;
        Tue, 08 Oct 2019 12:06:15 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m15sm8809190qka.104.2019.10.08.12.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 12:06:14 -0700 (PDT)
Message-ID: <1570561573.5576.307.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 08 Oct 2019 15:06:13 -0400
In-Reply-To: <20191008183525.GQ6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <20191007144937.GO2381@dhcp22.suse.cz>
         <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
         <20191008082752.GB6681@dhcp22.suse.cz>
         <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
         <1570550917.5576.303.camel@lca.pw> <20191008183525.GQ6681@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 20:35 +0200, Michal Hocko wrote:
> On Tue 08-10-19 12:08:37, Qian Cai wrote:
> > On Tue, 2019-10-08 at 14:56 +0200, Christian Borntraeger wrote:
> > > Adding Peter Oberparleiter.
> > > Peter, can you have a look?
> > > 
> > > On 08.10.19 10:27, Michal Hocko wrote:
> > > > On Tue 08-10-19 09:43:57, Petr Mladek wrote:
> > > > > On Mon 2019-10-07 16:49:37, Michal Hocko wrote:
> > > > > > [Cc s390 maintainers - the lockdep is http://lkml.kernel.org/r/1570228005-24979-1-git-send-email-cai@lca.pw
> > > > > >  Petr has explained it is a false positive
> > > > > >  http://lkml.kernel.org/r/20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz]
> > > > > > On Mon 07-10-19 16:30:02, Petr Mladek wrote:
> > > > > > [...]
> > > > > > > I believe that it cannot really happen because:
> > > > > > > 
> > > > > > > 	static int __init
> > > > > > > 	sclp_console_init(void)
> > > > > > > 	{
> > > > > > > 	[...]
> > > > > > > 		rc = sclp_rw_init();
> > > > > > > 	[...]
> > > > > > > 		register_console(&sclp_console);
> > > > > > > 		return 0;
> > > > > > > 	}
> > > > > > > 
> > > > > > > sclp_rw_init() is called before register_console(). And
> > > > > > > console_unlock() will never call sclp_console_write() before
> > > > > > > the console is registered.
> > > > > > > 
> > > > > > > AFAIK, lockdep only compares existing chain of locks. It does
> > > > > > > not know about console registration that would make some
> > > > > > > code paths mutually exclusive.
> > > > > > > 
> > > > > > > I believe that it is a false positive. I do not know how to
> > > > > > > avoid this lockdep report. I hope that it will disappear
> > > > > > > by deferring all printk() calls rather soon.
> > > > > > 
> > > > > > Thanks a lot for looking into this Petr. I have also checked the code
> > > > > > and I really fail to see why the allocation has to be done under the
> > > > > > lock in the first place. sclp_read_sccb and sclp_init_sccb are global
> > > > > > variables but I strongly suspect that they need a synchronization during
> > > > > > early init, callbacks are registered only later IIUC:
> > > > > 
> > > > > Good idea. It would work when the init function is called only once.
> > > > > But see below.
> > > > > 
> > > > > > diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> > > > > > index d2ab3f07c008..4b1c033e3255 100644
> > > > > > --- a/drivers/s390/char/sclp.c
> > > > > > +++ b/drivers/s390/char/sclp.c
> > > > > > @@ -1169,13 +1169,13 @@ sclp_init(void)
> > > > > >  	unsigned long flags;
> > > > > >  	int rc = 0;
> > > > > >  
> > > > > > +	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > > > > > +	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > > > > >  	spin_lock_irqsave(&sclp_lock, flags);
> > > > > >  	/* Check for previous or running initialization */
> > > > > >  	if (sclp_init_state != sclp_init_state_uninitialized)
> > > > > >  		goto fail_unlock;
> > > > > 
> > > > > It seems that sclp_init() could be called several times in parallel.
> > > > > I see it called from sclp_register() and sclp_initcall().
> > > > 
> > > > Interesting. Something for s390 people to answer I guess.
> > > > Anyway, this should be quite trivial to workaround by a cmpxch or alike.
> > > > 
> > 
> > The above fix is simply insufficient,
> 
> Isn't this yet another init time lockdep false possitive?

Again, this is not 100% false positive for sure yet.

> 
> > 00: [    3.654337] -> #3 (console_owner){....}:                                 
> > 00: [    3.654343]        lock_acquire+0x21a/0x468                              
> > 00: [    3.654345]        console_unlock+0x3a6/0xa30                            
> > 00: [    3.654346]        vprintk_emit+0x184/0x3c8                              
> > 00: [    3.654348]        vprintk_default+0x44/0x50                             
> > 00: [    3.654349]        printk+0xa8/0xc0                                      
> > 00: [    3.654351]        get_random_u64+0x40/0x108                             
> > 00: [    3.654360]        add_to_free_area_random+0x188/0x1c0                   
> > 00: [    3.654364]        free_one_page+0x72/0x128                              
> > 00: [    3.654366]        __free_pages_ok+0x51c/0xca0                           
> > 00: [    3.654368]        memblock_free_all+0x30a/0x3b0                         
> > 00: [    3.654370]        mem_init+0x84/0x200                                   
> > 00: [    3.654371]        start_kernel+0x384/0x6a0                              
> > 00: [    3.654373]        startup_continue+0x70/0xd0                            
> 
> This one is actually a nice example why trying to get printk out of the
> zone->lock is simply not viable. This one is likely a printk to warn
> that the random pool is not fully intiailized. Just because the
> allocator tries to randomize the initial free memory pool. You are not
> going to remove that printk, right?

Well, Sergey had a patch to convert that one to printk_deferred(), but even with
his patch, it will still trigger the lockdep splat here because the lock
dependency between zone->lock --> console_owner is still there from memory
offline.

> 
> I fully agree that this class of lockdep splats are annoying especially
> when they make the lockdep unusable but please discuss this with lockdep
> maintainers and try to find some solution rather than go and try to
> workaround the problem all over the place. If there are places that
> would result in a cleaner code then go for it but please do not make the
> code worse just because of a non existent problem flagged by a false
> positive.

It makes me wonder what make you think it is a false positive for sure.
