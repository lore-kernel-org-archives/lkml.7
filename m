Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE203C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E44A206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbfFMPb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:31:28 -0400
Received: from foss.arm.com ([217.140.110.172]:37938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbfFMLCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:02:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4927367;
        Thu, 13 Jun 2019 04:02:24 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0326E3F694;
        Thu, 13 Jun 2019 04:04:06 -0700 (PDT)
Subject: Re: [PATCH 3/7] perf: arm64: Use rseq to test userspace access to pmu
 counters
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20190611125315.18736-1-raphael.gault@arm.com>
 <20190611125315.18736-4-raphael.gault@arm.com>
 <20190611143346.GB28689@kernel.org>
 <20190611165755.GG29008@lakrids.cambridge.arm.com>
 <1620360283.42036.1560281622707.JavaMail.zimbra@efficios.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <b3a5c6d6-5827-36e1-f9ef-9602eaa5741d@arm.com>
Date:   Thu, 13 Jun 2019 12:02:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1620360283.42036.1560281622707.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu, Mark,

On 6/11/19 8:33 PM, Mathieu Desnoyers wrote:
> ----- On Jun 11, 2019, at 6:57 PM, Mark Rutland mark.rutland@arm.com wrote:
> 
>> Hi Arnaldo,
>>
>> On Tue, Jun 11, 2019 at 11:33:46AM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Jun 11, 2019 at 01:53:11PM +0100, Raphael Gault escreveu:
>>>> Add an extra test to check userspace access to pmu hardware counters.
>>>> This test doesn't rely on the seqlock as a synchronisation mechanism but
>>>> instead uses the restartable sequences to make sure that the thread is
>>>> not interrupted when reading the index of the counter and the associated
>>>> pmu register.
>>>>
>>>> In addition to reading the pmu counters, this test is run several time
>>>> in order to measure the ratio of failures:
>>>> I ran this test on the Juno development platform, which is big.LITTLE
>>>> with 4 Cortex A53 and 2 Cortex A57. The results vary quite a lot
>>>> (running it with 100 tests is not so long and I did it several times).
>>>> I ran it once with 10000 iterations:
>>>> `runs: 10000, abort: 62.53%, zero: 34.93%, success: 2.54%`
>>>>
>>>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>>>> ---
>>>>   tools/perf/arch/arm64/include/arch-tests.h    |   5 +-
>>>>   tools/perf/arch/arm64/include/rseq-arm64.h    | 220 ++++++++++++++++++
>>>
>>> So, I applied the first patch in this series, but could you please break
>>> this patch into at least two, one introducing the facility
>>> (include/rseq*) and the second adding the test?
>>>
>>> We try to enforce this kind of granularity as down the line we may want
>>> to revert one part while the other already has other uses and thus
>>> wouldn't allow a straight revert.
>>>
>>> Also, can this go to tools/arch/ instead? Is this really perf specific?
>>> Isn't there any arch/arm64/include files for the kernel that we could
>>> mirror and have it checked for drift in tools/perf/check-headers.sh?
>>
>> The rseq bits aren't strictly perf specific, and I think the existing
>> bits under tools/testing/selftests/rseq/ could be factored out to common
>> locations under tools/include/ and tools/arch/*/include/.
> 
> Hi Mark,
> 
> Thanks for CCing me!
> 
> Or into a stand-alone librseq project:
> 
> https://github.com/compudj/librseq (currently a development branch in
> my own github)
> 
> I don't see why this user-space code should sit in the kernel tree.
> It is not tooling-specific.
> 

I understand your point but I have to admit that I don't really see how 
to make it work together with the test which require those definitions.

>>
>>  From a scan, those already duplicate barriers and other helpers which
>> already have definitions under tools/, which seems unfortunate. :/
>>

Also I realize that there is a duplicate with definitions introduced in 
the selftests but I kind of simplified the macros I'm using to get rid 
of what wasn't useful to me at the moment. (mainly the loop labels and 
parameter injections in the asm statement)
I understand what both Mark and Arnaldo are saying about moving it out 
of perf so that it is not duplicated but my question is whether it is a 
good thing to do as is since it is not exactly the same content as 
what's in the selftests.

I hope you can understand my concerns and I'd like to hear your opinions 
on that matter.

Thanks,

-- 
Raphael Gault
