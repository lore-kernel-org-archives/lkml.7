Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301ADC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD352082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDJTNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfDJTNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:13:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E259316891D;
        Wed, 10 Apr 2019 19:13:54 +0000 (UTC)
Received: from llong.com (ovpn-120-189.rdu2.redhat.com [10.10.120.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3138600CC;
        Wed, 10 Apr 2019 19:13:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Aaron Lu <aaron.lu@intel.com>, Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 0/2] mm/memcontrol: Finer-grained memory control
Date:   Wed, 10 Apr 2019 15:13:19 -0400
Message-Id: <20190410191321.9527-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 10 Apr 2019 19:13:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current control mechanism for memory cgroup v2 lumps all the memory
together irrespective of the type of memory objects. However, there
are cases where users may have more concern about one type of memory
usage than the others.

We have customer request to limit memory consumption on anonymous memory
only as they said the feature was available in other OSes like Solaris.

To allow finer-grained control of memory, this patchset 2 new control
knobs for memory controller:
 - memory.subset.list for specifying the type of memory to be under control.
 - memory.subset.high for the high limit of memory consumption of that
   memory type.

For simplicity, the limit is not hierarchical and applies to only tasks
in the local memory cgroup.

Waiman Long (2):
  mm/memcontrol: Finer-grained control for subset of allocated memory
  mm/memcontrol: Add a new MEMCG_SUBSET_HIGH event

 Documentation/admin-guide/cgroup-v2.rst |  35 +++++++++
 include/linux/memcontrol.h              |   8 ++
 mm/memcontrol.c                         | 100 +++++++++++++++++++++++-
 3 files changed, 142 insertions(+), 1 deletion(-)

-- 
2.18.1

