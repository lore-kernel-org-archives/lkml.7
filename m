Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B48C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B872084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568143884;
	bh=OaT9zKjmVknfKEn+hyRKfhwFFHromGoLexX5hUXonK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iq09tqbp1343ORdclu3eUyGnHLOYA+a+xVh55JRXChA31ztRznarpxUjPbDMeUOJq
	 Zt28DSBo6btkv2YfjGH7xFOQ+8R2gzp+cE00VJGpS85BPVOFuv6WelPUTpTyP0JrWv
	 dpwQhSCeD0qgugZHGYQr8snLrGyTR1e1piXWGRIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfIJTbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:31:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfIJTbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:31:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6ED4FAE68;
        Tue, 10 Sep 2019 19:31:21 +0000 (UTC)
Date:   Tue, 10 Sep 2019 21:31:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190910193120.GF4023@dhcp22.suse.cz>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190910192304.GA220078@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910192304.GA220078@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 12:23:04, Minchan Kim wrote:
> On Tue, Sep 03, 2019 at 04:27:46PM +0800, sunqiuyang wrote:
> > From: Qiuyang Sun <sunqiuyang@huawei.com>
> > 
> > Currently, after a page is migrated, it
> > 1) has its PG_isolated flag cleared in move_to_new_page(), and
> > 2) is deleted from its LRU list (cc->migratepages) in unmap_and_move().
> > However, between steps 1) and 2), the page could be isolated by another
> > thread in isolate_movable_page(), and added to another LRU list, leading
> > to list_del corruption later.
> 
> Once non-LRU page is migrated out successfully, driver should clear
> the movable flag in the page. Look at reset_page in zs_page_migrate.
> So, other thread couldn't isolate the page during the window.
> 
> If I miss something, let me know it.

Please have a look at http://lkml.kernel.org/r/157FC541501A9C4C862B2F16FFE316DC190C5990@dggeml512-mbx.china.huawei.com
-- 
Michal Hocko
SUSE Labs
