Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570AAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106CA2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i59hc2z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfEWXhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 19:37:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18804 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfEWXhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 19:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558654627; x=1590190627;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZIhhpIGFD7zJj6WDIZ2agldWpQH1V2HpIRQEJrRB3ck=;
  b=i59hc2z/qyMdrAM63way0n5DFLPti32C9GiLp25QBWclKJFmCMZ5fKqo
   eOaaycI7YVwkrqBjmg7Pdzeao0/zlsj8oQ7GI8RSG46jpOYKCLOWxDUvf
   9kJRkboi3JJCa+rg10wHzJvxyARwgzYDcQ2//U6HmJhgfTOyBRRRND5Fe
   HFolz+UiRkZ7YQ8yFUp2cY71p8pCeyg0RVc4HZYMI9MGBxwaueSAOfPDf
   JvdpzwNl/Bb8wf2oYpXZ87VeupTtZP7dunzC3pKWyRjR6Vek00pr2gUAv
   N2HZTYZp4wvSju/HOF35XmhvqhEprNqg3FkepR94pvLslr609oCf+xP+y
   A==;
X-IronPort-AV: E=Sophos;i="5.60,505,1549900800"; 
   d="scan'208";a="108974742"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2019 07:37:06 +0800
IronPort-SDR: +3RhTfe9odXqRThB7qektL5KbWpr0Kv4a3xE2wXYfNhXLj20d/cX+nVx8PsXuDaIDQyTFWIrdU
 6krLrpf7AkQBFD5Fur13/LfBkEdebOslUwwiUvEH7O6pYxpD4lAr68+aegSUK73YEIsavFRieA
 CVrnZltDQnb/GPplQtpK+g3ZwnTxy9ZVjZA07js6wsoGMxDVfhv0FL1m2C4ZaP7Z6RW9RAwNW5
 pLZ/f4Y2rwN7Z07Ja2Ot5UGnmL0JrEwuEmZ1hVpm7iR3SUuiTpCumrx/ARL28DlM+O9SBEH7ok
 H14jr2X333vJbKhcd0ASoI83
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 May 2019 16:14:47 -0700
IronPort-SDR: db2blUkD4RtcGdB4eRBhiFkHDDBUCRe9NZ6lRc2cEw51pgA69avNI/0gV7G0cCNMoVH6IUItxj
 qY6QXRyY93vwoPtjtTE6KxRM9pnikVpk9yOcQ6CxFgEpGT1L45i1uNOXQVvLLaEL3KPTP2LNE0
 dcqLTJ59s9xphjvNYHVh+QkRotxKo/s+Ly6C57bWzGn+QdBt+Z24CSiFJnD/QA591TENp0+65G
 Dh2JalP7gVh8cGzipTk8+9G3QxylCtxuoRS0bZ/i3KYAZQE/ddfFhlQS+smfzVLwX6eXJBy69s
 1Pg=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 May 2019 16:37:05 -0700
Subject: Re: [RFT PATCH v4 3/5] cpu-topology: Move cpu topology code to common
 code.
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190428002529.14229-1-atish.patra@wdc.com>
 <20190428002529.14229-4-atish.patra@wdc.com>
 <20190523093549.GA13560@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <935ee66e-d303-5e0f-bbf9-20139ba79d77@wdc.com>
Date:   Thu, 23 May 2019 16:34:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523093549.GA13560@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 2:36 AM, Sudeep Holla wrote:
> On Sat, Apr 27, 2019 at 05:25:27PM -0700, Atish Patra wrote:
>> Both RISC-V & ARM64 are using cpu-map device tree to describe
>> their cpu topology. It's better to move the relevant code to
>> a common place instead of duplicate code.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/topology.h |  23 ---
>>   arch/arm64/kernel/topology.c      | 303 +-----------------------------
>>   drivers/base/arch_topology.c      | 298 ++++++++++++++++++++++++++++-
>>   drivers/base/topology.c           |   1 +
>>   include/linux/arch_topology.h     |  28 +++
>>   5 files changed, 330 insertions(+), 323 deletions(-)
>>
>> -void store_cpu_topology(unsigned int cpuid);
> [...]
> 
> 
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index edfcf8d982e4..2b0758c01cee 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -6,8 +6,8 @@
>>    * Written by: Juri Lelli, ARM Ltd.
>>    */
>>
>> -#include <linux/acpi.h>
>>   #include <linux/arch_topology.h>
>> +#include <linux/acpi.h>
> 
> I assume this was to avoid compilation errors, when I rebased I got
> conflict and I ordered them back alphabetically as before and hit the
> compilation error.
> 
> The actual fix would be to include linux/arch_topology.h in linux/topology.h
> as you are moving contents of asm/topology.h which it includes.
> 
> I did the change and get it tested by kbuild. See [1]
> 

Thanks for pointing that out. I think we can remove arch_topology.h 
include in base/arch_topology.c and base/topology.c as they already 
include sched/topology.h or linux/topology.h.

I will send out v5 soon.

> Regards,
> Sudeep
> 
> [1] https://git.kernel.org/sudeep.holla/linux/h/cpu_topology
> 


-- 
Regards,
Atish
