Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C702C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A66C21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKLKHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:07:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfKLKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:07:10 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUT4j-0007Wh-LE; Tue, 12 Nov 2019 11:07:05 +0100
Date:   Tue, 12 Nov 2019 11:07:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 14/16] x86/iopl: Restrict iopl() permission scope
In-Reply-To: <20191112084259.GI100264@gmail.com>
Message-ID: <alpine.DEB.2.21.1911121106450.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.881699933@linutronix.de> <20191112084259.GI100264@gmail.com>
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
> 
> > +static void task_update_io_bitmap(void)
> > +{
> > +	struct thread_struct *t = &current->thread;
> > +
> > +	preempt_disable();
> > +	if (t->iopl_emul == 3 || t->io_bitmap) {
> > +		/* TSS update is handled on exit to user space */
> > +		set_thread_flag(TIF_IO_BITMAP);
> > +	} else {
> > +		clear_thread_flag(TIF_IO_BITMAP);
> > +		/* Invalidate TSS */
> > +		tss_update_io_bitmap();
> > +	}
> > +	preempt_enable();
> > +}
> > +
> >  void io_bitmap_exit(void)
> >  {
> >  	struct io_bitmap *iobm = current->thread.io_bitmap;
> >  
> > -	preempt_disable();
> >  	current->thread.io_bitmap = NULL;
> > -	clear_thread_flag(TIF_IO_BITMAP);
> > -	tss_update_io_bitmap();
> > -	preempt_enable();
> > +	task_update_io_bitmap();
> 
> BTW., isn't the preempt_disable()/enable() sequence only needed around 
> the tss_update_io_bitmap() call?
> 
> ->iopl_emul, ->io_bitmap and TIF_IO_BITMAP can only be set by the current 
> task AFAICS.
> 
> I.e. critical section could be narrowed a bit.

Yes.
