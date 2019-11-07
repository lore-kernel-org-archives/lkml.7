Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D24D21D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YEY7FbEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKGTyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:54:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKGTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b3XWyTAN51GGwQJ3OlvxFEJCrV0vrJRe7r0j72I5jss=; b=YEY7FbEs/hXtr23AaFaDCMKpD
        F+IUHJedCBPdXSl99gAwF6mBor6wPNYioameeGYSF+SxQFF0yp18uSo9dtG9qwnnrpzhbJu0TsTEh
        0AjT5YRo6bJCUGbEmA5Vy/K6jrnT3j7a2kB7AlLV9nnvGhtd6PuIPj9mBQ/tFcDmHd0TFBToBVEJY
        lmf+lDhCMW18IybY0IB69ss+rIDT/O0RoVXwT593e0997jrK1GK7iw4ih1oA2lgFE+WXIXd+MC2Wi
        ZFcQClN9ipj5msOzRbr+2lwacZM9wQwO8krbanqn8v+FnbLkGuHMe33Re3PQV/RAOOERyUUT78qMu
        eNFQulWXQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSnrd-0003ym-EM; Thu, 07 Nov 2019 19:54:41 +0000
Date:   Thu, 7 Nov 2019 11:54:41 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
Message-ID: <20191107195441.GF11823@bombadil.infradead.org>
References: <20191107190628.22667-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107190628.22667-1-longman@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:06:28PM -0500, Waiman Long wrote:
> A customer with large SMP systems (up to 16 sockets) with application
> that uses large amount of static hugepages (~500-1500GB) are experiencing
> random multisecond delays. These delays was caused by the long time it
> took to scan the VMA interval tree with mmap_sem held.
> 
> The sharing of huge PMD does not require changes to the i_mmap at all.
> As a result, we can just take the read lock and let other threads
> searching for the right VMA to share in parallel. Once the right
> VMA is found, either the PMD lock (2M huge page for x86-64) or the
> mm->page_table_lock will be acquired to perform the actual PMD sharing.
> 
> Lock contention, if present, will happen in the spinlock. That is much
> better than contention in the rwsem where the time needed to scan the
> the interval tree is indeterminate.

I don't think this description really explains the contention argument
well.  There are _more_ PMD locks than there are i_mmap_sem locks, so
processes accessing different parts of the same file can work in parallel.

Are there other current users of the write lock that could use a read lock?
At first blush, it would seem that unmap_ref_private() also only needs
a read lock on the i_mmap tree.  I don't think hugetlb_change_protection()
needs the write lock either.  Nor retract_page_tables().
