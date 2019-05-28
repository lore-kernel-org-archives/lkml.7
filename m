Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE03C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C8020989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfE1Jul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:50:41 -0400
Received: from ozlabs.org ([203.11.71.1]:60637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfE1Juk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:50:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45CpxV1vzJz9s4V;
        Tue, 28 May 2019 19:50:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     jolsa@redhat.com, maddy@linux.vnet.ibm.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 1/2] perf ioctl: Add check for the sample_period value
In-Reply-To: <d2d34084-999d-9be2-511e-82625b80aa40@linux.ibm.com>
References: <20190511024217.4013-1-ravi.bangoria@linux.ibm.com> <20190513074213.GH2623@hirez.programming.kicks-ass.net> <20190513085620.GN2650@hirez.programming.kicks-ass.net> <d2d34084-999d-9be2-511e-82625b80aa40@linux.ibm.com>
Date:   Tue, 28 May 2019 19:50:37 +1000
Message-ID: <87h89eq55e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> On 5/13/19 2:26 PM, Peter Zijlstra wrote:
>> On Mon, May 13, 2019 at 09:42:13AM +0200, Peter Zijlstra wrote:
>>> On Sat, May 11, 2019 at 08:12:16AM +0530, Ravi Bangoria wrote:
>>>> Add a check for sample_period value sent from userspace. Negative
>>>> value does not make sense. And in powerpc arch code this could cause
>>>> a recursive PMI leading to a hang (reported when running perf-fuzzer).
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>> ---
>>>>  kernel/events/core.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>> index abbd4b3b96c2..e44c90378940 100644
>>>> --- a/kernel/events/core.c
>>>> +++ b/kernel/events/core.c
>>>> @@ -5005,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
>>>>  	if (perf_event_check_period(event, value))
>>>>  		return -EINVAL;
>>>>  
>>>> +	if (!event->attr.freq && (value & (1ULL << 63)))
>>>> +		return -EINVAL;
>>>
>>> Well, perf_event_attr::sample_period is __u64. Would not be the site
>>> using it as signed be the one in error?
>> 
>> You forgot to mention commit: 0819b2e30ccb9, so I guess this just makes
>> it consistent and is fine.
>> 
>
> Yeah, I was about to reply :)

I've taken patch 2. You should probably do a v2 of patch 1 with an
updated change log that explains things fully?

cheers
