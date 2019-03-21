Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3762C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6CA218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553192467;
	bh=EmTn4zvEP5gRbxj/9wqq4+Yb3fGzCjTOIMl/rebDQ2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H3TJFqW3eS6ymz2oTUW+CuKI46yzil6UTZZUOVK2N0umcBX8Eev/8d22r9IV28RPp
	 CTpI0S2T31YwIfCa/E+750aMbEkM4CRcPUw82/dZlgAsHuuuLV7nBMxp+Jy8z9+lEQ
	 /JMyeoo79H52ZgbZJll7IFAjS7l6J7i98J0M9ZLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfCUSVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbfCUSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:21:06 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FD921925
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553192465;
        bh=EmTn4zvEP5gRbxj/9wqq4+Yb3fGzCjTOIMl/rebDQ2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q5AC4bQnxb/P57Ed+gMsGqRFfyh9+dGlJZceTN3HJCs0ytzykOlZ/yHxXmJLYI9rf
         +5fDNgevgLxatrA87Quy0+xHJ+FW/MBVHSD+0PZCNZCOBpCk7tKBT0uYidCWqjsyAX
         wHmsR0CGb4JIJBi1GWsiIhF5rKmlULvOxasPPK0Q=
Received: by mail-wm1-f43.google.com with SMTP id v14so3754020wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:21:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWmLDlcRrZB1RDDbEAuyTWteyQgZ8M2oeN47H8HYo8WLElrNXKX
        a0IziwJ2VaKiw+ZsSzj/OO6b9+sjIjBK6A2lmUU/vQ==
X-Google-Smtp-Source: APXvYqweTtbEViLVdDXmT0Ck7StiegnUwWIcDiKt0bUq+hPFyToqJuLumxnI8VwopAST1YsCrADeuBPrbVTTLDtGiN0=
X-Received: by 2002:a1c:9a41:: with SMTP id c62mr392628wme.108.1553192463866;
 Thu, 21 Mar 2019 11:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com> <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
In-Reply-To: <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 11:20:52 -0700
X-Gmail-Original-Message-ID: <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com>
Message-ID: <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:19 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 21, 2019 at 11:05 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > In the long run, I think the right solution is to rewrite even more of
> > this mess in C.  We really ought to be able to put the IRQ flag
> > tracing and the context tracking into C code.
>
> Tangentially about this long run thing - can we start discussing just
> dropping PV mode entirely in the long run? Or even not-so-long run?
>
> What are the pressing advantages of paravirt these days? Because I can
> point to a lot of pressing _disadvantages_, and not all of them are
> about more complex code as shown by this patch...
>

I dunno.  Lots of people at least use to have serious commercial interest in it.

Hey Xen folks, how close are we to being able to say "if you want to
run a new kernel, you need to switch to PVH or similar"?

--Andy
