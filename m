Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ECCC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D237218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfGCNMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCNMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:12:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92AF1308FEC6;
        Wed,  3 Jul 2019 13:12:19 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7702C1001B04;
        Wed,  3 Jul 2019 13:12:13 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
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
References: <20190702183730.14461-1-longman@redhat.com>
 <20190703065628.GK978@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9ade5859-b937-c1ac-9881-2289d734441d@redhat.com>
Date:   Wed, 3 Jul 2019 09:12:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703065628.GK978@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 03 Jul 2019 13:12:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/19 2:56 AM, Michal Hocko wrote:
> On Tue 02-07-19 14:37:30, Waiman Long wrote:
>> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
>> file to shrink the slab by flushing all the per-cpu slabs and free
>> slabs in partial lists. This applies only to the root caches, though.
>>
>> Extends this capability by shrinking all the child memcg caches and
>> the root cache when a value of '2' is written to the shrink sysfs file.
> Why do we need a new value for this functionality? I would tend to think
> that skipping memcg caches is a bug/incomplete implementation. Or is it
> a deliberate decision to cover root caches only?

It is just that I don't want to change the existing behavior of the
current code. It will definitely take longer to shrink both the root
cache and the memcg caches. If we all agree that the only sensible
operation is to shrink root cache and the memcg caches together. I am
fine just adding memcg shrink without changing the sysfs interface
definition and be done with it.

Cheers,
Longman

