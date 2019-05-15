Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCF2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF0720881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEOInh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:43:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:62345 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEOIng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:43:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 01:43:35 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 01:43:35 -0700
Received: from [10.125.252.185] (abudanko-mobl.ccr.corp.intel.com [10.125.252.185])
        by linux.intel.com (Postfix) with ESMTP id 487A45800CB;
        Wed, 15 May 2019 01:43:31 -0700 (PDT)
Subject: Re: [PATCH v10 09/12] perf record: implement
 -z,--compression_level[=<n>] option
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
 <9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com>
 <20190514202041.GC8945@kernel.org> <20190514214631.GD8945@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cb3e1074-e0bc-aa6c-f4f8-73490a6b6735@linux.intel.com>
Date:   Wed, 15 May 2019 11:43:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514214631.GD8945@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.05.2019 0:46, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 14, 2019 at 05:20:41PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Mar 18, 2019 at 08:44:42PM +0300, Alexey Budankov escreveu:
>>>
>>> Implemented -z,--compression_level[=<n>] option that enables compression
>>> of mmaped kernel data buffers content in runtime during perf record
>>> mode collection. Default option value is 1 (fastest compression).
> 
> <SNIP>
>  
>> [root@quaco ~]# perf record -z2
>> ^C[ perf record: Woken up 1 times to write data ]
>> 0x1746e0 [0x76]: failed to process type: 81 [Invalid argument]
>> [ perf record: Captured and wrote 1.568 MB perf.data, compressed (original 0.452 MB, ratio is 3.995) ]
>>
>> [root@quaco ~]#
> 
> So, its the buildid processing at the end, so we can't do build-id
> processing when using PERF_RECORD_COMPRESSED, otherwise we'd have to
> uncompress at the end to find the PERF_RECORD_FORK/PERF_RECORD_MMAP,
> etc.
> 
> [root@quaco ~]# perf record -z2  --no-buildid sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.020 MB perf.data, compressed (original 0.001 MB, ratio is 2.153) ]
> [root@quaco ~]# perf report -D | grep PERF_RECORD_COMP
> 0x4f40 [0x195]: failed to process type: 81 [Invalid argument]
> Error:
> failed to process sample
> 0 0x4f40 [0x195]: PERF_RECORD_COMPRESSED
> [root@quaco ~]#
> 
> I'll play with it tomorrow.

Applied the whole patch set on top of the current perf/core 
and the whole thing functions as expected.

~Alexey

> 
> - Arnaldo
>  
>> I've pushed what I have to the tmp.perf/core branch, please try to see
>> if I made any mistake in fixing up conflicts with BPF_PROG_INFO and
>> BPF_BTF header features. I'll continue tomorrow with 10-12/12.
> 
