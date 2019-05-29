Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB8FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4B12437C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xY2rvs6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfE2XkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:40:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40024 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfE2XkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:40:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4TNdJpm045204;
        Wed, 29 May 2019 18:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559173159;
        bh=Ob84HKBpBDTg+9kN26JNOTwj7/pKEiiBDZ6BFO8Ly2U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xY2rvs6J1JpuBlyy+QK2mc2U+I9JjBnLA9VbnplG4BQTLpqWB6Sy2mLxg0bScLBP+
         AsIR4ArxnHRQR06r62fnlVI6hmyb0msh3tnY7DFPIz6e9YSbJdKWdgQu5v2K17bDir
         NJ1d/9hWtstSKtlXQsqgM+k1Wl4t4uzwP2QRlv6c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4TNdJsX105229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 May 2019 18:39:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 29
 May 2019 18:39:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 29 May 2019 18:39:19 -0500
Received: from [10.250.93.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4TNdHmh064568;
        Wed, 29 May 2019 18:39:17 -0500
Subject: Re: [PATCH v6 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
To:     Atish Patra <atish.patra@wdc.com>, <linux-kernel@vger.kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-riscv@lists.infradead.org>,
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
        <linux-arm-kernel@lists.infradead.org>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-2-atish.patra@wdc.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <49f41e62-5354-a674-d95f-5f63851a0ca6@ti.com>
Date:   Wed, 29 May 2019 19:39:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529211340.17087-2-atish.patra@wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 5:13 PM, Atish Patra wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> The current ARM DT topology description provides the operating system
> with a topological view of the system that is based on leaf nodes
> representing either cores or threads (in an SMT system) and a
> hierarchical set of cluster nodes that creates a hierarchical topology
> view of how those cores and threads are grouped.
> 
> However this hierarchical representation of clusters does not allow to
> describe what topology level actually represents the physical package or
> the socket boundary, which is a key piece of information to be used by
> an operating system to optimize resource allocation and scheduling.
> 

Are physical package descriptions really needed? What does "socket" 
imply that a higher layer "cluster" node grouping does not? It doesn't 
imply a different NUMA distance and the definition of "socket" is 
already not well defined, is a dual chiplet processor not just a fancy 
dual "socket" or are dual "sockets" on a server board "slotket" card, 
will we need new names for those too..

Andrew

> Lets add a new "socket" node type in the cpu-map node to describe the
> same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/arm/topology.txt      | 52 ++++++++++++++-----
>   1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
> index b0d80c0fb265..3b8febb46dad 100644
> --- a/Documentation/devicetree/bindings/arm/topology.txt
> +++ b/Documentation/devicetree/bindings/arm/topology.txt
> @@ -9,6 +9,7 @@ ARM topology binding description
>   In an ARM system, the hierarchy of CPUs is defined through three entities that
>   are used to describe the layout of physical CPUs in the system:
>   
> +- socket
>   - cluster
>   - core
>   - thread
> @@ -63,21 +64,23 @@ nodes are listed.
>   
>   	The cpu-map node's child nodes can be:
>   
> -	- one or more cluster nodes
> +	- one or more cluster nodes or
> +	- one or more socket nodes in a multi-socket system
>   
>   	Any other configuration is considered invalid.
>   
> -The cpu-map node can only contain three types of child nodes:
> +The cpu-map node can only contain 4 types of child nodes:
>   
> +- socket node
>   - cluster node
>   - core node
>   - thread node
>   
>   whose bindings are described in paragraph 3.
>   
> -The nodes describing the CPU topology (cluster/core/thread) can only
> -be defined within the cpu-map node and every core/thread in the system
> -must be defined within the topology.  Any other configuration is
> +The nodes describing the CPU topology (socket/cluster/core/thread) can
> +only be defined within the cpu-map node and every core/thread in the
> +system must be defined within the topology.  Any other configuration is
>   invalid and therefore must be ignored.
>   
>   ===========================================
> @@ -85,26 +88,44 @@ invalid and therefore must be ignored.
>   ===========================================
>   
>   cpu-map child nodes must follow a naming convention where the node name
> -must be "clusterN", "coreN", "threadN" depending on the node type (ie
> -cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes which
> -are siblings within a single common parent node must be given a unique and
> +must be "socketN", "clusterN", "coreN", "threadN" depending on the node type
> +(ie socket/cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes
> +which are siblings within a single common parent node must be given a unique and
>   sequential N value, starting from 0).
>   cpu-map child nodes which do not share a common parent node can have the same
>   name (ie same number N as other cpu-map child nodes at different device tree
>   levels) since name uniqueness will be guaranteed by the device tree hierarchy.
>   
>   ===========================================
> -3 - cluster/core/thread node bindings
> +3 - socket/cluster/core/thread node bindings
>   ===========================================
>   
> -Bindings for cluster/cpu/thread nodes are defined as follows:
> +Bindings for socket/cluster/cpu/thread nodes are defined as follows:
> +
> +- socket node
> +
> +	 Description: must be declared within a cpu-map node, one node
> +		      per physical socket in the system. A system can
> +		      contain single or multiple physical socket.
> +		      The association of sockets and NUMA nodes is beyond
> +		      the scope of this bindings, please refer [2] for
> +		      NUMA bindings.
> +
> +	This node is optional for a single socket system.
> +
> +	The socket node name must be "socketN" as described in 2.1 above.
> +	A socket node can not be a leaf node.
> +
> +	A socket node's child nodes must be one or more cluster nodes.
> +
> +	Any other configuration is considered invalid.
>   
>   - cluster node
>   
>   	 Description: must be declared within a cpu-map node, one node
>   		      per cluster. A system can contain several layers of
> -		      clustering and cluster nodes can be contained in parent
> -		      cluster nodes.
> +		      clustering within a single physical socket and cluster
> +		      nodes can be contained in parent cluster nodes.
>   
>   	The cluster node name must be "clusterN" as described in 2.1 above.
>   	A cluster node can not be a leaf node.
> @@ -164,13 +185,15 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
>   4 - Example dts
>   ===========================================
>   
> -Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
> +Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters in a single
> +physical socket):
>   
>   cpus {
>   	#size-cells = <0>;
>   	#address-cells = <2>;
>   
>   	cpu-map {
> +		socket0 {
>   			cluster0 {
>   				cluster0 {
>   					core0 {
> @@ -253,6 +276,7 @@ cpus {
>   				};
>   			};
>   		};
> +	};
>   
>   	CPU0: cpu@0 {
>   		device_type = "cpu";
> @@ -473,3 +497,5 @@ cpus {
>   ===============================================================================
>   [1] ARM Linux kernel documentation
>       Documentation/devicetree/bindings/arm/cpus.yaml
> +[2] Devicetree NUMA binding description
> +    Documentation/devicetree/bindings/numa.txt
> 
