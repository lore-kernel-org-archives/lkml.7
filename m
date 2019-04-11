Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1214C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2B720643
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554996259;
	bh=6e+pj2aQBoi8rIlYDWkd64W7SDDUShSvGkMhNYazVXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SrW9r1aOhwK9QtpyyJQTMpeZLotg+s0qaX1ON1r/JO2kR4PddQX1oLY6bdWzbBnm9
	 YK9S1w/Pmj8EQi5QrS9D6ypSWklghbsVIxKQOv4LUsmP6Tt7cunIof11vSx2o787Uc
	 Y5yslWb3A8wnupcrqHBhW52+C0mPfl4pgOpPamMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDKPYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:24:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfDKPYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:24:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10A4CAD4C;
        Thu, 11 Apr 2019 15:24:16 +0000 (UTC)
Date:   Thu, 11 Apr 2019 17:24:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 0/2] mm/memcontrol: Finer-grained memory control
Message-ID: <20190411152415.GA10383@dhcp22.suse.cz>
References: <20190410191321.9527-1-longman@redhat.com>
 <20190410195443.GL10383@dhcp22.suse.cz>
 <daef5f22-0bc2-a637-fa3d-833205623fb6@redhat.com>
 <20190411151911.GZ10383@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411151911.GZ10383@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 17:19:11, Michal Hocko wrote:
> On Thu 11-04-19 10:02:16, Waiman Long wrote:
> > On 04/10/2019 03:54 PM, Michal Hocko wrote:
> > > On Wed 10-04-19 15:13:19, Waiman Long wrote:
> > >> The current control mechanism for memory cgroup v2 lumps all the memory
> > >> together irrespective of the type of memory objects. However, there
> > >> are cases where users may have more concern about one type of memory
> > >> usage than the others.
> > >>
> > >> We have customer request to limit memory consumption on anonymous memory
> > >> only as they said the feature was available in other OSes like Solaris.
> > > Please be more specific about a usecase.
> > 
> > From that customer's point of view, page cache is more like common goods
> > that can typically be shared by a number of different groups. Depending
> > on which groups touch the pages first, it is possible that most of those
> > pages can be disproportionately attributed to one group than the others.
> > Anonymous memory, on the other hand, are not shared and so can more
> > correctly represent the memory footprint of an application. Of course,
> > there are certainly cases where an application can have large private
> > files that can consume a lot of cache pages. These are probably not the
> > case for the applications used by that customer.
> 
> So you are essentially interested in the page cache limiting, right?
> This has been proposed several times already and always rejected because
> this is not a good idea.

OK, so after reading other responses I've realized that I've
misunderstood your intention. You are really interested in the anon
memory limiting. But my objection still holds! I would like to hear much
more specific usecases. Is the page cache such a precious resource it
cannot be refaulted? With the storage speed these days I am quite not
sure. Also there is always way to delegate page cache pre-faulting to a
dedicated cgroup with a low limit protection if _some_ pagecache is
really important.

-- 
Michal Hocko
SUSE Labs
