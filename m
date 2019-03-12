Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28598C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA912147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552406254;
	bh=uFGF56FNDC++i8l3obPT4y6Bwd0/w+W7yiW6upID07w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J+KUJeJgnd3zHd6/CVo7Yju/wERQ4JVnRyhVx2ajR9ERYszfxaq6+U/3KbIqCpLdO
	 tumWdDdlAv65Cbn4BSqfTzPGiqAh9qwoXZJWH+7ex4EcpU50kZlyg0uNGMU1AyDsF3
	 5qDsOb7szM+ByY/gcqKEy7QUivd0ls2cRmAkcm34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCLP5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:57:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfCLP5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:57:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DB6EAC5F;
        Tue, 12 Mar 2019 15:57:31 +0000 (UTC)
Date:   Tue, 12 Mar 2019 16:57:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mm/hotplug: don't reset pagetype flags for offline
Message-ID: <20190312155730.GZ5721@dhcp22.suse.cz>
References: <20190310200102.88014-1-cai@lca.pw>
 <20190312153458.qvmrblg3pnokgx4d@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312153458.qvmrblg3pnokgx4d@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-03-19 16:35:06, Oscar Salvador wrote:
[...]
> One thing I noticed when looking at start_isolate_page_range and 
> undo_isolate_page_range functions, is that start_isolate_page_range increments
> the number of isolated pageblocks, while undo_isolate_page_range does the counter
> part.
> Since undo_isolate_page_range is really never called during offlining,
> we leave zone->nr_isolate_pageblock with a stale value.
> 
> I __think__  this does not matter much.
> We only get to check whether a zone got isolated pageblocks in
> has_isolate_pageblock(), and this is called from:
> 
> free_one_page
> free_pcppages_bulk
> __free_one_page

It forces those into slow(er) path. So it makes a difference.

> With a quick glance, the only difference in has_isolate_pageblock() returning
> true or false, seems to be that those functions perform some extra checks in
> case the zone reports to have isolated pageblocks.
> 
> I wonder if we should set nr_isolate_pageblock back to its original value
> before start_isolate_page_range.

Yes. And that would be a fixup to my 2ce13640b3f4.

-- 
Michal Hocko
SUSE Labs
