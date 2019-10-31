Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F14CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA60217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfJaJjd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:39:33 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:38821 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfJaJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:39:33 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9V9d5KV030776
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 31 Oct 2019 18:39:05 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9V9d5Ds002546;
        Thu, 31 Oct 2019 18:39:05 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9V9Y0El023154;
        Thu, 31 Oct 2019 18:39:05 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9977829; Thu, 31 Oct 2019 18:38:42 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0439.000; Thu,
 31 Oct 2019 18:38:41 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Thread-Topic: [PATCH v2] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Thread-Index: AQHVj6H5mxzEf5Q4l0mAfuJEVZ8f/qdz59AA
Date:   Thu, 31 Oct 2019 09:38:40 +0000
Message-ID: <20191031093840.GA9178@hori.linux.bs1.fc.nec.co.jp>
References: <20191031012151.2722280-1-guro@fb.com>
 <20191030211608.29f8fc92e07fd2ac2ef4d1d3@linux-foundation.org>
In-Reply-To: <20191030211608.29f8fc92e07fd2ac2ef4d1d3@linux-foundation.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4592DDEF39464440989A95B815E27759@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 09:16:08PM -0700, Andrew Morton wrote:
> On Wed, 30 Oct 2019 18:21:51 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > page_cgroup_ino() doesn't return a valid memcg pointer for non-compound
> > slab pages, because it depends on PgHead AND PgSlab flags to be set
> > to determine the memory cgroup from the kmem_cache.
> > It's correct for compound pages, but not for generic small pages. Those
> > don't have PgHead set, so it ends up returning zero.
> > 
> > Fix this by replacing the condition to PageSlab() && !PageTail().
> > 
> > Before this patch:
> > [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
> > 0x0000000000000080	        38        0  _______S___________________________________	slab
> > 
> > After this patch:
> > [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
> > 0x0000000000000080	       147        0  _______S___________________________________	slab
> > 
> > Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> Affects /proc/kpagecgroup, but page_cgroup_ino() is also used in the
> memory-failure code - I wonder what effect this bug has there?

hwpoison_filter_task() uses output of page_cgroup_ino() in order to
filter error injection events based on memcg.
So if page_cgroup_ino() fails to return memcg pointer, we just fail
to inject memory error.  Considering that hwpoison filter is for testing,
affected users are limited and the impact should be marginal.

> 
> IOW, should we backport this into -stable?

I think yes, because the patch is small enough and clearly fixes a bug.

Thanks,
Naoya Horiguchi
