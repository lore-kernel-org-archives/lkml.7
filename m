Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DED9C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AAF2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565290285;
	bh=GigiXD5zZkRUr1+wrqGcAfPJ9yELJgB2lxS5ARgO6bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0vL8oVHow9EEDYb558lJIC6pEqu6fBWsJWQLXH03OhY1v/dzufzoEkIKuPJXmfLZC
	 hUa9LvIXKwFHamj7RxcfAsMueqkiDyj/cJChtxZSXYhBGTOaVeg32KGVbIifTRBBl1
	 aSF9qik+Y6qfBBa59+Yq4zR0WQxRURS6it+mxxZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbfHHSvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:51:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733248AbfHHSvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:51:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E4BBAFA7;
        Thu,  8 Aug 2019 18:51:22 +0000 (UTC)
Date:   Thu, 8 Aug 2019 20:51:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] mm/oom: Add killed process selection information
Message-ID: <20190808185119.GF18351@dhcp22.suse.cz>
References: <20190808183247.28206-1-echron@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808183247.28206-1-echron@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 11:32:47, Edward Chron wrote:
> For an OOM event: print oomscore, memory pct, oom adjustment of the process
> that OOM kills and the totalpages value in kB (KiB) used in the calculation
> with the OOM killed process message. This is helpful to document why the
> process was selected by OOM at the time of the OOM event.
> 
> Sample message output:
> Jul 21 20:07:48 yoursystem kernel: Out of memory: Killed process 2826
>  (processname) total-vm:1056800kB, anon-rss:1052784kB, file-rss:4kB,
>  shmem-rss:0kB memory-usage:3.2% oom_score:1032 oom_score_adj:1000
>  total-pages: 32791748kB

A large part of this information is already printed in the oom eligible
task list. Namely rss, oom_score_adj, there is also page tables
consumption which might be a serious contributor as well. Why would you
like to see oom_score, memory-usage and total-pages to be printed as
well? How is that information useful?
-- 
Michal Hocko
SUSE Labs
