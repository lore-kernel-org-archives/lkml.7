Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB4DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9C02067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKLHRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:17:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:17:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUQQv-0005Wk-7m; Tue, 12 Nov 2019 08:17:49 +0100
Date:   Tue, 12 Nov 2019 08:17:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
In-Reply-To: <20191112071406.GC100264@gmail.com>
Message-ID: <alpine.DEB.2.21.1911120816570.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.603030685@linutronix.de> <20191112071406.GC100264@gmail.com>
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

On Tue, 12 Nov 2019, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> > +void io_bitmap_share(struct task_struct *tsk)
> > + {
> > +	/*
> > +	 * Take a refcount on current's bitmap. It can be used by
> > +	 * both tasks as long as none of them changes the bitmap.
> > +	 */
> > +	refcount_inc(&current->thread.io_bitmap->refcnt);
> > +	tsk->thread.io_bitmap = current->thread.io_bitmap;
> > +	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
> > +}
> 
> Ok, this is really neat. I suspect there might be some pathological cases 
> on ancient NUMA systems with a really high NUMA factor and bad caching 
> where this new sharing might regress performance, but I doubt this 
> matters, as both the hardware and this software functionality is legacy.

Definitely.

> > +	/*
> > +	 * If the bitmap is not shared, then nothing can take a refcount as
> > +	 * current can obviously not fork at the same time. If it's shared
> > +	 * duplicate it and drop the refcount on the original one.
> > +	 */
> > +	if (refcount_read(&iobm->refcnt) > 1) {
> > +		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> > +		if (!iobm)
> > +			return -ENOMEM;
> > +		io_bitmap_exit();
> >  	}
> >  
> > +	/* Set the tasks io_bitmap pointer (might be the same) */
> 
> speling nit:

s/speling/spelling/ :)
 
> s/tasks
>  /task's

Thanks,

	tglx
