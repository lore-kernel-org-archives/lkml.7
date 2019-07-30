Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C2C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDF2206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfG3Hyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:54:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:55879 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfG3Hyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:54:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 00:54:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; 
   d="scan'208";a="171845359"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2019 00:54:39 -0700
Subject: Re: [PATCH 3/3] Fix insn.c misaligned address error
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        mbd@fb.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-4-nums@google.com> <20190726193806.GB24867@kernel.org>
 <20190727184638.3263eb76c3cbde95f9896210@kernel.org>
 <2bc0fcc6-0477-ba1d-7418-5497efa7d571@intel.com>
 <20190730094745.f5d6e7fa062e09d70b643801@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e4269cb2-d8e6-da26-6afd-a9df72d4be36@intel.com>
Date:   Tue, 30 Jul 2019 10:53:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730094745.f5d6e7fa062e09d70b643801@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 3:47 AM, Masami Hiramatsu wrote:
> On Mon, 29 Jul 2019 11:22:34 +0300
> Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> On 27/07/19 12:46 PM, Masami Hiramatsu wrote:
>>> On Fri, 26 Jul 2019 16:38:06 -0300
>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>
>>>> Em Wed, Jul 24, 2019 at 11:45:12AM -0700, Numfor Mbiziwo-Tiapo escreveu:
>>>>> The ubsan (undefined behavior sanitizer) version of perf throws an
>>>>> error on the 'x86 instruction decoder - new instructions' function
>>>>> of perf test.
>>>>>
>>>>> To reproduce this run:
>>>>> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
>>>>>
>>>>> then run: tools/perf/perf test 62 -v
>>>>>
>>>>> The error occurs in the __get_next macro (line 34) where an int is
>>>>> read from a potentially unaligned address. Using memcpy instead of
>>>>> assignment from an unaligned pointer.
>>>>
>>>> Since this came from the kernel, don't we have to fix it there as well?
>>>> Masami, Adrian?
>>>
>>> I guess we don't need it, since x86 can access "unaligned address" and
>>> x86 insn decoder in kernel runs only on x86. I'm not sure about perf's
>>> that part. Maybe if we run it on other arch as cross-arch application,
>>> it may cause unaligned pointer issue.
>>
>> Yes, theoretically Intel PT decoding can be done on any arch.
>>
>> But the memcpy is probably sub-optimal for x86, so the patch as it stands
>> does not seem suitable.  I notice the kernel has get_unaligned() and
>> put_unaligned().
>>
>> Obviously it would be better for a patch to be accepted to
>> arch/x86/lib/insn.c also.
> 
> Hmm, then I rather like memcpy() for arch/x86/lib/insn.c, because it runs only
> on x86.

Yes, I was wrong about memcpy, and it is simpler for perf tools than
dragging out get_unaligned().
