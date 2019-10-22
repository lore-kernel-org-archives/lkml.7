Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4181CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E77C2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfJVBEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 21:04:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:2959 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfJVBEl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 21:04:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 18:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; 
   d="scan'208";a="209559867"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.104]) ([10.239.196.104])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2019 18:04:38 -0700
Subject: Re: [PATCH v2 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191015053350.13909-1-yao.jin@linux.intel.com>
 <20191015053350.13909-4-yao.jin@linux.intel.com>
 <20191021160803.GH32718@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <bcc3035b-b50c-231f-23b3-b3f03b2b46a7@linux.intel.com>
Date:   Tue, 22 Oct 2019 09:04:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021160803.GH32718@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/2019 12:08 AM, Jiri Olsa wrote:
> On Tue, Oct 15, 2019 at 01:33:48PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +			cycles += bi->cycles_aggr / bi->num_aggr;
>> +
>> +			he_block = hists__add_entry_block(&bh->block_hists,
>> +							  &al, bi);
>> +			if (!he_block) {
>> +				block_info__put(bi);
>> +				return -1;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (block_cycles)
>> +		*block_cycles += cycles;
>> +
>> +	return 0;
>> +}
>> +
>> +static int resort_cb(struct hist_entry *he, void *arg __maybe_unused)
>> +{
>> +	/* Skip the calculation of column length in output_resort */
>> +	he->filtered = true;
> 
> that's a nasty hack ;-) together with setting it back to false just below
> 
> why do you want to skip the columns calculation? we could add those columns
> to the output as well no?
> 
> jirka
> 

The columns calculation for this case causes the crash. The current 
columns calculation requires some information but we don't provide. So I 
just want to skip the columns calculation.

OK, I will check how to avoid this nasty hack.

Thanks
Jin Yao

>> +	return 0;
>> +}
>> +
>> +static void hists__clear_filtered(struct hists *hists)
>> +{
>> +	struct rb_node *next = rb_first_cached(&hists->entries);
>> +	struct hist_entry *he;
>> +
>> +	while (next) {
>> +		he = rb_entry(next, struct hist_entry, rb_node);
>> +		he->filtered = false;
>> +		next = rb_next(&he->rb_node);
>> +	}
>> +}
> 
> SNIP
> 
> jirka
> 
