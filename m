Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92502C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC6A2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560861475;
	bh=AVgnKknoWm90fQccTZKVci8bzaMZ7i81Db8kiMexxJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RAxPybKzZlf1v3m2xOwpMiKRwYspssqeDnMJ4fZGj1cU9OEC1k3Y6Gymaa7QhDZdA
	 6xWqI5Xibypm126vq9g85mh85/Xjf+zTu8F8HU3NyGZCgFBJE+spGfdVQhLxTSL8A9
	 juKe9DXBRbHafVqe0tOo3R2sDIv1xvQIwizFbqnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfFRMhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:37:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRMhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:37:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 425E1AD0B;
        Tue, 18 Jun 2019 12:37:52 +0000 (UTC)
Date:   Tue, 18 Jun 2019 14:37:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: Report number of memcg caches in slabinfo
Message-ID: <20190618123750.GG3318@dhcp22.suse.cz>
References: <20190617142149.5245-1-longman@redhat.com>
 <20190617143842.GC1492@dhcp22.suse.cz>
 <9e165eae-e354-04c4-6362-0f80fe819469@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e165eae-e354-04c4-6362-0f80fe819469@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-06-19 10:50:23, Waiman Long wrote:
> On 6/17/19 10:38 AM, Michal Hocko wrote:
> > [Cc linux-api]
> >
> > On Mon 17-06-19 10:21:49, Waiman Long wrote:
> >> There are concerns about memory leaks from extensive use of memory
> >> cgroups as each memory cgroup creates its own set of kmem caches. There
> >> is a possiblity that the memcg kmem caches may remain even after the
> >> memory cgroup removal.
> >>
> >> Therefore, it will be useful to show how many memcg caches are present
> >> for each of the kmem caches.
> > How is a user going to use that information?  Btw. Don't we have an
> > interface to display the number of (dead) cgroups?
> 
> The interface to report dead cgroups is for cgroup v2 (cgroup.stat)
> only. I don't think there is a way to find that for cgroup v1.

Doesn't debug_legacy_files provide the information for both cgroups
APIs?

> Also the
> number of memcg kmem caches may not be the same as the number of
> memcg's. It can range from 0 to above the number of memcg's.  So it is
> an interesting number by itself.

Is this useful enough to put into slabinfo? Doesn't this sound more like
a debugfs kinda a thing?

> From the user perspective, if the numbers is way above the number of
> memcg's, there is probably something wrong there.

-- 
Michal Hocko
SUSE Labs
