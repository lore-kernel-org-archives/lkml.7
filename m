Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D03C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2792073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575395834;
	bh=2kktFZXD9CwoMbSmBlBwAhAuQvCLLNSXzvolzrrYLkA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=AwxmHJshE5YvxRMdnpHpg/+0OV1L04T67oxWFK3Qaxto/WBpbfihZnCEM7xt1xPEF
	 TFsT6SLuTVCMfL9torKz2TotGpG3SdXzVofqOqBbVXAskNlSbIFk3MAZFq76L6roGP
	 Ee4/eUFesRJBHFd6wSc7JtvD3Aeu2t+SeaG8+R4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLCR5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfLCR5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:57:13 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F3D20674;
        Tue,  3 Dec 2019 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575395832;
        bh=2kktFZXD9CwoMbSmBlBwAhAuQvCLLNSXzvolzrrYLkA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hI3NOZiCUI9g1G+djYFq5JeGstQs+WuqJrQiddfYqVVLV8zruMzt2OiVa5zCkvhCE
         ev5xBCJDwjvEkzFj/5YzjU9g5wHgWbwfq3Vvg1rePHNZEjwjAcUd5Zf/b2s8xfHD+g
         Kfw2bOkvzI40czmGQR9IQNZqH3V5tfp+Qx1LIctg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2D8D33522780; Tue,  3 Dec 2019 09:57:12 -0800 (PST)
Date:   Tue, 3 Dec 2019 09:57:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191203175712.GI2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203071329.GC115767@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 08:13:29AM +0100, Ingo Molnar wrote:
> 
> * Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Mon, Dec 02, 2019 at 04:32:13PM +0900, Masami Hiramatsu wrote:
> > > Anders reported that the lockdep warns that suspicious
> > > RCU list usage in register_kprobe() (detected by
> > > CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> > > access kprobe_table[] by hlist_for_each_entry_rcu()
> > > without rcu_read_lock.
> > > 
> > > If we call get_kprobe() from the breakpoint handler context,
> > > it is run with preempt disabled, so this is not a problem.
> > > But in other cases, instead of rcu_read_lock(), we locks
> > > kprobe_mutex so that the kprobe_table[] is not updated.
> > > So, current code is safe, but still not good from the view
> > > point of RCU.
> > > 
> > > Let's lock the rcu_read_lock() around get_kprobe() and
> > > ensure kprobe_mutex is locked at those points.
> > > 
> > > Note that we can safely unlock rcu_read_lock() soon after
> > > accessing the list, because we are sure the found kprobe has
> > > never gone before unlocking kprobe_mutex. Unless locking
> > > kprobe_mutex, caller must hold rcu_read_lock() until it
> > > finished operations on that kprobe.
> > > 
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Instead of this, can you not just pass the lockdep_is_held() expression as
> > the last argument to list_for_each_entry_rcu() to silence the warning? Then
> > it will be a simpler patch.
> 
> Come on, we do not silence warnings!
> 
> If it's safely inside the lock then why not change it from 
> hlist_for_each_entry_rcu() to hlist_for_each_entry()?
> 
> I do think that 'lockdep flag' inside hlist_for_each_entry_rcu():
> 
> /**
>  * hlist_for_each_entry_rcu - iterate over rcu list of given type
>  * @pos:        the type * to use as a loop cursor.
>  * @head:       the head for your list.
>  * @member:     the name of the hlist_node within the struct.
>  * @cond:       optional lockdep expression if called from non-RCU protection.
>  *
>  * This list-traversal primitive may safely run concurrently with
>  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
>  * as long as the traversal is guarded by rcu_read_lock().
>  */
> #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> 
> is actively harmful. Why is it there?

For cases where common code might be invoked both from the reader
(with RCU protection) and from the updater (protected by some
lock).  This common code can then use the optional argument to
hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
called with either form of protection in place.

This also combines with the __rcu tag used to mark RCU-protected
pointers, in which case sparse complains when a non-RCU API is applied
to these pointers, to get back to your earlier question about use of
hlist_for_each_entry_rcu() within the update-side lock.

But what are you seeing as actively harmful about all of this?
What should we be doing instead?

If you are suggesting that KCSAN might replace sparse's use of __rcu,
I have been attempting to think along those lines, but thus far without
any success.  In contrast, I am starting to think that lockdep has made
the sparse __acquires() and __releases() tags obsolete.

Or am I missing your point?

							Thanx, Paul
