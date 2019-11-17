Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4CCC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 12:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B789B2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 12:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfKQMMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 07:12:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:37520 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfKQMMw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 07:12:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 04:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,316,1569308400"; 
   d="scan'208";a="215103025"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.212.51]) ([10.254.212.51])
  by fmsmga001.fm.intel.com with ESMTP; 17 Nov 2019 04:12:49 -0800
Subject: Re: [PATCH v1 2/2] perf report: Jump to symbol source view from total
 cycles view
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191113004852.21265-1-yao.jin@linux.intel.com>
 <20191113004852.21265-2-yao.jin@linux.intel.com>
 <20191115133445.GB25491@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <db38408d-1af4-3cf6-9d8f-91070cfa42d2@linux.intel.com>
Date:   Sun, 17 Nov 2019 20:12:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191115133445.GB25491@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2019 9:34 PM, Jiri Olsa wrote:
> On Wed, Nov 13, 2019 at 08:48:52AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index e8b3122a30a7..5bf122042c01 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -478,7 +478,8 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>>   void res_sample_init(void);
>>   
>>   int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>> -			   float min_percent);
>> +			   float min_percent, struct perf_env *env,
>> +			   struct annotation_options *annotation_opts);
>>   #else
>>   static inline
>>   int perf_evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
>> @@ -525,7 +526,9 @@ static inline void res_sample_init(void) {}
>>   
>>   int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
>>   			   struct evsel *evsel __maybe_unused,
>> -			   float min_percent __maybe_unused)
>> +			   float min_percent __maybe_unused,
>> +			   struct perf_env *env __maybe_unused,
>> +			   struct annotation_options *annotation_opts)
> 
> missing __maybe_unused, this breaks no-tui build 'make NO_SLANG=1'
> 
> jirka
> 

Oh, yes, I should add __maybe_unused.

Thanks
Jin Yao
