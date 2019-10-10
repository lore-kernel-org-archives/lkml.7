Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC12C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515AA21920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfJJH6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733062AbfJJH57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:57:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73269B1B8;
        Thu, 10 Oct 2019 07:57:57 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:57:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org, Vasily Gorbik <gor@linux.ibm.com>,
        PeterOberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010075756.nyix7l32ai6fylzn@pathway.suse.cz>
References: <20191008183525.GQ6681@dhcp22.suse.cz>
 <1570561573.5576.307.camel@lca.pw>
 <20191008191728.GS6681@dhcp22.suse.cz>
 <1570563324.5576.309.camel@lca.pw>
 <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
 <1570626402.5937.1.camel@lca.pw>
 <20191009132746.GA6681@dhcp22.suse.cz>
 <1570628593.5937.3.camel@lca.pw>
 <20191009142438.yx74ukfqwy2hr4fz@pathway.suse.cz>
 <1570632374.5937.8.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570632374.5937.8.camel@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-10-09 10:46:14, Qian Cai wrote:
> On Wed, 2019-10-09 at 16:24 +0200, Petr Mladek wrote:
> > On Wed 2019-10-09 09:43:13, Qian Cai wrote:
> > > On Wed, 2019-10-09 at 15:27 +0200, Michal Hocko wrote:
> > > > On Wed 09-10-19 09:06:42, Qian Cai wrote:
> > > > [...]
> > > > > https://lore.kernel.org/linux-mm/1570460350.5576.290.camel@lca.pw/
> > > > > 
> > > > > [  297.425964] -> #1 (&port_lock_key){-.-.}:
> > > > > [  297.425967]        __lock_acquire+0x5b3/0xb40
> > > > > [  297.425967]        lock_acquire+0x126/0x280
> > > > > [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> > > > > [  297.425969]        serial8250_console_write+0x3e4/0x450
> > > > > [  297.425970]        univ8250_console_write+0x4b/0x60
> > > > > [  297.425970]        console_unlock+0x501/0x750
> > > > > [  297.425971]        vprintk_emit+0x10d/0x340
> > > > > [  297.425972]        vprintk_default+0x1f/0x30
> > > > > [  297.425972]        vprintk_func+0x44/0xd4
> > > > > [  297.425973]        printk+0x9f/0xc5
> > > > > [  297.425974]        register_console+0x39c/0x520
> > > > > [  297.425975]        univ8250_console_init+0x23/0x2d
> > > > > [  297.425975]        console_init+0x338/0x4cd
> > > > > [  297.425976]        start_kernel+0x534/0x724
> > > > > [  297.425977]        x86_64_start_reservations+0x24/0x26
> > > > > [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> > > > > [  297.425978]        secondary_startup_64+0xb6/0xc0
> > > > > 
> > > > > where the report again show the early boot call trace for the locking
> > > > > dependency,
> > > > > 
> > > > > console_owner --> port_lock_key
> > > > > 
> > > > > but that dependency clearly not only happen in the early boot.
> > > > 
> > > > Can you provide an example of the runtime dependency without any early
> > > > boot artifacts? Because this discussion really doens't make much sense
> > > > without a clear example of a _real_ lockdep report that is not a false
> > > > possitive. All of them so far have been concluded to be false possitive
> > > > AFAIU.
> > > 
> > > An obvious one is in the above link. Just replace the trace in #1 above with
> > > printk() from anywhere, i.e., just ignore the early boot calls there as they are
> > >  not important.
> > > 
> > > printk()
> > >   console_unlock()
> > >     console_lock_spinning_enable() --> console_owner_lock
> > >   call_console_drivers()
> > >     serial8250_console_write() --> port->lock
> > 
> > Please, find the location where this really happens and then suggests
> > how the real deadlock could get fixed. So far, we have seen only
> > false positives and theoretical scenarios.
> 
> Now the bar is higher again. You are now asking me to actually trigger this
> potential deadlock live. I am probably better off buying some lottery tickets
> then if I could be that lucky.

No, we just do not want to comlicate the code too much just to hide
false positives from lockdep.

I do not ask you to reproduce the deadlock. I ask you to find
a code path where the deadlock might really happen. It seems
that you actually found one in the tty code in the other mail.

Best Regards,
Petr
