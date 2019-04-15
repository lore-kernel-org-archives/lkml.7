Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAE7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A7F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfDOPby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:31:54 -0400
Received: from foss.arm.com ([217.140.101.70]:37142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfDOPbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:31:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D08B374;
        Mon, 15 Apr 2019 08:31:53 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BC6F3F68F;
        Mon, 15 Apr 2019 08:31:49 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:31:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFT/RFC PATCH v3 4/5] arm: Use common cpu_topology
Message-ID: <20190415153147.GB28623@e107155-lin>
References: <20190320234806.19748-1-atish.patra@wdc.com>
 <20190320234806.19748-5-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320234806.19748-5-atish.patra@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 04:48:05PM -0700, Atish Patra wrote:
> Currently, ARM32 and ARM64 uses different data structures to
> represent their cpu toplogies. Since, we are moving the ARM64
> topology to common code to be used by other architectures, we
> can reuse that for ARM32 as well.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/arm/include/asm/topology.h | 22 +---------------------
>  arch/arm/kernel/topology.c      | 10 +++++-----
>  include/linux/arch_topology.h   | 10 +++++++++-
>  3 files changed, 15 insertions(+), 27 deletions(-)
>

[...]

> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index d4e76e0a..7c850611 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -36,17 +36,25 @@ unsigned long topology_get_freq_scale(int cpu)
>  struct cpu_topology {
>  	int thread_id;
>  	int core_id;
> +#ifdef CONFIG_ARM_CPU_TOPOLOGY
> +	int socket_id;

Sorry, but I can't find any reason why we need to do this ifdef dance
here, especially for socket_id vs package_id ? Other's I can understand
as there are new, but I am sure we can find a way and get away with
#ifdefery here completely.

> +#else
>  	int package_id;
>  	int llc_id;
> +	cpumask_t llc_sibling;
> +#endif
>  	cpumask_t thread_sibling;
>  	cpumask_t core_sibling;
> -	cpumask_t llc_sibling;
>  };
>
>  #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
>  extern struct cpu_topology cpu_topology[NR_CPUS];
>
> +#ifdef CONFIG_ARM_CPU_TOPOLOGY
> +#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
> +#else
>  #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
> +#endif

Since all callsites must use topology_physical_package_id, we should be
able to rename socket_id to package_id easily.

--
Regards,
Sudeep
