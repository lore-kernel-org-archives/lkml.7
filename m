Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A17CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9AA208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbfJ1UN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:13:29 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:8260 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfJ1UN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:13:28 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x9SKDD4I027324;
        Mon, 28 Oct 2019 21:13:13 +0100
Date:   Mon, 28 Oct 2019 21:13:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Andy Lutomirski <luto@kernel.org>, dev@dpdk.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [dpdk-dev] Please stop using iopl() in DPDK
Message-ID: <20191028201313.GA27316@1wt.eu>
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
 <20191025064225.GA22917@1wt.eu>
 <20191028094253.054fbf9c@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028094253.054fbf9c@hermes.lan>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Oct 28, 2019 at 09:42:53AM -0700, Stephen Hemminger wrote:
(...)
> > I'd see an API more or less like this :
> > 
> >   int ioport(int op, u16 port, long val, long *ret);
> > 
> > <op> would take values such as INB,INW,INL to fill *<ret>, OUTB,OUTW,OUL
> > to read from <val>, possibly ORB,ORW,ORL to read, or with <val>, write
> > back and return previous value to <ret>, ANDB/W/L, XORB/W/L to do the
> > same with and/xor, and maybe a TEST operation to just validate support
> > at start time and replace ioperm/iopl so that subsequent calls do not
> > need to check for errors. Applications could then replace :
> > 
> >     ioperm() with ioport(TEST,port,0,0)
> >     iopl() with ioport(TEST,0,0,0)
> >     outb() with ioport(OUTB,port,val,0)
> >     inb() with ({ char val;ioport(INB,port,0,&val);val;})
> > 
> > ... and so on.
> > 
> > And then ioperm/iopl can easily be dropped.
> > 
> > Maybe I'm overlooking something ?
> > Willy
> 
> DPDK does not want to system calls. It kills performance.
> With pure user mode access it can reach > 10 Million Packets/sec
> with a system call per packet that drops to 1 Million Packets/sec.

I know that it would cause this on the data path, but are you *really*
sure that in/out calls are performed there, because these are terribly
slow already ? I'd suspect that instead it's relying on read/write of
memory-mapped registers and descriptors. I really suspect that I/Os
are only used for configuration purposes, which is why I proposed the
stuff above (otherwise I obviously agree that syscalls in the data
path are performance killers).

> Also, adding new system calls might help in the long term,
> but users are often kernels that are at least 5 years behind
> upstream.

Sure but that has never been really an issue, what matters is that
backwards compatibility is long enough to let old features smoothly
fade away. Some people make fun of me because I still care a bit
about kernel 2.4 and openssl 0.9.7 compatibility for haproxy, so
yes, I am careful about backwards compatibility and smooth upgrades ;-)

Willy
