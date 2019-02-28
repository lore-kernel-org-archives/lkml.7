Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE884C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CCA205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfB1M5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:57:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55230 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfB1M5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:57:03 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gzLF6-0005UT-EO; Thu, 28 Feb 2019 13:56:52 +0100
Date:   Thu, 28 Feb 2019 13:56:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jann Horn <jannh@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        amir73il@gmail.com, "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, hannes@cmpxchg.org,
        Hugh Dickins <hughd@google.com>, jrdr.linux@gmail.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: missing stack trace entry on NULL pointer call [was: Re: BUG:
 unable to handle kernel NULL pointer dereference in
 __generic_file_write_iter]
In-Reply-To: <CAG48ez14jBF3uJH8qP+JrXtiQnQ2S+y9wHVpQ0mEXbmAVqKgWg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1902281248400.1821@nanos.tec.linutronix.de>
References: <0000000000001aab8b0582689e11@google.com> <20190221113624.284fe267e73752639186a563@linux-foundation.org> <CAG48ez14jBF3uJH8qP+JrXtiQnQ2S+y9wHVpQ0mEXbmAVqKgWg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019, Jann Horn wrote:
> +Josh for unwinding, +x86 folks
> On Wed, Feb 27, 2019 at 11:43 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Thu, 21 Feb 2019 06:52:04 -0800 syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    4aa9fc2a435a Revert "mm, memory_hotplug: initialize struct..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1101382f400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=ca95b2b7aef9e7cbd6ab
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > Not understanding.  That seems to be saying that we got a NULL pointer
> > deref in __generic_file_write_iter() at
> >
> >                 written = generic_perform_write(file, from, iocb->ki_pos);
> >
> > which isn't possible.
> >
> > I'm not seeing recent changes in there which could have caused this.  Help.
> 
> +
> 
> Maybe the problem is that the frame pointer unwinder isn't designed to
> cope with NULL function pointers - or more generally, with an
> unwinding operation that starts before the function's frame pointer
> has been set up?
> 
> Unwinding starts at show_trace_log_lvl(). That begins with
> unwind_start(), which calls __unwind_start(), which uses
> get_frame_pointer(), which just returns regs->bp. But that frame
> pointer points to the part of the stack that's storing the address of
> the caller of the function that called NULL; the caller of NULL is
> skipped, as far as I can tell.
> 
> What's kind of annoying here is that we don't have a proper frame set
> up yet, we only have half a stack frame (saved RIP but no saved RBP).

That wreckage is related to the fact that the indirect calls are going
through __x86_indirect_thunk_$REG. I just verified on a VM with some other
callback NULL'ed that the resulting backtrace is not really helpful.

So in that case generic_perform_write() has two indirect calls:

  mapping->a_ops->write_begin() and ->write_end()

Thanks,

	tglx
