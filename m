Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A5CC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0D52089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pgx5v8Yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfGAH0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:26:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfGAH0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dRqxafrMZIpojDELdzomwmakTdubds+IayDLNdEzxbI=; b=pgx5v8YkxCQJYmzC+hmmpOEiN
        6Ucd0F/aWF+8d8UX7CO/j4BCxdiC7CuFIFEPRxzl+ngptOU7ysG+jBLVfzr+p2LtEdNKZcGYxRUfz
        r96/vox6bUQoipY84jwzEDzLmZjHUNBRrbbLK9aWRz2vdmggcXsLPtbgSukHM5HLMcFGsoucB6N4c
        8aIxIGtw6KcLYWGWznvGqQxZ68zq0fVj7FCScWC/QeEPnZJwqMv3dw4ccTSzMNNOB9TCEpitdi/fQ
        snbr6bbnHhX0eUEO4hBAcvM8csO9q0KSK7tUSox8Q8mhyvQnhNkqhZEq0rn2egIw56iqvEWcl1OtB
        u37YM1Hng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhqi7-0007PU-J7; Mon, 01 Jul 2019 07:26:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2D8E20A87D66; Mon,  1 Jul 2019 09:26:45 +0200 (CEST)
Date:   Mon, 1 Jul 2019 09:26:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: avoid generating code twice for the cached
 versions
Message-ID: <20190701072645.GK3402@hirez.programming.kicks-ass.net>
References: <20190628045008.39926-1-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628045008.39926-1-walken@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:50:08PM -0700, Michel Lespinasse wrote:
> As was already noted in rbtree.h, the logic to cache rb_first (or rb_last)
> can easily be implemented externally to the core rbtree api.
> 
> Change the implementation to do just that. Previously the update of
> rb_leftmost was wired deeper into the implemntation, but there were
> some disadvantages to that - mostly, lib/rbtree.c had separate
> instantiations for rb_insert_color() vs rb_insert_color_cached(), as well
> as rb_erase() vs rb_erase_cached(), which were doing exactly the same
> thing save for the rb_leftmost update at the start of either function.
> 

> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>  include/linux/rbtree.h           | 70 +++++++++++++++++++++-----------
>  include/linux/rbtree_augmented.h | 27 +++++-------
>  lib/rbtree.c                     | 40 ++----------------
>  3 files changed, 59 insertions(+), 78 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
