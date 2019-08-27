Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3856EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042EE2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566906618;
	bh=+ToDRBQFWXCWdE5YMxpX2EwGqm5RqFci6yxNesW6CU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LqUEsFRmnP3nRVyk5y9f+KHd6+RTiFDage03BTiq1YUlMziGmqssK5Pa3Ep3egbU0
	 TSXT4YMyh3w0OHcsSxZ25HkcEDKRm27hhQMfKXDDGA5I3PcWWxoMUDDWuxnQMySHrG
	 gtImj3Lur4Ei2P3OTuQHiQvc+57385csdUIi2s2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfH0LuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:50:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfH0LuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:50:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9FC3B01E;
        Tue, 27 Aug 2019 11:50:15 +0000 (UTC)
Date:   Tue, 27 Aug 2019 13:50:14 +0200
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
Message-ID: <20190827115014.GZ7538@dhcp22.suse.cz>
References: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
 <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com>
 <20190826105521.GF7538@dhcp22.suse.cz>
 <20190827104313.GW7538@dhcp22.suse.cz>
 <CALOAHbBMWyPBw+Ciup4+YupbLrxcTW76w+Mfc-mGEm9kcWb8YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBMWyPBw+Ciup4+YupbLrxcTW76w+Mfc-mGEm9kcWb8YQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 19:43:49, Yafang Shao wrote:
> On Tue, Aug 27, 2019 at 6:43 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > If there are no objection to the patch I will post it as a standalong
> > one.
> 
> I have no objection to your patch. It could fix the issue.
> 
> I still think that it is not proper to use a new scan_control here as
> it breaks the global reclaim context.
>
> This context switch from global reclaim to memcg reclaim is very
> subtle change to the subsequent processing, that may cause some
> unexpected behavior.

Why would it break it? Could you be more specific please?

> Anyway, we can send this patch as a standalong one.
> Feel free to add:
> 
> Acked-by: Yafang Shao <laoar.shao@gmail.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
