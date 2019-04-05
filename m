Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D303C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F32217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfDEKQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbfDEKQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:16:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C64AF8762D;
        Fri,  5 Apr 2019 10:16:42 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D1EE600C5;
        Fri,  5 Apr 2019 10:16:41 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] sched/core: expand sched_getaffinity(2) to return number of CPUs
References: <20190403200809.GA13876@avx2>
        <20190404084249.GS4038@hirez.programming.kicks-ass.net>
Date:   Fri, 05 Apr 2019 12:16:39 +0200
In-Reply-To: <20190404084249.GS4038@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 4 Apr 2019 10:42:49 +0200")
Message-ID: <87wok83gfs.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 05 Apr 2019 10:16:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> On Wed, Apr 03, 2019 at 11:08:09PM +0300, Alexey Dobriyan wrote:
>> Currently there is no easy way to get the number of CPUs on the system.

The size of the affinity mask is only related to the number of CPUs in
the system in such a way that the number of CPUs cannot be larger than
the number of bits in the affinity mask.

>> Glibc in particular shipped with 1024 CPUs support maximum at some point
>> which is quite surprising as glibc maitainers should know better.

This dates back to a time when the kernel was never going to support
more than 1024 CPUs.

A lot of distribution kernels still enforce a hard limit, which papers
over firmware bugs which tell the kernel that the system can be
hot-plugged to a ridiculous number of sockets/CPUs.

>> Another group dynamically grow buffer until cpumask fits. This is
>> inefficient as multiple system calls are done.
>> 
>> Nobody seems to parse "/sys/devices/system/cpu/possible".
>> Even if someone does, parsing sysfs is much slower than necessary.
>
> True; but I suppose glibc already does lots of that anyway, right? It
> does contain the right information.

If I recall correctly my last investigation,
/sys/devices/system/cpu/possible does not reflect the size of the
affinity mask, either.

>> Patch overloads sched_getaffinity(len=0) to simply return "nr_cpu_ids".
>> This will make gettting CPU mask require at most 2 system calls
>> and will eliminate unnecessary code.
>> 
>> len=0 is chosen so that
>> * passing zeroes is the simplest thing
>> 
>> 	syscall(__NR_sched_getaffinity, 0, 0, NULL)
>> 
>>   will simply do the right thing,
>> 
>> * old kernels returned -EINVAL unconditionally.
>> 
>> Note: glibc segfaults upon exiting from system call because it tries to
>> clear the rest of the buffer if return value is positive, so
>> applications will have to use syscall(3).
>> Good news is that it proves noone uses sched_getaffinity(pid, 0, NULL).

Given that old kernels fail with EINVAL, that evidence is fairly
restricted.

I'm not sure if it's a good idea to overload this interface.  I expect
that users will want to call sched_getaffinity (the system call wrapper)
with cpusetsize == 0 to query the value, so there will be pressure on
glibc to remove the memset.  At that point we have an API that obscurely
fails with old glibc versions, but suceeds with newer ones, which isn't
great.

Thanks,
Florian
