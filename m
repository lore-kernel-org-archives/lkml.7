Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E61C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE91F20830
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nZMtS8X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfJDOGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:06:19 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:50440 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388149AbfJDOGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:06:18 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 796F42E14C7;
        Fri,  4 Oct 2019 17:06:14 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Kz1vR6wPb5-6DN4Tx7N;
        Fri, 04 Oct 2019 17:06:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570197974; bh=DBfHEamxKvTx1Gir1cokMNTtd0g/hC8mtUDDJ9PbayI=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=nZMtS8X0K9sl17tuougE1rULdQXzuwqnfOkxfmWIvrNzQw8Zr0UJVwgETvLGzsF12
         KeZbIf8Jz2uYI7LQX+cMQKSVo/W/HCa0+Ab0C962s+iXo4xH3JsOtmgI5VPTy4I58/
         1gtqNTSyTVDZOU04hgxP0tLP8Hd8pVm8FHaUeHi8=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id FdBjul4HHu-6DI0MXcv;
        Fri, 04 Oct 2019 17:06:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] mm/swap: piggyback lru_add_drain_all() calls
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <157019456205.3142.3369423180908482020.stgit@buzz>
 <20191004131230.GL9578@dhcp22.suse.cz>
 <c1617cff-847f-4cbf-d314-0382a3e9233d@yandex-team.ru>
 <20191004133929.GN9578@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d2884a8d-2b0d-efba-8a23-5eff8e0fe27b@yandex-team.ru>
Date:   Fri, 4 Oct 2019 17:06:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004133929.GN9578@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 16.39, Michal Hocko wrote:
> On Fri 04-10-19 16:32:39, Konstantin Khlebnikov wrote:
>> On 04/10/2019 16.12, Michal Hocko wrote:
>>> On Fri 04-10-19 16:09:22, Konstantin Khlebnikov wrote:
>>>> This is very slow operation. There is no reason to do it again if somebody
>>>> else already drained all per-cpu vectors while we waited for lock.
>>>>
>>>> Piggyback on drain started and finished while we waited for lock:
>>>> all pages pended at the time of our enter were drained from vectors.
>>>>
>>>> Callers like POSIX_FADV_DONTNEED retry their operations once after
>>>> draining per-cpu vectors when pages have unexpected references.
>>>
>>> This describes why we need to wait for preexisted pages on the pvecs but
>>> the changelog doesn't say anything about improvements this leads to.
>>> In other words what kind of workloads benefit from it?
>>
>> Right now POSIX_FADV_DONTNEED is top user because it have to freeze page
>> reference when removes it from cache. invalidate_bdev calls it for same reason.
>> Both are triggered from userspace, so it's easy to generate storm.
>>
>> mlock/mlockall no longer calls lru_add_drain_all - I've seen here
>> serious slowdown on older kernel.
>>
>> There are some less obvious paths in memory migration/CMA/offlining
>> which shouldn't be called frequently.
> 
> Can you back those claims by any numbers?
> 

Well, worst case requires non-trivial workload because lru_add_drain_all
skips cpus where vectors are empty. Something must constantly generates
flow of pages at each cpu. Also cpus must be busy to make scheduling per-cpu
works slower. And machine must be big enough (64+ cpus in our case).

In our case that was massive series of mlock calls in map-reduce while other
tasks writes log (and generates flow of new pages in per-cpu vectors). Mlock
calls were serialized by mutex and accumulated latency up to 10 second and more.

Kernel does not call lru_add_drain_all on mlock paths since 4.15, but same scenario
could be triggered by fadvise(POSIX_FADV_DONTNEED) or any other remaining user.
