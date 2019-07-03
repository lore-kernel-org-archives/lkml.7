Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7139C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4182189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562169208;
	bh=CuhYih1pMX2LOI7uQFX0bHnOKBAsJh5KmXFD6VVmkjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gzIAc/k4W3kS0glptFqIrOrWo1f0pTL7w5iqehpz1FEaMwy/M7IAZWC/orcL0I2mR
	 WgrLV5sJ90cVHN5JHazYZoG3rXt7T4NjTdoEgqecEFAFgmO4f0iWFEaJn8U1JOeYC1
	 51j5d8LG3P91F4d9HYOoEqXGvFtHG6hDX7GCUVz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGCPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:53:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:34834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfGCPxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18B12AD17;
        Wed,  3 Jul 2019 15:53:22 +0000 (UTC)
Date:   Wed, 3 Jul 2019 17:53:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
Message-ID: <20190703155314.GT978@dhcp22.suse.cz>
References: <20190702183730.14461-1-longman@redhat.com>
 <20190702130318.39d187dc27dbdd9267788165@linux-foundation.org>
 <78879b79-1b8f-cdfd-d4fa-610afe5e5d48@redhat.com>
 <20190702143340.715f771192721f60de1699d7@linux-foundation.org>
 <c29ff725-95ba-db4d-944f-d33f5f766cd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c29ff725-95ba-db4d-944f-d33f5f766cd3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-07-19 11:21:16, Waiman Long wrote:
> On 7/2/19 5:33 PM, Andrew Morton wrote:
> > On Tue, 2 Jul 2019 16:44:24 -0400 Waiman Long <longman@redhat.com> wrote:
> >
> >> On 7/2/19 4:03 PM, Andrew Morton wrote:
> >>> On Tue,  2 Jul 2019 14:37:30 -0400 Waiman Long <longman@redhat.com> wrote:
> >>>
> >>>> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> >>>> file to shrink the slab by flushing all the per-cpu slabs and free
> >>>> slabs in partial lists. This applies only to the root caches, though.
> >>>>
> >>>> Extends this capability by shrinking all the child memcg caches and
> >>>> the root cache when a value of '2' is written to the shrink sysfs file.
> >>> Why?
> >>>
> >>> Please fully describe the value of the proposed feature to or users. 
> >>> Always.
> >> Sure. Essentially, the sysfs shrink interface is not complete. It allows
> >> the root cache to be shrunk, but not any of the memcg caches. 
> > But that doesn't describe anything of value.  Who wants to use this,
> > and why?  How will it be used?  What are the use-cases?
> >
> For me, the primary motivation of posting this patch is to have a way to
> make the number of active objects reported in /proc/slabinfo more
> accurately reflect the number of objects that are actually being used by
> the kernel.

I believe we have been through that. If the number is inexact due to
caching then lets fix slabinfo rather than trick around it and teach
people to do a magic write to some file that will "solve" a problem.
This is exactly what drop_caches turned out to be in fact. People just
got used to drop caches because they were told so by $random web page.
So really, think about the underlying problem and try to fix it.

It is true that you could argue that this patch is actually fixing the
existing interface because it doesn't really do what it is documented to
do and on those grounds I would agree with the change. But do not teach
people that they have to write to some file to get proper numbers.
Because that is just a bad idea and it will kick back the same way
drop_caches.
-- 
Michal Hocko
SUSE Labs
