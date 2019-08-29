Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58D6233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfH2JmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:42:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:4341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfH2JmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:42:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 02:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="197765648"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 02:42:01 -0700
Subject: Re: Tracing text poke / kernel self-modifying code (Was: Re: [RFC v2
 0/6] x86: dynamic indirect branch promotion)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
References: <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
 <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
 <20190108190104.GC1900@hirez.programming.kicks-ass.net>
 <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
 <20190109103544.GH1900@hirez.programming.kicks-ass.net>
 <7b4952c2-d3e3-488f-3697-2e8b71c58063@intel.com>
 <20190829085339.GN2369@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d37f678f-cf1d-5c98-228f-05bed99f2112@intel.com>
Date:   Thu, 29 Aug 2019 12:40:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829085339.GN2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/19 11:53 AM, Peter Zijlstra wrote:
> On Thu, Aug 29, 2019 at 11:23:52AM +0300, Adrian Hunter wrote:
>> On 9/01/19 12:35 PM, Peter Zijlstra wrote:
>>> On Tue, Jan 08, 2019 at 12:47:42PM -0800, Nadav Amit wrote:
>>>
>>>> A general solution is more complicated, however, due to the racy nature of
>>>> cross-modifying code. There would need to be TSC recording of the time
>>>> before the modifications start and after they are done.
>>>>
>>>> BTW: I am not sure that static-keys are much better. Their change also
>>>> affects the control flow, and they do affect the control flow.
>>>
>>> Any text_poke() user is a problem; which is why I suggested a
>>> PERF_RECORD_TEXT_POKE that emits the new instruction. Such records are
>>> timestamped and can be correlated to the trace.
>>>
>>> As to the racy nature of text_poke, yes, this is a wee bit tricky and
>>> might need some care. I _think_ we can make it work, but I'm not 100%
>>> sure on exactly how PT works, but something like:
>>>
>>>  - write INT3 byte
>>>  - IPI-SYNC
>>>
>>> and ensure the poke_handler preserves the existing control flow (which
>>> it currently does not, but should be possible).
>>>
>>>  - emit RECORD_TEXT_POKE with the new instruction
>>>
>>> at this point the actual control flow will be through the INT3 and
>>> handler and not hit the actual instruction, so the actual state is
>>> irrelevant.
>>>
>>>  - write instruction tail
>>>  - IPI-SYNC
>>>  - write first byte
>>>  - IPI-SYNC
>>>
>>> And at this point we start using the new instruction, but this is after
>>> the timestamp from the RECORD_TEXT_POKE event and decoding should work
>>> just fine.
>>>
>>
>> Presumably the IPI-SYNC does not guarantee that other CPUs will not already
>> have seen the change.  In that case, it is not possible to provide a
>> timestamp before which all CPUs executed the old code, and after which all
>> CPUs execute the new code.
> 
> 'the change' is an INT3 poke, so either you see the old code flow, or
> you see an INT3 emulate the old flow in your trace.
> 
> That should be unambiguous.
> 
> Then you emit the RECORD_TEXT_POKE with the new instruction on. This
> prepares the decoder to accept a new reality.
> 
> Then we finish the instruction poke.
> 
> And then when the trace no longer shows INT3 exceptions, you know the
> new code is in effect.
> 
> How is this ambiguous?

It's not.  I didn't get that from the first read, sorry.

Can you expand on "and ensure the poke_handler preserves the existing
control flow"?  Whatever the INT3-handler does will be traced normally so
long as it does not itself execute self-modified code.
