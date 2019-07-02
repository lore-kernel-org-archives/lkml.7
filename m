Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A479C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E462184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGBSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBSlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:41:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5141558E5B;
        Tue,  2 Jul 2019 18:41:45 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7901A60C44;
        Tue,  2 Jul 2019 18:41:43 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
To:     Michal Hocko <mhocko@kernel.org>
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
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-3-longman@redhat.com>
 <20190627151506.GE5303@dhcp22.suse.cz>
 <5cb05d2c-39a7-f138-b0b9-4b03d6008999@redhat.com>
 <20190628073128.GC2751@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <eeca4ef9-1b62-dada-3d31-c247cb0b137f@redhat.com>
Date:   Tue, 2 Jul 2019 14:41:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628073128.GC2751@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 02 Jul 2019 18:41:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/19 3:31 AM, Michal Hocko wrote:
> On Thu 27-06-19 17:16:04, Waiman Long wrote:
>> On 6/27/19 11:15 AM, Michal Hocko wrote:
>>> On Mon 24-06-19 13:42:19, Waiman Long wrote:
>>>> With the slub memory allocator, the numbers of active slab objects
>>>> reported in /proc/slabinfo are not real because they include objects
>>>> that are held by the per-cpu slab structures whether they are actually
>>>> used or not.  The problem gets worse the more CPUs a system have. For
>>>> instance, looking at the reported number of active task_struct objects,
>>>> one will wonder where all the missing tasks gone.
>>>>
>>>> I know it is hard and costly to get a real count of active objects.
>>> What exactly is expensive? Why cannot slabinfo reduce the number of
>>> active objects by per-cpu cached objects?
>>>
>> The number of cachelines that needs to be accessed in order to get an
>> accurate count will be much higher if we need to iterate through all the
>> per-cpu structures. In addition, accessing the per-cpu partial list will
>> be racy.
> Why is all that a problem for a root only interface that should be used
> quite rarely (it is not something that you should be reading hundreds
> time per second, right)?

That can be true. Anyway, I have posted a new patch to use the existing
<slab>/shrink sysfs file to perform memcg cache shrinking as well. So I
am not going to pursue this patch.

Thanks,
Longman

