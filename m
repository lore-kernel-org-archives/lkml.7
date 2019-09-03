Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97CEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908F221881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XXl2aHLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfICTq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:46:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfICTq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0oSK57qWeSItTDz/D1Y7sd4ufyamhAWf1L+/fFFqZyQ=; b=XXl2aHLEUe68XutV+fxkA3608
        I7vNH9lR5XVbY+UgpzYTbkAox4OSJ03Bzgs3NwC0AtJMaQw1As2aLxpN8Opt30kA1U8WEKusrExp6
        4fUj9HPZD+tR0VciCPG3qSl/CZARQgij/0mwWRcGQqaK3Q/H3iIfcz5rcG6VHDIG+iIP7zCdhLSWo
        VbE53FBHmuMfjWaaoQGBr9JeLAyEjQVpBOkVOpBWFHw+vEVA4HVG1vjbX5cV6Be3UooOVtF2p/cyz
        od9fmPPSm39VMMPVLf52xTnV3ErNBwd528mnkG76Q8EQ8wp6M4y0FiJ01d6F6zOLuhVe7If542Lb6
        /Cvczd0Hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5ElH-0000KZ-UH; Tue, 03 Sep 2019 19:46:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1B33306010;
        Tue,  3 Sep 2019 21:46:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CE6B20977765; Tue,  3 Sep 2019 21:46:42 +0200 (CEST)
Date:   Tue, 3 Sep 2019 21:46:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 0/3] task: Making tasks on the runqueue rcu protected
Message-ID: <20190903194642.GV2349@hirez.programming.kicks-ass.net>
References: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wgQ_tZXQkovVked+nEsZhZqGVNnKmoy3b699dycZqCdKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ_tZXQkovVked+nEsZhZqGVNnKmoy3b699dycZqCdKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 08:44:40AM -0700, Linus Torvalds wrote:

> That said, it won't affect any of the core architectures much, because
> smp_store_release() isn't that expensive (it's just a compiler barrier
> on x86, it's a cheap instruction on arm64, and it should be very cheap
> on any other architecture too unless they do insane things - even on
> powerpc, which is about the worst case for any barriers, it's just an
> lwsync).

Right, x86/s390/Sparc it's a compiler barrier, ARM64 has a store-release
op which is relatively cheap, Power has an LWSYNC, but the rest does
store-release with smp_mb() -- and this includes ARM.

