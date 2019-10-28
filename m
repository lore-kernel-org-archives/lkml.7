Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A68CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862BF2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="n+qrbaRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfJ1JJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:09:05 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:50508 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727586AbfJ1JJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:09:05 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 0116A2E14AA;
        Mon, 28 Oct 2019 12:09:02 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id rbmTkccsQ7-91B4gKqx;
        Mon, 28 Oct 2019 12:09:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572253741; bh=D1UY7YwBq9rLsS/3wP+8KKMkTRJDlUf3WbuEaKn64+M=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=n+qrbaRsk5wNnLikzwMb/2bgfiW8IzGPXqkx64cVRHEFMA4TcaEv6Yz4rY5q5u1RM
         X5Yt6vaySd5hSo1c+U7fyQITf2hSupsbyb1VJdQulNLLoYYNPcm++NtBti/DEbmpct
         K049T9ACgoR+F53zK6w9Y0jiAV7vPLmV4ZCR4HCQ=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by myt4-4db2488e778a.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2xr2VxYMpr-91V8rcYn;
        Mon, 28 Oct 2019 12:09:01 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] pipe: wakeup writer only if pipe buffer is at least half
 empty
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <157219118016.7078.16223055699799396042.stgit@buzz>
 <CAHk-=wjoTncMYdQFmY4yspKOUsDSNn1dHp1FWvJ0eRO94ZM3dQ@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <5b970999-c714-6bfb-0b02-ed206bafced4@yandex-team.ru>
Date:   Mon, 28 Oct 2019 12:09:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjoTncMYdQFmY4yspKOUsDSNn1dHp1FWvJ0eRO94ZM3dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2019 19.12, Linus Torvalds wrote:
> On Sun, Oct 27, 2019 at 11:46 AM Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>>
>> There is no reason to wakeup writer if pipe has only one empty page.
>> This means reader consumes data slower then writer produces it.
>>
>> This patch waits until buffer is at least half empty before waking writer.
> 
> This is a bit dangerous, at least with David's other changes.
> 
> In particular, there's now a "max_usage" in his series means that the
> writer might be blocked even if there's lots of free slots, because
> the writer is only allowed to use part of those slots.
> 
> So I'd rather not see this logic particularly now that David is
> working on modifying the overall pipe logic.
> 
> I do agree with the overall idea, but I'm not entirely happy about the
> "half full" logic, because it gets subtle with David's changes.
> 
> Also, I'm a bit worried about cases where the readers and writers
> block on each other, and depend on "there's enough space in the pipe
> that we won't deadlock". Maybe the writer is blocked (because it
> filled the pipe), the reader reads just part of the pipe, and then the
> reader blocks on the writer doing something else, knowing that it just
> free'd up resources for the writer. But the writer is still blocked,
> and not woken up, because the pipe is still more than half full. See
> what I'm saying?
> 
> I'm not sure anything like that exists, but it's an example of a "hmm"
> condition.
> 

Ok. This breakage scenario is doubtful but such weird software really might exist.

What about making this thing tunable via fcntl like size of pipe buffer?

fcntl(fd, F_SETPIPE_WRITE_SZ, size)
