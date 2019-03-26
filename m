Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F10C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B4D20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfCZNzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:55:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:40211 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731589AbfCZNzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:55:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="155328495"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2019 06:55:02 -0700
Received: from [10.254.89.90] (kliang2-mobl.ccr.corp.intel.com [10.254.89.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B0A64580107;
        Tue, 26 Mar 2019 06:55:01 -0700 (PDT)
Subject: Re: [PATCH V3 01/23] perf/x86: Support outputting XMM registers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
 <20190322163718.2191-2-kan.liang@linux.intel.com>
 <alpine.DEB.2.21.1903260106210.1789@nanos.tec.linutronix.de>
 <5533614f-3d97-6e50-c63c-bee33c00c93b@linux.intel.com>
 <alpine.DEB.2.21.1903261442470.1789@nanos.tec.linutronix.de>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f1fc3d9d-259d-85e7-c85a-949e56bdc631@linux.intel.com>
Date:   Tue, 26 Mar 2019 09:55:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903261442470.1789@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2019 9:47 AM, Thomas Gleixner wrote:
> On Tue, 26 Mar 2019, Liang, Kan wrote:
>> On 3/25/2019 8:11 PM, Thomas Gleixner wrote:
>>
>> -#define REG_RESERVED (~((1ULL << PERF_REG_X86_MAX) - 1ULL))
>> +#define REG_RESERVED	0
>
> What's the point of having this around?

I once thought it may be kept for future extension if we have more regs.
But, yes, we should remove it completely for now.

Thanks,
Kan

> 
>>   int perf_reg_validate(u64 mask)
>>   {
>>   	if (!mask || mask & REG_RESERVED)
>>   		return -EINVAL;
> 
>   mask & 0 == 0, right? So which bits are you checking here?
> 
> Thanks,
> 
> 	tglx
> 
