Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2328AC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82E02067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="USrawQ6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfG2Pi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:38:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfG2Pi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kTRobX83JJeBQVwIveyy0p4dpxyy2pND5viOSWqwu2A=; b=USrawQ6/HCifS+n9zc9f7rRgp
        SS5hThycZpx1nxHNxbRjjHd58Mq1C1l4w9QEKwwQNaiogsS9aukVbw35Ie8ufchGdx5QtTCUwFcl3
        FfwbK5zDhfFPOG9/uFIYxpbEjq5att4KMnfsyy6QymNjukfSwlA81zJW06X6fuXkyw7GTf3MgE/kA
        zTAuXCQPr7aW2ZsXCalOGcV2p+X5RugQ0DbW7hKyFEYY5E78e/SGZcaC66r+TSJ8jNyEz/cfCvgHI
        qo6m3Yc0CFtAMw4MfaFMG+zOuLdhKL8rgV3QbYm+hMBMow6/yIR4aMeSHHAm+RQP9Alg2UCMNJ/r6
        cGy0ZFNJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs7jH-0001Zh-St; Mon, 29 Jul 2019 15:38:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4705420AFFEAE; Mon, 29 Jul 2019 17:38:25 +0200 (CEST)
Date:   Mon, 29 Jul 2019 17:38:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>,
        Will Deacon <will.deacon@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190729153825.GI31398@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
 <20190729142756.GF31425@hirez.programming.kicks-ass.net>
 <2bc722b9-3eff-6d99-4ee7-1f4cab8b6c21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc722b9-3eff-6d99-4ee7-1f4cab8b6c21@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:22:16AM -0400, Waiman Long wrote:
> On 7/29/19 10:27 AM, Peter Zijlstra wrote:

> > Also; why then not key off that owner tracking to free the resources
> > (and leave the struct mm around) and avoid touching this scheduling
> > hot-path ?
> 
> The resources are pinned by the reference count. Making a special case
> will certainly mess up the existing code.
> 
> It is actually a problem for systems that are mostly idle. Only the
> kernel->kernel case needs to be updated. If the CPUs isn't busy running
> user tasks, a little bit more overhead shouldn't really hurt IMHO.

But when you cannot find a new owner; you can start to strip mm_struct.
That is, what's stopping you from freeing swap reservations when that
happens?

That is; I think the moment mm_users drops to 0, you can destroy the
actual addres space. But you have to keep mm_struct around until
mm_count goes to 0.

This is going on the comments with mmget() and mmgrab(); they forever
confuse me.
