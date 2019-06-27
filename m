Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DA8C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F38A2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0Hem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:34:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:10758 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0Hel (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:34:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 00:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="173039705"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.106]) ([10.239.196.106])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2019 00:34:38 -0700
Subject: Re: [PATCH v5 4/7] perf diff: Use hists to manage basic blocks per
 symbol
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
 <1561644569-22306-5-git-send-email-yao.jin@linux.intel.com>
 <20190627072718.GA24279@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ceae45ed-f1e7-ad4e-78ab-a56f0ae0d11e@linux.intel.com>
Date:   Thu, 27 Jun 2019 15:34:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627072718.GA24279@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2019 3:27 PM, Jiri Olsa wrote:
> On Thu, Jun 27, 2019 at 10:09:26PM +0800, Jin Yao wrote:
> 
> SNIP
> 
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
>> +							  NULL, &dummy_al, bi);
> 
> nit, it's the only caller of hists__add_entry_block, so we don't need
> the 'ops' argument in there
> 
> other than this, this all looks good to me
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 

Hi Jiri,

Thanks so much!

Do you need me to send v6 which only removes the 'ops' argument from 
hists__add_entry_block? Or this v5 should be OK either?


Thanks
Jin Yao

