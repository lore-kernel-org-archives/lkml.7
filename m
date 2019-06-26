Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3974BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155AF205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFZA5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 20:57:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:13465 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFZA5g (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 20:57:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 17:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,418,1557212400"; 
   d="scan'208";a="172556908"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.208.68]) ([10.254.208.68])
  by orsmga002.jf.intel.com with ESMTP; 25 Jun 2019 17:57:31 -0700
Subject: Re: [PATCH v4 4/7] perf diff: Use hists to manage basic blocks per
 symbol
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1561041402-29444-1-git-send-email-yao.jin@linux.intel.com>
 <1561041402-29444-5-git-send-email-yao.jin@linux.intel.com>
 <20190625091134.GD9574@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b8e461e9-e835-539b-119a-698e774194af@linux.intel.com>
Date:   Wed, 26 Jun 2019 08:57:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625091134.GD9574@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/2019 5:11 PM, Jiri Olsa wrote:
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
> 
> so if we carry block_info in 'struct hist_entry' we don't need
> to use our own allocation in the 2nd level hist entries.. just
> for the first level to carry the new 'struct block_hists'
> 
> the block_info should be released in hist_entry__delete then,
> same as for other *info pointers
> 
> the rest of the patchset looks ok to me
> 
> thanks,
> jirka
> 

Yes, releasing the block_info in hist_entry__delete is a better way. 
Thanks Jiri, I will update the patch.

Thanks
Jin Yao

>> +
>> +struct hist_entry_ops block_entry_ops = {
>> +	.new    = block_entry_zalloc,
>> +	.free   = block_entry_free,
>> +};
>> +
>> +static int process_block_per_sym(struct hist_entry *he)
>> +{
>> +	struct annotation *notes;
>> +	struct cyc_hist *ch;
>> +	struct block_hist *bh;
>> +
>> +	if (!he->ms.map || !he->ms.sym)
>> +		return 0;
>> +
>> +	notes = symbol__annotation(he->ms.sym);
>> +	if (!notes || !notes->src || !notes->src->cycles_hist)
>> +		return 0;
>> +
>> +	bh = container_of(he, struct block_hist, he);
>> +	init_block_hist(bh);
>> +
>> +	ch = notes->src->cycles_hist;
>> +	for (unsigned int i = 0; i < symbol__size(he->ms.sym); i++) {
>> +		if (ch[i].num_aggr) {
>> +			struct block_info *bi;
>> +			struct hist_entry *he_block;
>> +
>> +			bi = block_info__new();
>> +			if (!bi)
>> +				return -1;
>> +
>> +			init_block_info(bi, he->ms.sym, &ch[i], i);
>> +			he_block = hists__add_entry_block(&bh->block_hists,
>> +							  &block_entry_ops,
>> +							  &dummy_al, bi);
>> +			if (!he_block) {
>> +				block_info__put(bi);
>> +				return -1;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
> 
> SNIP
> 
