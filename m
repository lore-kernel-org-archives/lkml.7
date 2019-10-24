Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E120ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77DC20650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571934273;
	bh=xD1gHG7sdYECgBcaX1I3ErLN5e+7Bcvxfw58Z5UkxWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EvavgXyR3HhqudFA+CizWK+wosl5y4DYYvV9HQFUi/v9yZXUtPKZj38HLoF7Sw6TF
	 nF2+UFcHzMfc5o2D0H+B+q9kZzP/tsD89QybN3dFwZprNsue30v6q1UrPMdt5khEY3
	 TXqPwipW6by69yPKOJ/pCPRCaAgtXTJoRuB9AfEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439856AbfJXQYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733261AbfJXQY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:24:29 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB6D20650
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571934269;
        bh=xD1gHG7sdYECgBcaX1I3ErLN5e+7Bcvxfw58Z5UkxWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cMgz30XMQHcj05ka5AvwAN4vg3QH06UOV2FiniGBcXY6aLJkgav30QRcBc4Yj5V4r
         i8nr6g22rn/+HUJNQgotVd06w4Zv/wyX9vjfDHPv6LG0sdkcn4nTddMILQyCol0aE3
         oiClyv3XYuC1hKYFlD6aF2kIocdrwoBL50dH+hno=
Received: by mail-wr1-f44.google.com with SMTP id r1so16987852wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:24:29 -0700 (PDT)
X-Gm-Message-State: APjAAAUTCsjsr3cDJihqeT9zdZdC5I7qNMGVy6/8nLIcGpfBrkix2nmD
        2FXDiaEMLUQRltEMGn+0SfIknBhpUKoAGo+EQiGJsw==
X-Google-Smtp-Source: APXvYqwH/8k3vOnYy8kFWtwcVyKD76drxnPThFvixiYP9/NJ4zhI9FrC8FyUhlrBqq3QTOq33KRRMBKNqm/rGC3Sdls=
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr4522564wrv.149.1571934267795;
 Thu, 24 Oct 2019 09:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191023122705.198339581@linutronix.de> <20191023123118.386844979@linutronix.de>
 <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
In-Reply-To: <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 24 Oct 2019 09:24:13 -0700
X-Gmail-Original-Message-ID: <CALCETrV79pw7-nisp4VdEkQ4=fr2nfJFOMCtyKmWZR6PG3=oWg@mail.gmail.com>
Message-ID: <CALCETrV79pw7-nisp4VdEkQ4=fr2nfJFOMCtyKmWZR6PG3=oWg@mail.gmail.com>
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

Well, I feel a bit silly.  I read this:

>
> >  #define SYSCALL_EXIT_WORK_FLAGS                                \
> > @@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

and I applied the diff in my head to the wrong function, and I didn't
notice that it didn't really apply there.  Oddly, gitweb gets this
right:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=WIP.core/entry&id=e3158f93138ded84eb44fa97606197f6adcf9366

Looking at the actual code:

Acked-by: Andy Lutomirski <luto@kernel.org>

with one minor caveat: you are making a subtle and mostly irrelevant
semantic change: with your patch, user mode will be traced as IRQs on
even if a nasty user has used iopl() to turn off interrupts.  This is
probably a good thing, but I think you should mention it in the
changelog.

FWIW, the rest of the series looks pretty good, too.
