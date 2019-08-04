Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C267C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 11:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA085206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 11:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="BfD08WN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfHDLow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 07:44:52 -0400
Received: from dougal.metanate.com ([90.155.101.14]:38613 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfHDLow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 07:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XFXKBtacMj7+iS2hJMQvDhIU6Wwk+FtP4wcUdSXcXdw=; b=BfD08WN9sQgszj4PKofDZRXqSy
        Vhtn/kZkuJ201sqCNJeS25cnVxoNAIEJHb3mgaF28rN3n5hXR3driv77qPZ2q0cY3s0pvNgCctlnx
        S0htVDvPFLf4JRm4qLUFhyCH0D6gUHCL+WEld4Ym86XPFJ+ZLeZeGLz+0EIFz9evyF+98t4It2UJX
        Lrx39s58u0xPBzFhNSMUb3fRnpQzfLE5c2PwyhImHcHBXwUXX/w2HsZz1H1fKizpbj6krW7mobYCD
        I4OotSIOWr55z3rHLTJhAOB5+OFTNW8DAgrFMYd/fn+NOThQK0JOHAKYsb4lmUgZcg0hGnhVZFO/O
        oCN5Q5gQ==;
Received: from johnkeeping.plus.com ([81.174.171.191] helo=donbot)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1huEwF-0006Wo-Sj; Sun, 04 Aug 2019 12:44:36 +0100
Date:   Sun, 4 Aug 2019 12:44:34 +0100
From:   John Keeping <john@metanate.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf unwind: fix libunwind when tid != pid
Message-ID: <20190804124434.204da4ac.john@metanate.com>
In-Reply-To: <20190802133039.GE27223@krava>
References: <20190729172430.14880-1-john@metanate.com>
        <20190729172430.14880-2-john@metanate.com>
        <20190802133039.GE27223@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 15:30:39 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Mon, Jul 29, 2019 at 06:24:30PM +0100, John Keeping wrote:
> > Commit e5adfc3e7e77 ("perf map: Synthesize maps only for thread group
> > leader") changed the recording side so that we no longer get mmap events
> > for threads other than the thread group leader.
> > 
> > When a file recorded after this change is loaded, the lack of mmap
> > records mean that unwinding is not set up for any other threads.  
> 
> sry I dont' follow what's the problem here, could you please
> describe the scenrio where the current code is failing in
> more details

With perf compiled to use libunwind, run:

	perf record --call-graph=dwarf -t $TID -- sleep 5
	perf report

If $TID is a process, then the output has the call graph, but if it's a
secondary thread then it is as if --no-call-graph was specified.

> > 
> > Following the rationale in that commit, move the libunwind fields into
> > struct map_groups and update the libunwind functions to take this
> > instead of the struct thread.  This is only required for
> > unwind__finish_access which must now be called from map_groups__delete
> > and the others are changed for symmetry.
> > 
> > Note that unwind__get_entries keeps the thread argument since it is
> > required for symbol lookup and the libdw unwind provider uses the thread
> > ID.  
> 
> SNIP
> 
> > @@ -59,37 +59,31 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
> >  		return 0;
> >  	}
> >  out_register:
> > -	unwind__register_ops(thread, ops);
> > +	unwind__register_ops(mg, ops);
> >  
> > -	err = thread->unwind_libunwind_ops->prepare_access(thread);
> > +	err = mg->unwind_libunwind_ops->prepare_access(mg);
> >  	if (initialized)
> >  		*initialized = err ? false : true;
> >  	return err;
> >  }
> >  
> > -void unwind__flush_access(struct thread *thread)
> > +void unwind__flush_access(struct map_groups *mg)
> >  {
> > -	if (!dwarf_callchain_users)
> > -		return;  
> 
> why did you remove this check?

I don't think there is any way for unwind_libunwind_ops to be set if
!dwarf_callchain_users so this is redundant given the following
condition.

But this should probably be a separate patch.

> > -
> > -	if (thread->unwind_libunwind_ops)
> > -		thread->unwind_libunwind_ops->flush_access(thread);
> > +	if (mg->unwind_libunwind_ops)
> > +		mg->unwind_libunwind_ops->flush_access(mg);
> >  }
> >  
> > -void unwind__finish_access(struct thread *thread)
> > +void unwind__finish_access(struct map_groups *mg)
> >  {
> > -	if (!dwarf_callchain_users)
> > -		return;  
> 
> why did you remove this check?

Likewise.


Regards,
John
