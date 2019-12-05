Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB36C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D53B2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfLEOGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:06:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59160 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfLEOGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:06:24 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1icrlU-00030b-96; Thu, 05 Dec 2019 15:05:56 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        brendanhiggins@google.com, gregkh@linuxfoundation.org,
        kexec@lists.infradead.org, peterz@infradead.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        sergey.senozhatsky.work@gmail.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Subject: Re: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191205134652.12631-1-prarit@redhat.com>
Date:   Thu, 05 Dec 2019 15:05:54 +0100
In-Reply-To: <20191205134652.12631-1-prarit@redhat.com> (Prarit Bhargava's
        message of "Thu, 5 Dec 2019 08:46:52 -0500")
Message-ID: <87zhg6zx31.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prarit,

On 2019-12-05, Prarit Bhargava <prarit@redhat.com> wrote:
> Based on the comments there is going to be a v6 but in any case I am
> starting testing of this patchset on several large core systems across
> multiple architectures (x86_64, ARM64, s390, ppc64le).  Some of those
> systems are known to fail boot due to the large amount of printk output so
> it will be good to see if these changes resolve those issues.

Right now the patches only include the ringbuffer as a separate entity
with a test module. So they do not yet have any effect on printk.

If you apply the patches and then build the "modules" target, you will
have a new test_prb.ko module. Loading that module will start some heavy
testing of the ringbuffer. As long as the testing is successful, the
module will keep testing. During this time the machine will be very
slow, but should still respond.

The test can be stopped by unloading the module. If the test stops on
its own, then a problem was found. The output of the test is put into
the ftrace buffer.

It would be nice if you could run the test module on some fat machines,
at least for a few minutes to see if anything explodes. ARM64 and
ppc64le will probably be the most interesting, due to memory barrier
testing.

Otherwise I will definitely be reaching out to you when we are ready to
perform actual printk testing with the newly agreed up semantics
(lockless, per-console printing threads, synchronous panic
consoles). Thanks for your help with this.

John Ogness
