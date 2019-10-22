Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24C1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743AD218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfJVF4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 01:56:49 -0400
Received: from mail.windriver.com ([147.11.1.11]:47196 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVF4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:56:49 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id x9M5ua1W026864
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 21 Oct 2019 22:56:36 -0700 (PDT)
Received: from [128.224.155.112] (128.224.155.112) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 21 Oct
 2019 22:56:34 -0700
Subject: Re: [PATCH v4] perf record: Add support for limit perf output file
 size
To:     Jiri Olsa <jolsa@redhat.com>
References: <20190925070637.13164-1-jiwei.sun@windriver.com>
 <20191021134137.GA8264@krava>
CC:     <acme@redhat.com>, <arnaldo.melo@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <mpetlan@redhat.com>,
        <namhyung@kernel.org>, <a.p.zijlstra@chello.nl>,
        <adrian.hunter@intel.com>, <Richard.Danter@windriver.com>
From:   Jiwei Sun <Jiwei.Sun@windriver.com>
Message-ID: <97a91775-c34c-ede4-4049-ce47160f4773@windriver.com>
Date:   Tue, 22 Oct 2019 13:56:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20191021134137.GA8264@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.112]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

On 2019e9410f21f% 21:41, Jiri Olsa wrote:
> On Wed, Sep 25, 2019 at 03:06:37PM +0800, Jiwei Sun wrote:
> 
> SNIP
> 
>>  SEE ALSO
>>  --------
>>  linkperf:perf-stat[1], linkperf:perf-list[1]
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 48600c90cc7e..30904d2a3407 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -91,6 +91,7 @@ struct record {
>>  	struct switch_output	switch_output;
>>  	unsigned long long	samples;
>>  	cpu_set_t		affinity_mask;
>> +	unsigned long		output_max_size;	/* = 0: unlimited */
>>  };
>>  
>>  static volatile int auxtrace_record__snapshot_started;
>> @@ -120,6 +121,12 @@ static bool switch_output_time(struct record *rec)
>>  	       trigger_is_ready(&switch_output_trigger);
>>  }
>>  
>> +static bool record__output_max_size_exceeded(struct record *rec)
>> +{
>> +	return rec->output_max_size &&
>> +	       (rec->bytes_written >= rec->output_max_size);
>> +}
>> +
>>  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>>  			 void *bf, size_t size)
>>  {
>> @@ -132,6 +139,12 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>>  
>>  	rec->bytes_written += size;
>>  
>> +	if (record__output_max_size_exceeded(rec)) {
>> +		WARN_ONCE(1, "WARNING: The perf data has already reached "
>> +			     "the limit, stop recording!\n");
> 
> I think the message whouldn't be a warning, the user asked for
> that, maybe something more like:
> 
>   [ perf record: perf size limit reached (XXMB), stopping session ]
> 
>> +		raise(SIGTERM);
> 
> could we just set 'done = 1' what's the benefit in killing perf?

Thanks for your suggestions. Yes, if just set "done == 1" is more efficient and more concise.
And I will modify it and the output format, and then send a v5 patch.
Thanks again.

Regards,
Jiwei

> 
> thanks,
> jirka
> 
> 
