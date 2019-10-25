Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4BECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1A120679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405272AbfJYGml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:42:41 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:4549 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405128AbfJYGmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:42:40 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x9P6gPsq023039;
        Fri, 25 Oct 2019 08:42:25 +0200
Date:   Fri, 25 Oct 2019 08:42:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dev@dpdk.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please stop using iopl() in DPDK
Message-ID: <20191025064225.GA22917@1wt.eu>
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Oct 24, 2019 at 09:45:56PM -0700, Andy Lutomirski wrote:
> Hi all-
> 
> Supporting iopl() in the Linux kernel is becoming a maintainability
> problem.  As far as I know, DPDK is the only major modern user of
> iopl().
> 
> After doing some research, DPDK uses direct io port access for only a
> single purpose: accessing legacy virtio configuration structures.
> These structures are mapped in IO space in BAR 0 on legacy virtio
> devices.
> 
> There are at least three ways you could avoid using iopl().  Here they
> are in rough order of quality in my opinion:
(...)

I'm just wondering, why wouldn't we introduce a sys_ioport() syscall
to perform I/Os in the kernel without having to play at all with iopl()/
ioperm() ? That would alleviate the need for these large port maps.
Applications that use outb/inb() usually don't need extreme speeds.
Each time I had to use them, it was to access a watchdog, a sensor, a
fan, control a front panel LED, or read/write to NVRAM. Some userland
drivers possibly don't need much more, and very likely run with
privileges turned on all the time, so replacing their inb()/outb() calls
would mostly be a matter of redefining them using a macro to use the
syscall instead.

I'd see an API more or less like this :

  int ioport(int op, u16 port, long val, long *ret);

<op> would take values such as INB,INW,INL to fill *<ret>, OUTB,OUTW,OUL
to read from <val>, possibly ORB,ORW,ORL to read, or with <val>, write
back and return previous value to <ret>, ANDB/W/L, XORB/W/L to do the
same with and/xor, and maybe a TEST operation to just validate support
at start time and replace ioperm/iopl so that subsequent calls do not
need to check for errors. Applications could then replace :

    ioperm() with ioport(TEST,port,0,0)
    iopl() with ioport(TEST,0,0,0)
    outb() with ioport(OUTB,port,val,0)
    inb() with ({ char val;ioport(INB,port,0,&val);val;})

... and so on.

And then ioperm/iopl can easily be dropped.

Maybe I'm overlooking something ?
Willy
