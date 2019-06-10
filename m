Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E349DC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A622086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbfFJVhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:37:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389193AbfFJVhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:37:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 720E7AAA8;
        Mon, 10 Jun 2019 21:37:00 +0000 (UTC)
Message-ID: <1560202615.3312.6.camel@suse.de>
Subject: Re: [v7 PATCH 1/2] mm: vmscan: remove double slab pressure by
 inc'ing sc->nr_scanned
From:   Oscar Salvador <osalvador@suse.de>
To:     Yang Shi <yang.shi@linux.alibaba.com>, ying.huang@intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, josef@toxicpanda.com,
        hughd@google.com, shakeelb@google.com, hdanton@sina.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Jun 2019 23:36:55 +0200
In-Reply-To: <1559025859-72759-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1559025859-72759-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 14:44 +0800, Yang Shi wrote:
> The commit 9092c71bb724 ("mm: use sc->priority for slab shrink
> targets")
> has broken up the relationship between sc->nr_scanned and slab
> pressure.
> The sc->nr_scanned can't double slab pressure anymore.  So, it sounds
> no
> sense to still keep sc->nr_scanned inc'ed.  Actually, it would
> prevent
> from adding pressure on slab shrink since excessive sc->nr_scanned
> would
> prevent from scan->priority raise.

Hi Yang,

I might be misunderstanding this, but did you mean "prevent from scan-
priority decreasing"?
I guess we are talking about balance_pgdat(), and in case
kswapd_shrink_node() returns true (it means we have scanned more than
we had to reclaim), raise_priority becomes false, and this does not let
sc->priority to be decreased, which has the impact that less pages will
 be reclaimed the next round.

Sorry for bugging here, I just wanted to see if I got this right.


-- 
Oscar Salvador
SUSE L3
