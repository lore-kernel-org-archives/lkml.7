Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B8FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711C82071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfKNSsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfKNSsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:48:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B89206CC;
        Thu, 14 Nov 2019 18:48:29 +0000 (UTC)
Date:   Thu, 14 Nov 2019 13:48:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191114134827.555e9b31@gandalf.local.home>
In-Reply-To: <CAADnVQJcwyDBm7no2_wauezjkEFvgJk10FppiqRBU8p_7n0tbw@mail.gmail.com>
References: <20191108212834.594904349@goodmis.org>
        <20191108213450.032003836@goodmis.org>
        <20191109022907.6zzo6orhxpt5n2sv@ast-mbp.dhcp.thefacebook.com>
        <20191109073310.6a7a16f2@gandalf.local.home>
        <20191114132942.2adc7aa2@gandalf.local.home>
        <CAADnVQJcwyDBm7no2_wauezjkEFvgJk10FppiqRBU8p_7n0tbw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 10:34:09 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Alexei,
> >
> > Do you still need such a feature?
> >
> > Note, I just pushed my tree to my for-next tree, and also have a
> > ftrace/direct branch that ends with this patch set that is the basis of
> > the rest of the work of my code. Feel free to build against that
> > branch if you need to have something built on the net tree.  
> 
> I'm still trying to figure out what you meant
> by your suggestion to implement a modify_ftrace_direct().
> I was thinking something much simpler like
> modify_ftrace_direct(ip, old_call, new_ca);
> will just text poke that call addr from old to new if old matches

The main reason, is that then we need to add another arch specific
change, where as, the solution I suggested doesn't need anything new.
The less arch specific code we need the better.

> and will adjust ftrace inner bookkeeping.
> I don't understand why you want to malloc/free ftrace_ops for that.

We wouldn't need to allocate it, the stub could be something as simple
as:

struct ftrace_ops dummy_ops = {
	.func = ftrace_stub;
}

And just register that, where we set the hash to it, which would
require an malloc and free, but is that really a problem? A modify
shouldn't be a hot path, as text poke itself is going to be slow.

-- Steve
