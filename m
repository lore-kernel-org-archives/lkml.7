Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E3FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700E021A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571866535;
	bh=SBMDObVtLwoJsFVjvZzIsniwPAe1oxrRAkshjAWtzj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r/Iz0LYujqkn6DHt7PaN4wgvwU9qe1nR8VZr9y0mzzTKHOueRtCio3m2hwRQVE1mb
	 jhN5NCRbhfL/ip/2TvoLw9lyD0CJ9hZbKk4xjmmTIYDxjCLjCRidIA3j/t/o/03/Sy
	 SifjpB4w2nkTM/u/QytUxtYU8ysENrUzLj4y+Jag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407557AbfJWVfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405741AbfJWVfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:35:34 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39B0621D7E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 21:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571866533;
        bh=SBMDObVtLwoJsFVjvZzIsniwPAe1oxrRAkshjAWtzj4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h3CDLvA6h0MsaxhWNI9xrgoTV+5LVFAYA+KjXLSRcwDE8Rmm5DMOpt/zPVRij91tu
         TIXM0vtC9cBP4e31o9cuvGYOHApLj9KgvUdoZcEJlv6e96yAqpD8MYkbk2ICIqzNwa
         7nF2y5WGCBHh2rod/Cdr0rV+N6/7E4tboKtuNBVQ=
Received: by mail-wr1-f45.google.com with SMTP id p4so23672096wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 14:35:33 -0700 (PDT)
X-Gm-Message-State: APjAAAVQx2g4NNIJiw7v8+1kg1a50e0lUbupOyVx0fbZpQn2GncA1JI4
        9VK3tAZq4b9jRcHzsz3U3iYTX7BbytnomLXr981/7w==
X-Google-Smtp-Source: APXvYqxcjjEXMQAIIXDM/w44hSbq6ajR/ylOwPkVyoOrIvjXgG6QXCSCwugMOg6p+QCWdK3zhJjgOXw4o76uQhhTHl0=
X-Received: by 2002:adf:f7d1:: with SMTP id a17mr235388wrq.111.1571866531748;
 Wed, 23 Oct 2019 14:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191023122705.198339581@linutronix.de> <20191023123118.386844979@linutronix.de>
 <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
In-Reply-To: <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Oct 2019 14:35:20 -0700
X-Gmail-Original-Message-ID: <CALCETrWvnge064VUY3FQKens2Nx8BPNDhUZAXCvF6bD7VJy93A@mail.gmail.com>
Message-ID: <CALCETrWvnge064VUY3FQKens2Nx8BPNDhUZAXCvF6bD7VJy93A@mail.gmail.com>
Subject: Re: [patch V2 08/17] x86/entry: Move syscall irq tracing to C code
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 2:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Interrupt state tracing can be safely done in C code. The few stack
> > operations in assembly do not need to be covered.
> >
> > Remove the now pointless indirection via .Lsyscall_32_done and jump to
> > swapgs_restore_regs_and_return_to_usermode directly.
>
> This doesn't look right.
>
> >  #define SYSCALL_EXIT_WORK_FLAGS                                \
> > @@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc
> >  {
> >         struct thread_info *ti;
> >
> > +       /* User to kernel transition disabled interrupts. */
> > +       trace_hardirqs_off();
> > +
>
> So you just traced IRQs off, but...
>
> >         enter_from_user_mode();
> >         local_irq_enable();
>
> Now they're on and traced on again?
>
> I also don't see how your patch handles the fastpath case.
>
> How about the attached patch instead?

Ignore the attached patch.  You have this in your
do_exit_to_usermode() later in the series.  But I'm still quite
confused by this patch.
