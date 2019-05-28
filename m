Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D43C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A49C2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559054829;
	bh=vSyJqkwYTRKiEH0VlhA88IIdg2wVZfMrGoZmJeJjoWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=knNsL5tPd5W/hHunu4qOpXBtl58nCa7vfiRt8FOabUHO3Vqn8cSCjxLP/BWhYUgil
	 wgNltCSasP5AA8IuoE9kb82SXd0ERE6utGhiucyg/030rX4oMwV9e7zszEJkZmqA/v
	 ao4mKp3NyBrGxjoGqx25M3WEjlfev8VJh/k0w6YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE1OrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfE1OrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:47:07 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DCC20679;
        Tue, 28 May 2019 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559054826;
        bh=vSyJqkwYTRKiEH0VlhA88IIdg2wVZfMrGoZmJeJjoWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVm8rsqPESoCyUlxGj7NPlEu91jfMqIp1E94FykZjnsPEbwo4/CxtpMXg/k6D0/rr
         7tHn6UwbqvnicCYZFB9oS1t0h7hjKtGtQV2oxV575GIqaIm3Sw4AxvJHbnoXoOB1Az
         LBT05XRlncjF+eqExz3g5NI6hXmj9xb4Ewv9IS8o=
Date:   Tue, 28 May 2019 16:47:02 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Barret Rhoden <brho@google.com>, linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
Subject: Re: [PATCH] modules: fix livelock in add_unformed_module()
Message-ID: <20190528144702.GA3459@linux-8ccs>
References: <be47ac01-a5ac-7be1-d387-5c841007b45f@google.com>
 <20190510184204.225451-1-brho@google.com>
 <dd48a3a4-9046-3917-55ba-d9eb391052b3@redhat.com>
 <d968a588-c43b-cfe1-6358-6c5d99f916a3@google.com>
 <ba46f7c1-caee-4237-b6c5-7edec0eaaac3@redhat.com>
 <e5f7f37b-5c99-f9de-61ce-5b3394caf0d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e5f7f37b-5c99-f9de-61ce-5b3394caf0d2@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [28/05/19 10:30 -0400]:
>
>
>On 5/22/19 1:08 PM, Prarit Bhargava wrote:
>>
>>
>> On 5/13/19 10:37 AM, Barret Rhoden wrote:
>>> Hi -
>>>
>>
>> Hey Barret, my apologies for not getting back to you earlier.  I got caught up
>> in something that took me away from this issue.
>>
>>> On 5/13/19 7:23 AM, Prarit Bhargava wrote:
>>> [snip]
>>>> A module is loaded once for each cpu.
>>>
>>> Does one CPU succeed in loading the module, and the others fail with EEXIST?
>>>
>>>> My follow-up patch changes from wait_event_interruptible() to
>>>> wait_event_interruptible_timeout() so the CPUs are no longer sleeping and can
>>>> make progress on other tasks, which changes the return values from
>>>> wait_event_interruptible().
>>>>
>>>> https://marc.info/?l=linux-kernel&m=155724085927589&w=2
>>>>
>>>> I believe this also takes your concern into account?
>>>
>>> That patch might work for me, but I think it papers over the bug where the check
>>> on old->state that you make before sleeping (was COMING || UNFORMED, now !LIVE)
>>> doesn't match the check to wake up in finished_loading().
>>>
>>> The reason the issue might not show up in practice is that your patch basically
>>> polls, so the condition checks in finished_loading() are only a quicker exit.
>>>
>>> If you squash my patch into yours, I think it will cover that case. Though if
>>> polling is the right answer here, it also raises the question of whether or not
>>> we even need finished_loading().
>>>
>>
>> The more I look at this I think you're right.  Let me do some additional testing
>> with your patch + my original patch.
>>
>
>I have done testing on arm64, s390x, ppc64le, ppc64, and x86 and have not seen
>any issues.
>
>Jessica, how would you like me to proceed?  Would you like an updated patch with
>Signed-off's from both Barret & myself?

Hi Prarit,

A freshly sent patch with the squashed changes and Signed-off's would
be great. Thank you both for testing and looking into this!

Jessica
