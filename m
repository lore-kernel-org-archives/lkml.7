Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A07DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2A5218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HbkLtCh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfDXQvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:51:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24779 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbfDXQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556124659; x=1587660659;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GlUjytnYt3dDfD0kI047DD3j/C12yQtxAL+gnd5rzyQ=;
  b=HbkLtCh6XsMGoGAEzkK4CJLdjXwQ7bv8MV5J3xJRx+SVa7mE9w9MYN21
   LORP/1Zg3oYcptpvwIXFnJ6j+p8WoZHBc+Be41ONFsw1pWxVhRm21epBo
   jCKjIQUZd7w2GnwXt2ZIVCyz6NzvU849E4KP2IkKVugQlKBj2pdBHJmf5
   qQPUCBEj8CEepD1DN+bevuscBNPQ5YktUsistgj+9t+IIhKYdZR3kTKbh
   phZsrtJlJzVlkSp1IQuzo4++Jy3x92KQ4gOy+HtspZpMuQ90excBA686Y
   cSvjVePcr4qK8J7aMbDw0ydBeG1erBGqA3M7693Cjspc6yETuV+yvlF3+
   A==;
X-IronPort-AV: E=Sophos;i="5.60,390,1549900800"; 
   d="scan'208";a="111663282"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 00:50:58 +0800
IronPort-SDR: Ggx22oOE5oH+C/mscY1kswdsobltge8lhw9AvWTnQbOm8LikbuBEeOJAUUJp3X8WGk1Rr8RRNl
 a8LWQJ+76+jEOOtMOtzeiMN7hkqF5F1YVqnIKfwv4Nt4+3aFvwGPBtDONpdaUmoc+oy7sB1MXt
 cE1AMtpWJyxVOnRa6kS7Y+psXYVS+RgQF76uK7mIWEFXbUIW6fQPsBqdgZf31fca2/DHxkEc1X
 v3XpjGaV45PmqWnn6Mbq2Nki8qph38T8gg5suUwCmj1tB+XZgRMuTmoKDwrdmyOgI1Ft5LN+vT
 hq78KgaIb+OBfimxgpsDFgK/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 24 Apr 2019 09:27:29 -0700
IronPort-SDR: iKIwQD+L/YrbHh+8Mjv83xcedcVEBFiC5eNSUa0uHyC2o8OqEN5mNdiXRkVFPVGX+kULGjXisq
 LNTS/ceDKZEGekwAkSeetUdE8mtV/ggbXZzG96yo7HXvdLWxB21LZG3iOGrpTVWJvD9nNf1JhL
 ilJN8gi9QCI3DJu/cdF50cHOmTkysowvc4ndBhIXN5Ejf6hKEVGhJnm+9NxVgu1HS1HY24BtuI
 rFctAfZ5hoRACwrxvOmHHnCwIQb1+qeJB8VFRhi/BdiqpNl+C+M80lhizuZZW7m/I1m2Zr6Z0f
 Q78=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2019 09:50:57 -0700
Subject: Re: [PATCH v3 1/3] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
References: <20190424000227.3085-1-atish.patra@wdc.com>
 <20190424000227.3085-2-atish.patra@wdc.com>
 <CAPKp9uZNEdL=Jt7vsxMBo72WR=ArefB6Vi7fLxnxMwAfUT3JOw@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <0d7be79c-3a74-dcb2-6618-d391e4cfec70@wdc.com>
Date:   Wed, 24 Apr 2019 09:50:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPKp9uZNEdL=Jt7vsxMBo72WR=ArefB6Vi7fLxnxMwAfUT3JOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 2:07 AM, Sudeep Holla wrote:
> On Wed, Apr 24, 2019 at 1:03 AM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> OF/DT core has a hook for architecture specific logical cpuid to hartid
>> mapping. By implementing this, we can pass the logical cpu id to cpu
>> node parsing functions.
>>
>> Fix the instances where logical cpuid is expected as an argument in
>> of_get_cpu_node.
>>
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/kernel/cpu.c | 3 +--
>>   arch/riscv/kernel/smp.c | 5 +++++
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> index cf2fca12414a..c8d2a3223099 100644
>> --- a/arch/riscv/kernel/cpu.c
>> +++ b/arch/riscv/kernel/cpu.c
>> @@ -136,8 +136,7 @@ static void c_stop(struct seq_file *m, void *v)
>>   static int c_show(struct seq_file *m, void *v)
>>   {
>>          unsigned long cpu_id = (unsigned long)v - 1;
>> -       struct device_node *node = of_get_cpu_node(cpuid_to_hartid_map(cpu_id),
>> -                                                  NULL);
> 
> I assume it work working just fine as you are doing cpu to hartid
> conversion here and
> weak implementation of arch_match_cpu_phys_id does direct match.
> 

Yup. That's correct.

Regards,
Atish
>> +       struct device_node *node = of_get_cpu_node(cpu_id, NULL);
>>          const char *compat, *isa, *mmu;
>>
>>          seq_printf(m, "processor\t: %lu\n", cpu_id);
>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>> index 0c41d07ec281..94db72662f60 100644
>> --- a/arch/riscv/kernel/smp.c
>> +++ b/arch/riscv/kernel/smp.c
>> @@ -70,6 +70,11 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
>>          for_each_cpu(cpu, in)
>>                  cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
>>   }
>> +
>> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>> +{
>> +       return phys_id == cpuid_to_hartid_map(cpu);
>> +}
>>   /* Unsupported */
>>   int setup_profiling_timer(unsigned int multiplier)
>>   {
>> --
>> 2.21.0
>>
> 

