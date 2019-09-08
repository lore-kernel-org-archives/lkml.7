Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E29C43217
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 09:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49872082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 09:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfIHJq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 05:46:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfIHJq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 05:46:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82ABA302455F;
        Sun,  8 Sep 2019 09:46:28 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDE1860605;
        Sun,  8 Sep 2019 09:46:27 +0000 (UTC)
Subject: Re: [PATCH 2/2] tools/power/x86/intel-speed-select: Display core
 count for bucket
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        David Arcari <darcari@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
 <20190905233748.6822-2-srinivas.pandruvada@linux.intel.com>
 <780a3faf-9e44-64f4-a354-bdee39af3af5@redhat.com>
 <20190906134655.GU2680@smile.fi.intel.com>
 <6b576770a4bbe6c24ea524083dec5a16bf3c9e94.camel@linux.intel.com>
 <b8c7bd1204f7b4f75a5bccec4d7c41b1225928f7.camel@linux.intel.com>
 <CAHp75Vc9xMPW38Toh2jKv9YYYNV16837aAcXKMP6WaM-L8zcSQ@mail.gmail.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <533a8c7c-d309-9b65-d973-120ae3e9f8b4@redhat.com>
Date:   Sun, 8 Sep 2019 05:46:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc9xMPW38Toh2jKv9YYYNV16837aAcXKMP6WaM-L8zcSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 08 Sep 2019 09:46:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/19 2:18 PM, Andy Shevchenko wrote:
> On Fri, Sep 6, 2019 at 10:47 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>>
>> On Fri, 2019-09-06 at 07:50 -0700, Srinivas Pandruvada wrote:
>>> On Fri, 2019-09-06 at 16:46 +0300, Andy Shevchenko wrote:
>>>> On Fri, Sep 06, 2019 at 05:39:54AM -0400, Prarit Bhargava wrote:
>>>>> On 9/5/19 7:37 PM, Srinivas Pandruvada wrote:
>>>>>> Read the bucket and core count relationship via MSR and display
>>>>>> when displaying turbo ratio limits.
>>>>>> +       ret = isst_send_msr_command(cpu, 0x1ae, 0,
>>>>>> buckets_info);
>>>>>
>>>>> ^^^ you can get rid of the magic number 0x1ae by doing (sorry for
>>>>> the cut-and-paste)
>>>>>
>>>>> diff --git a/tools/power/x86/intel-speed-select/Makefile
>>>>> b/tools/power/x86/intel
>>>>> index 12c6939dca2a..087d802ad844 100644
>>>>> --- a/tools/power/x86/intel-speed-select/Makefile
>>>>> +++ b/tools/power/x86/intel-speed-select/Makefile
>>>>> @@ -15,6 +15,8 @@ endif
>>>>>  MAKEFLAGS += -r
>>>>>
>>>>>  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>>>>> +override CFLAGS += -I../../../include
>>>>> +override CFLAGS +=
>>>>> -DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
>>>
>>> No, we can't use msr_index.
>> This comment was meant for use of /dev/cpu/X/msr not msr_index.
>> I didn't want to bring in dependency on msr-index.h for couple of 2
>> MSRs and the names in msr-index.h doesn't really reflect the actual
>> processing, they are doing. For example MSR_TURBO_RATIO_LIMIT1 for
>> 0x1ae. The definition of 0x1AE is different on cpu model 0x55 and
>> beyond.
>>
>>>
> 
> It seems not applicable on top of tools patch series I had applied before.
> 
>>>>
>>>> I guess it can be done in more neat way.
>>>>
>>>>> As I've been looking at this code I have been wondering why
>>>>> didn't
>>>>> you just use
>>>>> the standard /dev/cpu/X/msr interface that other x86 power
>>>>> utilities (turbostat,
>>>>> x86_energy_perf_policy) use?  Implementing msr_read() is trivial
>>>>> (warning
>>>>> untested and uncompiled code)
>>>
>>> No. We can't. The MSR interface is disabled on several distribution
>>> and
>>> platforms with secured boot. So some special MSRs are only allowed
>>> via
>>> this IOCTL interface.
>>>

Which distros don't have /dev/cpu/X/msr ?

None of other Intel tools have this restriction (or requirement depending on
your point of view).  Why is intel-speed-select special that we have to
jump through hoops?

P.

>>> Thanks,
>>> Srinivas
>>>
>>>
>>>>
>>>> Actually good point!
>>>>
>>
> 
> 
