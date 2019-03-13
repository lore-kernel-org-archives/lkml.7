Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A53C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33679214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCMPG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:06:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:9084 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCMPG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:06:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 08:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="306874916"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2019 08:06:26 -0700
Received: from [10.252.18.45] (unknown [10.252.18.45])
        by linux.intel.com (Postfix) with ESMTP id 7180158042B;
        Wed, 13 Mar 2019 08:06:24 -0700 (PDT)
Subject: Re: [PATCH v7 06/12] perf util: introduce Zstd based streaming
 compression API
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <f9062f55-c37f-bf50-8566-a587bce30131@linux.intel.com>
 <20190313143709.GD6676@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <810fc58b-ebcb-a20f-92c5-33501b1d7081@linux.intel.com>
Date:   Wed, 13 Mar 2019 18:06:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313143709.GD6676@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.03.2019 17:37, Jiri Olsa wrote:
> On Tue, Mar 12, 2019 at 08:23:42AM +0300, Alexey Budankov wrote:
>>
>> Implemented functions are based on Zstd streaming compression API.
>> The functions are used in runtime to compress data that come from
>> mmaped kernel buffer. zstd_init(), zstd_fini() are used for 
>> initialization and finalization to allocate and deallocate internal
>> zstd objects. zstd_compress_stream_to_records() is used to convert 
>> parts of mmaped kernel buffer into an array of PERF_RECORD_COMPRESSED 
>> records.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/Build      |  2 +
>>  tools/perf/util/compress.h | 18 ++++++++
>>  tools/perf/util/zstd.c     | 95 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 115 insertions(+)
>>  create mode 100644 tools/perf/util/zstd.c
>>
>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
>> index 8dd3102301ea..920ee8bebd83 100644
>> --- a/tools/perf/util/Build
>> +++ b/tools/perf/util/Build
>> @@ -145,6 +145,8 @@ perf-y += scripting-engines/
>>  
>>  perf-$(CONFIG_ZLIB) += zlib.o
>>  perf-$(CONFIG_LZMA) += lzma.o
>> +perf-y += zstd.o
> 
> we have CONFIG_ZSTD, so we can do:
> 
> perf-$(CONFIG_ZSTD) += zstd.o
> 
> and skip that #ifdef HAVE_ZSTD_SUPPORT in zstd.c
> and put stub inlines into compress.h

in v8.

~Alexey

> 
> thanks,
> jirka
> 
