Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED9EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8634020879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ReYOQaUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfEMLpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:45:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfEMLpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kIFwTuS2Cq6ZYIK7P/ywG/BfaUTgrMlQGg1qCWu+uzI=; b=ReYOQaUrt+Qr5hvD0m6+3Wv1W
        Nl73W6f8/GripfZ2I08SDufPtJezjJz80V+AW5QAewsXGvNgn+yjPfJQsIqQoLMKbiSLm15r+/noV
        2gclMRQHZQ9K/QGx0V1p8d0Ggsy26zQT3JhiJpqJ8AE9StIfmozWUMinKQCZCbldDvcqluN3UdZab
        NErbyDac0Qx/Xup/S+txTRLHKF1eobwznZdDqbQCpEIEzy1uV94J3hhXPlE3ywc7wGSlkCmhcT5Q9
        AnaAjUD20+tFeEiBrSdzmmQ2TpHTS05Mfg0FJ4nMCCRGDA+2USffRHMskSbr+o0thKRygfdVxCJbG
        yfa1+Tqhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ9OD-0006ri-VS; Mon, 13 May 2019 11:45:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60BA92029F87A; Mon, 13 May 2019 13:45:04 +0200 (CEST)
Date:   Mon, 13 May 2019 13:45:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] locking/lockdep: Add lock type enum to explicitly
 specify read or write locks
Message-ID: <20190513114504.GR2623@hirez.programming.kicks-ass.net>
References: <20190513091203.7299-1-duyuyang@gmail.com>
 <20190513091203.7299-2-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513091203.7299-2-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 05:11:47PM +0800, Yuyang Du wrote:
> + * Note that we have an assumption that a lock class cannot ever be both
> + * read and recursive-read.

We have such locks in the kernel... see:

  kernel/qrwlock.c:queued_read_lock_slowpath()

And yes, that is somewhat unfortunate, but hard to get rid of due to
hysterical raisins.
