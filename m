Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187ADC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C9A227BF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tp7DHuUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfGWJ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:27:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGWJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iGOng1nK2tteDL9Gsnzl+UsVfoooOvN9ZoRg2+d2ilw=; b=Tp7DHuUAJlzSf6P4KtvwjChc7
        c5qrgpBua1VXye3VXufVT37jbn7IS+f994XRj2sqlb2i/AS2ZjLpo7xrbUqAs7mrwPJ/rRlVLMfc9
        Vf1uhm/5plou3tAEsDVHf/xPz3OiQW0c2E1CFvkdM6kXqVc8uoxMH/txzl+dSq87q21t3oBOEbjW4
        ju4ngtsB6ejw/pJbrDVh5ejyG/z9dLGyKNeuSlTeUp+XQ89t5AHrP+EAVllf4jj8i3GfPhmxyu7kX
        ttwJclT/iqCEt4yyC7BTqfgblTu15Z7oA5V+dBciKU/eo426eQrz/ZNYcKLTftSH8uAutn6ahCxyZ
        OxAVTZuPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpr4l-00021J-OG; Tue, 23 Jul 2019 09:27:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 285AE20A291EC; Tue, 23 Jul 2019 11:27:14 +0200 (CEST)
Date:   Tue, 23 Jul 2019 11:27:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Lockdep: Reduce stack trace memory usage
Message-ID: <20190723092714.GA3402@hirez.programming.kicks-ass.net>
References: <20190722182443.216015-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722182443.216015-1-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:24:39AM -0700, Bart Van Assche wrote:
> Hi Peter,
> 
> An unfortunate side effect of commit 669de8bda87b ("kernel/workqueue: Use
> dynamic lockdep keys for workqueues") is that all stack traces associated
> with the lockdep key are leaked when a workqueue is destroyed. Fix this by
> storing each unique stack trace once. Please consider this patch series
> for Linux kernel v5.4.
> 
> Thanks,
> 
> Bart.
> 
> Bart Van Assche (4):
>   locking/lockdep: Make it clear that what lock_class::key points at is
>     not modified
>   stacktrace: Constify 'entries' arguments
>   locking/lockdep: Reduce space occupied by stack traces
>   locking/lockdep: Report more stack trace statistics
> 
>  include/linux/lockdep.h            |  11 +-
>  include/linux/stacktrace.h         |   4 +-
>  kernel/locking/lockdep.c           | 159 ++++++++++++++++++++++-------
>  kernel/locking/lockdep_internals.h |   9 +-
>  kernel/locking/lockdep_proc.c      |   8 +-
>  kernel/stacktrace.c                |   4 +-
>  6 files changed, 143 insertions(+), 52 deletions(-)

Thanks a lot for doing this Bart, excellent stuff!
