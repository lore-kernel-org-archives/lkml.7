Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26817C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E9120640
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfIRJFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:05:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45369 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIRJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:05:38 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iAVty-0002uu-W5; Wed, 18 Sep 2019 11:05:31 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
References: <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
        <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
        <87k1acz5rx.fsf@linutronix.de> <20190918012546.GA12090@jagdpanzerIV>
        <20190917220849.17a1226a@oasis.local.home>
        <20190918023654.GB15380@jagdpanzerIV>
        <20190918051933.GA220683@jagdpanzerIV> <87h85anj85.fsf@linutronix.de>
        <20190918081012.GB37041@jagdpanzerIV>
Date:   Wed, 18 Sep 2019 11:05:28 +0200
In-Reply-To: <20190918081012.GB37041@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 18 Sep 2019 17:10:12 +0900")
Message-ID: <877e66nfdz.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> Each console has its own iterator. This iterators will need to
>> advance, regardless if the message was printed via write() or
>> write_atomic().
>
> Great.
>
> ->atomic_write() path will make sure that kthread is parked or will
> those compete for uart port?

A cpu-lock (probably per-console) will be used to synchronize the
two. Unlike my RFCv1, we want to keep the cpu-lock out of the console
drivers and we want it to be less aggressive (using trylock's instead of
spinning). This should make the cpu-lock less "dangerous". I talked with
PeterZ, Thomas, and PetrM about how this can be implemented, but there
may still be some corner cases.

I would like to put everything together now so that we can run and test
if the decisions made in that meeting hold up for all the cases. I think
it will be easier to identify/add the missing pieces, once we have it
coded.

John Ogness
