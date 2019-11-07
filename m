Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCACC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B34214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbfKGOEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:04:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47925 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfKGOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:04:15 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSiOP-0007Fh-7S; Thu, 07 Nov 2019 15:04:09 +0100
Date:   Thu, 7 Nov 2019 15:04:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 4/9] x86/io: Speedup schedule out of I/O bitmap user
In-Reply-To: <20191107091231.GA4131@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911071502350.4256@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.133597409@linutronix.de> <20191107091231.GA4131@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 08:35:03PM +0100, Thomas Gleixner wrote:
> > There is no requirement to update the TSS I/O bitmap when a thread using it is
> > scheduled out and the incoming thread does not use it.
> > 
> > For the permission check based on the TSS I/O bitmap the CPU calculates the memory
> > location of the I/O bitmap by the address of the TSS and the io_bitmap_base member
> > of the tss_struct. The easiest way to invalidate the I/O bitmap is to switch the
> > offset to an address outside of the TSS limit.
> > 
> > If an I/O instruction is issued from user space the TSS limit causes #GP to be
> > raised in the same was as valid I/O bitmap with all bits set to 1 would do.
> > 
> > This removes the extra work when an I/O bitmap using task is scheduled out
> > and puts the burden on the rare I/O bitmap users when they are scheduled
> > in.
> 
> This also nicely aligns with that the context switch time is accounted
> to the next task. So by doing the expensive part on switch-in gets it
> all accounted to the task that caused it.

Just that I can't add the storage to tss_struct due to the VMX insanity of
setting TSS limit hard to 0x67 on vmexit instead of restoring the host
value.

Did I say that already that virt creates more problems than it solves?

Thanks,

	tglx
