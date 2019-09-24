Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E1C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9B421655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569328070;
	bh=UkoYPSvoNbyEGz8D99UJ45H7fpqACMqVy4xrbMiSILc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ChsIvRvaKma8Do7S9kui1b6mIkukIHMp6lceOQfD3xSWM8n2hcDYvpeXEghwp3c7O
	 jOApwwnMeXuvS/4LUb4YT56Qw/LoaDmrFTwnsYVijqK7s99kPsF7xWi3x3JkOc3iby
	 +O7RYpD0PEV+hFpCTZE13UK12kT6aPh2YLEcGEXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436592AbfIXM1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:27:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:52202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390187AbfIXM1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:27:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0D6DB0E2;
        Tue, 24 Sep 2019 12:27:47 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:27:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] memcg: Only record foreign writebacks with dirty
 pages when memcg is not disabled
Message-ID: <20190924122747.GQ23050@dhcp22.suse.cz>
References: <20190923083030.6442-1-bhe@redhat.com>
 <20190924111138.GA31919@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924111138.GA31919@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 19:11:51, Baoquan He wrote:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f3c15bb07cce..84e3fdb1ccb4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4317,6 +4317,9 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
>  
>  	trace_track_foreign_dirty(page, wb);
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +

This doesn't seem correct. We shouldn't even enter the slowpath with
memcg disabled AFAIC. The check should be done at mem_cgroup_track_foreign_dirty
level.
-- 
Michal Hocko
SUSE Labs
