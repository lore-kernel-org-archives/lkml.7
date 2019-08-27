Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F1F206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566910527;
	bh=1hU6W5SrQvF2IRb/yIAbSD+cXuMmxQ2zgb9o2ydZgTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xjNgLacAmLUrMDOSy2kPbmTaU2lNJHf6zMwzS/UGgCmYqdcbQ2fUspgGH0noXRh5/
	 Iw/EhDxXIgQ2gwZpCnwf0qGG7x4b2rVSvSbPilP6/RK8hkwHnuvdURmOIvoCxneD3v
	 mPMqAGGpYDNnvnC5V7tyPzEJjgvnm2JGAEOMYcfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfH0Mz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:55:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:39120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbfH0Mz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:55:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B187B62C;
        Tue, 27 Aug 2019 12:55:24 +0000 (UTC)
Date:   Tue, 27 Aug 2019 14:55:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Adric Blake <promarbler14@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNINGs in set_task_reclaim_state with memory cgroup and full
 memory usage
Message-ID: <20190827125521.GE7538@dhcp22.suse.cz>
References: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
 <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com>
 <20190826105521.GF7538@dhcp22.suse.cz>
 <20190827104313.GW7538@dhcp22.suse.cz>
 <CALOAHbBMWyPBw+Ciup4+YupbLrxcTW76w+Mfc-mGEm9kcWb8YQ@mail.gmail.com>
 <20190827115014.GZ7538@dhcp22.suse.cz>
 <CALOAHbAtuQFB=GC41ZgSLXxheaEY4yz=fO9Zr5=rvTnyOYjF3A@mail.gmail.com>
 <20190827120335.GA7538@dhcp22.suse.cz>
 <CALOAHbDbNxg1xxZAT0rf3=46DrM1PV2YEDEP6F9HMU9JvgvESA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDbNxg1xxZAT0rf3=46DrM1PV2YEDEP6F9HMU9JvgvESA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 20:19:34, Yafang Shao wrote:
> On Tue, Aug 27, 2019 at 8:03 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 27-08-19 19:56:16, Yafang Shao wrote:
> > > On Tue, Aug 27, 2019 at 7:50 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Tue 27-08-19 19:43:49, Yafang Shao wrote:
> > > > > On Tue, Aug 27, 2019 at 6:43 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > >
> > > > > > If there are no objection to the patch I will post it as a standalong
> > > > > > one.
> > > > >
> > > > > I have no objection to your patch. It could fix the issue.
> > > > >
> > > > > I still think that it is not proper to use a new scan_control here as
> > > > > it breaks the global reclaim context.
> > > > >
> > > > > This context switch from global reclaim to memcg reclaim is very
> > > > > subtle change to the subsequent processing, that may cause some
> > > > > unexpected behavior.
> > > >
> > > > Why would it break it? Could you be more specific please?
> > > >
> > >
> > > Hmm, I have explained it when replying to  Hillf's patch.
> > > The most suspcious one is settting target_mem_cgroup here, because we
> > > only use it to judge whether it is in global reclaim.
> > > While the memcg softlimit reclaim is really in global reclaims.
> >
> > But we are reclaim the target_mem_cgroup hierarchy. This is the whole
> > point of the soft reclaim. Push down that hierarchy below the configured
> > limit. And that is why we absolutely have to switch the reclaim context.
> >
> 
> One obvious issue is the reclaim couters may not correct.
> See shrink_inactive_list().
> The pages relcaimed in memcg softlimit will not be counted to
> PGSCAN_{DIRECT, KSWAPD} and PGSTEAL_{DIRECT, KSWAPD}.

And again this a long term behavior so I would be really curious why it
is considered a bug now. Really, the semantic of the soft limit is
weird. It has been grafted into the reclaim while it was doing a
semantically different thing. It doesn't really reflect kswapd or direct
reclaim targets.
-- 
Michal Hocko
SUSE Labs
