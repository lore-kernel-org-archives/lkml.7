Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA83C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F40927DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VlSP2Dac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfFCItW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:49:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34193 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFCItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559551760; x=1591087760;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MwpcSDOILdT5IlbEBeqtJ6errBQ16K1SSoalEiTlrzk=;
  b=VlSP2DacJ5TiF/66ZEF3ZUNMF9FAsy9vwxY7gOuRrpe+udLHzhyMhOeM
   lfsQ39wpyvBTQ0L9q8N2BcGymF91FLKBW1wAkT4JDB0O4kVVt0AHIrwuE
   2dgXXT+psw/ipfLnjZLXU1hGP+0weIKTUCXHCr9nqYQZdcoVVeqshvMA7
   HckLwzcturdSFfUBJtgrdn659YzzNqtjh9oEhrW1e1jzIKQJekMKE/oI0
   qZOLgHQJeKViEL05ocyFUoQZxO40FB+u+aw5VJ9XPWohtd5mjuaeA1RqM
   HS8j+WVC9/EFzoXrvHDxhjbvd4BH+cb5GQR9wJdMADE5NJhyOt1YRnrde
   g==;
X-IronPort-AV: E=Sophos;i="5.60,546,1549900800"; 
   d="scan'208";a="215919242"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2019 16:49:20 +0800
IronPort-SDR: yDZzYVwhNjgxE1j63nbft16FnfPQHnPQgjjNuMLFd/P+ft12COVU5HYrqC9hMovdtCvlVFRkgU
 bXFhaRFvhId35P05SgeDr/6tCl9XxJ5joIvXCfa6Whg0cTwZpahGHCphUpiESBSkDP6dTSALsO
 WK0BIgkgY9qYZRCi/AqOl4dr+g91mLUZrevxduBP7dVg7NnfM063znTGJA3lyRu7h85B1cIGSr
 v/2fFlvd+Ml7Tsc9jcXK/nZrOSpkCHPn2soP90nqCF1xK7+xNwf7rwYc1sxIdgvIMO6uvNwXQ4
 f9gxykj05pjWviLVpj1VUL2b
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 03 Jun 2019 01:24:23 -0700
IronPort-SDR: gCsdst6ihQVc3cWehGBwrDNcFnkYEvZYfs6K5Bd8evj/57lPWFsV64FqebkBljZbypOrN5zULP
 N+w4qwTlLLUejnUfC10+n0jo6Myy7+aN0AWvxJ/P8ffZ4rUpcfjr/yMZd8WCide5DX2WH5uGlK
 5a4/zFsUE6loi3os/hC6DfsF1RIVnQfGAKZJq/b30wbkX7X9lnf15aBlsOHLwUjfF9JqKo0yQt
 CxHWUfAw/UKuEKC10bitMU/1GaLYJdXbNdVH8b4KA0lbj1cPUQfA1s7VRa39VSHPlPzc05uFSr
 KG4=
Received: from unknown (HELO [10.225.104.42]) ([10.225.104.42])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Jun 2019 01:49:19 -0700
Subject: Re: [PATCH v6 2/7] dt-binding: cpu-topology: Move cpu-map to a common
 binding.
To:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Otto Sabart <ottosabart@seberm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-3-atish.patra@wdc.com>
 <0515d803-0da5-dcbe-3d3e-bb786b320d8b@arm.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <28118149-193d-2a8a-995a-2f1829e95c1c@wdc.com>
Date:   Mon, 3 Jun 2019 01:49:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0515d803-0da5-dcbe-3d3e-bb786b320d8b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 1:55 PM, Jeremy Linton wrote:
> Hi,
> 
> On 5/29/19 4:13 PM, Atish Patra wrote:
>> cpu-map binding can be used to described cpu topology for both
>> RISC-V & ARM. It makes more sense to move the binding to document
>> to a common place.
>>
>> The relevant discussion can be found here.
>> https://lkml.org/lkml/2018/11/6/19
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>    .../topology.txt => cpu/cpu-topology.txt}     | 82 +++++++++++++++----
>>    1 file changed, 66 insertions(+), 16 deletions(-)
>>    rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> similarity index 86%
>> rename from Documentation/devicetree/bindings/arm/topology.txt
>> rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> index 3b8febb46dad..069addccab14 100644
>> --- a/Documentation/devicetree/bindings/arm/topology.txt
>> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> @@ -1,12 +1,12 @@
>>    ===========================================
>> -ARM topology binding description
>> +CPU topology binding description
>>    ===========================================
>>    
>>    ===========================================
>>    1 - Introduction
>>    ===========================================
>>    
>> -In an ARM system, the hierarchy of CPUs is defined through three entities that
>> +In a SMP system, the hierarchy of CPUs is defined through three entities that
>>    are used to describe the layout of physical CPUs in the system:
>>    
>>    - socket
>> @@ -14,9 +14,6 @@ are used to describe the layout of physical CPUs in the system:
>>    - core
>>    - thread
>>    
>> -The cpu nodes (bindings defined in [1]) represent the devices that
>> -correspond to physical CPUs and are to be mapped to the hierarchy levels.
>> -
>>    The bottom hierarchy level sits at core or thread level depending on whether
>>    symmetric multi-threading (SMT) is supported or not.
>>    
>> @@ -25,33 +22,31 @@ threads existing in the system and map to the hierarchy level "thread" above.
>>    In systems where SMT is not supported "cpu" nodes represent all cores present
>>    in the system and map to the hierarchy level "core" above.
>>    
>> -ARM topology bindings allow one to associate cpu nodes with hierarchical groups
>> +CPU topology bindings allow one to associate cpu nodes with hierarchical groups
>>    corresponding to the system hierarchy; syntactically they are defined as device
>>    tree nodes.
>>    
>> -The remainder of this document provides the topology bindings for ARM, based
>> -on the Devicetree Specification, available from:
>> +Currently, only ARM/RISC-V intend to use this cpu topology binding but it may be
>> +used for any other architecture as well.
>>    
>> -https://www.devicetree.org/specifications/
>> +The cpu nodes, as per bindings defined in [4], represent the devices that
>> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
>>    
>> -If not stated otherwise, whenever a reference to a cpu node phandle is made its
>> -value must point to a cpu node compliant with the cpu node bindings as
>> -documented in [1].
>>    A topology description containing phandles to cpu nodes that are not compliant
>> -with bindings standardized in [1] is therefore considered invalid.
>> +with bindings standardized in [4] is therefore considered invalid.
>>    
>>    ===========================================
>>    2 - cpu-map node
>>    ===========================================
>>    
>> -The ARM CPU topology is defined within the cpu-map node, which is a direct
>> +The ARM/RISC-V CPU topology is defined within the cpu-map node, which is a direct
>>    child of the cpus node and provides a container where the actual topology
>>    nodes are listed.
>>    
>>    - cpu-map node
>>    
>> -	Usage: Optional - On ARM SMP systems provide CPUs topology to the OS.
>> -			  ARM uniprocessor systems do not require a topology
>> +	Usage: Optional - On SMP systems provide CPUs topology to the OS.
>> +			  Uniprocessor systems do not require a topology
>>    			  description and therefore should not define a
>>    			  cpu-map node.
>>    
>> @@ -494,8 +489,63 @@ cpus {
>>    	};
>>    };
>>    
>> +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
>> +
>> +{
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	compatible = "sifive,fu540g", "sifive,fu500";
>> +	model = "sifive,hifive-unleashed-a00";
>> +
>> +	...
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&CPU1>;
>> +				};
>> +				core1 {
>> +					cpu = <&CPU2>;
>> +				};
>> +				core2 {
>> +					cpu0 = <&CPU2>;
>> +				};
>> +				core3 {
>> +					cpu0 = <&CPU3>;
>> +				};
>> +			};
>> +		};
> 
> 
> <nit picking>
> 
> While socket is optional, its probably a good idea to include the node
> in the example even if the result is the same. 

Sure. I will update that.

That is because at least
> on arm64 the DT clusters=sockets decision had performance implications
> for larger systems.
> 
> Assuring the socket information is correct is helpful by itself to avoid
> having to explain why a single socket machine is displaying some other
> value in lscpu.
> 
Just for my understanding, can you give a example?

> 
> 
>> +
>> +		CPU1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "sifive,rocket0", "riscv";
>> +			reg = <0x1>;
>> +		}
>> +
>> +		CPU2: cpu@2 {
>> +			device_type = "cpu";
>> +			compatible = "sifive,rocket0", "riscv";
>> +			reg = <0x2>;
>> +		}
>> +		CPU3: cpu@3 {
>> +			device_type = "cpu";
>> +			compatible = "sifive,rocket0", "riscv";
>> +			reg = <0x3>;
>> +		}
>> +		CPU4: cpu@4 {
>> +			device_type = "cpu";
>> +			compatible = "sifive,rocket0", "riscv";
>> +			reg = <0x4>;
>> +		}
>> +	}
>> +};
>>    ===============================================================================
>>    [1] ARM Linux kernel documentation
>>        Documentation/devicetree/bindings/arm/cpus.yaml
>>    [2] Devicetree NUMA binding description
>>        Documentation/devicetree/bindings/numa.txt
>> +[3] RISC-V Linux kernel documentation
>> +    Documentation/devicetree/bindings/riscv/cpus.txt
>> +[4] https://www.devicetree.org/specifications/
>>
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


-- 
Regards,
Atish
