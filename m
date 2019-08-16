Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BFCC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FE72064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfHPFy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 01:54:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfHPFyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 01:54:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32C2D308FC20;
        Fri, 16 Aug 2019 05:54:25 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-126.pek2.redhat.com [10.72.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B528F5C1D6;
        Fri, 16 Aug 2019 05:54:19 +0000 (UTC)
Date:   Fri, 16 Aug 2019 13:54:16 +0800
From:   Dave Young <dyoung@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
Message-ID: <20190816055416.GA4460@dhcp-128-65.nay.redhat.com>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de>
 <20190816054651.GA4403@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816054651.GA4403@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 16 Aug 2019 05:54:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/19 at 01:46pm, Dave Young wrote:
> John, can you cc kexec list for your later series?
> 
> On 08/08/19 at 12:32am, John Ogness wrote:
> > This is a major change because the API (and underlying workings)
> > of the new ringbuffer are completely different than the previous
> > ringbuffer. Since there are several components of the printk
> > infrastructure that use the ringbuffer API (console, /dev/kmsg,
> > syslog, kmsg_dump), there are quite a few changes throughout the
> > printk implementation.
> > 
> > This is also a conservative change because it continues to use the
> > logbuf_lock raw spinlock even though the new ringbuffer is lockless.
> > 
> > The externally visible changes are:
> > 
> > 1. The exported vmcore info has changed:
> > 
> >     - VMCOREINFO_SYMBOL(log_buf);
> >     - VMCOREINFO_SYMBOL(log_buf_len);
> >     - VMCOREINFO_SYMBOL(log_first_idx);
> >     - VMCOREINFO_SYMBOL(clear_idx);
> >     - VMCOREINFO_SYMBOL(log_next_idx);
> >     + VMCOREINFO_SYMBOL(printk_rb_static);
> >     + VMCOREINFO_SYMBOL(printk_rb_dynamic);
> 
> I assumed this needs some userspace work in kexec,  how did you test
> them?
> 
> makedumpfile should need changes to dump the kernel log.
> 
> Also kexec-tools includes a vmcore-dmesg.c to extrace dmesg from
> /proc/vmcore.
> 
> > 
> > 2. For the CONFIG_PPC_POWERNV powerpc platform, kernel log buffer
> >    registration is no longer available because there is no longer
> >    a single contigous block of memory to represent all of the
> >    ringbuffer.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  arch/powerpc/platforms/powernv/opal.c |  22 +-
> >  include/linux/kmsg_dump.h             |   6 +-
> >  include/linux/printk.h                |  12 -
> >  kernel/printk/printk.c                | 745 ++++++++++++++------------
> >  kernel/printk/ringbuffer.h            |  24 +
> >  5 files changed, 415 insertions(+), 394 deletions(-)
> > 

[snip]

Seems kexec list has 40k limitation for msg body.  Simon and David, maybe it is
too small?

Thanks
Dave
