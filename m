Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F7DC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05043206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfHPDRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 23:17:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:7702 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfHPDRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 23:17:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 20:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="179556549"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2019 20:17:07 -0700
Received: from [10.226.38.74] (rtanwar-mobl.gar.corp.intel.com [10.226.38.74])
        by linux.intel.com (Postfix) with ESMTP id DA4465806C4;
        Thu, 15 Aug 2019 20:17:04 -0700 (PDT)
Subject: Re: [PATCH 1/3] x86: cpu: Use constant definitions for CPU type
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
References: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
 <bb09309eb9b4de8b8eff83d00d34c135b048fe25.1565856842.git.rahul.tanwar@linux.intel.com>
 <alpine.DEB.2.21.1908151226580.1923@nanos.tec.linutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <ab4c986c-cd28-7621-f81a-daeb0e597a20@linux.intel.com>
Date:   Fri, 16 Aug 2019 11:17:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908151226580.1923@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,


Thanks for your comments.


On 15/8/2019 6:31 PM, Thomas Gleixner wrote:
> Rahul,
>
> On Thu, 15 Aug 2019, Rahul Tanwar wrote:
>
> Please use the proper prefix for your patches. x86 uses
>
> x86/subsystem: not x86: subsystem:


Well noted.


>> This patch replaces direct values usage with constant definitions usage
>> when access CPU models.
> Please do not use 'This patch'. We already know that this is a patch
> otherwise you wouldn't have sent it with [PATCH] on the subject line,
> right?
>
> See Documentation/process/submitting-patches.rst and search for 'This
> patch'.


Well noted.


>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> ---
>>   arch/x86/kernel/cpu/intel.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index 8d6d92ebeb54..0419fba1ea56 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -265,9 +265,9 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>>   	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
>>   	if (c->x86 == 6) {
>>   		switch (c->x86_model) {
>> -		case 0x27:	/* Penwell */
>> -		case 0x35:	/* Cloverview */
>> -		case 0x4a:	/* Merrifield */
>> +		case INTEL_FAM6_ATOM_SALTWELL_MID:	/* Penwell */
>> +		case INTEL_FAM6_ATOM_SALTWELL_TABLET:	/* Cloverview */
>> +		case INTEL_FAM6_ATOM_SILVERMONT_MID:	/* Merrifield */
> Are these comments really still useful now that the defines are used? I
> don't think so.


Agree that these comments can be removed here. These comments are useful to

associate the CPU model with the product name. But, i think, the right 
place to have

these comments is intel-family.h. I will remove these comments from here 
in V2.


Regards,

Rahul

