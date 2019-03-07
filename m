Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F81EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D73820675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551985633;
	bh=xUQpkflw/lleDy8DtQBoKdYhV0IIr3oEasuhYJKVhXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bc1L79jG2tTYItvN0Nu1FL0gjezqrV70e4Cbm4LFuEmFAulSaNLssY20PRGhaNM5h
	 6jGwzr1fqIyBMjRrQVr6iuCAPiQFJmKCy5OsyiVV6MnIvxCOd4L95CsmKtuB/ny0uq
	 //ZGtf5nvXjd8nlm3vxyPzzy7LWjZC2gldBg8PXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCGTHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGTHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:07:11 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6373D20879
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551985630;
        bh=xUQpkflw/lleDy8DtQBoKdYhV0IIr3oEasuhYJKVhXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MQWTcQNrxXs40b9iel8ZXoBNgMhUYD0iKoVEJojuX23yICstqRzq7TCTnHzuwoYz4
         kjgLiOZDz8Qjlu1Em0Ua1YooprbSOPqHzhVF69vZGAyHbBIKG9tqClGSLNjj7aBJzG
         kQyO9OI2WRXBKBZ2gkDPyo6c1WiYLc8TJ97AYkuo=
Received: by mail-wm1-f50.google.com with SMTP id x10so10277844wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:07:10 -0800 (PST)
X-Gm-Message-State: APjAAAWBkR8qjjsKFRK+bjMRYjbavRJPAv/NP3NUwoKkdN2y+LuVIJ0l
        ihR9R1UNDDB1nDHf6PBB8G8dVikYx2LF2ih7gWYInw==
X-Google-Smtp-Source: APXvYqzo4Ns5h0u4buT0c9QRjKer1un+yQxFMHoSGcRD2HAdGIwknv1ta6WvfhD/XU00s0Jb3GXvuDca3ANCLWlatYQ=
X-Received: by 2002:a1c:7906:: with SMTP id l6mr6491195wme.83.1551985628850;
 Thu, 07 Mar 2019 11:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20190307114511.870090179@infradead.org> <20190307115159.708180729@infradead.org>
 <CALCETrX8ZAQpqxA+aRA7gdT3or33wj2Lmj40khmHp59JO=AVVg@mail.gmail.com> <20190307185922.GA2482@worktop.programming.kicks-ass.net>
In-Reply-To: <20190307185922.GA2482@worktop.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 Mar 2019 11:06:57 -0800
X-Gmail-Original-Message-ID: <CALCETrWZ5MwPqFuwDkTKKZXnZivqdjtb9LhpgLpYk+iAagWyRw@mail.gmail.com>
Message-ID: <CALCETrWZ5MwPqFuwDkTKKZXnZivqdjtb9LhpgLpYk+iAagWyRw@mail.gmail.com>
Subject: Re: [PATCH 07/20] x86/uaccess: Always inline force_valid_ss()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 07, 2019 at 10:05:43AM -0800, Andy Lutomirski wrote:
> > On Thu, Mar 7, 2019 at 3:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x3cc: call to force_valid_ss.isra.5() with UACCESS enabled
> > >
> > > XXX: move the callsite out of te AC=1 region instead?
> >
> > Let's move it instead.  I looked at the code and it should be fine.
>
> Something like so; or did I miss something subtle?

Reviewed-by: Andy Lutomirski <luto@kernel.org>

Also, this stuff is pretty well covered by the x86 selftests, mostly
because getting it right in the first place was way too subtle for
comfort.

--Andy
