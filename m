Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B5B205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrV3Vkbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCRQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:16:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCRQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YHQi/3e6+Nd2hmdPSPUhS2o9LcDAvjz7QnorLsrEaIA=; b=FrV3Vkbj94xDcrez4y+cFwZDvK
        8Q8ZRS8AGtUWTig02ihcurV7zE/EgQoc/ERjGev3ApAPQ/t2ZuH9xyPjDqcUprs+2s3UEeTtCMfmJ
        Qp2IyMl9+4LzYyta6Csf5oPcbfHKzT7obMyQEu5qPVTlOHYv0YFP9yJV3kfQ8NCtkUlSd/rTemEyU
        MEqBmG5+TrRoDvy2uKcavz5Lzcs+BIhEXA/qMKJOt3+qjkT26ohY7+6L0iqMU0i07yv7PzRLbnYKR
        rjzyci7tmIaRgeRjaZGiZrOaTYwLFw2/wpfnGug8FzeaFOIK2OJHreUoSTDrQJSxSqLSBEroZlKI9
        D0AY5Arg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBjV8-000255-3T; Wed, 03 Apr 2019 17:16:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56840203C12DB; Wed,  3 Apr 2019 19:16:35 +0200 (CEST)
Date:   Wed, 3 Apr 2019 19:16:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190403171635.GM4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <9ec3d8dc-d1e0-1b8a-5e00-ba92b9756c58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ec3d8dc-d1e0-1b8a-5e00-ba92b9756c58@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 12:33:20PM -0400, Waiman Long wrote:
> static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32
> val)
> {
>         if (static_branch_unlikely(&use_numa_spinlock))
>                 numa_queued_spin_lock_slowpath(lock, val);
>         else   
>                 native_queued_spin_lock_slowpath(lock, val);
> }

That's horrible for the exact reason you state.

> Alternatively, we can also call numa_queued_spin_lock_slowpath() in
> native_queued_spin_lock_slowpath() if we don't want to increase the code
> size of spinlock call sites.

Yeah, still don't much like that though, we're littering the fast path
of that slow path with all sorts of crap.
