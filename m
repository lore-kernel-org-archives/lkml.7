Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E1AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C147D2075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PTvxLNFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfKGTm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:42:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfKGTm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KVFpWOzDulBeid8afCN82toHL+r9kNvnmgoyCPgx/MY=; b=PTvxLNFDgEDJImxNYpSMN4dyq
        cND1bgROPYwf+yilUytbALIAKB8oi2cbh6I1oI3aawpMwWw0mQNNpXPOD40bdJyIZNW2uKSJqNnCV
        l5p8B6+Nf6i7CEsrOhdt3Ey+IFuAdIj1BkPA9+HAkd+pCTkE6ZBFPfQj9rOP649tH7jzP+QQ8Zt6X
        3CidaLEu1vUpqB44C1NsMNcbkjSjtOEOsLgMaWOJcinvpAKg95CL3DCjeFKbEN6feru9KYFbTKQp5
        ihwHqMrFZ8sUgoSa+GGz9LbgKs1q2arl+WAhAP1TjB6bMa1ESUaXh8PQPRAia7PtVS6Mnbut8a+DN
        g/4q1hvkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSnfl-0000T6-To; Thu, 07 Nov 2019 19:42:25 +0000
Date:   Thu, 7 Nov 2019 11:42:25 -0800
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
Message-ID: <20191107194225.GE11823@bombadil.infradead.org>
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
> -	i_mmap_lock_write(mapping);
> +	/*
> +	 * PMD sharing does not require changes to i_mmap. So a read lock
> +	 * is enuogh.
> +	 */
> +	i_mmap_lock_read(mapping);

We don't have comments before any of the other calls to i_mmap_lock_read()
justifying why we don't need the write lock.  I don't understand why this
situation is different.  Just delete the comment and make this a two-line
patch.

