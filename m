Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF966C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7941206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbfG3WkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:40:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:25382 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbfG3WkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:40:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 15:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="162868018"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2019 15:40:05 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 52A6E58060A;
        Tue, 30 Jul 2019 15:40:05 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] mm/vmalloc.c: Fix percpu free VM area search
 criteria
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190730204643.tsxgc3n4adb63rlc@pc636>
 <d121eb22-01fd-c549-a6e8-9459c54d7ead@intel.com>
 <9fdd44c2-a10e-23f0-a71c-bf8f3e6fc384@linux.intel.com>
 <20190730223400.hzsyjrxng2s5gk4u@pc636>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <63e48375-afa4-4ab6-240d-1633d7cc9ea4@linux.intel.com>
Date:   Tue, 30 Jul 2019 15:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730223400.hzsyjrxng2s5gk4u@pc636>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/30/19 3:34 PM, Uladzislau Rezki wrote:
> Hello, Sathyanarayanan.
>
>> I agree with Dave. I don't think this issue is related to NUMA. The problem
>> here is about the logic we use to find appropriate vm_area that satisfies
>> the offset and size requirements of pcpu memory allocator.
>>
>> In my test case, I can reproduce this issue if we make request with offset
>> (ffff000000) and size (600000).
>>
> Just to clarify, does it mean that on your setup you have only one area with the
> 600000 size and 0xffff000000 offset?
No, its 2 areas. with offset (0, ffff000000) and size (a00000, 600000).
>
> Thank you.
>
> --
> Vlad Rezki
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

