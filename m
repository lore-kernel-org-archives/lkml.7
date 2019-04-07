Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3CC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C7C20879
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="L3oKibsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDGT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:26:19 -0400
Received: from mail.efficios.com ([167.114.142.138]:59716 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:26:19 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7C7801D04B7;
        Sun,  7 Apr 2019 15:26:17 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id whK05hXSWsvZ; Sun,  7 Apr 2019 15:26:17 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EF7091D04B3;
        Sun,  7 Apr 2019 15:26:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EF7091D04B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554665177;
        bh=0xqhKfNn8Rxz/lLzWhxAngbaNpJiYHOCuPS5BM6vPuU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=L3oKibsU6A3mW5Q1vVzfUdkFlgOBrt2FukemuDjglb12wsRd2kMkK/JeflISvHM+N
         LBw9HUl7dNyitNCDmJ4VwA7ohZo6c1Xegk35rNXjh8vW5sEMJsxPK8o66MqIySJULg
         Mx8iQuQcBeyfj+UwFsOmHcfyGAXfNKc9oJJSkfJ9XyejsvnlRxI2+HRfmQGOSkILqE
         aV3SwjZnDs3JGINoWHcx9oPhmF/y+fgxsHcUn/j8QAkvnZzrX6o1qrkSPW1M5eG4Ce
         +2AfdmZarAPvY9KpOOFAk0s/ITcxlQf6afbsQeysTaIPU9M50N0WnWUeUy4NHSQFaR
         nUcNYhjG7Y9lw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id CzvJ1oraud4P; Sun,  7 Apr 2019 15:26:16 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id CB54A1D049B;
        Sun,  7 Apr 2019 15:26:16 -0400 (EDT)
Date:   Sun, 7 Apr 2019 15:26:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Message-ID: <134026717.535.1554665176677.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190407135937.GA30053@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com> <20190403133243.GE4102@linux.ibm.com> <1028306587.504.1554301662374.JavaMail.zimbra@efficios.com> <20190403162039.GA14111@linux.ibm.com> <20190405232835.GA24702@linux.ibm.com> <20190406230613.GA187766@google.com> <20190407133941.GC14111@linux.ibm.com> <20190407135937.GA30053@linux.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: Forbid static SRCU use in modules
Thread-Index: wn1LwCT5BP1OIEBKqrOp4KuL+ZjghA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 7, 2019, at 9:59 AM, paulmck paulmck@linux.ibm.com wrote:

> On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
>> On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> 
> [ . . . ]
> 
>> > > diff --git a/include/asm-generic/vmlinux.lds.h
>> > > b/include/asm-generic/vmlinux.lds.h
>> > > index f8f6f04c4453..c2d919a1566e 100644
>> > > --- a/include/asm-generic/vmlinux.lds.h
>> > > +++ b/include/asm-generic/vmlinux.lds.h
>> > > @@ -338,6 +338,10 @@
>> > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>> > >  		__stop___tracepoints_ptrs = .;				\
>> > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
>> > > +		. = ALIGN(8);						\
>> > > +		__start___srcu_struct = .;				\
>> > > +		*(___srcu_struct_ptrs)					\
>> > > +		__end___srcu_struct = .;				\
>> > >  	}								\
>> > 
>> > This vmlinux linker modification is not needed. I tested without it and srcu
>> > torture works fine with rcutorture built as a module. Putting further prints
>> > in kernel/module.c verified that the kernel is able to find the srcu structs
>> > just fine. You could squash the below patch into this one or apply it on top
>> > of the dev branch.
>> 
>> Good point, given that otherwise FORTRAN named common blocks would not
>> work.
>> 
>> But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
>> macro that it can be mapped read-only?  Or am I suffering from excessive
>> optimism?
> 
> And to answer the other question, in the case where I am suffering from
> excessive optimism, it should be a separate commit.  Please see below
> for the updated original commit thus far.
> 
> And may I have your Tested-by?

Just to confirm: does the cleanup performed in the modules going
notifier end up acting as a barrier first before freeing the memory ?
If not, is it explicitly stated that a barrier must be issued before
module unload ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
