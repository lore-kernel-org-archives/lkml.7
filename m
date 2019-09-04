Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E28FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1206522CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567579120;
	bh=d0JkGktu8if4c1/D9P/zS+aCW2j4oVxB03dCyc5sTwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A0Bq9mp6efhU9MpBdAVsM6trKvzxth8wGKSWt38JxFnQaBxzBklrg0qFGS5v1eaoQ
	 +brFxPUXIzriKKuRAu2gYaJbEHRZz+Xmzf3AbOM6KScrRjsjddf1d5yZOhZCzmjeJ+
	 U7mMFC6my6VyIPhxf2GhbCXe8ZPm9u5y2MR6bWzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfIDGij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:38:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfIDGii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:38:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3364ACE3;
        Wed,  4 Sep 2019 06:38:37 +0000 (UTC)
Date:   Wed, 4 Sep 2019 08:38:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190904063836.GD3838@dhcp22.suse.cz>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190903131737.GB18939@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-09-19 02:18:38, sunqiuyang wrote:
> The isolate path of non-lru movable pages:
> 
> isolate_migratepages_block
> 	isolate_movable_page
> 		trylock_page
> 		// if PageIsolated, goto out_no_isolated
> 		a_ops->isolate_page
> 		__SetPageIsolated
> 		unlock_page
> 	list_add(&page->lru, &cc->migratepages)
> 
> The migration path:
> 
> unmap_and_move
> 	__unmap_and_move
> 		lock_page
> 		move_to_new_page
> 			a_ops->migratepage
> 			__ClearPageIsolated
> 		unlock_page
> 	/* here, the page could be isolated again by another thread, and added into another cc->migratepages,
> 	since PG_Isolated has been cleared, and not protected by page_lock */
> 	list_del(&page->lru)

But the page has been migrated already and not freed yet because there
is still a pin on it. So nobody should be touching it at this stage.
Or do I still miss something?
-- 
Michal Hocko
SUSE Labs
