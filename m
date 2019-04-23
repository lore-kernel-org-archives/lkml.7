Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F19C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627F32175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfDWOfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:35:44 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:52065 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbfDWOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:35:43 -0400
Received: from mail.blacknight.com (unknown [81.17.254.11])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 15F711C1E0C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:35:42 +0100 (IST)
Received: (qmail 9400 invoked from network); 23 Apr 2019 14:35:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Apr 2019 14:35:41 -0000
Date:   Tue, 23 Apr 2019 15:35:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: avoid potential NULL pointer
 dereference
Message-ID: <20190423143540.GQ18914@techsingularity.net>
References: <20190423120806.3503-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190423120806.3503-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:08:05PM +0300, Andrey Ryabinin wrote:
> ac.preferred_zoneref->zone passed to alloc_flags_nofragment() can be NULL.
> 'zone' pointer unconditionally derefernced in alloc_flags_nofragment().
> Bail out on NULL zone to avoid potential crash.
> Currently we don't see any crashes only because alloc_flags_nofragment()
> has another bug which allows compiler to optimize away all accesses to
> 'zone'.
> 
> Fixes: 6bb154504f8b ("mm, page_alloc: spread allocations across zones before introducing fragmentation")
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
