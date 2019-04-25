Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C0C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A035206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556226551;
	bh=WpmCo0Eolh7ocNua2jKlJaDc65LagGI+szT8NXdlDyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qTT6SdKPuTkNcpZNnNXwVm+J+6xerM5WYoeDS59Mus0f6ovfHhhTMkHTvJEfhfl+Y
	 qWjJimOn1ZwFmNaLycZyCb65jrr3hW8PxvDW6glGbJALPqISY/HyScVvxZOooF8VdV
	 x/jv1ko7UXKvZIvUwLjEwKkcltFKDfxBUHVp5rrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfDYVJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfDYVJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:09:09 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B70E0206A3;
        Thu, 25 Apr 2019 21:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556226548;
        bh=WpmCo0Eolh7ocNua2jKlJaDc65LagGI+szT8NXdlDyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hwCGJgJLgap2sUcaotmg2GU3j2hAAro/ij+TdeK6m1lWq8XFJuzwuuIjvpKGfVhbm
         UD4cSWul8/LRGi3W/6wnjPlPNmsQJjnzUYoBYU+ANMKe24twKNEkaj5q7jzC1wW3Sw
         1aTtd63UZ1hCSFe8WEnDMt/XxyrkFTGKvz3wEooc=
Date:   Thu, 25 Apr 2019 14:09:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: fix never set ALLOC_NOFRAGMENT flag
Message-Id: <20190425140908.7da3c4e52663196c7b914b00@linux-foundation.org>
In-Reply-To: <20190424234052.GW18914@techsingularity.net>
References: <20190423120806.3503-1-aryabinin@virtuozzo.com>
        <20190423120806.3503-2-aryabinin@virtuozzo.com>
        <20190423120143.f555f77df02a266ba2a7f1fc@linux-foundation.org>
        <20190424090403.GS18914@techsingularity.net>
        <20190424154624.f1084195c36684453a557718@linux-foundation.org>
        <20190424234052.GW18914@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 00:40:53 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> On Wed, Apr 24, 2019 at 03:46:24PM -0700, Andrew Morton wrote:
> > On Wed, 24 Apr 2019 10:04:03 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> > 
> > > On Tue, Apr 23, 2019 at 12:01:43PM -0700, Andrew Morton wrote:
> > > > On Tue, 23 Apr 2019 15:08:06 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> > > > 
> > > > > Commit 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> > > > > removed setting of the ALLOC_NOFRAGMENT flag. Bring it back.
> > > > 
> > > > What are the runtime effects of this fix?
> > > 
> > > The runtime effect is that ALLOC_NOFRAGMENT behaviour is restored so
> > > that allocations are spread across local zones to avoid fragmentation
> > > due to mixing pageblocks as long as possible.
> > 
> > OK, thanks.  Is this worth a -stable backport?
> 
> Yes, but only for 5.0 obviously and both should be included if that is
> the case. I did not push for it initially as problems in this area are
> hard for a general user to detect and people have not complained about
> 5.0's fragmentation handling.

Ah, OK.  0a79cdad5eb2 didn't have a -stable tag so I suppose we can
leave this patch un-stabled.

If they went and backported 0a79cdad5eb2 anyway, let's hope the scripts
are smart enough to catch this patch's Fixes: link.

