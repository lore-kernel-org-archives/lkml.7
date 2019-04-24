Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46124C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF9B21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfDXJEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:04:06 -0400
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:40794 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfDXJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:04:06 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 99DD498BFE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:04:04 +0000 (UTC)
Received: (qmail 31721 invoked from network); 24 Apr 2019 09:04:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Apr 2019 09:04:04 -0000
Date:   Wed, 24 Apr 2019 10:04:03 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: fix never set ALLOC_NOFRAGMENT flag
Message-ID: <20190424090403.GS18914@techsingularity.net>
References: <20190423120806.3503-1-aryabinin@virtuozzo.com>
 <20190423120806.3503-2-aryabinin@virtuozzo.com>
 <20190423120143.f555f77df02a266ba2a7f1fc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190423120143.f555f77df02a266ba2a7f1fc@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:01:43PM -0700, Andrew Morton wrote:
> On Tue, 23 Apr 2019 15:08:06 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> 
> > Commit 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> > removed setting of the ALLOC_NOFRAGMENT flag. Bring it back.
> 
> What are the runtime effects of this fix?

The runtime effect is that ALLOC_NOFRAGMENT behaviour is restored so
that allocations are spread across local zones to avoid fragmentation
due to mixing pageblocks as long as possible.

-- 
Mel Gorman
SUSE Labs
