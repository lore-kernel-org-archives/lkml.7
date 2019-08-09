Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211E7C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9AE20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfHIUHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:07:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfHIUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:07:39 -0400
Received: from p200300ddd71876457e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7645:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwBAi-0005PW-HC; Fri, 09 Aug 2019 22:07:32 +0200
Date:   Fri, 9 Aug 2019 22:07:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
In-Reply-To: <CAHk-=wiDzz+KU-ArqpnzjYkvDtKWjUqMfiiJXpXhgYU+Wd0r-w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908092141490.21433@nanos.tec.linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de> <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com> <874l2rclmw.fsf@linutronix.de> <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
 <20190808194523.6f83e087@gandalf.local.home> <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com> <20190808204841.5afcad46@gandalf.local.home> <CAHk-=whNcrysjJYPDFhKAc4tvd80XGAyh95oZeAY6bmzpv3G-A@mail.gmail.com>
 <alpine.DEB.2.21.1908091306520.21433@nanos.tec.linutronix.de> <CAHk-=wiDzz+KU-ArqpnzjYkvDtKWjUqMfiiJXpXhgYU+Wd0r-w@mail.gmail.com>
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
> On Fri, Aug 9, 2019 at 4:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > >
> > > But I don't know what a power-off-in-laptop scenario really looks like..
> >
> > That's random behaviour. It's hardware & BIOS & value add. What do you
> > expect?
> >
> > I tried on a few machines. My laptop does not retain any useful information
> > and on some server box (which takes ages to boot) the memory is squeaky
> > clean, i.e. the BIOS wiped it already. Some others worked with a two second
> > delay between turning the remote power switch on and off.
> 
> You were there at the Intel meeting, weren't you?

Yup.

> This is all about the fact that "we're not getting sane and reliable
> debug facilities for remote debugging". We haven't gotten them over
> two decades, we're not seeing it in the future either.

I know. It sucks.

> So what if we _can_ get an ACPI update and in the next decade your
> laptop _will_ have a memory area that doesn't get scribbled over?

No argument here.

> Does it work today? Yes it does, but only for very special cases
> (basically warm reboot with "fast boot" enabled).
> 
> But they are special cases that may be things that can be extended
> upon without any actual hardware changes.

I'm all for it. I just tried it out and the ratio was 3 out of 5 retained
the data +/- a few bitflips with ~2 seconds power off. The other two were
the laptop and that server machine which wipes everything.

If that can be avoided with some ACPI tweak especially on the laptop, that
would be great. I'm not so worried about the server case.

Debugging laptops and random client machines is the real interesting use
case. They usually lack serial and even if they have serial then the
reporter has not necessarily a second machine to capture the stuff.

Thanks,

	tglx
