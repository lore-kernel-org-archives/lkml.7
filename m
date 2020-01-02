Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C48C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5A021655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt3WWU13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgABUMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:12:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43422 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725783AbgABUMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577995962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmwpBc1ws8gg87hNBNAq54BxB72ENM/Su9oYjBh/O1w=;
        b=Mt3WWU13A4C2x6NSfyCPkdaAEamOFd0gtYdt9JIKF4VOrYwMGc6Y8YKdz8ffq0lsicJHCB
        dde6IkDTi6JRf+dHs+JIVgAJcvfD3OXF5TUBQ9f0XQ5NVo3MuxHQgNLQtpEdQUGG+Hj6V0
        bxRpoMa78ju1U/usfbVziLDWkm+LCtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-2covikjdPKqRnHQA_tQ2Mg-1; Thu, 02 Jan 2020 15:12:39 -0500
X-MC-Unique: 2covikjdPKqRnHQA_tQ2Mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B76A9107ACC4;
        Thu,  2 Jan 2020 20:12:37 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E3925D9C9;
        Thu,  2 Jan 2020 20:12:37 +0000 (UTC)
Subject: Re: [PATCH] watchdog: Fix possible soft lockup warning at bootup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
References: <20200102154149.7564-1-longman@redhat.com>
 <20200102120817.d1c289313747cfde7270076f@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <044ac2d7-1dee-46a9-93ba-31645ec2f8a1@redhat.com>
Date:   Thu, 2 Jan 2020 15:12:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200102120817.d1c289313747cfde7270076f@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/20 3:08 PM, Andrew Morton wrote:
> On Thu,  2 Jan 2020 10:41:49 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> It was found that watchdog soft lockup warning was displayed on some
>> arm64 server systems at bootup time:
>>
>> ...
>>
>> Further analysis of the situation revealed that the smp_init() call
>> itself took more than 20s for that 2-socket 56-core and 224-thread
>> server.
>>
>>  [    0.115632] CPU1: Booted secondary processor 0x0000000100 [0x431f0af1]
>>    :
>>  [   27.177282] CPU223: Booted secondary processor 0x0000011b03 [0x431f0af1]
>>
>> By adding some instrumentation code, it was found that for cpu 14,
>> watchdog_enable() was called early with a timestamp of 1. The first
>> watchdog timer callback for that cpu, however, happened really late at
>> the above 25s timestamp mark causing the watchdog logic to treat the
>> delay as a soft lockup.
>>
>> On another arm64 system that doesn't show the soft lockup warning, the
>> watchdog timer callback happened earlier at the 5s timestamp mark with
>> the watchdog thread invoked shortly after that.
>>
>> The reason why there was such a delay in the first watchdog timer
>> callback for that particular system wasn't fully known yet.
> Mysteries are unwelcome.  Are you continuing to investigate this?
Yes, I will do some more investigation as to why it took so long.
>> Given
>> the fact that smp_init() can run for a long time on some systems,
>> it is probably more appropriate to enable the watchdog function after
>> smp_init() instead of before it.
>>
>> Another way is to leave watchdog_touch_ts at 0 in watchdog_enable()
>> while the system is at the booting stage. Either one of those should
>> be able to eliminate the soft lockup warning on bootup.
>>
>> ...
>>
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -496,7 +496,9 @@ static void watchdog_enable(unsigned int cpu)
>>  		      HRTIMER_MODE_REL_PINNED_HARD);
>>  
>>  	/* Initialize timestamp */
>> -	__touch_watchdog();
>> +	if (system_state != SYSTEM_BOOTING)
>> +		__touch_watchdog();
> A comment which explains the system_state test would be appropriate
> here.

Will do so.

>>  	/* Enable the perf event */
>>  	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
>>  		watchdog_nmi_enable(cpu);

Cheers,
Longman

