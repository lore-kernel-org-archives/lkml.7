Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48951C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2450F208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406493AbfHILPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:15:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56393 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHILPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:15:18 -0400
Received: from p200300ddd71876457e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7645:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hw2rX-0005Hx-HG; Fri, 09 Aug 2019 13:15:11 +0200
Date:   Fri, 9 Aug 2019 13:15:05 +0200 (CEST)
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
In-Reply-To: <CAHk-=whNcrysjJYPDFhKAc4tvd80XGAyh95oZeAY6bmzpv3G-A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908091306520.21433@nanos.tec.linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de> <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com> <874l2rclmw.fsf@linutronix.de> <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
 <20190808194523.6f83e087@gandalf.local.home> <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com> <20190808204841.5afcad46@gandalf.local.home> <CAHk-=whNcrysjJYPDFhKAc4tvd80XGAyh95oZeAY6bmzpv3G-A@mail.gmail.com>
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

On Thu, 8 Aug 2019, Linus Torvalds wrote:

> On Thu, Aug 8, 2019 at 5:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I've never tried, but are you saying that even with the "10 second
> > hold" the laptop's DRAM may still have old data that is accessible?
> 
> The power doesn't go off when you *start* the 10s hold. It goes off
> after ten seconds.
> 
> So power is off only for the time it then takes you to press the power
> button again to turn it on again. So just a second or two if you react
> quickly to the "ok, power light finally went off". Longer if you
> don't.
> 
> But yes, DRAM has retention time in the seconds. See for example
> 
>     https://www.pdl.cmu.edu/PDL-FTP/NVM/dram-retention_isca13.pdf
> 
> and look at the kinds of times they are looking at - their graphs
> aren't in  milliseconds, they are in 1-5 seconds (and the retention is
> pretty high for that time).
> 
> But I don't know what a power-off-in-laptop scenario really looks like..

That's random behaviour. It's hardware & BIOS & value add. What do you
expect?

I tried on a few machines. My laptop does not retain any useful information
and on some server box (which takes ages to boot) the memory is squeaky
clean, i.e. the BIOS wiped it already. Some others worked with a two second
delay between turning the remote power switch on and off.

Thanks,

	tglx
