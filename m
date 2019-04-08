Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B44CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59D420833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDHHtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDHHtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:49:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70B5381233;
        Mon,  8 Apr 2019 07:49:39 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F24DB6013C;
        Mon,  8 Apr 2019 07:49:37 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] sched/core: expand sched_getaffinity(2) to return number of CPUs
References: <20190403200809.GA13876@avx2>
        <20190404084249.GS4038@hirez.programming.kicks-ass.net>
        <87wok83gfs.fsf@oldenburg2.str.redhat.com>
        <20190406194825.GA5106@avx2>
Date:   Mon, 08 Apr 2019 09:49:35 +0200
In-Reply-To: <20190406194825.GA5106@avx2> (Alexey Dobriyan's message of "Sat,
        6 Apr 2019 22:48:25 +0300")
Message-ID: <878swlszqo.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 08 Apr 2019 07:49:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexey Dobriyan:

>> >> Patch overloads sched_getaffinity(len=0) to simply return "nr_cpu_ids".
>> >> This will make gettting CPU mask require at most 2 system calls
>> >> and will eliminate unnecessary code.
>> >> 
>> >> len=0 is chosen so that
>> >> * passing zeroes is the simplest thing
>> >> 
>> >> 	syscall(__NR_sched_getaffinity, 0, 0, NULL)
>> >> 
>> >>   will simply do the right thing,
>> >> 
>> >> * old kernels returned -EINVAL unconditionally.
>> >> 
>> >> Note: glibc segfaults upon exiting from system call because it tries to
>> >> clear the rest of the buffer if return value is positive, so
>> >> applications will have to use syscall(3).
>> >> Good news is that it proves noone uses sched_getaffinity(pid, 0, NULL).
>> 
>> Given that old kernels fail with EINVAL, that evidence is fairly
>> restricted.
>> 
>> I'm not sure if it's a good idea to overload this interface.  I expect
>> that users will want to call sched_getaffinity (the system call wrapper)
>> with cpusetsize == 0 to query the value, so there will be pressure on
>> glibc to remove the memset.  At that point we have an API that obscurely
>> fails with old glibc versions, but suceeds with newer ones, which isn't
>> great.
>
> I can do "if (len == 536870912)" so that bit count overflows on old
> kernels into EINVAL and is unlikely to be used ever.

I don't see how this solves this particular issue.  It will still result
in a mysterious crash if programs use an updated system call wrapper.

Thanks,
Florian
