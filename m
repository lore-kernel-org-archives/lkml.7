Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFF02087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JOufS5Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfDOVQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:16:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5888 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDOVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555363006; x=1586899006;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mZ06PkjkN1kj6AoAOlS4fY0McGXa90ZE9BqMC0BMkog=;
  b=JOufS5Ggkc7xb5tXwhFwlopxty034svER4QPrDuOSsfD9r69/GryYAI6
   D6mJEGDYZG0k4Rt5yQWDiuRPMyVy5dlNaoBMDlGTEzFQ0quxzXlhS++8C
   tyvJmG8lZNGHraQbtn+D9CgnfpEfqNEEK14W7rnCSB78jEQdZ2t/b5KRh
   B8wdfU8dIbgSnq3Oqw1acfU09m1V6gWl7cjNylHn71ZKGsua1xjFj9nRX
   DNcR8uY/YyB2Uob0edpIm+GHDUOimJVL5e5M4vSLrD9gzwnoIGSCgZ4Jz
   yNTALN2fcBxwXcy9YOBAchCBKEOKv/q+fR7cLr3NGFE9+/FIlVgizB4WQ
   A==;
X-IronPort-AV: E=Sophos;i="5.60,355,1549900800"; 
   d="scan'208";a="106027217"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2019 05:16:46 +0800
IronPort-SDR: KqKOmgcpyUqqDK1IfKkKUzGXbwQ1ummsLPfmAcZ6Il4kZNYuFypJpcKh8C0MfqObQ7OjYR6daB
 W4Yidrj3K/+XJbjI+O10m8h/eZaAeN0IsCtsWLYTglp/H3KPZCHySGampJrck6obsSJoGIvi50
 z05WhN52uJPBSY8SCe7if5LxEm6NmadsNY7HeaUw4V7IsdF8GAGRWWiZFICRGhloMoqGEIUB1M
 kWnYXD7NdZfsFl+nFqK0+0d/gatt3lGnlYq6H+rPK1WAZrMMy0dXEWSyTsgVlC+6CHJthK2+6Z
 u8BbtCt2CwpeqtEHxOVZs8CQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 15 Apr 2019 13:53:31 -0700
IronPort-SDR: WyjbmdytrWtcpzzNWefd5pvS4XMx0OHZY9Ezcv8kZjOLto2KRssL/GM/nLI20qrji0nps20rrr
 vwlWCN5S3ROchI5ATm2/z24WqFah18CoBApkHTiOmHxevutj2CGj/pevd3kP4wPbo365ssJ3Pb
 zDPzXTIgJH7d/se4hXe6oKN3xU7SZYHtfno9vcHA8WBnzEVNreyCPQACIy3mqKVCooSeitoWbT
 tq+vsC/kLHfe6VF7FkyxWodOQ5hSeapKDz4x1Rn/n0Gl8VCP80u0kigINPHzIhf+eUdJy+yF/k
 htQ=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2019 14:16:45 -0700
Subject: Re: [RFT/RFC PATCH v3 4/5] arm: Use common cpu_topology
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>
References: <20190320234806.19748-1-atish.patra@wdc.com>
 <20190320234806.19748-5-atish.patra@wdc.com>
 <20190415153147.GB28623@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <41f890e9-3893-9092-bac7-3daca99f181b@wdc.com>
Date:   Mon, 15 Apr 2019 14:16:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415153147.GB28623@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 8:31 AM, Sudeep Holla wrote:
> On Wed, Mar 20, 2019 at 04:48:05PM -0700, Atish Patra wrote:
>> Currently, ARM32 and ARM64 uses different data structures to
>> represent their cpu toplogies. Since, we are moving the ARM64
>> topology to common code to be used by other architectures, we
>> can reuse that for ARM32 as well.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/arm/include/asm/topology.h | 22 +---------------------
>>   arch/arm/kernel/topology.c      | 10 +++++-----
>>   include/linux/arch_topology.h   | 10 +++++++++-
>>   3 files changed, 15 insertions(+), 27 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
>> index d4e76e0a..7c850611 100644
>> --- a/include/linux/arch_topology.h
>> +++ b/include/linux/arch_topology.h
>> @@ -36,17 +36,25 @@ unsigned long topology_get_freq_scale(int cpu)
>>   struct cpu_topology {
>>   	int thread_id;
>>   	int core_id;
>> +#ifdef CONFIG_ARM_CPU_TOPOLOGY
>> +	int socket_id;
> 
> Sorry, but I can't find any reason why we need to do this ifdef dance
> here, especially for socket_id vs package_id ? 

I was not sure if we can rename socket_id to package_id from a semantic 
point of view. If you are okay with it, I will change it to package_id 
and send a v4.

Other's I can understand
> as there are new, but I am sure we can find a way and get away with
> #ifdefery here completely.
> 
That would be good. Any suggestions on how to do that?

>> +#else
>>   	int package_id;
>>   	int llc_id;
>> +	cpumask_t llc_sibling;
>> +#endif
>>   	cpumask_t thread_sibling;
>>   	cpumask_t core_sibling;
>> -	cpumask_t llc_sibling;
>>   };
>>
>>   #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
>>   extern struct cpu_topology cpu_topology[NR_CPUS];
>>
>> +#ifdef CONFIG_ARM_CPU_TOPOLOGY
>> +#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
>> +#else
>>   #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
>> +#endif
> 
> Since all callsites must use topology_physical_package_id, we should be
> able to rename socket_id to package_id easily.
> 
Sure.

Regards,
Atish
> --
> Regards,
> Sudeep
> 

