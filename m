Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B06C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643F426FF8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfFCRnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:43:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:56237 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfFCRnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:43:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 10:43:00 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jun 2019 10:43:00 -0700
Received: from [10.251.11.94] (kliang2-mobl.ccr.corp.intel.com [10.251.11.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8A84D5801E6;
        Mon,  3 Jun 2019 10:42:59 -0700 (PDT)
Subject: Re: [PATCH V2 3/5] perf stat: Support per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
References: <1559228029-5876-1-git-send-email-kan.liang@linux.intel.com>
 <1559228029-5876-3-git-send-email-kan.liang@linux.intel.com>
 <20190603163636.GC12203@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cc4eea9a-e18e-af7e-2290-98727fce2f6a@linux.intel.com>
Date:   Mon, 3 Jun 2019 13:42:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603163636.GC12203@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/2019 12:36 PM, Jiri Olsa wrote:
> On Thu, May 30, 2019 at 07:53:47AM -0700, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> +
>>   static int perf_env__get_core(struct cpu_map *map, int idx, void *data)
>>   {
>>   	struct perf_env *env = data;
>>   	int core = -1, cpu = perf_env__get_cpu(env, map, idx);
>>   
>>   	if (cpu != -1) {
>> -		int socket_id = env->cpu[cpu].socket_id;
>> -
>>   		/*
>> -		 * Encode socket in upper 16 bits
>> -		 * core_id is relative to socket, and
>> +		 * Encode socket in upper 24 bits
> 
> please note we use upper 8 bits for socket number,
> the comments suggests it's 24 bits

I will fix it in v3.

> 
>> +		 * encode die id in upper 16 bits
>> +		 * core_id is relative to socket and die,
>>   		 * we need a global id. So we combine
>> -		 * socket + core id.
>> +		 * socket + die id + core id
>>   		 */
>> -		core = (socket_id << 16) | (env->cpu[cpu].core_id & 0xffff);
>> +		if (WARN_ONCE(env->cpu[cpu].socket_id >> 8,
>> +		    "The socket_id number is too big. Please upgrade the perf tool.\n"))
> 
> hum, how's perf tool upgrade going to help in here?


I think there is nothing we can do for current encoding, if the socket 
number or die number is bigger than 8 bits. We have to design a new 
encoding method, which needs to update the perf tool.
So I use a similar expression from process_cpu_topology().
		if (do_core_id_test && nr != (u32)-1 && nr > (u32)cpu_nr) {
			pr_debug("socket_id number is too big."
				 "You may need to upgrade the perf tool.\n");
			goto free_cpu;
		}

Any suggestions for the warning message?



> 
>> +			return -1;
>> +
>> +		if (WARN_ONCE(env->cpu[cpu].die_id >> 8,
>> +		    "The die_id number is too big. Please upgrade the perf tool.\n"))
>> +			return -1;
>> +
>> +		core = (env->cpu[cpu].socket_id << 24) |
>> +		       (env->cpu[cpu].die_id << 16) |
>> +		       (env->cpu[cpu].core_id & 0xffff);
>>   	}
> 
> other than comments above, the patchset looks good to me
>

Thanks for the review. I will send out V3 after the comments are addressed.

Thanks,
Kan
