Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C683C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8207216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfE2KsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:48:17 -0400
Received: from foss.arm.com ([217.140.101.70]:43354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfE2KsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:48:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A32A341;
        Wed, 29 May 2019 03:48:16 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 333153F59C;
        Wed, 29 May 2019 03:48:12 -0700 (PDT)
Date:   Wed, 29 May 2019 11:48:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-riscv@lists.infradead.org,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFT PATCH v5 3/5] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20190529104801.GA13155@e107155-lin>
References: <20190524000653.13005-1-atish.patra@wdc.com>
 <20190524000653.13005-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524000653.13005-4-atish.patra@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 05:06:50PM -0700, Atish Patra wrote:
> Both RISC-V & ARM64 are using cpu-map device tree to describe
> their cpu topology. It's better to move the relevant code to
> a common place instead of duplicate code.
>

I couldn't test this on any ARM64 server platforms, tested on Juno
and other embedded platforms.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  arch/arm64/include/asm/topology.h |  23 ---
>  arch/arm64/kernel/topology.c      | 303 +-----------------------------
>  drivers/base/arch_topology.c      | 296 +++++++++++++++++++++++++++++
>  include/linux/arch_topology.h     |  28 +++
>  include/linux/topology.h          |   1 +
>  5 files changed, 329 insertions(+), 322 deletions(-)
>

[...]

> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 0825c4a856e3..6b95c91e7d67 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
>

[...]

> -static int __init parse_cluster(struct device_node *cluster, int depth)
> -{
> -	char name[10];
> -	bool leaf = true;
> -	bool has_cores = false;
> -	struct device_node *c;
> -	static int package_id __initdata;
> -	int core_id = 0;

[Ultra minor nit]: you seem to have reordered the above declaration when
you moved, just noticed as it showed up when comparing.

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1739d7e1952a..20a960131bee 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c

[...]

> +
> +static int __init parse_cluster(struct device_node *cluster, int depth)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	bool has_cores = false;
> +	int core_id = 0;
> +	static int package_id __initdata;
> +	struct device_node *c;
> +	int i, ret;
> +

[...]

> +#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> +void update_siblings_masks(unsigned int cpu);
> +#endif
> +void remove_cpu_topology(unsigned int cpuid);
> +

Another thing(not a block and we can do it once this is merged) is to
remove these #ifdefs

--
Regards,
Sudeep
