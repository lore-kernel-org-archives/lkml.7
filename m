Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D037FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37F3212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfFXOJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:09:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731916AbfFXOJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:09:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86070AF2C;
        Mon, 24 Jun 2019 14:09:52 +0000 (UTC)
Date:   Mon, 24 Jun 2019 15:09:50 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, jhladky@redhat.com,
        lvenanci@redhat.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -mm] autonuma: Fix scan period updating
Message-ID: <20190624140950.GF2947@suse.de>
References: <20190624025604.30896-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190624025604.30896-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:56:04AM +0800, Huang Ying wrote:
> The autonuma scan period should be increased (scanning is slowed down)
> if the majority of the page accesses are shared with other processes.
> But in current code, the scan period will be decreased (scanning is
> speeded up) in that situation.
> 
> This patch fixes the code.  And this has been tested via tracing the
> scan period changing and /proc/vmstat numa_pte_updates counter when
> running a multi-threaded memory accessing program (most memory
> areas are accessed by multiple threads).
> 

The patch somewhat flips the logic on whether shared or private is
considered and it's not immediately obvious why that was required. That
aside, other than the impact on numa_pte_updates, what actual
performance difference was measured and on on what workloads?

-- 
Mel Gorman
SUSE Labs
