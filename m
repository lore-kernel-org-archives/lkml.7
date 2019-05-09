Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1453CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25902173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfEINBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfEINBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:01:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13E4520989;
        Thu,  9 May 2019 13:01:00 +0000 (UTC)
Date:   Thu, 9 May 2019 09:00:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190509090058.6554dc81@gandalf.local.home>
In-Reply-To: <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
References: <20190318153840.906404905@infradead.org>
        <20190318155140.058627431@infradead.org>
        <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
        <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 10:26:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Mar 20, 2019 at 4:17 AM David Laight <David.Laight@aculab.com> wrote:
> >  
> > >               ______r = !!(cond);                                     \  
> >
> >         Is that (or maybe just the !!) needed any more??  
> 
> It is, because the 'cond' expression might not be an int, it could be
> a test for a pointer being non-NULL, or an u64 being non-zero, and not
> having the "!!" would mean that you'd get a warning or drop bits when
> assigning to 'int'.
> 
> And you do need the new temporary variable to avoid double evaluation
> the way that code is written.
> 
> That said, I do think the code is really ugly. We could:
> 
>  - avoid the temporary by just simplifying things.
> 
>  - do the '!!' just once in the parent macro.
> 
>  - Steven has this crazy model of "more underscores are better". They
> aren't. They don't help if things nest anyway, but what does help is
> meaningful names. Both when things don't nest, and when looking at
> generated asm files.
> 
>  - ,, and finally, what _is_ better is to chop things up so that they
> are smaller and make each macro do only one thing
> 
> So maybe do the patch something like the attached instead? Completely
> untested, but it looks sane to me.
> 

Linus,

This patch works. Can I get your Signed-off-by for it?

-- Steve
