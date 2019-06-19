Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5293C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7D3204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfFSPrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfFSPrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:47:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42C843078AA0;
        Wed, 19 Jun 2019 15:47:42 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DEEF19C6F;
        Wed, 19 Jun 2019 15:47:40 +0000 (UTC)
Subject: Re: [PATCH] mm, memcg: Add a memcg_slabinfo debugfs file
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190619144610.12520-1-longman@redhat.com>
 <CALvZod5yHbtYe2x3TGQKGtxjvTDpAGjvSc8Pvphbn00pdRfs2g@mail.gmail.com>
 <20831975-590f-ecab-53db-5d7e6b1a053f@redhat.com>
 <CALvZod6T31z2P+wdUz3LVYO3dTSbOc89cKDn=8LKpN+ZovL8jw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a33fba37-ef61-8179-9994-df7e04cc5866@redhat.com>
Date:   Wed, 19 Jun 2019 11:47:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6T31z2P+wdUz3LVYO3dTSbOc89cKDn=8LKpN+ZovL8jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 19 Jun 2019 15:47:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/19 11:35 AM, Shakeel Butt wrote:
> On Wed, Jun 19, 2019 at 8:30 AM Waiman Long <longman@redhat.com> wrote:
>> On 6/19/19 11:18 AM, Shakeel Butt wrote:
>>> On Wed, Jun 19, 2019 at 7:46 AM Waiman Long <longman@redhat.com> wrote:
>>>> There are concerns about memory leaks from extensive use of memory
>>>> cgroups as each memory cgroup creates its own set of kmem caches. There
>>>> is a possiblity that the memcg kmem caches may remain even after the
>>>> memory cgroup removal. Therefore, it will be useful to show how many
>>>> memcg caches are present for each of the kmem caches.
>>>>
>>>> This patch introduces a new <debugfs>/memcg_slabinfo file which is
>>>> somewhat similar to /proc/slabinfo in format, but lists only slabs that
>>>> are in memcg kmem caches. Information available in /proc/slabinfo are
>>>> not repeated in memcg_slabinfo.
>>>>
>>> At Google, we have an interface /proc/slabinfo_full which shows each
>>> kmem cache (root and memcg) on a separate line i.e. no accumulation.
>>> This interface has helped us a lot for debugging zombies and memory
>>> leaks. The name of the memcg kmem caches include the memcg name, css
>>> id and "dead" for offlined memcgs. I think these extra information is
>>> much more useful for debugging. What do you think?
>>>
>>> Shakeel
>> Yes, I think that can be a good idea. My only concern is that it can be
>> very verbose. Will work on a v2 patch.
>>
> Yes, it is very verbose but it is only for debugging and normal users
> should not be (continuously) reading that interface.

I am not against it. It is just an observation. I still think we can
skip kmem caches that don't have any child memcg caches as the
information is in slabinfo already.

Cheers,
Longman

