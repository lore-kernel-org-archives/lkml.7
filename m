Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71FEC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31C421901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbfGYICT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:02:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:62083 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388596AbfGYICT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:02:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 01:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="170171070"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.66.75.233]) ([10.66.75.233])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2019 01:02:15 -0700
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Add ICL-NNPI support to PMC
 Core
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20190614080940.13640-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VfMdKqpC3_gF-VzcJQqiWM9E0irORr60KLXyu8HuQg9KA@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <37653b30-7a76-0896-ecb7-2fbeab4308ec@linux.intel.com>
Date:   Thu, 25 Jul 2019 13:32:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfMdKqpC3_gF-VzcJQqiWM9E0irORr60KLXyu8HuQg9KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 29-Jun-19 6:48 PM, Andy Shevchenko wrote:
> On Fri, Jun 14, 2019 at 11:14 AM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> Ice Lake Neural Network Processor for deep learning inference a.k.a.
>> ICL-NNPI can re-use Ice Lake Mobile regmap to enable Intel PMC Core
>> driver on it.
>>
> This will be postponed till next cycle since the CPU model will not
> appear before merge window.
> So, please, resend than (I guess somewhat in a month).


The dependent CPUID Patch is now upstream, 
https://github.com/torvalds/linux/blob/bed38c3e2dca01b358a62b5e73b46e875742fd75/arch/x86/include/asm/intel-family.h#L59 
so can you please apply this one?


Thank you

Rajneesh


>
>> Cc: Darren Hart <dvhart@infradead.org>
>> Cc: Andy Shevchenko <andy@infradead.org>
>> Cc: platform-driver-x86@vger.kernel.org
>> Link: https://lkml.org/lkml/2019/6/5/1034
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel_pmc_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
>> index 1d902230ba61..be6cda89dcf5 100644
>> --- a/drivers/platform/x86/intel_pmc_core.c
>> +++ b/drivers/platform/x86/intel_pmc_core.c
>> @@ -815,6 +815,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>          INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
>>          INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
>>          INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
>> +       INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
>>          {}
>>   };
>>
>> --
>> 2.17.1
>>
>
