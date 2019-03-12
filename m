Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC326C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A299D2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCLKaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:30:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:41642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfCLKaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:30:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D69CCAEC2;
        Tue, 12 Mar 2019 10:30:17 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:30:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190312103017.rvdtoc3j34eayleb@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
 <20190307051530.GC4893@jagdpanzerIV>
 <87va0pznsq.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va0pznsq.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-03-11 11:51:49, John Ogness wrote:
> On 2019-03-07, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > I don't really understand the role of loglevel anymore.
> 
> "what the kernel considers" is a configuration option of the
> administrator. The administrator can increase the verbocity of the
> console (loglevel) without having negative effects on the system
> itself.

Where do you get the confidence that atomic console will not
slow down the system? Have you tried it on real life workload
when debugging a real life bug?

Some benchmarks might help. Well, it would be needed to
trigger some messages from them and see how the different
approaches affect the overall system performance.


> Also, if the system were to suddenly crash, those crash messages
> shouldn't be in jeopardy just because the verbocity of the console was
> turned up.

This expects that the error messages will be enough to discover
and fix the problem.


> You (and Petr) talk about that _all_ console printing is for
> emergencies. That if an administrator sets the loglevel to 7 it is
> because the pr_info messages are just as important as the pr_emerg.

It might be true when the messages with higher level (more critical)
are not enough to understand the situation.


> And if that is indeed the intention of console printing and loglevel, then
> why is asynchronous printk calls for console messages even allowed
> today? IMO that isn't taking the importance of the message very
> seriously.

Because it was working pretty well in the past. The amount of messages
is still growing (code complexity, more CPUs, more devices, ...).
Our customers have started reporting softlockups "only" 7 years ago
or so.

We currently have two level handling of messages:

   + all messages can be seen from userspace
   + messages below console_loglevel can be seen
     on the console

You are introducing one more level of handling:

   + critical messages are printed on the console directly
     even before the queued less critical ones


The third level would be acceptable when:

   + atomic consoles are reliable enough
   + the code complexity is worth the gain


IMHO, we mix too many things here:

   + log buffer implementation
   + console offload
   + direct console handling using atomic consoles

I see the potential in all areas:

   + lock less ring buffer helps to avoid deadlocks,
     and extra log buffers

   + console offload prevents too long stalls (softlockups)

   + direct console handling might help to avoid deadlocks
     and might make the output more reliable.


I think that we are on the same page here.

But we must use an incremental approach. It is not acceptable
to replace everything by a single patch. And it is not acceptable
to break important functionality and implement alternative
solution several patches later.

Also no solution is as ideal as it is sometimes presented
in this thread.

Best Regards,
Petr
