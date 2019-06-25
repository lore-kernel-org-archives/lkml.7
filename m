Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05245C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF98208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfFYJGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:06:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbfFYJGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:06:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D323BAEAA;
        Tue, 25 Jun 2019 09:06:21 +0000 (UTC)
Date:   Tue, 25 Jun 2019 11:06:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618045117.GA7419@jagdpanzerIV>
 <87imt2bl0k.fsf@linutronix.de>
 <20190625064543.GA19050@jagdpanzerIV>
 <20190625071500.GB19050@jagdpanzerIV>
 <875zoujbq4.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zoujbq4.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-06-25 10:44:19, John Ogness wrote:
> On 2019-06-25, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > In vprintk_emit(), are we going to always reserve 1024-byte
> > records, since we don't know the size in advance, e.g.
> > 
> > 	printk("%pS %s\n", regs->ip, current->name)
> > 		prb_reserve(&e, &rb, ????);
> > 
> > or are we going to run vscnprintf() on a NULL buffer first,
> > then reserve the exactly required number of bytes and afterwards
> > vscnprintf(s) -> prb_commit(&e)?
> 
> (As suggested by Petr) I want to use vscnprintf() on a NULL
> buffer. However, a NULL buffer is not sufficient because things like the
> loglevel are sometimes added via %s (for example, in /dev/kmsg). So
> rather than a NULL buffer, I would use a small buffer on the stack
> (large enough to store loglevel/cont information). This way we can use
> vscnprintf() to get the exact size _and_ printk_get_level() will see
> enough of the formatted string to parse what it needs.

vscnprintf() with NULL pointer is perfectly fine. Only the formatted
string has variable size.

Log level, timestamp, and other information can be stored as
metadata with a fixed size, see struct printk_log. They are
formatted as text later, see msg_print_text() and
msg_print_ext_header().

> > I'm asking this because, well, if the most common usage
> > pattern (printk->prb_reserve) will always reserve fixed
> > size records (aka data blocks), then you _probably_ (??)
> > can drop the 'variable size records' requirement from prb
> > design and start looking at records (aka data blocks) as
> > fixed sized chunks of bytes, which are always located at
> > fixed offsets.
> 
> The average printk message size is well under 128 bytes. It would be
> quite wasteful to always reserve 1K blocks.

Yes, I think that we need to store the strings in variable
sized chunks.

Best Regards,
Petr
