Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1ADC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A39208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F8AFn2T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfE1LQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:16:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36275 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfE1LQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:16:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so19774553wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m2nsIiu2xmXeWsYUgRHVpMlsXmoMPRxeUORAALMIKSI=;
        b=F8AFn2T8q0YuEbe8O1YmusdB4KKX4+W7+bSwB31soLQqW7nM+xmlU7TAZMFkFdHJLB
         Jy1WVb8qw8KkVqWiofCzb5Ey2TiQlhTVZFu8lRZeL0GtHBtn4yicUcWTdye2K+uayqkC
         jqFubNh1Hl8MPRKXzBgIS8CoL7co65suY5UoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m2nsIiu2xmXeWsYUgRHVpMlsXmoMPRxeUORAALMIKSI=;
        b=NknNhEzlTG5TzQ6aMtQ8BlX0gE4hUZzqkk9vdZQZjuLrYkNlj+kQuvuPyGylFgOGXL
         q+mGQupt5ACHyHsf0uW6ga/ij7z86u4u+4fBNZd6kdUJGGNgAyiwNkq4NSpJfuEAmEpK
         qq/2A8h9k5YOnr8ksb6/Z3QWBdvonNKLT8OAweVMfWBQ9ujQI6oz5eZABhZD2CN0WmfR
         NA9qNDjWGsWbR2/IimhV0c3WHGRKdCIvlyT2d1UhF99TPjQNeAkbBeOLtUUMe7jcy8oe
         P6sK/kENkd0RoeOeumxh5jziNAiitfLcCsZFEEtdAz41jJTHz4iGGPPc/Tkp+nwmJME2
         8x0w==
X-Gm-Message-State: APjAAAXKSA4sJ0GcZ2A2mgIpHQjPYFMhUsAJ1OYuN3Z8fvjf7DtlZRwn
        zInXQph7NFsSsDOGsPg0vaNCxQ==
X-Google-Smtp-Source: APXvYqz5nIcFjokXYBk+792MqQz8LkCQtBXoFpS+E23Bk9wHZ1kkRwZndDs817gSoTcwICsJyRkaDQ==
X-Received: by 2002:adf:9bd2:: with SMTP id e18mr27122695wrc.210.1559042166403;
        Tue, 28 May 2019 04:16:06 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id h17sm16048029wrq.79.2019.05.28.04.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 04:16:05 -0700 (PDT)
Date:   Tue, 28 May 2019 13:15:58 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, arnd@arndb.de,
        bp@alien8.de, catalin.marinas@arm.com, davem@davemloft.net,
        fenghua.yu@intel.com, heiko.carstens@de.ibm.com,
        herbert@gondor.apana.org.au, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, linux@armlinux.org.uk, mattst88@gmail.com,
        mingo@kernel.org, mpe@ellerman.id.au, palmer@sifive.com,
        paul.burton@mips.com, paulus@samba.org, ralf@linux-mips.org,
        rth@twiddle.net, stable@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, vgupta@synopsys.com,
        gregkh@linuxfoundation.org, jhansen@vmware.com, vdasa@vmware.com,
        aditr@vmware.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/18] locking/atomic: atomic64 type cleanup
Message-ID: <20190528111558.GA9106@andrea>
References: <20190522132250.26499-1-mark.rutland@arm.com>
 <20190523083013.GA4616@andrea>
 <20190523101926.GA3370@lakrids.cambridge.arm.com>
 <20190524103731.GN2606@hirez.programming.kicks-ass.net>
 <20190524111807.GS2650@hirez.programming.kicks-ass.net>
 <20190524114220.GA4260@fuggles.cambridge.arm.com>
 <20190524115231.GN2623@hirez.programming.kicks-ass.net>
 <20190524224340.GA3792@andrea>
 <20190528104719.GN2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528104719.GN2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 12:47:19PM +0200, Peter Zijlstra wrote:
> On Sat, May 25, 2019 at 12:43:40AM +0200, Andrea Parri wrote:
> > > ---
> > > Subject: Documentation/atomic_t.txt: Clarify pure non-rmw usage
> > > 
> > > Clarify that pure non-RMW usage of atomic_t is pointless, there is
> > > nothing 'magical' about atomic_set() / atomic_read().
> > > 
> > > This is something that seems to confuse people, because I happen upon it
> > > semi-regularly.
> > > 
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  Documentation/atomic_t.txt | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > > index dca3fb0554db..89eae7f6b360 100644
> > > --- a/Documentation/atomic_t.txt
> > > +++ b/Documentation/atomic_t.txt
> > > @@ -81,9 +81,11 @@ SEMANTICS
> > >  
> > >  The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
> > >  implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> > > -smp_store_release() respectively.
> > > +smp_store_release() respectively. Therefore, if you find yourself only using
> > > +the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
> > > +and are doing it wrong.
> > 
> > The counterargument (not so theoretic, just look around in the kernel!) is:
> > we all 'forget' to use READ_ONCE() and WRITE_ONCE(), it should be difficult
> > or more difficult to forget to use atomic_read() and atomic_set()...   IAC,
> > I wouldn't call any of them 'wrong'.
> 
> I'm thinking you mean that the type system isn't helping us with
> READ/WRITE_ONCE() like it does with atomic_t ?

Yep.


> And while I agree that
> there is room for improvement there, that doesn't mean we should start
> using atomic*_t all over the place for that.

Agreed.  But this still doesn't explain that "and are doing it wrong",
AFAICT; maybe just remove that part?

  Andrea


> 
> Part of the problem with READ/WRITE_ONCE() is that it serves a dual
> purpose; we've tried to untangle that at some point, but Linus wasn't
> having it.
