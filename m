Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C21FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4144322525
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLFBve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:51:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:12140 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfLFBvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:51:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 17:51:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="243473463"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2019 17:51:31 -0800
Date:   Fri, 6 Dec 2019 09:51:26 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, richard.weiyang@gmail.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or,
        tglx@linutronix.de
Subject: Re: [Patch v2 4/6] x86/mm: Refine debug print string retrieval
 function
Message-ID: <20191206015126.GB3846@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
 <20191205021403.25606-5-richardw.yang@linux.intel.com>
 <20191205091311.GD2810@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205091311.GD2810@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:13:11AM +0100, Peter Zijlstra wrote:
>On Thu, Dec 05, 2019 at 10:14:01AM +0800, Wei Yang wrote:
>> Generally, the mapping page size are:
>> 
>>    4K, 2M, 1G
>> 
>> except in case 32-bit without PAE, the mapping page size are:
>> 
>>    4K, 4M
>> 
>> Based on PG_LEVEL_X definition and mr->page_size_mask, we can calculate
>> the mapping page size from a predefined string array.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  arch/x86/mm/init.c | 39 +++++++++++++--------------------------
>>  1 file changed, 13 insertions(+), 26 deletions(-)
>> 
>> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
>> index 0eb5edb63fa2..ded58a31c679 100644
>> --- a/arch/x86/mm/init.c
>> +++ b/arch/x86/mm/init.c
>> @@ -308,29 +308,20 @@ static void __ref adjust_range_page_size_mask(struct map_range *mr,
>>  	}
>>  }
>>  
>> +static void __meminit mr_print(struct map_range *mr, unsigned int maxidx)
>>  {
>> +#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
>> +	static const char *sz[2] = { "4K", "4M" };
>> +#else
>> +	static const char *sz[4] = { "4K", "2M", "1G", "" };
>> +#endif
>> +	unsigned int idx, s;
>>  
>> +	for (idx = 0; idx < maxidx; idx++, mr++) {
>> +		s = (mr->page_size_mask >> PG_LEVEL_2M) & (ARRAY_SIZE(sz) - 1);
>
>Is it at all possible for !PAE to have 1G here, if you use the sz[4]
>definition unconditionally?
>

You mean remove the ifdef and use sz[4] for both condition?

Then how to differentiate 4M and 2M?

>> +		pr_debug(" [mem %#010lx-%#010lx] page size %s\n",
>> +			 mr->start, mr->end - 1, sz[s]);
>> +	}
>>  }

-- 
Wei Yang
Help you, Help me
