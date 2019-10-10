Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38453C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1742F21929
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfJJIVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:21:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:53288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732980AbfJJIVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:21:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8F1DAFE4;
        Thu, 10 Oct 2019 08:21:11 +0000 (UTC)
Date:   Thu, 10 Oct 2019 10:21:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, john.ogness@linutronix.de,
        akpm@linux-foundation.org, Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010082110.dreavjarni7mkvv6@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
 <20191009142623.GE6681@dhcp22.suse.cz>
 <20191010051201.GA78180@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010051201.GA78180@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-10-10 14:12:01, Sergey Senozhatsky wrote:
> On (10/09/19 16:26), Michal Hocko wrote:
> > On Wed 09-10-19 15:56:32, Peter Oberparleiter wrote:
> > [...]
> > > A generic solution would be preferable from my point of view though,
> > > because otherwise each console driver owner would need to ensure that any
> > > lock taken in their console.write implementation is never held while
> > > memory is allocated/released.
> >
> > Considering that console.write is called from essentially arbitrary code
> > path IIUC then all the locks used in this path should be pretty much
> > tail locks or console internal ones without external dependencies.
> 
> That's a good expectation, but I guess it's not always the case.
> 
> One example might be NET console - net subsystem locks, net device
> drivers locks, maybe even some MM locks (skb allocations?).
> 
> But even more "commonly used" consoles sometimes break that
> expectation. E.g. 8250
> 
> serial8250_console_write()
>  serial8250_modem_status()
>   wake_up_interruptible()
> 
> And so on.

I think that the only maintainable solution is to call the console
drivers in a well defined context (kthread). We have finally opened
doors to do this change.

Using printk_deferred() or removing the problematic printk() is
a short term workaround. I am not going to block such patches.
But the final decision will be on maintainers of the affected subsystems.

Deferring console work should prevent the deadlocks. Another story
is allocating memory from console->write() callback. It makes the
console less reliable when there is a memory contention. Preventing
this would be very valuable.

Best Regards,
Petr
