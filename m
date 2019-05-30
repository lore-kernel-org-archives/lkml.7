Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D0C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1BC26194
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfE3UzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:55:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42416 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3UzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:55:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF11C341;
        Thu, 30 May 2019 13:55:11 -0700 (PDT)
Received: from [192.168.100.220] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193FB3F690;
        Thu, 30 May 2019 13:55:10 -0700 (PDT)
Subject: Re: [PATCH v6 2/7] dt-binding: cpu-topology: Move cpu-map to a common
 binding.
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-3-atish.patra@wdc.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <0515d803-0da5-dcbe-3d3e-bb786b320d8b@arm.com>
Date:   Thu, 30 May 2019 15:55:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529211340.17087-3-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/29/19 4:13 PM, Atish Patra wrote:
> cpu-map binding can be used to described cpu topology for both
> RISC-V & ARM. It makes more sense to move the binding to document
> to a common place.
> 
> The relevant discussion can be found here.
> https://lkml.org/lkml/2018/11/6/19
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../topology.txt => cpu/cpu-topology.txt}     | 82 +++++++++++++++----
>   1 file changed, 66 insertions(+), 16 deletions(-)
>   rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> similarity index 86%
> rename from Documentation/devicetree/bindings/arm/topology.txt
> rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
> index 3b8febb46dad..069addccab14 100644
> --- a/Documentation/devicetree/bindings/arm/topology.txt
> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> @@ -1,12 +1,12 @@
>   ===========================================
> -ARM topology binding description
> +CPU topology binding description
>   ===========================================
>   
>   ===========================================
>   1 - Introduction
>   ===========================================
>   
> -In an ARM system, the hierarchy of CPUs is defined through three entities that
> +In a SMP system, the hierarchy of CPUs is defined through three entities that
>   are used to describe the layout of physical CPUs in the system:
>   
>   - socket
> @@ -14,9 +14,6 @@ are used to describe the layout of physical CPUs in the system:
>   - core
>   - thread
>   
> -The cpu nodes (bindings defined in [1]) represent the devices that
> -correspond to physical CPUs and are to be mapped to the hierarchy levels.
> -
>   The bottom hierarchy level sits at core or thread level depending on whether
>   symmetric multi-threading (SMT) is supported or not.
>   
> @@ -25,33 +22,31 @@ threads existing in the system and map to the hierarchy level "thread" above.
>   In systems where SMT is not supported "cpu" nodes represent all cores present
>   in the system and map to the hierarchy level "core" above.
>   
> -ARM topology bindings allow one to associate cpu nodes with hierarchical groups
> +CPU topology bindings allow one to associate cpu nodes with hierarchical groups
>   corresponding to the system hierarchy; syntactically they are defined as device
>   tree nodes.
>   
> -The remainder of this document provides the topology bindings for ARM, based
> -on the Devicetree Specification, available from:
> +Currently, only ARM/RISC-V intend to use this cpu topology binding but it may be
> +used for any other architecture as well.
>   
> -https://www.devicetree.org/specifications/
> +The cpu nodes, as per bindings defined in [4], represent the devices that
> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
>   
> -If not stated otherwise, whenever a reference to a cpu node phandle is made its
> -value must point to a cpu node compliant with the cpu node bindings as
> -documented in [1].
>   A topology description containing phandles to cpu nodes that are not compliant
> -with bindings standardized in [1] is therefore considered invalid.
> +with bindings standardized in [4] is therefore considered invalid.
>   
>   ===========================================
>   2 - cpu-map node
>   ===========================================
>   
> -The ARM CPU topology is defined within the cpu-map node, which is a direct
> +The ARM/RISC-V CPU topology is defined within the cpu-map node, which is a direct
>   child of the cpus node and provides a container where the actual topology
>   nodes are listed.
>   
>   - cpu-map node
>   
> -	Usage: Optional - On ARM SMP systems provide CPUs topology to the OS.
> -			  ARM uniprocessor systems do not require a topology
> +	Usage: Optional - On SMP systems provide CPUs topology to the OS.
> +			  Uniprocessor systems do not require a topology
>   			  description and therefore should not define a
>   			  cpu-map node.
>   
> @@ -494,8 +489,63 @@ cpus {
>   	};
>   };
>   
> +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
> +
> +{
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	compatible = "sifive,fu540g", "sifive,fu500";
> +	model = "sifive,hifive-unleashed-a00";
> +
> +	...
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU1>;
> +				};
> +				core1 {
> +					cpu = <&CPU2>;
> +				};
> +				core2 {
> +					cpu0 = <&CPU2>;
> +				};
> +				core3 {
> +					cpu0 = <&CPU3>;
> +				};
> +			};
> +		};


<nit picking>

While socket is optional, its probably a good idea to include the node 
in the example even if the result is the same. That is because at least 
on arm64 the DT clusters=sockets decision had performance implications 
for larger systems.

Assuring the socket information is correct is helpful by itself to avoid 
having to explain why a single socket machine is displaying some other 
value in lscpu.



> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "sifive,rocket0", "riscv";
> +			reg = <0x1>;
> +		}
> +
> +		CPU2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "sifive,rocket0", "riscv";
> +			reg = <0x2>;
> +		}
> +		CPU3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "sifive,rocket0", "riscv";
> +			reg = <0x3>;
> +		}
> +		CPU4: cpu@4 {
> +			device_type = "cpu";
> +			compatible = "sifive,rocket0", "riscv";
> +			reg = <0x4>;
> +		}
> +	}
> +};
>   ===============================================================================
>   [1] ARM Linux kernel documentation
>       Documentation/devicetree/bindings/arm/cpus.yaml
>   [2] Devicetree NUMA binding description
>       Documentation/devicetree/bindings/numa.txt
> +[3] RISC-V Linux kernel documentation
> +    Documentation/devicetree/bindings/riscv/cpus.txt
> +[4] https://www.devicetree.org/specifications/
> 

