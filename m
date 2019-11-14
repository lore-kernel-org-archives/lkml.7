Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F475C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48F1206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfKNMjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:39:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40496 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNMjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:39:23 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVEP2-0001xD-GQ; Thu, 14 Nov 2019 13:39:12 +0100
Date:   Thu, 14 Nov 2019 13:39:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Peter Zijlstra' <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
In-Reply-To: <a0146b86073f4b9bb858d80b4a71683e@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.1911141335550.2507@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.603030685@linutronix.de> <20191112091521.GX4131@hirez.programming.kicks-ass.net> <a0146b86073f4b9bb858d80b4a71683e@AcuMS.aculab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 12 November 2019 09:15
> ...
> > > +	/*
> > > +	 * If the bitmap is not shared, then nothing can take a refcount as
> > > +	 * current can obviously not fork at the same time. If it's shared
> > > +	 * duplicate it and drop the refcount on the original one.
> > > +	 */
> > > +	if (refcount_read(&iobm->refcnt) > 1) {
> > > +		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> > > +		if (!iobm)
> > > +			return -ENOMEM;
> > > +		io_bitmap_exit();
> > 		refcount_set(&iobm->refcnt, 1);
> > >  	}
> 
> What happens if two threads of the same process enter the above
> at the same time?
> (I've not looked for a lock, but since kmemdup() can sleep I'd suspect there isn't one.)
> 
> Also can another thread call fork() - eg while the kmemdup() is sleeping?

That's not a problem at all. The io bitmap which is duplicated can neither
be modified nor freed while the duplication is in progress. That's what the
refcount is for. The threads drop their refcount _after_ duplication.

And fork is not a problem either because that just increments the refcount.

Thanks,

	tglx


