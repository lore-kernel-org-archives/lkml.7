Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE462081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfEVRJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfEVRJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52168307D96D;
        Wed, 22 May 2019 17:08:58 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A21CB611A0;
        Wed, 22 May 2019 17:08:56 +0000 (UTC)
Subject: Re: [PATCH] modules: fix livelock in add_unformed_module()
To:     Barret Rhoden <brho@google.com>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
References: <be47ac01-a5ac-7be1-d387-5c841007b45f@google.com>
 <20190510184204.225451-1-brho@google.com>
 <dd48a3a4-9046-3917-55ba-d9eb391052b3@redhat.com>
 <d968a588-c43b-cfe1-6358-6c5d99f916a3@google.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <ba46f7c1-caee-4237-b6c5-7edec0eaaac3@redhat.com>
Date:   Wed, 22 May 2019 13:08:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d968a588-c43b-cfe1-6358-6c5d99f916a3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 22 May 2019 17:09:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/19 10:37 AM, Barret Rhoden wrote:
> Hi -
> 

Hey Barret, my apologies for not getting back to you earlier.  I got caught up
in something that took me away from this issue.

> On 5/13/19 7:23 AM, Prarit Bhargava wrote:
> [snip]
>> A module is loaded once for each cpu.
> 
> Does one CPU succeed in loading the module, and the others fail with EEXIST?
> 
>> My follow-up patch changes from wait_event_interruptible() to
>> wait_event_interruptible_timeout() so the CPUs are no longer sleeping and can
>> make progress on other tasks, which changes the return values from
>> wait_event_interruptible().
>>
>> https://marc.info/?l=linux-kernel&m=155724085927589&w=2
>>
>> I believe this also takes your concern into account?
> 
> That patch might work for me, but I think it papers over the bug where the check
> on old->state that you make before sleeping (was COMING || UNFORMED, now !LIVE)
> doesn't match the check to wake up in finished_loading().
> 
> The reason the issue might not show up in practice is that your patch basically
> polls, so the condition checks in finished_loading() are only a quicker exit.
> 
> If you squash my patch into yours, I think it will cover that case. Though if
> polling is the right answer here, it also raises the question of whether or not
> we even need finished_loading().
> 

The more I look at this I think you're right.  Let me do some additional testing
with your patch + my original patch.

P.


> Barret
