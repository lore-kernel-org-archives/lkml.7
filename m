Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F419CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ADE2084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575475961;
	bh=7xsuEGPTK6tCQyu2Zfo67N6YL+YrQ/lBOC8bOlpdWnc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dXBvbDtUAVFPqAIrKmw8UJmGdZIQEzjk6iGR/+uKVm2wCbx0xgvkRouMY6Wvd9saY
	 Ffc7LPt0P8qZnivbV12LQGx1njxN6nlimyuOmHtiD8AoFgeAvCz9tFwbFBotWyv6Je
	 uygMpP1sMDNfyy9eQVs6zU/Yfl67fka/BTIgxm6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfLDQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfLDQMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:12:40 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B43472081B;
        Wed,  4 Dec 2019 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575475959;
        bh=7xsuEGPTK6tCQyu2Zfo67N6YL+YrQ/lBOC8bOlpdWnc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eQQvkck+Enrg19F6wOGlibvLmhgYoaeog1JKTTtO/SOD0zMidcuO9sP2YGJI5XbbC
         0XaX3r0jbwAPz83JkFPBJcv3eVouzZzyPrOSZqVnq0J3yiIOUthOe6jATE5jDIurmo
         NKg4u+4n7oePPG905bwM43N2RICammERV/tV7FMk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 08FB735227A5; Wed,  4 Dec 2019 08:12:39 -0800 (PST)
Date:   Wed, 4 Dec 2019 08:12:39 -0800
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
Message-ID: <20191204161239.GL2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
 <20191203175712.GI2889@paulmck-ThinkPad-P72>
 <20191204100549.GB114697@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204100549.GB114697@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 11:05:50AM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > >  * This list-traversal primitive may safely run concurrently with
> > >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> > >  * as long as the traversal is guarded by rcu_read_lock().
> > >  */
> > > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > > 
> > > is actively harmful. Why is it there?
> > 
> > For cases where common code might be invoked both from the reader
> > (with RCU protection) and from the updater (protected by some
> > lock).  This common code can then use the optional argument to
> > hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
> > called with either form of protection in place.
> > 
> > This also combines with the __rcu tag used to mark RCU-protected
> > pointers, in which case sparse complains when a non-RCU API is applied
> > to these pointers, to get back to your earlier question about use of
> > hlist_for_each_entry_rcu() within the update-side lock.
> > 
> > But what are you seeing as actively harmful about all of this?
> > What should we be doing instead?
> 
> Yeah, so basically in the write-locked path hlist_for_each_entry() 
> generates (slightly) more efficient code than hlist_for_each_entry_rcu(), 
> correct?

Potentially yes, if the READ_ONCE() constrains the compiler.  Or not,
depending of course on the compiler and the surrounding code.

> Also, the principle of passing warning flags around is problematic - but 
> I can see the point in this specific case.

Would it help to add an hlist_for_each_entry_protected() that expected
RCU-protected pointers and write-side protection, analogous to
rcu_dereference_protected()?  Or would that expansion of the RCU API
outweigh any benefits?

							Thanx, Paul
