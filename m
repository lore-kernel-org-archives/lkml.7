Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E6C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 01:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CAC2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 01:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q4yLHaP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfEUBoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 21:44:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfEUBoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 21:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H2+x+MHVEZdCVE43yCMhl0CBsWPnqAGcA3mpEfmYBV4=; b=q4yLHaP0ptU37tRb4hLHZxJmm
        ew5v4etxyfhz8kN5laXZoOJo0kg4bdW+mbUnZQ4wTr6eX35KDhHy9W1FM/Th6gTkXw0m7JmwDncr6
        d3Ky/VrjxPss4IkozN7BQDI00Ja/RNMdxYF8ewPodxJQSznB04gOl3ramIHiqM4EMlydAhHLIowN+
        /LHHYx/EygTi582MDiFvUyClSpCqhAbjBrqUpmTy4G9UaWfAOAsVN8j7PkYrQd7fGlpm+UWv9ms8t
        XTjN+gKCo1BaWEOY1E123DatNsdFdKJYfobIgRpVoNrld/nW/6z2XcSSrfpaTTEqWOe7a2Gsbhf6i
        J1c0i7Rvg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hStpl-0000XC-36; Tue, 21 May 2019 01:44:53 +0000
Date:   Mon, 20 May 2019 18:44:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190521014452.GA6738@bombadil.infradead.org>
References: <20190520035254.57579-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-1-minchan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> IMHO we should spell it out that this patchset complements MADV_WONTNEED
> and MADV_FREE by adding non-destructive ways to gain some free memory
> space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> kernel that memory region is not currently needed and should be reclaimed
> immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> kernel that memory region is not currently needed and should be reclaimed
> when memory pressure rises.

Do we tear down page tables for these ranges?  That seems like a good
way of reclaiming potentially a substantial amount of memory.

