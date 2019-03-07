Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC34C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E4920851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCGI0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:26:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:60608 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCGI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:26:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:26:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="129564455"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 07 Mar 2019 00:26:40 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id 23F935805B4;
        Thu,  7 Mar 2019 00:26:37 -0800 (PST)
Subject: Re: [PATCH v5 07/10] perf record: implement -z,--compression_level=n
 option and compression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
 <20190305122649.GL16615@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4ae795c5-70e9-6f02-441a-8055aff7ee64@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:26:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122649.GL16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:26, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 06:58:32PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +static int record__aio_enabled(struct record *rec);
>> +
>>  static void record__aio_mmap_read_sync(struct record *rec)
>>  {
>>  	int i;
>>  	struct perf_evlist *evlist = rec->evlist;
>>  	struct perf_mmap *maps = evlist->mmap;
>>  
>> -	if (!rec->opts.nr_cblocks)
>> +	if (!record__aio_enabled(rec))
>>  		return;
>>  
>>  	for (i = 0; i < evlist->nr_mmaps; i++) {
>> @@ -292,13 +294,17 @@ static int record__aio_parse(const struct option *opt,
>>  
>>  	if (unset) {
>>  		opts->nr_cblocks = 0;
>> -	} else {
>> -		if (str)
>> -			opts->nr_cblocks = strtol(str, NULL, 0);
>> -		if (!opts->nr_cblocks)
>> -			opts->nr_cblocks = nr_cblocks_default;
>> +		return 0;
>>  	}
>>  
>> +	if (str)
>> +		opts->nr_cblocks = strtol(str, NULL, 0);
>> +	if (!opts->nr_cblocks)
>> +		opts->nr_cblocks = nr_cblocks_default;
>> +
>> +	if (opts->nr_cblocks > nr_cblocks_max)
>> +		opts->nr_cblocks = nr_cblocks_max;
>> +
>>  	return 0;
> 
> does not seem to be related to the patch, if that's the case please separate

in v7.

~Alexey

> 
> jirka
> 
