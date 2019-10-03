Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1055C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17FA207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="beEbyjRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfJCTOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:14:15 -0400
Received: from mail.efficios.com ([167.114.142.138]:60432 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:14:14 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A458233B6C7;
        Thu,  3 Oct 2019 15:14:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 2VPmRjdUR16r; Thu,  3 Oct 2019 15:14:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EFB6B33B6C0;
        Thu,  3 Oct 2019 15:14:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EFB6B33B6C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1570130052;
        bh=7io7uSdeeE/pgtuBYIIMb2OgPbrbl38vwPbZaO6HFvw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=beEbyjRH8RDU1ayL22FADOwMgSZr7sHigxFMjXI2qgq8/UCvEKQUz0BAu0ma4VSvH
         ElPhCIJKfqloIbzwqUaoYvSl+CEHYWIryWQIgbiSFMZpkJ5+OS0shtOszfU4hrmLBY
         jYqCOd7595Fh6TTom8wsBPKfTS3G9e2H2NNipLmsUaxy25yvbX0GC0tN02TLH+bxZJ
         ShGjKH2aMkcnnvYeFhHRCrhYpqir8/Kl9yvc40l/H9QyVN1Rl9fWVdWN6u1DcuNw7A
         091bRHxp6Ou1eohY9EJy7NTbFvVu2hFX17GjUDpbGzGcO/Z1Q1oiLEbz3v6ak39k3I
         XSWRvWk/KNzvg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id pJzSuz6dVofd; Thu,  3 Oct 2019 15:14:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D0F9B33B6B3;
        Thu,  3 Oct 2019 15:14:11 -0400 (EDT)
Date:   Thu, 3 Oct 2019 15:14:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
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
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        Martin <martin.petersen@oracle.com>
Message-ID: <996944932.1292.1570130051686.JavaMail.zimbra@efficios.com>
In-Reply-To: <20191003190919.GA2689@paulmck-ThinkPad-P72>
References: <20191003014153.GA13156@paulmck-ThinkPad-P72> <20191003014310.13262-1-paulmck@kernel.org> <644598334.955.1570120530976.JavaMail.zimbra@efficios.com> <20191003165220.GZ2689@paulmck-ThinkPad-P72> <618064891.1049.1570123274780.JavaMail.zimbra@efficios.com> <20191003190919.GA2689@paulmck-ThinkPad-P72>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: Upgrade rcu_swap_protected() to rcu_replace()
Thread-Index: ag42kyaxnP9eCqmhEy53O9DecrsO8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 3, 2019, at 3:09 PM, paulmck paulmck@kernel.org wrote:

> On Thu, Oct 03, 2019 at 01:21:14PM -0400, Mathieu Desnoyers wrote:
>> ----- On Oct 3, 2019, at 12:52 PM, paulmck paulmck@kernel.org wrote:
>> 
>> > On Thu, Oct 03, 2019 at 12:35:30PM -0400, Mathieu Desnoyers wrote:
>> >> ----- On Oct 2, 2019, at 9:43 PM, paulmck paulmck@kernel.org wrote:
>> >> 
>> >> > From: "Paul E. McKenney" <paulmck@kernel.org>
>> >> > 
>> >> > Although the rcu_swap_protected() macro follows the example of swap(),
>> >> > the interactions with RCU make its update of its argument somewhat
>> >> > counter-intuitive.  This commit therefore introduces an rcu_replace()
>> >> > that returns the old value of the RCU pointer instead of doing the
>> >> > argument update.  Once all the uses of rcu_swap_protected() are updated
>> >> > to instead use rcu_replace(), rcu_swap_protected() will be removed.
>> >> 
>> >> We expose the rcu_xchg_pointer() API in liburcu (Userspace RCU) project.
>> >> Any reason for not going that way and keep the kernel and user-space RCU
>> >> APIs alike ?
>> >> 
>> >> It's of course fine if they diverge, but we might want to at least consider
>> >> if using the same API name would be OK.
>> > 
>> > Different semantics.  An rcu_xchg_pointer() allows concurrent updates,
>> > and rcu_replace() does not.
>> > 
>> > But yes, if someone needs the concurrent updates, rcu_xchg_pointer()
>> > would certainly be my choice for the name.
>> 
>> Then considering that its assignment counterpart is "rcu_assign_pointer()"
>> (and not "rcu_assign()"), would "rcu_replace_pointer()" be less ambiguous
>> about its intended use ?
> 
> The sequence was rcu_swap_protected() -> rcu_swap() -> rcu_replace().
> Because that rcu_replace(), unlike rcu_swap_protected(), returns a
> value, the shorter name is valuable.
> 
> Maybe we should have used rcu_assign() instead of rcu_assign_pointer(),
> but there is no point in that sort of change at this late date!

I agree that having both the "rcu_" prefix and the "_pointer" suffix is
somewhat redundant. Indeed it's not a worthwhile change for a pre-existing
API, but it is welcome for a new API.

Thanks!

Mathieu

> 
>							Thanx, Paul
> 
>> Thanks,
>> 
>> Mathieu
>> 
>> 
>> > 
>> >							Thanx, Paul
>> > 
>> >> Thanks,
>> >> 
>> >> Mathieu
>> >> 
>> >> 
>> >> > 
>> >> > Link:
>> >> > https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
>> >> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> >> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> >> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
>> >> > Cc: Christoph Hellwig <hch@lst.de>
>> >> > Cc: Hannes Reinecke <hare@suse.de>
>> >> > Cc: Johannes Thumshirn <jthumshirn@suse.de>
>> >> > Cc: Shane M Seymour <shane.seymour@hpe.com>
>> >> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
>> >> > ---
>> >> > include/linux/rcupdate.h | 18 ++++++++++++++++++
>> >> > 1 file changed, 18 insertions(+)
>> >> > 
>> >> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> >> > index 75a2ede..3b73287 100644
>> >> > --- a/include/linux/rcupdate.h
>> >> > +++ b/include/linux/rcupdate.h
>> >> > @@ -383,6 +383,24 @@ do {									      \
>> >> > } while (0)
>> >> > 
>> >> > /**
>> >> > + * rcu_replace() - replace an RCU pointer, returning its old value
>> >> > + * @rcu_ptr: RCU pointer, whose old value is returned
>> >> > + * @ptr: regular pointer
>> >> > + * @c: the lockdep conditions under which the dereference will take place
>> >> > + *
>> >> > + * Perform a replacement, where @rcu_ptr is an RCU-annotated
>> >> > + * pointer and @c is the lockdep argument that is passed to the
>> >> > + * rcu_dereference_protected() call used to read that pointer.  The old
>> >> > + * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
>> >> > + */
>> >> > +#define rcu_replace(rcu_ptr, ptr, c)					\
>> >> > +({									\
>> >> > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
>> >> > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
>> >> > +	__tmp;								\
>> >> > +})
>> >> > +
>> >> > +/**
>> >> >  * rcu_swap_protected() - swap an RCU and a regular pointer
>> >> >  * @rcu_ptr: RCU pointer
>> >> >  * @ptr: regular pointer
>> >> > --
>> >> > 2.9.5
>> >> 
>> >> --
>> >> Mathieu Desnoyers
>> >> EfficiOS Inc.
>> > > http://www.efficios.com
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
