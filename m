Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD96C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7582184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fONq6q23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbfGRPII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:08:08 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:44410 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbfGRPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:08:08 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 4DA4B2E14E5;
        Thu, 18 Jul 2019 18:08:05 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id eXvUEDwHGP-84N4WWpg;
        Thu, 18 Jul 2019 18:08:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563462485; bh=r+b1A4l2F9g/q3ITgDkPw72qBmDym1kZ98ZmcHn0K5o=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=fONq6q23F+TbpfJUloG+4AFtEiPFAzYalIZRoJbbZtzbwYfw3hOzrUGevBCgpBLt3
         1xSMeWyElu/EiB0c1Y+1qjl6d0f01J5sGN8KzRd1VKZmnVt2ItWA0zRZR1M8fp7vAM
         uWPWO5qTXUNSaNYmvs/LfFEkPVA88TEFptog/Nzc=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38d2:81d0:9f31:221f])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QzWFJEUVAn-84ISGi64;
        Thu, 18 Jul 2019 18:08:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 2/2] mm/memcontrol: split local and nested atomic
 vmstats/vmevents counters
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
References: <156336655741.2828.4721531901883313745.stgit@buzz>
 <156336655979.2828.15196553724473875230.stgit@buzz>
 <20190717175319.GB25882@cmpxchg.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <e768596e-f012-b8f0-ee3c-773abb7a3692@yandex-team.ru>
Date:   Thu, 18 Jul 2019 18:08:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717175319.GB25882@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2019 20:53, Johannes Weiner wrote:
> On Wed, Jul 17, 2019 at 03:29:19PM +0300, Konstantin Khlebnikov wrote:
>> This is alternative solution for problem addressed in commit 815744d75152
>> ("mm: memcontrol: don't batch updates of local VM stats and events").
>>
>> Instead of adding second set of percpu counters which wastes memory and
>> slows down showing statistics in cgroup-v1 this patch use two arrays of
>> atomic counters: local and nested statistics.
>>
>> Then update has the same amount of atomic operations: local update and
>> one nested for each parent cgroup. Readers of hierarchical statistics
>> have to sum two atomics which isn't a big deal.
>>
>> All updates are still batched using one set of percpu counters.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Yeah that looks better. Note that it was never about the atomics,
> though, but rather the number of cachelines dirtied. Your patch should
> solve this problem as well, but it might be a good idea to run
> will-it-scale on it to make sure the struct layout is still fine.
> 

Looks like this patch shows 2% regression for 24 core 2 numa node
machine I have. Compete remove of these counters gives 2% boost.
Also I cannot reproduce regression fixed by commit 815744d75152 - revert
have no effect.

So, feel free to ignore second patch. I'll play with this a little more.

Maybe atomic per-numa counters could give nice balance between scalability add overhead.
Ideally this memory could be mapped in per-cpu manner to give atomic access via fs/gs.
