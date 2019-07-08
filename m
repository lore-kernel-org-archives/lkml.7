Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CB5C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C75320665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfGHHKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:10:49 -0400
Received: from foss.arm.com ([217.140.110.172]:40042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfGHHKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:10:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876322B;
        Mon,  8 Jul 2019 00:10:48 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0079D3F246;
        Mon,  8 Jul 2019 00:12:42 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] perf: arm64: Add test to check userspace access to
 hardware counters.
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com
References: <20190705085541.9356-1-raphael.gault@arm.com>
 <20190705085541.9356-2-raphael.gault@arm.com>
 <20190705145436.GA29396@kernel.org>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <7fcf5a01-15f3-5a97-bc1b-74d82f31981f@arm.com>
Date:   Mon, 8 Jul 2019 08:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190705145436.GA29396@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 7/5/19 3:54 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 05, 2019 at 09:55:37AM +0100, Raphael Gault escreveu:
>> This test relies on the fact that the PMU registers are accessible
>> from userspace. It then uses the perf_event_mmap_page to retrieve
>> the counter index and access the underlying register.
>>
>> This test uses sched_setaffinity(2) in order to run on all CPU and thus
>> check the behaviour of the PMU of all cpus in a big.LITTLE environment.
>>
>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>> ---
>>   tools/perf/arch/arm64/include/arch-tests.h |   6 +
>>   tools/perf/arch/arm64/tests/Build          |   1 +
>>   tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
>>   tools/perf/arch/arm64/tests/user-events.c  | 255 +++++++++++++++++++++
>>   4 files changed, 266 insertions(+)
>>   create mode 100644 tools/perf/arch/arm64/tests/user-events.c
>>
>> diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
>> index 90ec4c8cb880..a9b17ae0560b 100644
>> --- a/tools/perf/arch/arm64/include/arch-tests.h
>> +++ b/tools/perf/arch/arm64/include/arch-tests.h
>> @@ -2,11 +2,17 @@
>>   #ifndef ARCH_TESTS_H
>>   #define ARCH_TESTS_H
>>   
>> +#define __maybe_unused	__attribute__((unused))
> 
> 
> What is wrong with using:
> 
> #include <linux/compiler.h>
> 
> ?
> 
> [acme@quaco perf]$ find tools/perf/ -name "*.[ch]" | xargs grep __maybe_unused | wc -l
> 1115
> [acme@quaco perf]$ grep __maybe_unused tools/include/linux/compiler.h
> #ifndef __maybe_unused
> # define __maybe_unused		__attribute__((unused))
> [acme@quaco perf]$
> 
> Also please don't break strings in multiple lines just to comply with
> the 80 column limit. That is ok when you have multiple lines ending with
> a newline, but otherwise just makes it look ugly.
> 

You're right, I shall correct those points.

Thanks,

-- 
Raphael Gault
