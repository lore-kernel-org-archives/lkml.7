Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C0DCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC98421920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405686AbfJWNNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:13:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:5165 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732284AbfJWNNJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:13:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="196773178"
Received: from shilongz-mobl.ccr.corp.intel.com (HELO [10.254.210.50]) ([10.254.210.50])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 06:13:07 -0700
Subject: Re: [PATCH v3 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-4-yao.jin@linux.intel.com>
 <20191023113636.GM22919@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <74eca781-82b5-998d-f8d3-c6b80f8a4f78@linux.intel.com>
Date:   Wed, 23 Oct 2019 21:13:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023113636.GM22919@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2019 7:36 PM, Jiri Olsa wrote:
> On Tue, Oct 22, 2019 at 04:07:08PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +static void get_block_hists(struct hists *hists, struct block_hist *bh,
>> +			    struct report *rep)
>> +{
>> +	struct rb_node *next = rb_first_cached(&hists->entries);
>> +	struct hist_entry *he;
>> +
>> +	init_block_hist(bh, rep);
>> +
>> +	while (next) {
>> +		he = rb_entry(next, struct hist_entry, rb_node);
>> +		block_info__process_sym(he, bh, &rep->block_cycles,
>> +					rep->cycles_count);
>> +		next = rb_next(&he->rb_node);
>> +	}
>> +
>> +	hists__output_resort(&bh->block_hists, NULL);
>> +}
>> +
>> +static int hists__fprintf_all_blocks(struct hists *hists, struct report *rep)
>> +{
>> +	struct block_hist *bh = &rep->block_hist;
>> +
>> +	get_block_hists(hists, bh, rep);
>> +	symbol_conf.report_individual_block = true;
>> +	hists__fprintf(&bh->block_hists, true, 0, 0, 0,
>> +		       stdout, true);
>> +	hists__delete_entries(&bh->block_hists);
>> +	return 0;
>> +}
>> +
>>   static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   					 struct report *rep,
>>   					 const char *help)
>> @@ -500,6 +820,12 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   			continue;
>>   
>>   		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
>> +
>> +		if (rep->total_cycles) {
>> +			hists__fprintf_all_blocks(hists, rep);
> 
> it's still being computed in output function, the computation
> should be outside.. like in report__output_resort or such
> 

Maybe a bit complicated in the implementation, but that's fine, let me 
have a try.

Thanks
Jin Yao

> thanks,
> jirka
> 
