Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9667DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F4F222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfKMLkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:40:51 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:50527 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727693AbfKMLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:40:51 -0500
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 99946A3F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 11:40:48 +0000 (GMT)
Received: (qmail 2036 invoked from network); 13 Nov 2019 11:40:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Nov 2019 11:40:48 -0000
Date:   Wed, 13 Nov 2019 11:40:46 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 6/8] mm/lru: remove rcu_read_lock to fix performance
 regression
Message-ID: <20191113114045.GZ3016@techsingularity.net>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573567588-47048-7-git-send-email-alex.shi@linux.alibaba.com>
 <20191112143844.GB7934@bombadil.infradead.org>
 <a6bb6739-cc00-cf9f-cd69-6016ce93e054@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a6bb6739-cc00-cf9f-cd69-6016ce93e054@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:40:58AM +0800, Alex Shi wrote:
> 
> 
> ?? 2019/11/12 ????10:38, Matthew Wilcox ????:
> > On Tue, Nov 12, 2019 at 10:06:26PM +0800, Alex Shi wrote:
> >> Intel 0day report there are performance regression on this patchset.
> >> The detailed info points to rcu_read_lock + PROVE_LOCKING which causes
> >> queued_spin_lock_slowpath waiting too long time to get lock.
> >> Remove rcu_read_lock is safe here since we had a spinlock hold.
> > Argh.  You have not sent these patches in a properly reviewable form!
> > I wasted all that time reviewing the earlier patch in this series only to
> > find out that you changed it here.  FIX THE PATCH, don't send a fix-patch
> > on top of it!
> > 
> 
> Hi Matthew,
> 
> Very sorry for your time! The main reasons I use a separate patch since a, Intel 0day asking me to credit their are founding, and I don't know how to give a clearly/elegant explanation for a non-exist regression in a fixed patch. b, this regression is kindly pretty tricky.  Maybe it's better saying thanks in version change log of cover-letter?
> 

Add something like this to the patch

[lkp@intel.com: Fix RCU-related regression reported by LKP robot]
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
...

-- 
Mel Gorman
SUSE Labs
