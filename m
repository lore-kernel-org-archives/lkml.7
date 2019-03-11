Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ADD204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCKITN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:19:13 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:41238 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfCKITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:19:09 -0400
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1h3G8g-0001FY-TP; Mon, 11 Mar 2019 09:18:27 +0100
Date:   Mon, 11 Mar 2019 09:18:26 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [RFC PATCH v1 25/25] printk: remove unused code
Message-ID: <20190311081826.k7ybxniveuqeaxzp@flow>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-26-john.ogness@linutronix.de>
 <20190308140229.xje5ay7w2qtlada5@flow>
 <20190311024600.GA25608@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311024600.GA25608@jagdpanzerIV>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-11 11:46:00 [+0900], Sergey Senozhatsky wrote:
> On (03/08/19 15:02), Sebastian Andrzej Siewior wrote:
> > On 2019-02-12 15:30:03 [+0100], John Ogness wrote:
> > 
> > you removed the whole `irq_work' thing. You can also remove the include
> > for linux/irq_work.h.
> 
> It may be too early to remove the whole `irq_work' thing.
> printk()->call_console_driver() should take console_sem
> lock.

I would be _very_ glad to see that irq_work thingy gone. I just stumbled
upon this irq_work and cursed a little while doing other things.
Checking John's series and seeing that it was gone, was a relief.
Printing the whole thing in irq context does not look sane. printing the
import things right away and printing the remaining things later in
kthread looks good to me.

> 	-ss

Sebastian
