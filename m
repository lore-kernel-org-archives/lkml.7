Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBB9C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CB620873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfGROhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGROhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C258C09AD0F;
        Thu, 18 Jul 2019 14:37:02 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14D3660576;
        Thu, 18 Jul 2019 14:36:59 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm, slab: Show last shrink time in us when
 slab/shrink is read
To:     Christopher Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190717202413.13237-1-longman@redhat.com>
 <20190717202413.13237-3-longman@redhat.com>
 <0100016c04e1562a-e516c595-1d46-40df-ab29-da1709277e9a-000000@email.amazonses.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6fb9f679-02d1-c33f-2d79-4c2eaa45d264@redhat.com>
Date:   Thu, 18 Jul 2019 10:36:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0100016c04e1562a-e516c595-1d46-40df-ab29-da1709277e9a-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 18 Jul 2019 14:37:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/19 7:39 AM, Christopher Lameter wrote:
> On Wed, 17 Jul 2019, Waiman Long wrote:
>
>> The show method of /sys/kernel/slab/<slab>/shrink sysfs file currently
>> returns nothing. This is now modified to show the time of the last
>> cache shrink operation in us.
> What is this useful for? Any use cases?

I got query about how much time will the slab_mutex be held when
shrinking the cache. I don't have a solid answer as it depends on how
many memcg caches are there. This patch is a partial answer to that as
it give a rough upper bound of the lock hold time.


>> CONFIG_SLUB_DEBUG depends on CONFIG_SYSFS. So the new shrink_us field
>> is always available to the shrink methods.
> Aside from minimal systems without CONFIG_SYSFS... Does this build without
> CONFIG_SYSFS?

The sysfs code in mm/slub.c is guarded by CONFIG_SLUB_DEBUG which, in
turn, depends on CONFIG_SYSFS. So if CONFIG_SYSFS is off, the shrink
sysfs methods will be off as well. I haven't tried doing a minimal
build. I will certainly try that, but I don't expect any problem here.

Cheers,
Longman

