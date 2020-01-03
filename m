Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3405C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C754E22B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKXiWZv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgACPRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:17:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57725 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727646AbgACPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578064627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKAaHNjytSdT8rosbQETjCGcSaOZoNcBhl7ioM0dWIg=;
        b=BKXiWZv3g2DDGiAduZ+aCT/WoUyjyS5jHcA49vKoDLoZioY1aCdwutXHCWjsmkcxApQkV2
        ozYLSgZnj7hHc7r+kIUMtH0uEPqa+UkYIDybAwfw8f0YRsc2Kz3NY9tLwKSkUGfTWM1Dvf
        O4bQbF+f8A74s9bVOb3baUxNoKA5aL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-fPoBMCM-NIWKQx2NJ3SBhQ-1; Fri, 03 Jan 2020 10:17:04 -0500
X-MC-Unique: fPoBMCM-NIWKQx2NJ3SBhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5508E107ACC5;
        Fri,  3 Jan 2020 15:17:03 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-142.rdu2.redhat.com [10.10.122.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7592E7BA3A;
        Fri,  3 Jan 2020 15:17:02 +0000 (UTC)
Subject: Re: [PATCH] watchdog: Fix possible soft lockup warning at bootup
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
References: <20200102154149.7564-1-longman@redhat.com>
 <20200102120817.d1c289313747cfde7270076f@linux-foundation.org>
 <044ac2d7-1dee-46a9-93ba-31645ec2f8a1@redhat.com>
Organization: Red Hat
Message-ID: <a94d109e-7253-3368-7ae7-344a546fbb23@redhat.com>
Date:   Fri, 3 Jan 2020 10:17:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <044ac2d7-1dee-46a9-93ba-31645ec2f8a1@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/20 3:12 PM, Waiman Long wrote:
> On 1/2/20 3:08 PM, Andrew Morton wrote:
>> On Thu,  2 Jan 2020 10:41:49 -0500 Waiman Long <longman@redhat.com> wrote:
>>
>>> It was found that watchdog soft lockup warning was displayed on some
>>> arm64 server systems at bootup time:
>>>
>>> ...
>>>
>>> Further analysis of the situation revealed that the smp_init() call
>>> itself took more than 20s for that 2-socket 56-core and 224-thread
>>> server.
>>>
>>>  [    0.115632] CPU1: Booted secondary processor 0x0000000100 [0x431f0af1]
>>>    :
>>>  [   27.177282] CPU223: Booted secondary processor 0x0000011b03 [0x431f0af1]
>>>
>>> By adding some instrumentation code, it was found that for cpu 14,
>>> watchdog_enable() was called early with a timestamp of 1. The first
>>> watchdog timer callback for that cpu, however, happened really late at
>>> the above 25s timestamp mark causing the watchdog logic to treat the
>>> delay as a soft lockup.
>>>
>>> On another arm64 system that doesn't show the soft lockup warning, the
>>> watchdog timer callback happened earlier at the 5s timestamp mark with
>>> the watchdog thread invoked shortly after that.
>>>
>>> The reason why there was such a delay in the first watchdog timer
>>> callback for that particular system wasn't fully known yet.
>> Mysteries are unwelcome.  Are you continuing to investigate this?
> Yes, I will do some more investigation as to why it took so long.

As stated in my v2 patch, the soft lockup problem is caused by a clock
slowdown in during the init_smp() call. This is likely to be hardware
specific and I don't have enough information about the hardware to do an
in-depth investigation of this slow down. So I opt to do just a delay of
the init call as a workaround.


>>> Given
>>> the fact that smp_init() can run for a long time on some systems,
>>> it is probably more appropriate to enable the watchdog function after
>>> smp_init() instead of before it.
>>>
>>> Another way is to leave watchdog_touch_ts at 0 in watchdog_enable()
>>> while the system is at the booting stage. Either one of those should
>>> be able to eliminate the soft lockup warning on bootup.
>>>
>>> ...
>>>
>>> --- a/kernel/watchdog.c
>>> +++ b/kernel/watchdog.c
>>> @@ -496,7 +496,9 @@ static void watchdog_enable(unsigned int cpu)
>>>  		      HRTIMER_MODE_REL_PINNED_HARD);
>>>  
>>>  	/* Initialize timestamp */
>>> -	__touch_watchdog();
>>> +	if (system_state != SYSTEM_BOOTING)
>>> +		__touch_watchdog();
>> A comment which explains the system_state test would be appropriate
>> here.
> Will do so.

This change is not actually necessary. So it is taken out from the v2 patch.

Cheers,
Longman

