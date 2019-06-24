Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E81BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FE620644
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfFXOt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:49:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:40950 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfFXOt2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:49:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 07:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="163342375"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.211.94]) ([10.254.211.94])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2019 07:49:25 -0700
Subject: Re: [PATCH v4 4/7] perf diff: Use hists to manage basic blocks per
 symbol
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1561041402-29444-1-git-send-email-yao.jin@linux.intel.com>
 <1561041402-29444-5-git-send-email-yao.jin@linux.intel.com>
 <20190624075718.GE5471@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cdc87d42-8a5c-5b12-c746-896e3324cb35@linux.intel.com>
Date:   Mon, 24 Jun 2019 22:49:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624075718.GE5471@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2019 3:57 PM, Jiri Olsa wrote:
> On Thu, Jun 20, 2019 at 10:36:39PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +
>> +static void *block_entry_zalloc(size_t size)
>> +{
>> +	return zalloc(size + sizeof(struct hist_entry));
>> +}
>> +
>> +static void block_entry_free(void *he)
>> +{
>> +	struct block_info *bi = ((struct hist_entry *)he)->block_info;
>> +
>> +	block_info__put(bi);
>> +	free(he);
>> +}
>> +
>> +struct hist_entry_ops block_entry_ops = {
>> +	.new    = block_entry_zalloc,
>> +	.free   = block_entry_free,
>> +};
> 
> hum, so there's already block_hist_ops moving that stuff into 'struct block_hist',
> which is great, but why don't we have 'struct block_entry' in here? that would
> keep the 'struct block_info'
> 
> thanks,
> jirka
> 

Hi Jiri,

If I define 'struct block_entry' as following and cast 'he' to 'struct 
block_entry' in some places, such as in block_cmp(), we can get the 
'struct block_entry'.

struct block_entry {
	struct block_info bi;
	struct hist_entry he;
};

But I don't know when I can set the 'bi' of 'struct block_entry'. Before 
or after calling hists__add_entry_xxx()? Before calling 
hists__add_entry_xxx(), we don't know the hist_entry. After calling 
hists__add_entry_xxx(), actually the hist_entry__cmp doesn't work (no bi ).

That's why I create block_info in hist_entry. Maybe I misunderstand what 
your suggested, correct me if I'm wrong.

Thanks
Jin Yao
