Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D18C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E924CB3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhMtqMIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfFDJKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:10:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFDJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m/c3FgrUfhn4KG9UznydNu1bp5nGuO9Yr6Nn9DVwU2I=; b=QhMtqMIcZIv85zDrVleDnKMDE
        jGU0NCY8syc8w7oZYS3KIKp2VW+nsL2rTgZIGec4AUU07p4Ir7ab+bmy5FbBm12opml274lqfHQVv
        xLVD1Vhd/Avw0GtIiHp+wBt3csju+DK58d+8pwWaK9is9EvmmMcc2iLoW59iA6ShyN8OVL03SAzlb
        dm83B+UgB142Eg53DlUT0azEuitwt69Cm/d7mML1j+O/DAncHSpvQRBNEusrnAEfij04W63Xw6lO4
        6M+g6O3XFHClcCwqOy7lROGTwuZSWtj7t3RSa11ByBbrvu9aQNMfEp34qIdJaqApt2qtGVRflriHW
        CXNNaDrfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY5SD-00033n-GM; Tue, 04 Jun 2019 09:10:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 438742083FE28; Tue,  4 Jun 2019 11:10:00 +0200 (CEST)
Date:   Tue, 4 Jun 2019 11:10:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
Message-ID: <20190604091000.GH3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205918.22251-16-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:14PM -0400, Waiman Long wrote:
> Reader optimistic spinning is helpful when the reader critical section
> is short and there aren't that many readers around. It makes readers
> relatively more preferred than writers. When a writer times out spinning
> on a reader-owned lock and set the nospinnable bits, there are two main
> reasons for that.
> 
>  1) The reader critical section is long, perhaps the task sleeps after
>     acquiring the read lock.
>  2) There are just too many readers contending the lock causing it to
>     take a while to service all of them.
> 
> In the former case, long reader critical section will impede the progress
> of writers which is usually more important for system performance.
> In the later case, reader optimistic spinning tends to make the reader
> groups that contain readers that acquire the lock together smaller
> leading to more of them. That may hurt performance in some cases. In
> other words, the setting of nonspinnable bits indicates that reader
> optimistic spinning may not be helpful for those workloads that cause it.
> 
> Therefore, any writers that have observed the setting of the writer
> nonspinnable bit for a given rwsem after they fail to acquire the lock
> via optimistic spinning will set the reader nonspinnable bit once they
> acquire the write lock. Similarly, readers that observe the setting
> of reader nonspinnable bit at slowpath entry will also set the reader
> nonspinnable bit when they acquire the read lock via the wakeup path.

So both cases set the _reader_ nonspinnable bit?
