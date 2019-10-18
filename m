Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E719CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3002064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634419AbfJRRD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634399AbfJRRD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63ED13083362;
        Fri, 18 Oct 2019 17:03:56 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 590365C21A;
        Fri, 18 Oct 2019 17:03:55 +0000 (UTC)
Subject: Re: [PATCH 00/16] The new slab memory controller
To:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Lameter <cl@linux.com>
References: <20191018002820.307763-1-guro@fb.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f3eb1843-8f10-1e7e-9cc7-9e0209c837ce@redhat.com>
Date:   Fri, 18 Oct 2019 13:03:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 18 Oct 2019 17:03:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/19 8:28 PM, Roman Gushchin wrote:
> The existing slab memory controller is based on the idea of replicating
> slab allocator internals for each memory cgroup. This approach promises
> a low memory overhead (one pointer per page), and isn't adding too much
> code on hot allocation and release paths. But is has a very serious flaw:
                                               ^it^
> it leads to a low slab utilization.
>
> Using a drgn* script I've got an estimation of slab utilization on
> a number of machines running different production workloads. In most
> cases it was between 45% and 65%, and the best number I've seen was
> around 85%. Turning kmem accounting off brings it to high 90s. Also
> it brings back 30-50% of slab memory. It means that the real price
> of the existing slab memory controller is way bigger than a pointer
> per page.
>
> The real reason why the existing design leads to a low slab utilization
> is simple: slab pages are used exclusively by one memory cgroup.
> If there are only few allocations of certain size made by a cgroup,
> or if some active objects (e.g. dentries) are left after the cgroup is
> deleted, or the cgroup contains a single-threaded application which is
> barely allocating any kernel objects, but does it every time on a new CPU:
> in all these cases the resulting slab utilization is very low.
> If kmem accounting is off, the kernel is able to use free space
> on slab pages for other allocations.

In the case of slub memory allocator, it is not just unused space within
a slab. It is also the use of per-cpu slabs that can hold up a lot of
memory, especially if the tasks jump around to different cpus. The
problem is compounded if a lot of memcgs are being used. Memory
utilization can improve quite significantly if per-cpu slabs are
disabled. Of course, it comes with a performance cost.

Cheers,
Longman

