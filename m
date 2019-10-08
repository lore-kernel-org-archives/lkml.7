Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18CCC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8084A206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570523276;
	bh=IBu2jG7uAGx/Y52e0dqjhyfJXAepLbhtOo/X2v4yk8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e8h4yeRrOeYXlG8oBZjtefD7DTCgkeAQyb9isRSqFfMaWBoPTvFyIqf80i/8zFCop
	 DHJZOfCRi8C3Rt7RKtrwD6zZKANPyXGRC/DvOLJqkEP4LPzUFg4iPS29qgNP4TvmU9
	 CbeXyHIEr/fY3p1vSq5aKexaiZz96dYBPePkOuQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfJHI1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:27:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:35226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730362AbfJHI1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:27:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88DCEADF0;
        Tue,  8 Oct 2019 08:27:53 +0000 (UTC)
Date:   Tue, 8 Oct 2019 10:27:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008082752.GB6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 09:43:57, Petr Mladek wrote:
> On Mon 2019-10-07 16:49:37, Michal Hocko wrote:
> > [Cc s390 maintainers - the lockdep is http://lkml.kernel.org/r/1570228005-24979-1-git-send-email-cai@lca.pw
> >  Petr has explained it is a false positive
> >  http://lkml.kernel.org/r/20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz]
> > On Mon 07-10-19 16:30:02, Petr Mladek wrote:
> > [...]
> > > I believe that it cannot really happen because:
> > > 
> > > 	static int __init
> > > 	sclp_console_init(void)
> > > 	{
> > > 	[...]
> > > 		rc = sclp_rw_init();
> > > 	[...]
> > > 		register_console(&sclp_console);
> > > 		return 0;
> > > 	}
> > > 
> > > sclp_rw_init() is called before register_console(). And
> > > console_unlock() will never call sclp_console_write() before
> > > the console is registered.
> > > 
> > > AFAIK, lockdep only compares existing chain of locks. It does
> > > not know about console registration that would make some
> > > code paths mutually exclusive.
> > > 
> > > I believe that it is a false positive. I do not know how to
> > > avoid this lockdep report. I hope that it will disappear
> > > by deferring all printk() calls rather soon.
> > 
> > Thanks a lot for looking into this Petr. I have also checked the code
> > and I really fail to see why the allocation has to be done under the
> > lock in the first place. sclp_read_sccb and sclp_init_sccb are global
> > variables but I strongly suspect that they need a synchronization during
> > early init, callbacks are registered only later IIUC:
> 
> Good idea. It would work when the init function is called only once.
> But see below.
> 
> > diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> > index d2ab3f07c008..4b1c033e3255 100644
> > --- a/drivers/s390/char/sclp.c
> > +++ b/drivers/s390/char/sclp.c
> > @@ -1169,13 +1169,13 @@ sclp_init(void)
> >  	unsigned long flags;
> >  	int rc = 0;
> >  
> > +	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > +	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> >  	spin_lock_irqsave(&sclp_lock, flags);
> >  	/* Check for previous or running initialization */
> >  	if (sclp_init_state != sclp_init_state_uninitialized)
> >  		goto fail_unlock;
> 
> It seems that sclp_init() could be called several times in parallel.
> I see it called from sclp_register() and sclp_initcall().

Interesting. Something for s390 people to answer I guess.
Anyway, this should be quite trivial to workaround by a cmpxch or alike.

-- 
Michal Hocko
SUSE Labs
