Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E5EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48CE218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378153;
	bh=ebWsCv2ip+dY4MqUszXt3GYUc8Jv8t0MXqlE2ZjxSLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ldECViPX5PocLTCdmrx6be35ZUsTZDROyZDJHv6RHYqU16VwyHhaWjw8JRwdDQfTi
	 d/k5qEietezozlxZeb3eYMh1v+5aNUHj/KLYdpMOSaq3BTJ7pL5Vxekc2ztQn6YMWk
	 dJLer6CwtEMPcjAy4cSIY1Je++LQq62e0Q8wv5JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbfB1SWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:22:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfB1SWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:22:31 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4D50ADFA;
        Thu, 28 Feb 2019 18:22:30 +0000 (UTC)
Date:   Thu, 28 Feb 2019 10:22:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 2/4] mm: remove zone_lru_lock() function access
 ->lru_lock directly
Message-Id: <20190228102229.dec5e125fc65a3ff7c6f865f@linux-foundation.org>
In-Reply-To: <7AF5AEF9-FF0A-41C1-834A-4C33EBD0CA09@oracle.com>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
        <20190228083329.31892-2-aryabinin@virtuozzo.com>
        <7AF5AEF9-FF0A-41C1-834A-4C33EBD0CA09@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 05:53:37 -0700 William Kucharski <william.kucharski@oracle.com> wrote:

> > On Feb 28, 2019, at 1:33 AM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a9852ed7b97f..2d081a32c6a8 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1614,8 +1614,8 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
> > 
> > }
> > 
> > -/*
> > - * zone_lru_lock is heavily contended.  Some of the functions that
> > +/**
> 
> Nit: Remove the extra asterisk here; the line should then revert to being unchanged from
> the original.

I don't think so.  This kernedoc comment was missing its leading /**. 
The patch fixes that.

