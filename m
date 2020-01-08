Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD5C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D969E2080A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578452576;
	bh=W6HEc1BQoIiWlJA9SIyta0MUSBglN9e1a7/Yb5joxrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IOLl0vAE6i/J/f1T7vnfzDcUintPozpWPvrVXv4f8T9E3Es8WiOiAY5ZK7F7KVADT
	 dMB/OYp+nGtRv+XiW1Vc3rnv6Hb1S4BsW527vKIQrOu8i34/ewsyg01he9Elfpyhb2
	 vCaJsDlJi/ysw0466ZxXQe/0QjRsZ77zdRUxSASI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgAHDC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgAHDCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:02:55 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A9E2075A;
        Wed,  8 Jan 2020 03:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578452575;
        bh=W6HEc1BQoIiWlJA9SIyta0MUSBglN9e1a7/Yb5joxrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n57mDStE2+vKfuvNCDQ/Aotjv8v0CZqgnznTKqM/gTrmrsj0RKlR7QhvoeE4jYtZZ
         GNgs1XC9V2BlTnAdEEf2UsiCin+qCgkjXKYhJ37+WVGvTZgN7rqtjwjr3j/UgjCq2S
         YWDQFtqTrsRVSsx+o1YRk2wA7af/Qo+IWF9Ggcx0=
Date:   Wed, 8 Jan 2020 12:02:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUGFIX PATCH] kprobes: Fix to cancel optimizing/unoptimizing
 kprobes correctly
Message-Id: <20200108120249.99d5a6d5201d1401e24447bc@kernel.org>
In-Reply-To: <20200107183907.3c87500a@gandalf.local.home>
References: <157840814418.7181.13478003006386303481.stgit@devnote2>
        <20200107183907.3c87500a@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 18:39:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  7 Jan 2020 23:42:24 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > optimize_kprobe() and unoptimize_kprobe() cancels if given kprobe
> > is on the optimizing_list or unoptimizing_list. However, since
> > commit f66c0447cca1 ("kprobes: Set unoptimized flag after
> > unoptimizing code") modified the update timing of the
> > KPROBE_FLAG_OPTIMIZED, it doesn't work as expected anymore.
> > 
> > The optimized_kprobe could be following states.
> > 
> > - [optimizing]: Before inserting jump instruction
> >   op.kp->flags has KPROBE_FLAG_OPTIMIZED and
> >   op->list is not empty.
> > 
> > - [optimized]: jump inserted
> >   op.kp->flags has KPROBE_FLAG_OPTIMIZED and
> >   op->list is empty.
> > 
> > - [unoptimizing]: Before removing jump instruction (including unused
> >   optprobe)
> >   op.kp->flags has KPROBE_FLAG_OPTIMIZED and
> >   op->list is not empty.
> > 
> > - [unoptimized]: jump removed
> >   op.kp->flags doesn't have KPROBE_FLAG_OPTIMIZED and
> >   op->list is empty.
> > 
> > Current code mis-expects [unoptimizing] state doesn't have
> > KPROBE_FLAG_OPTIMIZED, and that can cause wrong results.
> > 
> > This introduces optprobe_queued_unopt() to distinguish [optimizing]
> > and [unoptimizing] states and fixes logics in optimize_kprobe() and
> > unoptimize_kprobe().
> > 
> > Fixes: f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Looks good.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thank you!

> 
> 
> >  		return;
> >  	}
> > +
> >  	/* Optimized kprobe case */
> > -	if (force)
> > +	if (force) {
> >  		/* Forcibly update the code: this is a special case */
> >  		force_unoptimize_kprobe(op);
> > -	else {
> > +	} else {
> >  		list_add(&op->list, &unoptimizing_list);
> >  		kick_kprobe_optimizer();
> >  	}
> 
> I see you added some clean up to this patch.

Yeah, I felt somewhat uncomfortable for that. 

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
