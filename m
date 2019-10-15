Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930FAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6489E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571137445;
	bh=RF5Y4SnrRE/0fn8QOcsxeRqWtjEJtU2bhEuVc1C1xXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jxr16yTE9WOKWWSs9nu6l5/nkX6XYkXtgR8+CLr+9IPTyibasoYnKhewqpiJL9t+W
	 RnV8roWFoX3Lz5fjYdl/k4fcVRyariHtvS6uuWqePBAuLrklC5PDrXAZHhrFPn3vlz
	 EsdcCJPgYcKqmTjBaHtVDcE9Dza7dQKZuNFaU+IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfJOLEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:04:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfJOLEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:04:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 364ECAC3E;
        Tue, 15 Oct 2019 11:04:02 +0000 (UTC)
Date:   Tue, 15 Oct 2019 13:04:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
Message-ID: <20191015110401.GZ317@dhcp22.suse.cz>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
 <20191015082048.GU317@dhcp22.suse.cz>
 <3b73e301-ea4a-5edb-9360-2ae9b4ad9f69@yandex-team.ru>
 <20191015103623.GX317@dhcp22.suse.cz>
 <31cab57d-6e79-33cb-1a58-99065c6e7b82@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31cab57d-6e79-33cb-1a58-99065c6e7b82@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-10-19 13:49:14, Konstantin Khlebnikov wrote:
> On 15/10/2019 13.36, Michal Hocko wrote:
> > On Tue 15-10-19 11:44:22, Konstantin Khlebnikov wrote:
> > > On 15/10/2019 11.20, Michal Hocko wrote:
> > > > On Tue 15-10-19 11:09:59, Konstantin Khlebnikov wrote:
> > > > > Mapped, dirty and writeback pages are also counted in per-lruvec stats.
> > > > > These counters needs update when page is moved between cgroups.
> > > > 
> > > > Please describe the user visible effect.
> > > 
> > > Surprisingly I don't see any users at this moment.
> > > So, there is no effect in mainline kernel.
> > 
> > Those counters are exported right? Or do we exclude them for v1?
> 
> It seems per-lruvec statistics is not exposed anywhere.
> And per-lruvec NR_FILE_MAPPED, NR_FILE_DIRTY, NR_WRITEBACK never had users.

So why do we have it in the first place? I have to say that counters
as we have them now are really clear as mud. This is really begging for
a clean up.
-- 
Michal Hocko
SUSE Labs
