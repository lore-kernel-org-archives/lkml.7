Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD99C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC55221D7C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JsMyUfCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbfIFHHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:07:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfIFHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YXK73tivEnMNI9CQO794J8LHPRCrpJ3xfmxR2bH/X9s=; b=JsMyUfCy3FAFa46lyBPr5e9FO
        D89aALXwuIIzrCU9F1w8Tsb80Af39kLcJrosbEtOcpFn0a3gi9xc0PUeHE1GuBzm0iV+sq5piKn26
        DXSaz/xS5jur/Cn6Fd60Bo0KoNISLKNltgS2SOCmiVRjaD6WFxpip9Phmxo7SloS7aZnJ7SiTwc5B
        hphZILp765UwCmpxe06w6n0U+ID2iGMPbFyoUJwhVoa8mz/ZJ3gNRtfh06vWdzRgxmUR8yaEtTlnP
        vgsUWkv0tWk964pv4s2uzGTI2yr7tVSvncaVkKdcz1F/s21Ga5zM5aTCIFC4ljVw000aArD3vPsce
        CYjgOHiJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i68LM-0002iT-4B; Fri, 06 Sep 2019 07:07:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1644303121;
        Fri,  6 Sep 2019 09:06:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C98E29DE780D; Fri,  6 Sep 2019 09:07:36 +0200 (CEST)
Date:   Fri, 6 Sep 2019 09:07:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
Message-ID: <20190906070736.GR2349@hirez.programming.kicks-ass.net>
References: <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
 <20190903074117.GX2369@hirez.programming.kicks-ass.net>
 <20190903074718.GT2386@hirez.programming.kicks-ass.net>
 <87k1apqqgk.fsf@x220.int.ebiederm.org>
 <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
 <874l1tp7st.fsf@x220.int.ebiederm.org>
 <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
 <20190903200603.GW2349@hirez.programming.kicks-ass.net>
 <20190903213218.GG4125@linux.ibm.com>
 <87r24umryu.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r24umryu.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:02:49PM -0500, Eric W. Biederman wrote:
> Paul, what is the purpose of the barrier in rcu_assign_pointer?
> 
> My intuition says it is the assignment half of rcu_dereference, and that
> anything that rcu_dereference does not need is too strong.

I see that Paul has also replied, but let me give another take on it.

RCU does *two* different but related things. It provide object
consistency and it provides object lifetime management.

Object consistency is provided by rcu_assign_pointer() /
rcu_dereference:

 - rcu_assign_pointer() is a PUBLISH operation, it is meant to expose an
object to the world. In that respect it needs to ensure that all
previous stores to this object are complete before it writes the
pointer and exposes the object.

To this purpose, rcu_assign_pointer() is an smp_store_release().

 - rcu_dereference() is a CONSUME operation. It matches the PUBLISH from
above and guarantees that any further loads/stores to the observed
object come after.

Naturally this would be an smp_load_acquire(), _HOWEVER_, since we need
the address of the object in order to construct a load/store from/to
said object, we can rely on the address-dependency to provide this
barrier (except for Alpha, which is fscking weird). After all if you
haven't completed the load of the (object) base address, you cannot
compute the object member address and issue any subsequent memops, now
can you ;-)

Now the thing here is that the 'rq->curr = next' assignment does _NOT_
expose the task (our object). The task is exposed the moment it enters
the PID hash. It is this that sets us free of the PUBLISH requirement
and thus we can use RCU_INIT_POINTER().


The object lifetime thing is provided by
rcu_read_load()/rcu_read_unlock() on the one hand and
synchronize_rcu()/call_rcu() on the other. That ensures that if you
observe an object inside the RCU read side section, the object storage
must stay valid.

And it is *that* properpy we wish to make use of.


Does this make sense to you?
