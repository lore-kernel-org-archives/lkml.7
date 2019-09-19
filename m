Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2DFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4305521D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568899947;
	bh=hbDUb3nA396jbEiPqiKCTD8xyX9jvHkQ1YVadHUfGbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zk6qdTrReRv+X7B4QFOeJYIiSoth+Q27gQ4cX2hiHUpjoJBDS8DYKidF1bK41rlg5
	 WOYYb91Hbr5csXiGNM6vrgnB7nbPJhQo6s3PKQnHr8ins3ANVv73PNj0obR4Zhwm4Z
	 lHZzNvRkhqrwR0U0HUwmONNyGisG56GUxVrcOsew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbfISNc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:32:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:32990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389492AbfISNc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:32:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D6C1AFC4;
        Thu, 19 Sep 2019 13:32:24 +0000 (UTC)
Date:   Thu, 19 Sep 2019 15:32:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] mm: memcg: add priority for soft limit reclaiming
Message-ID: <20190919133222.GD15782@dhcp22.suse.cz>
References: <20190919131332.4180-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919131332.4180-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-09-19 21:13:32, Hillf Danton wrote:
> 
> Currently memory controler is playing increasingly important role in
> how memory is used and how pages are reclaimed on memory pressure.
> 
> In daily works memcg is often created for critical tasks and their pre
> configured memory usage is supposed to be met even on memory pressure.
> Administrator wants to make it configurable that the pages consumed by
> memcg-B can be reclaimed by page allocations invoked not by memcg-A but
> by memcg-C.

I am not really sure I understand the usecase well but this sounds like
what memory reclaim protection in v2 is aiming at.
 
> That configurability is addressed by adding priority for soft limit
> reclaiming to make sure that no pages will be reclaimed from memcg of
> higer priortiy in favor of memcg of lower priority.

cgroup v1 interfaces are generally frozen and mostly aimed at backward
compatibility. I am especially concerned about adding a new way to
control soft limit which is known to be misdesigned and unfixable to
behave reasonably.

> Pages are reclaimed with no priority being taken into account by default
> unless user turns it on, and then they are responsible for their smart
> activities almost the same way as they play realtime FIFO/RR games.
> 
> Priority is available only in the direct reclaiming context in order to
> advoid churning in the complex kswapd behavior.
> 
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.cz>
> Signed-off-by: Hillf Danton <hdanton@sina.com>

That being said, you should describe the usecase and explain why v2
interface is not providing what you need. We might think about where to
go from there but extending the soft limit reclaim is almost certainly
not the right way to go.
-- 
Michal Hocko
SUSE Labs
