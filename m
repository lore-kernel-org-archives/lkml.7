Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79015C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4260A2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfG3VP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:15:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:19804 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbfG3VP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:15:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 14:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="196059110"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2019 14:15:57 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id DA4F65803A5;
        Tue, 30 Jul 2019 14:15:56 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] mm/vmalloc.c: Fix percpu free VM area search
 criteria
To:     Dave Hansen <dave.hansen@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190730204643.tsxgc3n4adb63rlc@pc636>
 <d121eb22-01fd-c549-a6e8-9459c54d7ead@intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <9fdd44c2-a10e-23f0-a71c-bf8f3e6fc384@linux.intel.com>
Date:   Tue, 30 Jul 2019 14:13:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d121eb22-01fd-c549-a6e8-9459c54d7ead@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/30/19 1:54 PM, Dave Hansen wrote:
> On 7/30/19 1:46 PM, Uladzislau Rezki wrote:
>>> +		/*
>>> +		 * If required width exeeds current VA block, move
>>> +		 * base downwards and then recheck.
>>> +		 */
>>> +		if (base + end > va->va_end) {
>>> +			base = pvm_determine_end_from_reverse(&va, align) - end;
>>> +			term_area = area;
>>> +			continue;
>>> +		}
>>> +
>>>   		/*
>>>   		 * If this VA does not fit, move base downwards and recheck.
>>>   		 */
>>> -		if (base + start < va->va_start || base + end > va->va_end) {
>>> +		if (base + start < va->va_start) {
>>>   			va = node_to_va(rb_prev(&va->rb_node));
>>>   			base = pvm_determine_end_from_reverse(&va, align) - end;
>>>   			term_area = area;
>>> -- 
>>> 2.21.0
>>>
>> I guess it is NUMA related issue, i mean when we have several
>> areas/sizes/offsets. Is that correct?
> I don't think NUMA has anything to do with it.  The vmalloc() area
> itself doesn't have any NUMA properties I can think of.  We don't, for
> instance, partition it into per-node areas that I know of.
>
> I did encounter this issue on a system with ~100 logical CPUs, which is
> a moderate amount these days.

I agree with Dave. I don't think this issue is related to NUMA. The 
problem here is about the logic we use to find appropriate vm_area that 
satisfies the offset and size requirements of pcpu memory allocator.

In my test case, I can reproduce this issue if we make request with 
offset (ffff000000) and size (600000).

>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

