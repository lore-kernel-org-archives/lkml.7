Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E091FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEA420881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfENRUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:20:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59390 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfENRUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:20:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6924C374;
        Tue, 14 May 2019 10:20:11 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01943F575;
        Tue, 14 May 2019 10:20:08 -0700 (PDT)
Subject: Re: [PATCH v7 10/13] selftests/resctrl: Add vendor detection
 mechanism
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <1549767042-95827-11-git-send-email-fenghua.yu@intel.com>
 <20190510183909.65732a67@donnerap.cambridge.arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <5cc3b562-6e48-f64c-06dd-b1ee1059e33e@arm.com>
Date:   Tue, 14 May 2019 18:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510183909.65732a67@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

(thanks for digging into this!)

On 10/05/2019 18:39, Andre Przywara wrote:
> On Sat,  9 Feb 2019 18:50:39 -0800
> Fenghua Yu <fenghua.yu@intel.com> wrote:
>> From: Babu Moger <babu.moger@amd.com>
>>
>> RESCTRL feature is supported both on Intel and AMD now. Some features
>> are implemented differently. Add vendor detection mechanism. Use the vendor
>> check where there are differences.
> 
> I don't think vendor detection is the right approach. The Linux userland
> interface should be even architecture agnostic, not to speak of different
> vendors.
> 
> But even if we need this for some reason ...

>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index 3959b2b0671a..1d9adcfbdb4c 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -14,6 +14,66 @@
>>  #define BENCHMARK_ARGS		64
>>  #define BENCHMARK_ARG_SIZE	64
>>  
>> +/**
>> + * This variables provides information about the vendor
>> + */
>> +int genuine_intel;
>> +int authentic_amd;
>> +
>> +void lcpuid(const unsigned int leaf, const unsigned int subleaf,
>> +	    struct cpuid_out *out)
> 
> There is a much easier way to detect the vendor, without resorting to
> (unchecked) inline assembly in userland:

> I changed this to scan /proc/cpuinfo for a line starting with vendor_id,
> then use the information there. This should work everywhere.

Everywhere x86. /proc/cpuinfo is unfortunately arch specific, arm64 spells that field 'CPU
implementer'. Short of invoking lscpu, I don't know a portable way of finding this string.

What do we need it for? Surely it indicates something is wrong with the kernel interface
if you need to know which flavour of CPU this is.

The only differences I've spotted are the 'MAX_MBA_BW' on Intel is a percentage, on AMD
its a number between 1 and 2K. If user-space needs to know we could add another file with
the 'max_bandwidth'. (I haven't spotted how the MBA default_ctrl gets exposed).

The other one is the non-contiguous CBM values, where user-space is expected to try it and
see [0]. If user-space needs to know, we could expose some 'sparse_bitmaps=[0 1]', unaware
user-space keeps working.


Thanks,

James

[0] https://lore.kernel.org/patchwork/patch/991236/#1179944
