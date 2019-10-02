Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D34AC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F422190F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570002894;
	bh=WOC+NCJwrTRBZoSkLkTV3dK20ECKafPt1ncVFt0QzHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0DmX1d1n4OyFefixBRlmb+7IBdBMX65h/e069qJXbZegUWvVr5eytTcsYIVCYawgV
	 /fCLSflDGmrCBz+GMyfsdg4/IbFguH91ijhly4L42V0cGpcGPdw1hZTroxBh7ZDahw
	 XAh3OBS9lu6PH0lss8BWKRA/sL89pyPzeWGanxi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfJBHyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJBHyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:54:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21148ABF4;
        Wed,  2 Oct 2019 07:54:52 +0000 (UTC)
Date:   Wed, 2 Oct 2019 09:54:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
Message-ID: <20191002075451.GG15624@dhcp22.suse.cz>
References: <20191001142227.1227176-1-arnd@arndb.de>
 <CAKwvOdn7J6bvF=58UkeXA8LVAMt-g76EDFT+j5EWc0LdsyX_CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn7J6bvF=58UkeXA8LVAMt-g76EDFT+j5EWc0LdsyX_CQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-10-19 09:36:24, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 7:22 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Removing the mem_cgroup_id_get() stub function introduced a new warning
> > of the same kind when CONFIG_MMU is disabled:
> >
> > mm/memcontrol.c:4929:13: error: unused function 'mem_cgroup_id_get_many' [-Werror,-Wunused-function]
> >
> > Address this using a __maybe_unused annotation.
> >
> > Note: alternatively, this could be moved into an #ifdef block.  Marking it
> 
> Hi Arnd,
> Thank you for the patch!  I would prefer to move the definition to the
> correct set of #ifdef guards rather than __maybe_unused.  Maybe move
> the definition of mem_cgroup_id_get_many() to just before
> __mem_cgroup_clear_mc()?  I find __maybe_unused to be a code smell.

Agreed!
-- 
Michal Hocko
SUSE Labs
