Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349B7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEF421726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfEHQn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:43:57 -0400
Received: from foss.arm.com ([217.140.101.70]:40270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfEHQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:43:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF3F1374;
        Wed,  8 May 2019 09:43:55 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31F693F238;
        Wed,  8 May 2019 09:43:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] coresight: Do not call smp_processor_id() from
 preemptible
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
References: <1556899459-27785-1-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkyxDY8g9zyhTyTqALgF5dmVX1F7DA_93ECpnvAaACYX8g@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ea6e3e0f-dea4-39dd-cc29-14001091a4ec@arm.com>
Date:   Wed, 8 May 2019 17:43:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkyxDY8g9zyhTyTqALgF5dmVX1F7DA_93ECpnvAaACYX8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/2019 17:39, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Fri, 3 May 2019 at 10:04, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Instead of using smp_processor_id() to figure out the node,
>> use the numa_node_id() for the current CPU node to avoid
>> splats like :
>>
>>   BUG: using smp_processor_id() in preemptible [00000000] code: perf/1743
>>   caller is alloc_etr_buf.isra.6+0x80/0xa0
>>   CPU: 1 PID: 1743 Comm: perf Not tainted 5.1.0-rc6-147786-g116841e #344
>>   Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Feb  1 2019
>>    Call trace:
>>     dump_backtrace+0x0/0x150
>>     show_stack+0x14/0x20
>>     dump_stack+0x9c/0xc4
>>     debug_smp_processor_id+0x10c/0x110
>>     alloc_etr_buf.isra.6+0x80/0xa0
>>     tmc_alloc_etr_buffer+0x12c/0x1f0
>>     etm_setup_aux+0x1c4/0x230
>>     rb_alloc_aux+0x1b8/0x2b8
>>     perf_mmap+0x35c/0x478
>>     mmap_region+0x34c/0x4f0
>>     do_mmap+0x2d8/0x418
>>     vm_mmap_pgoff+0xd0/0xf8
>>     ksys_mmap_pgoff+0x88/0xf8
>>     __arm64_sys_mmap+0x28/0x38
>>     el0_svc_handler+0xd8/0x138
>>     el0_svc+0x8/0xc
>>
> 
> That is very interesting...
> 
>> Fixes: 855ab61c16bf70b646 ("coresight: tmc-etr: Refactor function tmc_etr_setup_perf_buf()")
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 793639f..74578bd 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1323,13 +1323,11 @@ static struct etr_perf_buffer *
>>   tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
>>                         int nr_pages, void **pages, bool snapshot)
>>   {
>> -       int node, cpu = event->cpu;
>> +       int node;
>>          struct etr_buf *etr_buf;
>>          struct etr_perf_buffer *etr_perf;
>>
>> -       if (cpu == -1)
>> -               cpu = smp_processor_id();
>> -       node = cpu_to_node(cpu);
>> +       node = (event->cpu == -1)? numa_node_id() : cpu_to_node(event->cpu);
> 
> Seems to me using numa_node_id() simply circumvent function
> debug_smp_processor_id() and using get_cpu() and put_cpu() would be
> more appropriate.  But I'll trust the NUMA people have thought about
> this long before me.  Would you mind sending another revision that fix
> the same code for ETB and ETF?

Sure, will send it soon.

Suzuki
