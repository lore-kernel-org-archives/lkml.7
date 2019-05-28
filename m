Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD76BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5B42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfE1Nm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:42:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfE1Nm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:42:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 256C4AF6A;
        Tue, 28 May 2019 13:42:28 +0000 (UTC)
Date:   Tue, 28 May 2019 15:42:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV>
 <20190528044619.GA3429@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528044619.GA3429@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-05-28 13:46:19, Sergey Senozhatsky wrote:
> On (05/28/19 13:15), Sergey Senozhatsky wrote:
> > On (05/28/19 01:24), Dmitry Safonov wrote:
> > [..]
> > > While handling sysrq the console_loglevel is bumped to default to print
> > > sysrq headers. It's done to print sysrq messages with WARNING level for
> > > consumers of /proc/kmsg, though it sucks by the following reasons:
> > > - changing console_loglevel may produce tons of messages (especially on
> > >   bloated with debug/info prints systems)
> > > - it doesn't guarantee that the message will be printed as printk may
> > >   deffer the actual console output from buffer (see the comment near
> > >   printk() in kernel/printk/printk.c)
> > > 
> > > Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
> > > Make sysrq print the headers unsuppressed instead of changing
> > > console_loglevel.

I like this idea. console_loglevel is temporary manipulated only
when some messages should or should never appear on the console.
Storing this information in the message flags would help
to solve all the related races.

> > I've been thinking about this a while ago... So what I thought back
> > then was that affected paths are atomic: sysrq, irqs, NMI, etc. Well
> > at leasted it seemed to be so.

Yes, this would be useful for the other situations when all printk's
in a particular context should be handled this way. We could build
it on top of this patch.

> Ahh.. OK, now I sort of remember why I gave up on this idea (see [1]
> at the bottom, when it comes to uv_nmi_dump_state()) - printk_NMI and
> printk-safe redirections.
> 
> 	NMI
> 		loglevel = NEW
> 		printk -> printk_safe_nmi
> 		loglevel = OLD
> 
> 	iret
> 
> 	IRQ
> 		flush printk_safe_nmi -> printk
> 		// At this point we don't remember about
> 		// loglevel manipulation anymore
> 	iret

printk_safe buffer preserves KERN_* headers. It should be
possible to insert KERN_UNSUPPRESSED there.

The patch itself looks fine on the first sight. If we go
forward, please, split the printk and sysrq part
into two patches.

Best Regards,
Petr
