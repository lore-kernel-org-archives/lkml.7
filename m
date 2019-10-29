Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DD1CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C489A2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572338256;
	bh=dnMXb3m4kD24TqWFe8QYOmVotckjAnvSJX/1VpC4d7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TLLR5C5vV7MciW2Zcw1cOV9O9LP3dG//z9/DlEosqXrCIo2+qCpG/AD7AyRUw+RaL
	 pm63steP+AmRaRMX+38wkcbpJdudVZvVQW1QKJFS2xQtGMVJ2xeH4sJ781cXWDuIPt
	 0/bKXpSbfH2Gzhw6nCfxmMG2OfeXQj/BUH5aigRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfJ2Ihf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:37:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbfJ2Ihf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:37:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11716AE87;
        Tue, 29 Oct 2019 08:37:32 +0000 (UTC)
Date:   Tue, 29 Oct 2019 09:37:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v2] memcg: add memcg lru for page reclaiming
Message-ID: <20191029083730.GC31513@dhcp22.suse.cz>
References: <20191026110745.12956-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026110745.12956-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26-10-19 19:07:45, Hillf Danton wrote:
> 
> Currently soft limit reclaim is frozen, see
> Documentation/admin-guide/cgroup-v2.rst for reasons.
> 
> This work adds memcg hook into kswapd's logic to bypass slr,
> paving a brick for its cleanup later.
> 
> After b23afb93d317 ("memcg: punt high overage reclaim to
> return-to-userland path"), high limit breachers are reclaimed one
> after another spiraling up through the memcg hierarchy before
> returning to userspace.
> 
> We can not add new hook yet if it is infeasible to defer that
> reclaiming a bit further until kswapd becomes active.
> 
> It can be defered however because high limit breach looks benign
> in the absence of memory pressure, or we ensure it will be
> reclaimed soon in the presence of kswapd.

This is not true and I have already expressed that in a responsoce to
the v1 of this patch. Let me repeat (for the last time hopefully) the
high limit is aimed at throttling allocators even when the system is not
under a memory pressure. So no, we cannot defer to kswapd.

This patchset is ignoring the previous review feedback. You still
haven't described any real usecase and any reasons why the existing
feature list doesn't satisfy it.

Until this is sorted out:
Nacked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
