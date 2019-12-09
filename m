Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA14C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9C9207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLIKY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:24:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:54240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfLIKY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:24:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F954AE5C;
        Mon,  9 Dec 2019 10:24:24 +0000 (UTC)
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
To:     Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <7fc610be-df56-c5ae-33fb-53b471aa76d1@suse.com>
Date:   Mon, 9 Dec 2019 11:24:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209100717.GC6156@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.19 11:07, Michal Hocko wrote:
> On Fri 06-12-19 23:05:24, Baoquan He wrote:
>> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
>> parameter") a global varialbe global max_mem_size is added to store
>> the value which is parsed from 'mem= '. This truly stops those
>> DIMM from being added into system memory during boot.
>>
>> However, it also limits the later memory hotplug functionality. Any
>> memory board can't be hot added any more if its region is beyond the
>> max_mem_size. System will print error like below:
>>
>> [  216.387164] acpi PNP0C80:02: add_memory failed
>> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
>> [  216.392187] acpi PNP0C80:02: Enumeration failure
>>
>> >From document of 'mem =' parameter, it should be a restriction during
>> boot, but not impact the system memory adding/removing after booting.
>>
>>    mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
>>
>> So fix it by also checking if it's during SYSTEM_BOOTING stage when
>> restrict memory adding. Otherwise, skip the restriction.
> 
> Could you be more specific about why the boot vs. later hotplug makes
> any difference? The documentation is explicit about the boot time but
> considering this seems to be like that since ever I strongly suspect
> that this is just an omission.
> 
> Btw. how have you tested the situation fixed by 357b4da50a62?

I guess he hasn't.

The backtrace of the problem at that time was:

[ 8321.876844]  [<ffffffff81019ab9>] dump_trace+0x59/0x340
[ 8321.882683]  [<ffffffff81019e8a>] show_stack_log_lvl+0xea/0x170
[ 8321.889298]  [<ffffffff8101ac31>] show_stack+0x21/0x40
[ 8321.895043]  [<ffffffff81319530>] dump_stack+0x5c/0x7c
[ 8321.900779]  [<ffffffff8107fbf1>] warn_slowpath_common+0x81/0xb0
[ 8321.907482]  [<ffffffff81009f54>] xen_alloc_pte+0x1d4/0x390
[ 8321.913718]  [<ffffffff81064950>] 
pmd_populate_kernel.constprop.6+0x40/0x80
[ 8321.921498]  [<ffffffff815ef0a8>] phys_pmd_init+0x210/0x255
[ 8321.927724]  [<ffffffff815ef2c7>] phys_pud_init+0x1da/0x247
[ 8321.933951]  [<ffffffff815efb81>] kernel_physical_mapping_init+0xf5/0x1d4
[ 8321.941533]  [<ffffffff815ebc7d>] init_memory_mapping+0x18d/0x380
[ 8321.948341]  [<ffffffff810647f9>] arch_add_memory+0x59/0xf0
[ 8321.954570]  [<ffffffff815eceed>] add_memory_resource+0x8d/0x160
[ 8321.961283]  [<ffffffff815ecff2>] add_memory+0x32/0xf0
[ 8321.967025]  [<ffffffff813e1c91>] acpi_memory_device_add+0x131/0x2e0
[ 8321.974128]  [<ffffffff8139f752>] acpi_bus_attach+0xe2/0x190
[ 8321.980453]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
[ 8321.986778]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
[ 8321.993103]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
[ 8321.999428]  [<ffffffff813a1157>] acpi_bus_scan+0x37/0x70
[ 8322.005461]  [<ffffffff81fba955>] acpi_scan_init+0x77/0x1b4
[ 8322.011690]  [<ffffffff81fba70c>] acpi_init+0x297/0x2b3
[ 8322.017530]  [<ffffffff8100213a>] do_one_initcall+0xca/0x1f0
[ 8322.023855]  [<ffffffff81f74266>] kernel_init_freeable+0x194/0x226
[ 8322.030760]  [<ffffffff815eb1ba>] kernel_init+0xa/0xe0
[ 8322.036503]  [<ffffffff815f7bc5>] ret_from_fork+0x55/0x80

So this patch would break it again.

I'd recommend ...

> 
>> Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem= parameter")
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> ---
>>   mm/memory_hotplug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 55ac23ef11c1..5466a0a00901 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -105,7 +105,7 @@ static struct resource *register_memory_resource(u64 start, u64 size)
>>   	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>>   	char *resource_name = "System RAM";
>>   
>> -	if (start + size > max_mem_size)
>> +	if (start + size > max_mem_size && system_state == SYSTEM_BOOTING)

... changing this to: ... && system_state != SYSTEM_RUNNING

With that you can add my:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
