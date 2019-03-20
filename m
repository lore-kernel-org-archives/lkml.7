Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78131C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451D620835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dz13dbwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCTB3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:29:24 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25874 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCTB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553045364; x=1584581364;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=E38eZeQ9viQA5lcPyg6T8ZDnldIgV4Gx/PClWhyMd1Y=;
  b=Dz13dbwyBOzM+BqGbKwiwJO9Gte2lntOxcaJtXSKJbAAACFe239wAE17
   9htXUFydaoU0VKD4hxYePcjv0OhTlC18rjIhj8dv7GEHOEui2Adp5Xdw4
   zUuaYzqBuS+DDs4lHAgpOnE0ZvS7ND08cS9sPTNOO3gA/CImErj4i4B6Y
   MWZ+O66JOL4HqiJ7KhhcVaR8oqkSQfH/548Oqc/ZhZ0qrQTDXZI6q8nxI
   7yfpB3NnSwE38hxtaNHOu5J01wXKujGgkRKlcAu4Qwnc58R1BX0vDF2TF
   WEyDapUayK0AhuorpxYWatOdk/QHb2LNphewFYGBzxjpAYFE5iTfKQwsS
   A==;
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="105533605"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 09:29:24 +0800
IronPort-SDR: UyC1AfKo5AeepZUZkML4jvpdboQ/a5Kdar40DYnOjZocuv0E9BanWWWrUYd0ltp9BH+nfBr6Lw
 LO0nCDuuED3XtPIm/W8FAgXLVY6tSZiHI8mnNfjp2D/QEZYI29RBYC9fkRuILMQbhww6EUii1T
 oXMvh06rJFFTKxL6d0Tq9pcSIcP9OYVHpwg+PEYykkRieYTHqYz6Hoytcs8i9mw/kCQaZZjClR
 +KGz7GEY19Lp1H81spiWfcsx0lQNA8R0/PKvaspF9JvyRj5RqnNrSys3CNfVO7+BFD/jbB+tkw
 ADqHxtrX7S3YMFJrCGrNmjUk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Mar 2019 18:07:01 -0700
IronPort-SDR: ehNFdQnfwd/m+YDcdOgF4/akeWcqQ3xEoATR/qDhm0CgvHERM2qSgNbKPtT1SgneCBv3gXpAlK
 0dg9EyZye1LX9w283yHtxHJQ4jePb/p2fcX/U5aJGmgAmUDpuiTeyjXv0suiDQYO8IeTYYr56M
 KTJv6mKsqJUIMlBOMPaDg+KKcVlep0E97KU2vS99NXtgN4O2G9j8BHEHK1GBNAEgXaYRNiSxk6
 yZZIuOVDGZP8s0bcranNx5mZYr3AaSvD8vRuDZRUtlOycyQirn5qKYruxh8wlVUYOqH+Un7vhx
 tYk=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.70.138]) ([10.111.70.138])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Mar 2019 18:29:24 -0700
Subject: Re: [v1 PATCH 4/4] RISC-V: Support nr_cpus command line option.
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
References: <20190319222028.4293-1-atish.patra@wdc.com>
 <20190319222028.4293-4-atish.patra@wdc.com>
 <BYAPR04MB5816217E1BD06F0EB68E15A7E7400@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58168FE99AA058FB79A0650EE7400@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <17dc2df7-a730-1461-2577-1a05ec27d32d@wdc.com>
Date:   Tue, 19 Mar 2019 18:29:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB58168FE99AA058FB79A0650EE7400@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 4:58 PM, Damien Le Moal wrote:
> On 2019/03/20 8:56, Damien Le Moal wrote:
>> On 2019/03/20 7:20, Atish Patra wrote:
>>> If nr_cpus command line option is set, maximum possible cpu should be
>>> set to that value.
>>>
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>> ---
>>>   arch/riscv/kernel/smpboot.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>>> index 609475c5..a8fe590c 100644
>>> --- a/arch/riscv/kernel/smpboot.c
>>> +++ b/arch/riscv/kernel/smpboot.c
>>> @@ -86,11 +86,19 @@ void __init setup_smp(void)
>>>   		}
>>>   
>>>   		cpuid_to_hartid_map(cpuid) = hart;
>>> -		set_cpu_possible(cpuid, true);
>>
>> This looks weird: the code being changed does not match what patch 3/4 did.
> 
> Arg... Ignore this one. My bad. Morning here, I need more coffee :)
> 
:).

>>
>>>   		cpuid++;
>>>   	}
>>>   
>>>   	BUG_ON(!found_boot_cpu);
>>> +
>>> +	if (cpuid > nr_cpu_ids)
>>> +		pr_warn("Total number of cpus [%d] are greater than configured via nr_cpus [%d]\n",
>>
>> "The total number of cpus [%d] is greater than nr_cpus option value [%d]\n"
>>

ok. I will fix it in v2.

Regards,
Atish
>>> +			cpuid, nr_cpu_ids);
>>> +
>>> +	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
>>> +		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID)
>>> +			set_cpu_possible(cpuid, true);
>>> +	}
>>>   }
>>>   
>>>   int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>>
>>
>>
> 
> 

