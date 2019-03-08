Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D303DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A407720811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCHKEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:04:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:55084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfCHKEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:04:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67407AD4C;
        Fri,  8 Mar 2019 10:04:52 +0000 (UTC)
Date:   Fri, 8 Mar 2019 11:04:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
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
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190308100449.dccctqo6i4xa6bhq@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <87va0uopmd.fsf@linutronix.de>
 <20190308013134.GB4063@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308013134.GB4063@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-08 10:31:34, Sergey Senozhatsky wrote:
> On (03/07/19 13:06), John Ogness wrote:
> > On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > > This, theoretically, creates a whole new world of possibilities for
> > > console drivers. Now they can do GFP_KERNEL allocations and stall
> > > printk_kthread during OOM; or they can explicitly reschedule from
> > > ->write() callback (via console_conditional_schedule()) because
> > > console_lock() sets console_may_schedule.
> > 
> This can stall the entire printing pipeline
> 
> OOM -> printk_kthread() -> console_lock() -> con_foo() -> kmalloc(GFP_KERNEL) -> OOM
> 
> > Although, as I mentioned in a previous response[0], perhaps we should
> > not loosen the requirements on write().
> 
> Right. Console drivers better stay restricted; very restricted.

I agree here.

> > It is exactly that disable_preempt() that is so harmful for realtime tasks.

> I'll reply in another email (later today, or tomorrow).

I see. But I have troubles to imagine a preemtible direct console
output. The result would be mixed messages on a single line.

Best Regards,
Petr
