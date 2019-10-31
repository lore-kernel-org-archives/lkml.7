Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D277CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 04:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D6D2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 04:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572495373;
	bh=TdavWRFLS/Lxw3pvDBh+4n0ncIlxfulsj9NTk8R2yXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZxO6tCivvRhH+SQ2kKtakLBAK5lTWmpsoS9Onx451gAF5+EZn7v7IWSBqMlhDc1i8
	 oRtbBaVVNYIx1joy+gW943XQMVIc1ZMAm4JOare7LlZqxWxaaHtQBoVvWoNssOaoQt
	 qB32dAMZwdHG0neXp3G7wfp46QNGFzF/pKTgyTG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfJaEQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 00:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfJaEQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 00:16:10 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154D42080F;
        Thu, 31 Oct 2019 04:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572495369;
        bh=TdavWRFLS/Lxw3pvDBh+4n0ncIlxfulsj9NTk8R2yXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VoSZnYi/gWQldgzmpcUHJGLjbfRmcYdaPHP34Y5dGR5XV6mJu4e957W3ZqXGMNqKF
         fNrFI2YZhZ7jZNYC64cOHe9j5ZK+g41EDaLanHfzBmmUGWCP10M8wGBq4Md6Da8HR7
         nYngzYFUl3qkZ465PWWNcA0nOYGrB9GkzEzaSjOA=
Date:   Wed, 30 Oct 2019 21:16:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v2] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Message-Id: <20191030211608.29f8fc92e07fd2ac2ef4d1d3@linux-foundation.org>
In-Reply-To: <20191031012151.2722280-1-guro@fb.com>
References: <20191031012151.2722280-1-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 18:21:51 -0700 Roman Gushchin <guro@fb.com> wrote:

> page_cgroup_ino() doesn't return a valid memcg pointer for non-compound
> slab pages, because it depends on PgHead AND PgSlab flags to be set
> to determine the memory cgroup from the kmem_cache.
> It's correct for compound pages, but not for generic small pages. Those
> don't have PgHead set, so it ends up returning zero.
> 
> Fix this by replacing the condition to PageSlab() && !PageTail().
> 
> Before this patch:
> [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
> 0x0000000000000080	        38        0  _______S___________________________________	slab
> 
> After this patch:
> [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
> 0x0000000000000080	       147        0  _______S___________________________________	slab
> 
> Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>

Affects /proc/kpagecgroup, but page_cgroup_ino() is also used in the
memory-failure code - I wonder what effect this bug has there?

IOW, should we backport this into -stable?
