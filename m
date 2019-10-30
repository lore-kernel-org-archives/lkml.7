Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E81CA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D431620856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfJ3GJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 02:09:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:60968 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfJ3GJB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:09:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 23:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="211258333"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.58]) ([10.239.196.58])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2019 23:08:58 -0700
Subject: Re: [PATCH v4 5/7] perf report: Sort by sampled cycles percent per
 block for stdio
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191028013330.18319-1-yao.jin@linux.intel.com>
 <20191028013330.18319-6-yao.jin@linux.intel.com>
 <20191029092747.GH28772@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <df900509-7e69-2414-fca6-dccb70a2daf1@linux.intel.com>
Date:   Wed, 30 Oct 2019 14:08:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029092747.GH28772@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2019 5:27 PM, Jiri Olsa wrote:
> On Mon, Oct 28, 2019 at 09:33:28AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index 0e27d6830011..7cf137b0451b 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -758,6 +758,10 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
>>   	struct hist_entry entry = {
>>   		.block_info = block_info,
>>   		.hists = hists,
>> +		.ms = {
>> +			.map = al->map,
>> +			.sym = al->sym,
>> +		},
> 
> this looks like separated fix, if thats the case
> please explain the change and move it to separate patch
> 
> thanks,
> jirka
> 

Hi Jiri,

Sorry, this information is needed for reporting the block range 
information (such as reporting the source lines).

I will move this code to another patch in v5.

Thanks
Jin Yao

