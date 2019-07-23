Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40963C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2FC218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="HNHBMNej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbfGWPIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:08:16 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:47638 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731767AbfGWPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:08:16 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 7A6852E14C4;
        Tue, 23 Jul 2019 18:08:12 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BcxYFxZnla-8C5OPgk9;
        Tue, 23 Jul 2019 18:08:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563894492; bh=FfrxMQ3/T40zfvxNCGGC0/I3Mfe2Uti/Lqf5PFT3euA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=HNHBMNejDDlRT6ijLfCzFFUZUdrRW37pxt3V2UsNhzRWpGEUvNSKvDuUsqFkxyJaD
         1dFNt/Rb8TfB7NU47v4Z2JD/H5+jB4W0iSAMt5lzmPHleP288f2mALmnfxFsqpBTap
         w4I+vqMMq2yVVAJwf/2cw5QYy/cGqDssNSnrrK54=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38b3:1cdf:ad1a:1fe1])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id dHFoLqHukc-8BIauBFl;
        Tue, 23 Jul 2019 18:08:12 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] mm/page_idle: simple idle page tracking for virtual
 memory
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <156388286599.2859.5353604441686895041.stgit@buzz>
 <20190723134647.GA104199@google.com>
 <53719394-2679-81ae-686e-c138522c0dfc@yandex-team.ru>
 <20190723142547.GD104199@google.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <056496c5-d87f-9ac0-a325-c0b0fb6a1f05@yandex-team.ru>
Date:   Tue, 23 Jul 2019 18:08:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723142547.GD104199@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2019 17:25, Joel Fernandes wrote:
> On Tue, Jul 23, 2019 at 04:59:07PM +0300, Konstantin Khlebnikov wrote:
>>
>>
>> On 23.07.2019 16:46, Joel Fernandes wrote:
>>> On Tue, Jul 23, 2019 at 02:54:26PM +0300, Konstantin Khlebnikov wrote:
>>>> The page_idle tracking feature currently requires looking up the pagemap
>>>> for a process followed by interacting with /sys/kernel/mm/page_idle.
>>>> This is quite cumbersome and can be error-prone too. If between
>>>> accessing the per-PID pagemap and the global page_idle bitmap, if
>>>> something changes with the page then the information is not accurate.
>>>> More over looking up PFN from pagemap in Android devices is not
>>>> supported by unprivileged process and requires SYS_ADMIN and gives 0 for
>>>> the PFN.
>>>>
>>>> This patch adds simplified interface which works only with mapped pages:
>>>> Run: "echo 6 > /proc/pid/clear_refs" to mark all mapped pages as idle.
>>>> Pages that still idle are marked with bit 57 in /proc/pid/pagemap.
>>>> Total size of idle pages is shown in /proc/pid/smaps (_rollup).
>>>>
>>>> Piece of comment is stolen from Joel Fernandes <joel@joelfernandes.org>
>>>
>>> This will not work well for the problem at hand, the heap profiler
>>> (heapprofd) only wants to clear the idle flag for the heap memory area which
>>> is what it is profiling. There is no reason to do it for all mapped pages.
>>> Using the /proc/pid/page_idle in my patch, it can be done selectively for
>>> particular memory areas.
>>>
>>> I had previously thought of having an interface that accepts an address
>>> range to set the idle flag, however that is also more complexity.
>>
>> Profiler could look into particular area in /proc/pid/smaps
>> or count idle pages via /proc/pid/pagemap.
>>
>> Selective /proc/pid/clear_refs is not so hard to add.
>> Somthing like echo "6 561214d03000-561214d29000" > /proc/pid/clear_refs
>> might be useful for all other operations.
> 
> This seems really odd of an interface. Also I don't see how you can avoid
> looking up reverse maps to determine if a page is really idle.

This pretty straight forward format if you look into /proc/pid/maps and others.
Parsing is trivial - just one sscanf().

If we are looking for abandoned pages in particular proces it is enough to
mark page idle and look at access bit in this process.

If page is shared and got foreign access -- it is not abandoned.
And some information could be retrieved right from pagemap: file/anon and
exclusive-map bits.

> 
> What is also more odd is that traditionally clear_refs does interfere with
> reclaim due to clearing of accessed bit. Now you have one of the interfaces
> with clear_refs that does not interfere with reclaim. That is makes it very
> inconsistent. Also in this patch you have 2 interfaces to solve this, where
> as my patch added a single clean interface that is easy to use and does not
> need parsing of address ranges.

Your patch adds yet another per-task proc file which requires special tool.

My just extends existing interface and useful without any tools: just echo and cat.
And yet, special tool could get precise per-page information in binary form
along with other useful bits from /proc/pid/pagemap.

> 
> All in all, I don't see much the point of this honestly. But thanks for
> poking at it.
> 
> thanks,
> 
>   - Joel
> 
