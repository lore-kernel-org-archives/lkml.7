Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EABBC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1672173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbfGPPYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbfGPPYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:24:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86DE1217D9;
        Tue, 16 Jul 2019 15:24:35 +0000 (UTC)
Date:   Tue, 16 Jul 2019 11:24:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Will Deacon <will@kernel.org>,
        mingo@redhat.com, corbet@lwn.net, linux@armlinux.org.uk,
        catalin.marinas@arm.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tracing/fgraph: support recording function return
 values
Message-ID: <20190716112433.5936c60f@gandalf.local.home>
In-Reply-To: <20190716142005.GE3402@hirez.programming.kicks-ass.net>
References: <20190713121026.11030-1-changbin.du@gmail.com>
        <20190715082930.uyxn2kklgw4yri5l@willie-the-truck>
        <20190715101231.GB3419@hirez.programming.kicks-ass.net>
        <20190716140817.za4rad3hx76efqgp@mail.google.com>
        <20190716142005.GE3402@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 16:20:05 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jul 16, 2019 at 10:08:18PM +0800, Changbin Du wrote:
> > On Mon, Jul 15, 2019 at 12:12:31PM +0200, Peter Zijlstra wrote:  
> 
> > > Alternatively, we can have recordmcount (or objtool) mark all functions
> > > with a return value when the build has DEBUG_INFO on. The dwarves know
> > > the function signature.
> > >  
> > We can extend the recordmcount tool to search 'subprogram' tag in the DIE tree.
> > In below example, the 'DW_AT_type' is the type of function pidfd_create().
> > 
> > $ readelf -w kernel/pid.o
> >  [...]
> >  <1><1b914>: Abbrev Number: 232 (DW_TAG_subprogram)
> >     <1b916>   DW_AT_name        : (indirect string, offset: 0x415e): pidfd_create
> >     <1b91a>   DW_AT_decl_file   : 1
> >     <1b91b>   DW_AT_decl_line   : 471
> >     <1b91d>   DW_AT_decl_column : 12
> >     <1b91e>   DW_AT_prototyped  : 1
> >     <1b91e>   DW_AT_type        : <0xcc>
> >     <1b922>   DW_AT_low_pc      : 0x450
> >     <1b92a>   DW_AT_high_pc     : 0x50
> >     <1b932>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
> >     <1b934>   DW_AT_GNU_all_call_sites: 1
> >     <1b934>   DW_AT_sibling     : <0x1b9d9>
> >  [...]
> > 
> > To that end, we need to introduce libdw library for recordmcount. I will have a
> > try this week.  
> 
> Right; but only when this config option is set.

Sure, and we can have fgraph support of return values depend on that
option ;-)

> 
> > And probably, we can also record the parameters?  
> 
> The 'fun' part is where to store all this information in the kernel and
> how fast you can find it while tracing.

This has been on my TODO list for a long time (I'm really happy if
someone else would do it!). My thought is that this information would
need to be able to be a module and loaded (like config.gz can be). And
then you can load the info, do the tracing, and then unload it.

For the speed part, we can add a way to hook the function with the
parameters, which shouldn't be an issue, as we already do that when
filtering for function graph. There's a function hash table that fgraph
users have that is tested to see if it should trace the function or
not. And the functions themselves are recorded in a mostly binary array
that can be looked up via a binary search from the ip address.

-- Steve
