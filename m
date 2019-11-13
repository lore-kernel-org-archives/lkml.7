Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D760C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FE322467
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfKMOeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfKMOeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:34:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 742B32245D;
        Wed, 13 Nov 2019 14:34:29 +0000 (UTC)
Date:   Wed, 13 Nov 2019 09:34:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191113093427.53cabea1@gandalf.local.home>
In-Reply-To: <alpine.LSU.2.21.1911131500210.18679@pobox.suse.cz>
References: <20191108212834.594904349@goodmis.org>
        <20191108213450.032003836@goodmis.org>
        <alpine.LSU.2.21.1911131500210.18679@pobox.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 15:13:44 +0100 (CET)
Miroslav Benes <mbenes@suse.cz> wrote:

> > @@ -1757,6 +1761,18 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> >  				return false;
> >  			rec->flags--;
> >  
> > +			if (ops->flags & FTRACE_OPS_FL_DIRECT)
> > +				rec->flags &= ~FTRACE_FL_DIRECT;
> > +
> > +			/*
> > +			 * Only the internal direct_ops should have the
> > +			 * DIRECT flag set. Thus, if it is removing a
> > +			 * function, then that function should no longer
> > +			 * be direct.
> > +			 */
> > +			if (ops->flags & FTRACE_OPS_FL_DIRECT)
> > +				rec->flags &= ~FTRACE_FL_DIRECT;
> > +  
> 
> The flag is dropped twice here.

Ah, thanks for pointing this out. It appears that a rebase I did (where
I modified and rebased on a previous version) add this as a new change
(with the comment).

-- Steve
