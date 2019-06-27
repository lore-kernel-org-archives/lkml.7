Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6205EC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EB22064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfF0M6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0M6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:58:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8068D204FD;
        Thu, 27 Jun 2019 12:58:06 +0000 (UTC)
Date:   Thu, 27 Jun 2019 08:58:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 2/4] objtool: Add support for C jump tables
Message-ID: <20190627085804.070a9541@gandalf.local.home>
In-Reply-To: <20190627024700.q4rkcbhmrna6ev4y@treble>
References: <cover.1561595111.git.jpoimboe@redhat.com>
        <426541f62dad525078ee732c09bc206289e994aa.1561595111.git.jpoimboe@redhat.com>
        <CAADnVQ+veayfD70Xsu8UnNrLdRW6rh9jxPb=OGoiYT-O=_zW=A@mail.gmail.com>
        <20190627024700.q4rkcbhmrna6ev4y@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 21:47:00 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Jun 26, 2019 at 06:42:40PM -0700, Alexei Starovoitov wrote:
> > > @@ -1035,9 +1038,18 @@ static struct rela *find_switch_table(struct objtool_file *file,
> > >
> > >                 /*
> > >                  * Make sure the .rodata address isn't associated with a
> > > -                * symbol.  gcc jump tables are anonymous data.
> > > +                * symbol.  GCC jump tables are anonymous data.
> > > +                *
> > > +                * Also support C jump tables which are in the same format as
> > > +                * switch jump tables.  Each jump table should be a static
> > > +                * local const array named "jump_table" for objtool to
> > > +                * recognize it.  
> > 
> > Nacked-by: Alexei Starovoitov <ast@kernel.org>
> > 
> > It's not acceptable for objtool to dictate kernel naming convention.  
> 
> Abrasive nack notwithstanding, I agree it's not ideal.
> 
> How about the following approach instead?  This is the only other way I
> can think of to annotate a jump table so that objtool can distinguish
> it:
> 
> #define __annotate_jump_table __section(".jump_table.rodata")
> 
> Then bpf would just need the following:
> 
> -	static const void *jumptable[256] = {
> +	static const void __annotate_jump_table *jumptable[256] = {
> 
> This would be less magical and fragile than my original approach.
> 
> I think the jump table would still be placed with all the other rodata,
> like before, because the vmlinux linker script recognizes the section
> ".rodata" suffix and bundles them all together.
> 

After finally getting a chance to skim through this lovely thread, I
was going to suggest exactly this. This is the way we usually handle
"special" data.

As it appears that Alexei is good with this approach, please go this
route.

Thanks!

-- Steve


