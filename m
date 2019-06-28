Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C27C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73022064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561707094;
	bh=4TPRoDbbvJMuASutOOb9t8E1zisZK/trAdh2WtQAcQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WHmW1NZff75j598LEq9HnXXMzW1TKHIa4j13aVxrPI0rboQMf+dqucW9XXzFXmylx
	 rtMUIATvkkYmYNm7cn5wDrtfo6lxIXpxj/NTEsoFLybDvc4RHpdCTZ/nOXQS5291jp
	 BaP2/8wCqI48IzwLGUVYOXRV+6eGhxE7FtP4K+Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfF1Hbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:31:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:32908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbfF1Hbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:31:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3DF7B167;
        Fri, 28 Jun 2019 07:31:30 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:31:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
Message-ID: <20190628073128.GC2751@dhcp22.suse.cz>
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-3-longman@redhat.com>
 <20190627151506.GE5303@dhcp22.suse.cz>
 <5cb05d2c-39a7-f138-b0b9-4b03d6008999@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb05d2c-39a7-f138-b0b9-4b03d6008999@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-06-19 17:16:04, Waiman Long wrote:
> On 6/27/19 11:15 AM, Michal Hocko wrote:
> > On Mon 24-06-19 13:42:19, Waiman Long wrote:
> >> With the slub memory allocator, the numbers of active slab objects
> >> reported in /proc/slabinfo are not real because they include objects
> >> that are held by the per-cpu slab structures whether they are actually
> >> used or not.  The problem gets worse the more CPUs a system have. For
> >> instance, looking at the reported number of active task_struct objects,
> >> one will wonder where all the missing tasks gone.
> >>
> >> I know it is hard and costly to get a real count of active objects.
> > What exactly is expensive? Why cannot slabinfo reduce the number of
> > active objects by per-cpu cached objects?
> >
> The number of cachelines that needs to be accessed in order to get an
> accurate count will be much higher if we need to iterate through all the
> per-cpu structures. In addition, accessing the per-cpu partial list will
> be racy.

Why is all that a problem for a root only interface that should be used
quite rarely (it is not something that you should be reading hundreds
time per second, right)?
-- 
Michal Hocko
SUSE Labs
