Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5795C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DCE20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZbE4zfTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDKSmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:42:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9923 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDKSmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555008129; x=1586544129;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hIqJpL9qmrEfYgXeeTAks3CkmZml+PfGdaFICYG+Af4=;
  b=ZbE4zfTsGvjnul4QXIXs83UzvWHcDG32BQaA+wQP1xAE5AWeq0rSDkM/
   ohgyAylNDnOTHktdqYCCuDO5hnDn9R6DgSgzgqeGcgQgVqPSkmO2BmBa4
   2ohGx7Omd18m9ao52Wqad0Tl9+OY9G+ikg4/60FgVd0TotHOU3ieRnXdn
   aBpl2NgK2uby/MPZ3dC5alztPX8AyyhOSlGGNYhOVvWwkE/WGJ2m+Op60
   WKn9TZ9WLnmaki7BTBE5f+wofaGQ3wGkWLSwSVuAtmSFG42GMA8yVE4/v
   fjMYfnosrUJBLhCec38bz/0RALs5Cad1b90lxGDgh0mwtxPqZYky6YBOk
   g==;
X-IronPort-AV: E=Sophos;i="5.60,338,1549900800"; 
   d="scan'208";a="110650033"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2019 02:42:09 +0800
IronPort-SDR: tEQMnj92rD6xH0Dj8/xuDZTfORQfy74VZUMtecS63Tkwntp6gFmi07+tJmWk4buFhy/RhQyCdD
 Udc2p3nNsztvfPuJmhEPKW6J5+SQbXeC0S7pUoO4gZM03V10mDzzD+BIby/2Q1dYfSUHwdQ/dq
 s0zRG+MinAVoOm8653VFVFnnKuXhyN9nyGBmECIQTNMbDYXn7K+lP56pD2YDjZM8RRt0wg9jQe
 KVWeq7F+y/jiZBhSgF5eURAHexo0vdHlzFCw1N/i8caQrM0ix7L1T0hy45WG7dz6EgnTykysHK
 m+3LJk2+1lX8++vz9EtUxjRw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Apr 2019 11:19:01 -0700
IronPort-SDR: APu4HWZAoD3hiQKINbXvLNyEuMol863baIgLCy4vuWkwm6FK6hYK51/GHCU1H9rYryicNpsrkw
 m7KD+ZP+INUni8aG7daUFJEDXzVL7DT/6CnuRCUFiP372o1d3w/9pdF+94BbsXa0eSjmNyc+aO
 gcOpCUdM/tZnvlXUag0xbt+CkJSxmANSsuHtwm6f4qORcY0WX7VtjcxpYlcSrDMBxVgkX5A9fe
 3IQ0VUZ84MeQQbD0ZWF22ir3Ifu8bW+Hx+FeIPGonucoknTNJwzsFxno6VnGZYJYC4bD8RhXW7
 IcI=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Apr 2019 11:42:09 -0700
Subject: Re: [PATCH v2 3/4] RISC-V: Implement nosmp commandline option.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20190410230443.15729-1-atish.patra@wdc.com>
 <20190410230443.15729-4-atish.patra@wdc.com>
 <20190411070119.GD29422@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <fbc18e77-f75c-6f34-2f2e-b461807ba910@wdc.com>
Date:   Thu, 11 Apr 2019 11:42:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411070119.GD29422@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 12:01 AM, Christoph Hellwig wrote:
> On Wed, Apr 10, 2019 at 04:04:42PM -0700, Atish Patra wrote:
>> nosmp command line option sets max_cpus to zero. No secondary harts
>> will boot if this is enabled. But present cpu mask will still point to
>> all possible masks.
>>
>> Fix present cpu mask for nosmp usecase.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/kernel/smpboot.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>> index eb533b5c2c8c..a8ad200581aa 100644
>> --- a/arch/riscv/kernel/smpboot.c
>> +++ b/arch/riscv/kernel/smpboot.c
>> @@ -47,6 +47,17 @@ void __init smp_prepare_boot_cpu(void)
>>   
>>   void __init smp_prepare_cpus(unsigned int max_cpus)
>>   {
>> +	int cpuid;
>> +
>> +	/* This covers non-smp usecase mandated by "nosmp" option */
>> +	if (max_cpus == 0)
>> +		return;
>> +
>> +	for_each_possible_cpu(cpuid) {
>> +		if (cpuid == smp_processor_id())
>> +			continue;
>> +		set_cpu_present(cpuid, true);
>> +	}
> 
> Most other architectures seem to use init_cpu_present() here.
> 

I did a quick grep through other archs. Mostly, init_cpu_present is 
preferred when you update a entire cpumask or cpu 0.
We can just use cpu_possible_mask and init_cpu_present together to avoid 
the loop. It will just set the current boot cpu bit once more.

But looking at ARM64 code, we may have to bring back the loop when we 
have some implementation similar cpu_ops.

Regards,
Atish

> Otherwise this looks fine to me.
> 

