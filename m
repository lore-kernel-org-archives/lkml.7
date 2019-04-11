Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F43C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505972184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bCMROc3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfDKHZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:25:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SiTuSSgF96JPHFaF+F9FdZ1hDfGH+LK06K+iKMdjpd0=; b=bCMROc3UXmvcvYpj91F5n+uhb
        W3rFsMY+x6thYgQHs6WJF3o9zzcGuWt8NiBEE5ZnITidQDPuPRq6eRYC3v5QywJIcmA9RO6K/FWfY
        vmQvi3mZs6526oujo53LV3m9BJ8QRcPWZIUqolSohWMo6PpvvTIg8aV0J/AyWNnGjR7Zbz/03vb9c
        r3Vh7SSijmht5Yx/JkQeK2h2fr53e0CD1Y4ZAP+JbUnBw/iO8xErcQOXvqiP7sw6zxOCY8WFNXRkw
        DRBm2SNMQEx8UlSCHICydKqln01SqlLM3cLebZu0RTeGy4nEn+hsaIndgAC5qtUlMYY1xEY+EA2p/
        QJGewmBgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEU5T-0004OM-Dq; Thu, 11 Apr 2019 07:25:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E417929AA8DC5; Thu, 11 Apr 2019 09:25:29 +0200 (CEST)
Date:   Thu, 11 Apr 2019 09:25:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 05/14] locking/rwsem: Remove rwsem_wake() wakeup
 optimization
Message-ID: <20190411072529.GA4038@hirez.programming.kicks-ass.net>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410184231.6748-6-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:42:22PM -0400, Waiman Long wrote:
> With the commit 59aabfc7e959 ("locking/rwsem: Reduce spinlock contention
> in wakeup after up_read()/up_write()"), the rwsem_wake() forgoes doing
> a wakeup if the wait_lock cannot be directly acquired and an optimistic
> spinning locker is present.  This can help performance by avoiding
> spinning on the wait_lock when it is contended.
> 
> With the later commit 133e89ef5ef3 ("locking/rwsem: Enable lockless
> waiter wakeup(s)"), the performance advantage of the above optimization
> diminishes as the average wait_lock hold time become much shorter.
> 
> By supporting rwsem lock handoff, we can no longer relies on the fact
> that the presence of an optimistic spinning locker will ensure that the
> lock will be acquired by a task soon. This can lead to missed wakeup
> and application hang. So the commit 59aabfc7e959 ("locking/rwsem:
> Reduce spinlock contention in wakeup after up_read()/up_write()")
> will have to be reverted.

Does it make sense to make this patch #3 in this series? The less code
there is, the easier to review the other patches.
