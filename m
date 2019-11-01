Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E48ECA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF39B2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfKAOHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:07:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:8272 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfKAOHh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:07:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 07:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,255,1569308400"; 
   d="scan'208";a="211789726"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.210.166]) ([10.254.210.166])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 07:07:34 -0700
Subject: Re: [PATCH v5 7/7] perf report: Sort by sampled cycles percent per
 block for tui
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
 <20191030060430.23558-8-yao.jin@linux.intel.com>
 <20191101083434.GD2172@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2bbc0a0d-639b-7a88-71d5-6c022f46134c@linux.intel.com>
Date:   Fri, 1 Nov 2019 22:07:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101083434.GD2172@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2019 4:34 PM, Jiri Olsa wrote:
> On Wed, Oct 30, 2019 at 02:04:30PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
>> index 91d3e18b50aa..078f2f2c7abd 100644
>> --- a/tools/perf/ui/browsers/hists.h
>> +++ b/tools/perf/ui/browsers/hists.h
>> @@ -5,6 +5,7 @@
>>   #include "ui/browser.h"
>>   
>>   struct annotation_options;
>> +struct evsel;
>>   
>>   struct hist_browser {
>>   	struct ui_browser   b;
>> @@ -15,6 +16,7 @@ struct hist_browser {
>>   	struct pstack	    *pstack;
>>   	struct perf_env	    *env;
>>   	struct annotation_options *annotation_opts;
>> +	struct evsel	    *block_evsel;
> 
> you should be able to get the evsel from hists_to_evsel function
> 
> jirka
> 

Maybe we can't. The hists in hist_browser is set to block_hists (not the 
hists for evsel).

See block_hists_tui_browse,

int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
                           float min_percent)
{
        struct hists *hists = &bh->block_hists;
        struct hist_browser *browser;
        ......
        browser = hist_browser__new(hists);
        ......
}

So I have to pass the evsel in.

Thanks
Jin Yao
