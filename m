Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C6BC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7181217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfHJFyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:54:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57982 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfHJFyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:54:17 -0400
Received: from p200300ddd71876237e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7623:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwKKP-0001qU-GQ; Sat, 10 Aug 2019 07:54:09 +0200
Date:   Sat, 10 Aug 2019 07:53:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
In-Reply-To: <CAHk-=wiG55kT0MRprt+Opbpcc=ebugC_rz4d6-whtAGXri3TwQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908100745260.7324@nanos.tec.linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de> <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com> <20190809061437.GE2332@hirez.programming.kicks-ass.net>
 <CAHk-=wiG55kT0MRprt+Opbpcc=ebugC_rz4d6-whtAGXri3TwQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019, Linus Torvalds wrote:
> On Thu, Aug 8, 2019 at 11:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Note that you can hook this into printk as a fake early serial device;
> > just have the serial device write to the DRAM buffer.
> 
> No, you really really can't.
...
> Even the "early console" stuff tries to honor serialization by
> console_lock and console_suspended etc. Or things like the "I'm in the
> middle of the scheduler, so I won't be doing any real logging".

If you think of it as the classic console you are right. What Peter has in
mind is the extra stuff on top of this buffer patchset, which implements
emergency write to consoles. That's an extra callback in the console
struct, which can be invoked in such situations igoring context and console
lock completely.

Right now we have an implementation for serial only, but that already is
useful. I nicely got (minimaly garbled) crash dumps out of an NMI
handler. With the current mainline console code the machine just hung.

So with this scheme we actually could hook your smart buffer into the
console stuff and still achieve what you want.

Thanks,

	tglx
