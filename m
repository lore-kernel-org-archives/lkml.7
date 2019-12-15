Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF227C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E84206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHPlmjxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLORGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:06:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbfLORGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 12:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576429570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEv91kLJC9ETqzd67UpOFEgC9D5e9yBJ8rM6VNAM6/0=;
        b=BHPlmjxe6EscIu0yrQUB3Kl/BvQYNBJEp0yWHA7VLInScMuKOJVhAFG8fEEnG7hUOYXGIH
        LOfuvOb8xZYsbaLWBO6KEGfYFd7gQncRBfbk6yd/dhNWX6/0Qs6ueiO7ftLVC5i6wesi0y
        ACNkX+pyQpgBNd8XK7YV2AiA4chTcGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-0Q0brOK4PdiyCiMNpib7jw-1; Sun, 15 Dec 2019 12:06:06 -0500
X-MC-Unique: 0Q0brOK4PdiyCiMNpib7jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2C3918543A0;
        Sun, 15 Dec 2019 17:06:05 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 400DE7A5FD;
        Sun, 15 Dec 2019 17:06:05 +0000 (UTC)
Subject: Re: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191212223525.1652-1-longman@redhat.com>
 <20191212223525.1652-5-longman@redhat.com>
 <20191213102525.GA2844@hirez.programming.kicks-ass.net>
 <20191213105042.GJ2871@hirez.programming.kicks-ass.net>
 <9a79ef1a-96e0-1fd7-97e8-ef854b08524d@redhat.com>
 <20191213181255.GF2844@hirez.programming.kicks-ass.net>
 <7ca26a9a-003f-6f24-08e4-f01b80e3e962@redhat.com>
 <20191213184759.GH2844@hirez.programming.kicks-ass.net>
 <2763959e-b0e9-a8cd-3468-232d128c8260@redhat.com>
Organization: Red Hat
Message-ID: <1f680c85-c338-6a9e-01f4-d1f6a36e0c6f@redhat.com>
Date:   Sun, 15 Dec 2019 12:06:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2763959e-b0e9-a8cd-3468-232d128c8260@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 3:08 PM, Waiman Long wrote:
> On 12/13/19 1:47 PM, Peter Zijlstra wrote:
>> On Fri, Dec 13, 2019 at 01:35:05PM -0500, Waiman Long wrote:
>>> On 12/13/19 1:12 PM, Peter Zijlstra wrote:
>>>>> In this way, the wasted space will be k bytes where k is the number of
>>>>> 1-entry chains. I don't think merging adjacent blocks will be that
>>>>> useful at this point. We can always add this capability later on if it
>>>>> is found to be useful.
>>>> I'm thinking 1 entry isn't much of a chain. My brain is completely fried
>>>> atm, but are we really storing single entry 'chains' ? It seems to me we
>>>> could skip that.
>>>>
>>> Indeed, the current code can produce a 1-entry chain. I also thought
>>> that a chain had to be at least 2 entries. I got tripped up assuming
>>> that. It could be a bug somewhere that allow a 1-entry chain to happen,
>>> but I am not focusing on that right now.
>> If we need the minimum 2 entry granularity, it might make sense to spend
>> a little time on that. If we can get away with single entry markers,
>> then maybe write a comment so we'll not forget about it.
>>
> I will take a look at why an 1-entry chain happes and see if it is a bug
> that need to be fixed.

New lock chains are stored as part of the validate_chain() call from
__lock_acquire(). So for a n-entry lock chain, all previous n-1, n-2,
... 1 entry lock chains are stored as well. That may not be the most
efficient way to store the information, but it is simple. When booting
up a 2-socket x86-64 system, I saw about 800 1-entry lock chains being
stored.

Since I am planning to enforce a minimum of 2 chain_hlocks entry
allocation, we can theoretically allow a 1-entry chain to share the same
storage with a 2-entry chains with the same starting lock. That will add
a bit more code in the allocation and freeing path. I am not planning to
do that for this patchset, but may consider it as a follow up patch.

Cheers,
Longman

