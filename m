Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B521C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4F1206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfG2I2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:28:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:22293 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfG2I2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:28:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 01:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="scan'208";a="176317959"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2019 01:23:54 -0700
Subject: Re: [PATCH 3/3] Fix insn.c misaligned address error
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        mbd@fb.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-4-nums@google.com> <20190726193806.GB24867@kernel.org>
 <20190727184638.3263eb76c3cbde95f9896210@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2bc0fcc6-0477-ba1d-7418-5497efa7d571@intel.com>
Date:   Mon, 29 Jul 2019 11:22:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190727184638.3263eb76c3cbde95f9896210@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/19 12:46 PM, Masami Hiramatsu wrote:
> On Fri, 26 Jul 2019 16:38:06 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
>> Em Wed, Jul 24, 2019 at 11:45:12AM -0700, Numfor Mbiziwo-Tiapo escreveu:
>>> The ubsan (undefined behavior sanitizer) version of perf throws an
>>> error on the 'x86 instruction decoder - new instructions' function
>>> of perf test.
>>>
>>> To reproduce this run:
>>> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
>>>
>>> then run: tools/perf/perf test 62 -v
>>>
>>> The error occurs in the __get_next macro (line 34) where an int is
>>> read from a potentially unaligned address. Using memcpy instead of
>>> assignment from an unaligned pointer.
>>
>> Since this came from the kernel, don't we have to fix it there as well?
>> Masami, Adrian?
> 
> I guess we don't need it, since x86 can access "unaligned address" and
> x86 insn decoder in kernel runs only on x86. I'm not sure about perf's
> that part. Maybe if we run it on other arch as cross-arch application,
> it may cause unaligned pointer issue.

Yes, theoretically Intel PT decoding can be done on any arch.

But the memcpy is probably sub-optimal for x86, so the patch as it stands
does not seem suitable.  I notice the kernel has get_unaligned() and
put_unaligned().

Obviously it would be better for a patch to be accepted to
arch/x86/lib/insn.c also.

> 
> Thank you,
> 
>>
>> [acme@quaco perf]$ find . -name insn.c
>> ./arch/x86/lib/insn.c
>> ./arch/arm/kernel/insn.c
>> ./arch/arm64/kernel/insn.c
>> ./tools/objtool/arch/x86/lib/insn.c
>> ./tools/perf/util/intel-pt-decoder/insn.c
>> [acme@quaco perf]$ diff -u ./tools/perf/util/intel-pt-decoder/insn.c ./arch/x86/lib/insn.c
>> --- ./tools/perf/util/intel-pt-decoder/insn.c	2019-07-06 16:59:05.734265998 -0300
>> +++ ./arch/x86/lib/insn.c	2019-07-06 16:59:01.369202998 -0300
>> @@ -10,8 +10,8 @@
>>  #else
>>  #include <string.h>
>>  #endif
>> -#include "inat.h"
>> -#include "insn.h"
>> +#include <asm/inat.h>
>> +#include <asm/insn.h>
>>
>>  /* Verify next sizeof(t) bytes can be on the same instruction */
>>  #define validate_next(t, insn, n)	\
>> [acme@quaco perf]$
>>
>>
>> - Arnaldo
>>  
>>> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
>>> ---
>>>  tools/perf/util/intel-pt-decoder/insn.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/intel-pt-decoder/insn.c b/tools/perf/util/intel-pt-decoder/insn.c
>>> index ca983e2bea8b..de1944c60aa9 100644
>>> --- a/tools/perf/util/intel-pt-decoder/insn.c
>>> +++ b/tools/perf/util/intel-pt-decoder/insn.c
>>> @@ -31,7 +31,8 @@
>>>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
>>>  
>>>  #define __get_next(t, insn)	\
>>> -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
>>> +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); \
>>> +		insn->next_byte += sizeof(t); r; })
>>>  
>>>  #define __peek_nbyte_next(t, insn, n)	\
>>>  	({ t r = *(t*)((insn)->next_byte + n); r; })
>>> -- 
>>> 2.22.0.657.g960e92d24f-goog
>>
>> -- 
>>
>> - Arnaldo
> 
> 

