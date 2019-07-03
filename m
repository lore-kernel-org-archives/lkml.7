Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B893C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A5120673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGCBHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:07:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:52386 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGCBHn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:07:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 18:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; 
   d="scan'208";a="164191096"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.96]) ([10.239.196.96])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jul 2019 18:07:40 -0700
Subject: Re: [PATCH v6 5/7] perf diff: Link same basic blocks among different
 data
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
 <1561713784-30533-6-git-send-email-yao.jin@linux.intel.com>
 <20190702161739.GK15462@kernel.org> <20190702162000.GL15462@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <20f32ca4-af39-3f8e-c679-765b3849cfd9@linux.intel.com>
Date:   Wed, 3 Jul 2019 09:07:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702162000.GL15462@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2019 12:20 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 02, 2019 at 01:17:39PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Jun 28, 2019 at 05:23:02PM +0800, Jin Yao escreveu:
>>> The target is to compare the performance difference (cycles
>>> diff) for the same basic blocks in different data files.
>>>
>>> The same basic block means same function, same start address
>>> and same end address. This patch finds the same basic blocks
>>> from different data files and link them together and resort
>>> by the cycles diff.
>>>
>>>   v3:
>>>   ---
>>>   The block stuffs are maintained by new structure 'block_hist',
>>>   so this patch is update accordingly.
>>>
>>>   v2:
>>>   ---
>>>   Since now the basic block hists is changed to per symbol,
>>>   the patch only links the basic block hists for the same
>>>   symbol in different data files.
>>>
>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>> ---
>>>   tools/perf/builtin-diff.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 90 insertions(+)
>>>
>>> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
>>> index 83b8c0f..823f162 100644
>>> --- a/tools/perf/builtin-diff.c
>>> +++ b/tools/perf/builtin-diff.c
>>> @@ -641,6 +641,85 @@ static int process_block_per_sym(struct hist_entry *he)
>>>   	return 0;
>>>   }
>>>   
>>> +static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
>>> +{
>>> +	struct block_info *bi_a = a->block_info;
>>> +	struct block_info *bi_b = b->block_info;
>>> +	int cmp;
>>> +
>>> +	if (!bi_a->sym || !bi_b->sym)
>>> +		return -1;
>>> +
>>> +	if (bi_a->sym->name && bi_b->sym->name) {
>>> +		cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
>>> +		if ((!cmp) && (bi_a->start == bi_b->start) &&
>>> +		    (bi_a->end == bi_b->end)) {
>>> +			return 0;
>>> +		}
>>
>>
>> builtin-diff.c:658:17: error: address of array 'bi_a->sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>>          if (bi_a->sym->name && bi_b->sym->name) {
>>              ~~~~~~~~~~~^~~~ ~~
>> builtin-diff.c:658:36: error: address of array 'bi_b->sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>>          if (bi_a->sym->name && bi_b->sym->name) {
>>
>> Because:
>>
>> struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
>> {
>>          size_t namelen = strlen(name) + 1;
>>          struct symbol *sym = calloc(1, (symbol_conf.priv_size +
>>                                          sizeof(*sym) + namelen));
>>
>>
>> So it will be at least a strlen(sym->name) == 0, i.e. we can use it
>> without checking anything.
>>
>> I'm chanign it to do the cmp straight away
> 
> i.e. I added this on top of this patch:
> 
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 823f162b0060..fafb7b3f58fb 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -650,13 +650,10 @@ static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
>   	if (!bi_a->sym || !bi_b->sym)
>   		return -1;
>   
> -	if (bi_a->sym->name && bi_b->sym->name) {
> -		cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
> -		if ((!cmp) && (bi_a->start == bi_b->start) &&
> -		    (bi_a->end == bi_b->end)) {
> -			return 0;
> -		}
> -	}
> +	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
> +
> +	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
> +		return 0;
>   
>   	return -1;
>   }
> 

Hi Arnaldo,

Thanks so much for providing the fix. Maybe my gcc version is too old.
gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9)

I will switch to gcc version 7.4.0.

Thanks
Jin Yao


