Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E459DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC93D2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCGI2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:28:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:19116 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGI2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:28:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:28:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="132289664"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 07 Mar 2019 00:28:20 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id 1B4855805B4;
        Thu,  7 Mar 2019 00:28:17 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 09/10] perf inject: enable COMPRESSED records
 decompression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <fa393ac2-f9ae-288b-ff0b-9218b8270775@linux.intel.com>
 <20190305122655.GM16615@krava>
Organization: Intel Corp.
Message-ID: <309cd907-7af5-8320-a171-ebfe113256f9@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:28:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122655.GM16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:26, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 07:07:49PM +0300, Alexey Budankov wrote:
>>
>> Initialized decompression API so COMPRESSED record would be
>> decompressed into the resulting output data file.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-inject.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>> index 24086b7f1b14..8e0e06d3edfc 100644
>> --- a/tools/perf/builtin-inject.c
>> +++ b/tools/perf/builtin-inject.c
>> @@ -837,6 +837,9 @@ int cmd_inject(int argc, const char **argv)
>>  	if (inject.session == NULL)
>>  		return -1;
>>  
>> +	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
>> +		pr_warning("Decompression initialization failed.\n");
> 
> hum, I wonder we should put this inside perf_session__new/perf_session__delete

comp_level parameter passing would extend the signature of __new()

struct perf_session *perf_session__new(struct perf_data *data,
				       bool repipe, struct perf_tool *tool,
				       int comp_level)

~Alexey

> 
> jirka
> 
>> +
>>  	if (inject.build_ids) {
>>  		/*
>>  		 * to make sure the mmap records are ordered correctly
>> @@ -867,6 +870,7 @@ int cmd_inject(int argc, const char **argv)
>>  	ret = __cmd_inject(&inject);
>>  
>>  out_delete:
>> +	zstd_fini(&(inject.session->zstd_data));
>>  	perf_session__delete(inject.session);
>>  	return ret;
>>  }
>> -- 
>> 2.20.1
>>
> 
