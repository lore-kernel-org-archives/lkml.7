Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC844C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F51C20854
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XbZJbzsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfCFRVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:21:47 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:41888 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730446AbfCFRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:21:46 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id E64A720F87;
        Wed,  6 Mar 2019 20:21:41 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id vMCNxkEDHw-LfWePQ4l;
        Wed, 06 Mar 2019 20:21:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551892901; bh=svhR2/tX9+r+vH6MDX+JmfKjG9q28BbX70lOscStCEg=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=XbZJbzsUScdF1Bru+p5YH3fAQqaUh3dopdNAc45dKqWZt+9eVJwYi0IhrHGbIDIJT
         +oCud92s/7dxdlYTWWXoxUJao4sJTQ0OKwQd7y80lK38X+ygxfJ2lxyhv1kYAzFbPg
         EBkYNDHG6mq7U1fdQNr5pfaJy0lxq3Y4IpzmD0FI=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:60f::1:1f])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id GClj5OiKAj-Lf4qRK8H;
        Wed, 06 Mar 2019 20:21:41 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] sched/core: check format and overflows in cgroup2 cpu.max
To:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
References: <155125520155.293746.7017401430432481979.stgit@buzz>
 <20190305155741.GD50184@devbig004.ftw2.facebook.com>
 <4c0f1d90-b147-e1cd-20c1-0cdd869f4f15@yandex-team.ru>
 <20190306161154.GF50184@devbig004.ftw2.facebook.com>
 <20190306164825.GY32477@hirez.programming.kicks-ass.net>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <7c418d64-734e-000c-052a-f6fc59fdcf8e@yandex-team.ru>
Date:   Wed, 6 Mar 2019 20:21:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306164825.GY32477@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.2019 19:48, Peter Zijlstra wrote:
> On Wed, Mar 06, 2019 at 08:11:54AM -0800, Tejun Heo wrote:
>> Hello, Konstantin.
>>
>> On Tue, Mar 05, 2019 at 08:03:24PM +0300, Konstantin Khlebnikov wrote:
>>>> Ditto as the blkio patch.  Unless there is a correctness problem, my
>>>> preference is towards keeping the parsing functions simple and I don't
>>>> think the kernel needs to play the role of strict input verifier here
>>>> as long as the only foot getting shot is the user's own.
>>>
>>> IMHO non-strict interface more likely hides bugs and could cause
>>> problems for future changes.
>>>
>>> Here is only only one fatal bug - buffer overflow in sscanf because
>>> %s has no limit.
>>
>> Ah, indeed.  Can you please post a patch to fix that problem first?

Done.
Please see [PATCH] sched/core: fix buffer overflow in cgroup2 property cpu.max

>>
>>> Strict validation could be done as more strict sscanf variant or
>>> some kind of extension for format string.
>>
>> I don't necessarily disagree with you; however, what often ends up
>> with these manually crafted parsing approach are 1. code which is
>> unnecessarily difficult to follow 2. different subset of validations
>> and parsing bugs (of course) everywhere.
>>
>> Given the above, I tend to lean towards dump sscanf() parsing.  If we
>> wanna improve the situation, I think the right thing to do is either
>> improving sscanf or introducing new helpers to parse these things
>> rather than hand-crafting each site.  It is really error-prone.

I'm playing with sscanf right now.

Both problems (integer overflows and matching end of string)
are relatively easy to fix without breaking sane compatibility.

> 
> Always use a field width specifier with %s.  Which is exactly what the
> proposed patch did IIRC.
> 
> Maybe that's something checkpatch could warn about.
> 

This could be done mandatory.
In-kernel sscanf always requires width for "%[...]".
