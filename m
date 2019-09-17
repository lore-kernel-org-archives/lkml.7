Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25BC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DB521925
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404700AbfIQILr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:11:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728802AbfIQILr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:11:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F180EB11B;
        Tue, 17 Sep 2019 08:11:44 +0000 (UTC)
Date:   Tue, 17 Sep 2019 10:11:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Prarit Bhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk meeting at LPC
Message-ID: <20190917081144.g254hccous7haavu@pathway.suse.cz>
References: <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <cfc7b1fa-e629-19a6-154b-0dd4f5604aa7@I-love.SAKURA.ne.jp>
 <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
 <20190916094314.6053f988@gandalf.local.home>
 <20190916094314.6053f988@gandalf.local.home>
 <87r24giac9.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r24giac9.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-16 16:28:54, John Ogness wrote:
> On 2019-09-16, Steven Rostedt <rostedt@goodmis.org> wrote:
> >>>> 9. Support for printk dictionaries will be discontinued. I will
> >>>> look into who is using this and why. If printk dictionaries are
> >>>> important for you, speak up now!
> >>> 
> >>> I think that dev_printk() is using "const char *dict, size_t
> >>> dictlen," part via create_syslog_header(). Some userspace programs
> >>> might depend on availability of such information.
> >> 
> >> Yeah, but it seems to be the only dictionary writer. There were
> >> doubts (during the meeting) whether anyone was actually using the
> >> information.
> >> 
> >> Hmm, it seems that journalctl is able to filer device specific
> >> information, for example, I get:
> >> 
> >> $> journalctl _KERNEL_DEVICE=+usb:2-1  
> >> -- Logs begin at Tue 2019-08-13 09:00:03 CEST, end at Mon 2019-09-16 12:32:58 CEST. --
> >> Aug 13 09:00:04 linux-qszd kernel: usb 2-1: new high-speed USB device number 2 using ehci-pci
> >> 
> >> One question is if anyone is using this filtering. Simple grep is
> >> enough. Another question is whether it really needs to get passed
> >> this way.
> >> 
> >
> > If worse comes to worse, perhaps we let the console decide what to do
> > with it. Where all consoles but the "kmsg" one ignores it?

/dev/kmsg is one interface passing dictionary. The other is
netconsole. It is the only console with CON_EXTENDED flag set.

> > Then journalctl should work as normal.
> >
> > Or will this break one of our other changes?

It just complicates the code because we need to store and read
the information separately.


> The consoles will just iterate the ringbuffer. So if any console needs
> dictionary information, that information needs to be stored in the
> ringbuffer as well.
> 
> The dictionary text and message text could be stored as concatenated
> strings. The descriptor would point separately to the beginning of
> dictionary and message. So the data-buffer would still be a clean
> collection of text. But AFAIK Linus didn't want to see that "extra" text
> at all.

I would double check with Linus that he would consider this as
breaking userspace.

IMHO, it is perfectly fine to add this support later in separate patch(set) if
really necessary. I can't imagine that anyone would depend on this
feature when bisecting kernel. We could discuss and handle this later.
At least after the merge window.

> If we want to keep dictionary text out of the data-buffer, we could have
> a 2nd data-buffer dedicated for dictionary text. I expect it would not
> really complicate things. Especially if the dictionary part was "best
> effort" (i.e. if the dictionary text does not fit in the free part of
> its data-buffer, it is dropped).

Interesting idea. I like it if it does not complicate the code too much.

Best Regards,
Petr
