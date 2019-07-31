Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC53C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB51F20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob6jGBDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfGaXC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:02:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36615 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfGaXC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:02:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so32687039pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zSVovo+uXXKjFUzeHTWvaVn3AHj2z5CjONfRFgl2zMQ=;
        b=ob6jGBDG2FtVWJUzRTWzcgq1bInGQBbB+nYFic1RH2q96FC5J3gJ/O4GJhBs0Cp8P4
         rFxRx9g3zbqapWDQFi7kPYyb+2J6ct2ilFxg8SYsdrEYHDe7Vv/s3D6OSKvqNwwpFHaf
         URdzbbJXedWJPKqy9Ggs20Y09YqXPTCzVRVfqMAIu0dbaf5DY4L6hyMFxvpQ6riA1+7U
         AICuYlz9jpdKrUVW6dGS02tU/nL2G5VXXtQBkB9SluQOjGRjmmPAaGEqyIKcrq4HliyQ
         EMlInAACSPZ2A2URGXMVRcV76ENqCz3DwUEAYgOymfxURNDUdxNNyuQS4qv3HnRfKU00
         +B9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zSVovo+uXXKjFUzeHTWvaVn3AHj2z5CjONfRFgl2zMQ=;
        b=pm4ub263drU1WZWTliyHAfS3yLRhruLy9OAv+nVsi2BavxQTzppSqLYdzibb0GLwDD
         /JchxKdEmkrZPnGMDo6xOdvDWYp6rfx1Gnc8HYK0e9DnJkwe7hWg+AO/P3BEL92TNDsm
         6WQYmDm5w4QIKvQlMZv1hvxj+mlhlh/RXL4pqmJOJWPpP7x58KUMPzNqU2b7Qx20xdu6
         2X1Nx2/6oCreA5kBoxyzlj2p1+EAP+YeCThXcSDQtKlHPihHyXXpF1NnDCZmdMdr0vo/
         gCUHlsxBQHqXUjqdRR9HSGQ4BMg7Rw0hr2iyMEKAmtjdcCyAp3u+kPONewOApqm6771R
         TyXA==
X-Gm-Message-State: APjAAAXRt09H1uufxsEx/Ti+G0nmI2MeO4ELmv65MFDRgevNp1FW2OsE
        0DQjnvvSkhPUR1uox8cEoms=
X-Google-Smtp-Source: APXvYqz78G2WOLMSVmFLdvovam4oev6GJYgu69W0dyo8fh2AWEAivD1x39JqD0sGgIDa4wITJrkz5w==
X-Received: by 2002:a65:534c:: with SMTP id w12mr116147200pgr.51.1564614147597;
        Wed, 31 Jul 2019 16:02:27 -0700 (PDT)
Received: from [10.69.137.114] ([50.228.72.82])
        by smtp.gmail.com with ESMTPSA id s66sm73638084pfs.8.2019.07.31.16.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 16:02:27 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        viro@zeniv.linux.org.uk, jannh@google.com
References: <20190730220602.28781-1-krisman@collabora.com>
 <20190730220602.28781-2-krisman@collabora.com>
 <20190731120600.GT31381@hirez.programming.kicks-ass.net>
 <306b3332-0065-59dc-e6d6-ee3c8a67ef53@gmail.com>
 <alpine.DEB.2.21.1908010038040.1788@nanos.tec.linutronix.de>
From:   Zebediah Figura <z.figura12@gmail.com>
Message-ID: <e0097ca1-5f09-41da-7c6b-80efbba58ab0@gmail.com>
Date:   Wed, 31 Jul 2019 18:02:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908010038040.1788@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 5:39 PM, Thomas Gleixner wrote:
> On Wed, 31 Jul 2019, Zebediah Figura wrote:
>> On 7/31/19 7:06 AM, Peter Zijlstra wrote:
>>> On Tue, Jul 30, 2019 at 06:06:02PM -0400, Gabriel Krisman Bertazi wrote:
>>>> This is a new futex operation, called FUTEX_WAIT_MULTIPLE, which allows
>>>> a thread to wait on several futexes at the same time, and be awoken by
>>>> any of them.  In a sense, it implements one of the features that was
>>>> supported by pooling on the old FUTEX_FD interface.
>>>>
>>>> My use case for this operation lies in Wine, where we want to implement
>>>> a similar interface available in Windows, used mainly for event
>>>> handling.  The wine folks have an implementation that uses eventfd, but
>>>> it suffers from FD exhaustion (I was told they have application that go
>>>> to the order of multi-milion FDs), and higher CPU utilization.
>>>
>>> So is multi-million the range we expect for @count ?
>>>
>>
>> Not in Wine's case; in fact Wine has a hard limit of 64 synchronization
>> primitives that can be waited on at once (which, with the current user-side
>> code, translates into 65 futexes). The exhaustion just had to do with the
>> number of primitives created; some programs seem to leak them badly.
> 
> And how is the futex approach better suited to 'fix' resource leaks?
> 

The crucial constraints for implementing Windows synchronization 
primitives in Wine are that (a) it must be possible to access them from 
multiple processes and (b) it must be possible to wait on more than one 
at a time.

The current best solution for this, performance-wise, backs each Windows 
synchronization primitive with an eventfd(2) descriptor and uses poll(2) 
to select on them. Windows programs can create an apparently unbounded 
number of synchronization objects, though they can only wait on up to 64 
at a time. However, on Linux the NOFILE limit causes problems; some 
distributions have it as low as 4096 by default, which is too low even 
for some modern programs that don't leak objects.

The approach we are developing, that relies on this patch, backs each 
object with a single futex whose value represents its signaled state. 
Therefore the only resource we are at risk of running out of is 
available memory, which exists in far greater quantities than available 
descriptors. [Presumably Windows synchronization primitives require at 
least some kernel memory to be allocated per object as well, so this 
puts us essentially at parity, for whatever that's worth.]

To be clear, I think the primary impetus for developing the futex-based 
approach was performance; it lets us avoid some system calls in hot 
paths (e.g. waiting on an already signaled object, resetting the state 
of an object to unsignaled. In that respect we're trying to get ahead of 
Windows, I guess.) But we have still been encountering occasional grief 
due to NOFILE limits that are too low, so this is another helpful benefit.
