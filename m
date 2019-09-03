Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA825C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD33207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ilKCQ7Ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfICUGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:06:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfICUGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s/mxBv481g4gknPtfmgtkEvU8Nr3mAfkiqeLHsTDIQ0=; b=ilKCQ7OunKsvHtouU1msoWwVh
        4G5Ha3b/T1/I/Sah2EY9NQ/wKA6JfImRCwX1VWlUMrt8TsPKtvjnSq3xyUGhpoEO5D2XYl2Jh28qj
        KoACNHg2EvRbMxy15aJnQ6zj2iZ7pk61sHtakaNpZ2eH8/vqxkM8KPyS8gAy9Vj1gCPK0kW+aXF52
        t3tSd35yTSdOGZYEnzG4vrkGqrmC7UvmFEvFPkTYZ5TPtdnoHi5TLozGxg95lY9U3bIA0fJs71bI8
        fV015J+2lXOo+TBuja8TMrlMTBKqCib/+xMCROmKKDPi4ChNIZfQAJ7IEU2NSFOgKF1Hhtyo9LAgg
        TXHv1XeYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5F41-0006sN-ME; Tue, 03 Sep 2019 20:06:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39697301A76;
        Tue,  3 Sep 2019 22:05:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A1A12097777E; Tue,  3 Sep 2019 22:06:03 +0200 (CEST)
Date:   Tue, 3 Sep 2019 22:06:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
Message-ID: <20190903200603.GW2349@hirez.programming.kicks-ass.net>
References: <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
 <20190903074117.GX2369@hirez.programming.kicks-ass.net>
 <20190903074718.GT2386@hirez.programming.kicks-ass.net>
 <87k1apqqgk.fsf@x220.int.ebiederm.org>
 <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
 <874l1tp7st.fsf@x220.int.ebiederm.org>
 <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:18:47PM -0700, Linus Torvalds wrote:
> Now, if you can point to some particular field where that ordering
> makes sense for the particular case of "make it active on the
> runqueue" vs "look up the task from the runqueue using RCU", then I do
> think that the whole release->acquire consistency makes sense.
> 
> But it's not clear that such a field exists, particularly when this is
> in no way the *common* way to even get a task pointer, and other paths
> do *not* use the runqueue as the serialization point.

Even if we could find a case (and I'm not seeing one in a hurry), I
would try really hard to avoid adding extra barriers here and instead
make the consumer a little more complicated if at all possible.

The Power folks got rid of a SYNC (yes, more expensive than LWSYNC) from
their __switch_to() implementation and that had a measurable impact.

9145effd626d ("powerpc/64: Drop explicit hwsync in context switch")
