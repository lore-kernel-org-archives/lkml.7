Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F08AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF7422365
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfKTHSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:18:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:41648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbfKTHSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:18:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C29A8B237;
        Wed, 20 Nov 2019 07:18:51 +0000 (UTC)
Subject: Re: [Xen-devel] Ping: [PATCH 0/2] x86/Xen/32: xen_iret_crit_fixup
 adjustments
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
 <09359c00-5769-0e0d-4af9-963897d3b498@suse.com>
 <40267a5b-8f1b-6463-72cd-f8f354c58bc4@oracle.com>
 <6d70b8e0-7acd-d8ea-fa41-6866ae1ffef9@oracle.com>
 <b308b5ab-7b25-414a-6153-8c4f70b1c6a1@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <1c35e9f9-d46a-b15e-84b0-b6018fbef6e7@suse.com>
Date:   Wed, 20 Nov 2019 08:18:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <b308b5ab-7b25-414a-6153-8c4f70b1c6a1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2019 03:39, Boris Ostrovsky wrote:
> On 11/19/19 9:17 PM, Boris Ostrovsky wrote:
>> On 11/19/19 12:50 PM, Boris Ostrovsky wrote:
>>> On 11/19/19 7:58 AM, Jan Beulich wrote:
>>>> On 11.11.2019 15:30, Jan Beulich wrote:
>>>>> The first patch here fixes another regression from 3c88c692c287
>>>>> ("x86/stackframe/32: Provide consistent pt_regs"), besides the
>>>>> one already addressed by
>>>>> https://lists.xenproject.org/archives/html/xen-devel/2019-10/msg01988.html.
>>>>> The second patch is a minimal bit of cleanup on top.
>>>>>
>>>>> 1: make xen_iret_crit_fixup independent of frame layout
>>>>> 2: simplify xen_iret_crit_fixup's ring check
>>>> Seeing that the other regression fix has been taken into -tip,
>>>> what is the situation here? Should 5.4 really ship with this
>>>> still unfixed?
>>> I am still unable to boot a 32-bit guest with those patches, crashing in
>>> int3_exception_notify with regs->sp zero.
>>>
>>> When I revert to 3c88c692c287 the guest actually boots so my (?) problem
>>> was introduced somewhere in-between.
>> Nevermind this. I didn't read your patches correctly.
> 
> BTW, I'd rather this not go into 5.4 this late. 3c88c692c287 has been
> there since 5.2 and noone complained.

Afaict the issues were introduced in 5.3, and my first patch (including
a note [complaint if you will] of the second issue) was sent around
5.4-rc2. This has been blocking osstest's linux-linus forever since, so
even without my mail everyone could have been aware by paying attention
to the flight reports (the bisection ones, unfortunately, are pretty
useless here, as in cases like this one they seem to tend to point at
huge merge commits).

Jan
