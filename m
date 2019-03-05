Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0990C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAEA20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WGrJxuXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCERD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:03:29 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:35361 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbfCERD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:03:29 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id A70382172C;
        Tue,  5 Mar 2019 20:03:25 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ONzywnqZWe-3PZmkE0p;
        Tue, 05 Mar 2019 20:03:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551805405; bh=Efq7zsOnvkFWdyEnDBSMbThgQ/W7bl+NeEp+4pmYK2w=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=WGrJxuXJcHLd8tFO6odNGkuNhRXbe41D44BFr6nUhZ9GLD6Cw6RgcV1OsCNrObs6k
         SOrDZ1TW0p9GCBjIiQm53jQZ7/C4BcPC/9F5sWs2JoBcWoK7q8nYJRJWBEITowPnMF
         oZuzT4/nrgK2Xf6rTqXAcwQGZZBK2/zyCj6aiSR0=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:f9d0:8381:2ca:ee7b])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id s2LJCjtbst-3PoWKeW6;
        Tue, 05 Mar 2019 20:03:25 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] sched/core: check format and overflows in cgroup2 cpu.max
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
References: <155125520155.293746.7017401430432481979.stgit@buzz>
 <20190305155741.GD50184@devbig004.ftw2.facebook.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <4c0f1d90-b147-e1cd-20c1-0cdd869f4f15@yandex-team.ru>
Date:   Tue, 5 Mar 2019 20:03:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305155741.GD50184@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.03.2019 18:57, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 27, 2019 at 11:13:21AM +0300, Konstantin Khlebnikov wrote:
>> Cgroup2 interface for cpu bandwidth limit has some flaws:
>>
>> - on stack buffer overflow
>> - no checks for valid format or trailing garbage
>> - no checks for integer overflows
>>
>> This patch fixes all these flaws.
> 
> Ditto as the blkio patch.  Unless there is a correctness problem, my
> preference is towards keeping the parsing functions simple and I don't
> think the kernel needs to play the role of strict input verifier here
> as long as the only foot getting shot is the user's own.

IMHO non-strict interface more likely hides bugs and could cause problems for future changes.

Here is only only one fatal bug - buffer overflow in sscanf because %s has no limit.

Strict validation could be done as more strict sscanf variant or some kind of extension for format string.

> 
> Thanks.
> 
