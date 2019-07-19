Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D1C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C535521871
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfGSOJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfGSOJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:09:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0616181F2F;
        Fri, 19 Jul 2019 14:09:08 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D59842FC5B;
        Fri, 19 Jul 2019 14:09:06 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mm, slab: Extend slab/shrink to shrink all memcg
 caches
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190717202413.13237-1-longman@redhat.com>
 <20190717202413.13237-2-longman@redhat.com>
 <20190719062052.GK30461@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <caa120bb-bfcc-45ef-08e1-af40e52b43df@redhat.com>
Date:   Fri, 19 Jul 2019 10:09:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719062052.GK30461@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 19 Jul 2019 14:09:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/19 2:20 AM, Michal Hocko wrote:
> On Wed 17-07-19 16:24:12, Waiman Long wrote:
>> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
>> file to shrink the slab by flushing out all the per-cpu slabs and free
>> slabs in partial lists. This can be useful to squeeze out a bit more memory
>> under extreme condition as well as making the active object counts in
>> /proc/slabinfo more accurate.
>>
>> This usually applies only to the root caches, as the SLUB_MEMCG_SYSFS_ON
>> option is usually not enabled and "slub_memcg_sysfs=1" not set. Even
>> if memcg sysfs is turned on, it is too cumbersome and impractical to
>> manage all those per-memcg sysfs files in a real production system.
>>
>> So there is no practical way to shrink memcg caches.  Fix this by
>> enabling a proper write to the shrink sysfs file of the root cache
>> to scan all the available memcg caches and shrink them as well. For a
>> non-root memcg cache (when SLUB_MEMCG_SYSFS_ON or slub_memcg_sysfs is
>> on), only that cache will be shrunk when written.
> I would mention that memcg unawareness was an overlook more than
> anything else. The interface is intended to shrink all pcp data of the
> cache. The fact that we are using per-memcg internal caches is an
> implementation detail.
>
>> On a 2-socket 64-core 256-thread arm64 system with 64k page after
>> a parallel kernel build, the the amount of memory occupied by slabs
>> before shrinking slabs were:
>>
>>  # grep task_struct /proc/slabinfo
>>  task_struct        53137  53192   4288   61    4 : tunables    0    0
>>  0 : slabdata    872    872      0
>>  # grep "^S[lRU]" /proc/meminfo
>>  Slab:            3936832 kB
>>  SReclaimable:     399104 kB
>>  SUnreclaim:      3537728 kB
>>
>> After shrinking slabs:
>>
>>  # grep "^S[lRU]" /proc/meminfo
>>  Slab:            1356288 kB
>>  SReclaimable:     263296 kB
>>  SUnreclaim:      1092992 kB
>>  # grep task_struct /proc/slabinfo
>>  task_struct         2764   6832   4288   61    4 : tunables    0    0
>>  0 : slabdata    112    112      0
> Now that you are touching the documentation I would just add a note that
> shrinking might be expensive and block other slab operations so it
> should be used with some care.
>
Good point. I will update the patch to include such a note in the
documentation.

Thanks,
Longman

