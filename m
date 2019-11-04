Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BDECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6965521D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfKDMdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:33:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:32337 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfKDMdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:33:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 04:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="195441192"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2019 04:33:11 -0800
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191104104009.GF4131@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <408a3fcd-a456-68d8-087a-d244a741be06@intel.com>
Date:   Mon, 4 Nov 2019 14:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104104009.GF4131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 12:40 PM, Peter Zijlstra wrote:
> On Fri, Oct 25, 2019 at 03:59:55PM +0300, Adrian Hunter wrote:
>> Record changes to kernel text (i.e. self-modifying code) in order to
>> support tracers like Intel PT decoding through jump labels.
>>
>> A copy of the running kernel code is needed as a reference point
>> (e.g. from /proc/kcore). The text poke event records the old bytes
>> and the new bytes so that the event can be processed forwards or backwards.
>>
>> The text poke event has 'flags' to describe when the event is sent. At
>> present the only flag is PERF_TEXT_POKE_UPDATE which indicates the
>> point at which tools should update their reference kernel executable to
>> change the old bytes to the new bytes.
>>
>> Other architectures may wish to emit a pair of text poke events. One before
>> and one after a text poke. In that case, PERF_TEXT_POKE_UPDATE flag would
>> be set on only one of the pair.
>>
>> In the case of Intel PT tracing, the executable code must be walked to
>> reconstruct the control flow. For x86 a jump label text poke begins:
>>   - write INT3 byte
>>   - IPI-SYNC
>> At this point the actual control flow will be through the INT3 and handler
>> and not hit the old or new instruction. Intel PT outputs FUP/TIP packets
>> for the INT3, so the flow can still be decoded. Subsequently:
>>   - emit RECORD_TEXT_POKE with the new instruction
>>   - write instruction tail
>>   - IPI-SYNC
>>   - write first byte
>>   - IPI-SYNC
>> So before the text poke event timestamp, the decoder will see either the
>> old instruction flow or FUP/TIP of INT3. After the text poke event
>> timestamp, the decoder will see either the new instruction flow or FUP/TIP
>> of INT3. Thus decoders can use the timestamp as the point at which to
>> modify the executable code.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> @@ -1000,6 +1001,26 @@ enum perf_event_type {
>>  	 */
>>  	PERF_RECORD_BPF_EVENT			= 18,
>>  
>> +	/*
>> +	 * Records changes to kernel text i.e. self-modified code.
>> +	 * 'flags' has PERF_TEXT_POKE_UPDATE (i.e. bit 0) set to
>> +	 * indicate to tools to update old bytes to new bytes in the
>> +	 * executable image.
>> +	 * 'len' is the number of old bytes, which is the same as the number
>> +	 * of new bytes. 'bytes' contains the old bytes followed immediately
>> +	 * by the new bytes.
>> +	 *
>> +	 * struct {
>> +	 *	struct perf_event_header	header;
>> +	 *	u64				addr;
>> +	 *	u16				flags;
> 
> What's the purpose of the 'flags' field? We currently only have the 1
> flag defined, but what possible other flags are you thinking of?

That was to allow for identifying 'before' and 'after' text poke events.

> 
>> +	 *	u16				len;
>> +	 *	u8				bytes[];
>> +	 *	struct sample_id		sample_id;
>> +	 * };
>> +	 */
>> +	PERF_RECORD_TEXT_POKE			= 19,
>> +
>>  	PERF_RECORD_MAX,			/* non-ABI */
>>  };
>>  
>> @@ -1041,6 +1062,11 @@ enum perf_callchain_context {
>>  #define PERF_AUX_FLAG_PARTIAL		0x04	/* record contains gaps */
>>  #define PERF_AUX_FLAG_COLLISION		0x08	/* sample collided with another */
>>  
>> +/**
>> + * PERF_RECORD_TEXT_POKE::flags bits
>> + */
>> +#define PERF_TEXT_POKE_UPDATE		0x01	/* update old bytes to new bytes */
>> +
>>  #define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
>>  #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
>>  #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
> 
> 
>> +void perf_event_text_poke(unsigned long addr, u16 flags, const void *old_bytes,
>> +			  const void *new_bytes, size_t len)
>> +{
>> +	struct perf_text_poke_event text_poke_event;
>> +	size_t tot, pad;
>> +
>> +	if (!atomic_read(&nr_text_poke_events))
>> +		return;
>> +
>> +	tot  = sizeof(text_poke_event.flags) +
>> +	       sizeof(text_poke_event.len) + (len << 1);
> 
> Maybe use: 'len * 2', compiler should be smart enough.
> 
>> +	pad  = ALIGN(tot, sizeof(u64)) - tot;
>> +
>> +	text_poke_event = (struct perf_text_poke_event){
>> +		.old_bytes    = old_bytes,
>> +		.new_bytes    = new_bytes,
>> +		.pad          = pad,
>> +		.flags        = flags,
>> +		.len          = len,
>> +		.event_id  = {
>> +			.header = {
>> +				.type = PERF_RECORD_TEXT_POKE,
>> +				.misc = PERF_RECORD_MISC_KERNEL,
>> +				.size = sizeof(text_poke_event.event_id) + tot + pad,
>> +			},
>> +			.addr = addr,
>> +		},
>> +	};
>> +
>> +	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL);
>> +}
> 
> Also, I'm thinking this patch has a problem with
> arch_unoptimize_kprobe() as it stands today.
> 
> I've got a patch pending for that:
> 
>   https://lkml.kernel.org/r/20191018074634.629386219@infradead.org
> 
> That rewrites that a little, but it will be slightly differently broken
> after that.
> 
> The problem is that while we can (and do) ignore regular kprobes (they
> use text_poke() which isn't instrumented, and they don't need to be,
> because they're always going through INT3), we cannot ignore optprobes.
> 
> Installing the optprobe works as expected, but unoptimizing is difficult
> and as it stands your patch will not report the old text (you'll see
> that first byte overwriten with 0xCC) and after my patch you'll not see
> it at all.
> 
> Now, I suppose we can stick an explicit perf_event_text_poke() in there
> after my patch.
> 
> We have to delay this patch until after my x86/ftrace rewrite anyway,
> because otherwise ftrace is hidden too.
> 
> And even then, this will then notify us of all text modifications, but
> what about all the extra text, like ftrace trampolines, k(ret)probe
> trampolines, optprobe slots, bpf-jit, etc.?

Generally jump labels are used by default, whereas ftrace and probes are
more under the control of the user.  So just having jump labels done is the
main thing.

The tools have some support for copying out bpf-jit, although I am not sure
it guarantees to get short-lived code.
