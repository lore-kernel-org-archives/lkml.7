Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87B6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE80F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfCUUfy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfCUUfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:35:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A86802183E;
        Thu, 21 Mar 2019 20:35:51 +0000 (UTC)
Date:   Thu, 21 Mar 2019 16:35:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321163550.21b29194@gandalf.local.home>
In-Reply-To: <b6d80345-4153-13d4-a63d-4760764d7c98@citrix.com>
References: <20190320221534.165ab87b@oasis.local.home>
        <20190321083317.GL6058@hirez.programming.kicks-ass.net>
        <20190321090241.GL6521@hirez.programming.kicks-ass.net>
        <20190321104517.GM6521@hirez.programming.kicks-ass.net>
        <20190321093242.4a948198@gandalf.local.home>
        <20190321172203.GS5996@hirez.programming.kicks-ass.net>
        <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
        <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
        <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com>
        <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com>
        <20190321183713.GX5996@hirez.programming.kicks-ass.net>
        <CALCETrW-Jn=nWOgYUdMhoS_Z6vYNmfYzt6P54FBOaWzp4kPvQQ@mail.gmail.com>
        <b6d80345-4153-13d4-a63d-4760764d7c98@citrix.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 20:00:19 +0000
Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> I'm afraid that I've not got the original context of this thread, but
> I'm going to guess that something is resulting in a #PF before %cr2
> before it gets saved on the #PF path, and using a PVOP causes things to
> explode?

Actually it had nothing to do with PVOPs. It was tracing that caused
it. We added tracepoints to irqs off and on (with a config enabled),
and there's an option to allow taking user stack traces at any
tracepoint. The tracing of irqs off happened at the start of the page
fault entry, and by tracing the userspace stack (which can also fault)
we corrupted the cr2 for the original page fault.

The work now is to store that cr2 early on, but that requires doing it
in assembly, and that's where PVOPs makes the solution hard.

-- Steve


> 
> If it helps in the short term, Xen will trap and emulate a mov from cr2
> instruction correctly.  Performance will surely suck, but it might be an
> option if we need to rethink how this information is made available to
> guests.
> 
> Thanks,
> 
> ~Andrew

