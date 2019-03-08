Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BB6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F38420811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCHKAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:00:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfCHKAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:00:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0977AF50;
        Fri,  8 Mar 2019 10:00:19 +0000 (UTC)
Date:   Fri, 8 Mar 2019 11:00:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190308100016.d2v6avtotjo3eyxo@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg1rggcz.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-03-07 10:53:48, John Ogness wrote:
> On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > If there are setups which can be fully !atomic (in terms of console
> > output) then we, essentially, have a fully preemptible kthread printk
> > implementation.
> 
> Correct. I've mentioned in another response[0] some ideas about what
> could be done to aid this.
> 
> I understand that fully preemptible kthread printing is unacceptable for
> you. Since all current console drivers are already irq safe, I'm
> wondering if using irq_work to handle the emergency printing for console
> drivers without write_atomic() would help. (If the printk caller is in a
> context that write() supports, then write() could be called directly.)
> This would also demand that the irq-safe requirements for write() are
> not relaxed. The printk-kthread might still be faster than irq_work, but
> it might increase reliability if an irq_work is triggered as an extra
> precaution.

It is getting more and more complicated. The messages would be pushed
directly, from irq, and kthread. It would depend how the code would
look like but I am not much optimistic.

Note that you could not pass any data to the irq_work handler.
It would need to iterate over the logbuffer and take care of
all non-handled emergency messages.

Anyway, we could solve this later. We need to keep the current
console_unlock() handling as a fallback until enough consoles
support the direct mode anyway.

Best Regards,
Petr
