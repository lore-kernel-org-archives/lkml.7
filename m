Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF26C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8709F20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfEWJgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:36:00 -0400
Received: from foss.arm.com ([217.140.101.70]:41522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbfEWJf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:35:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B413341;
        Thu, 23 May 2019 02:35:59 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 835643F718;
        Thu, 23 May 2019 02:35:55 -0700 (PDT)
Date:   Thu, 23 May 2019 10:35:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: Re: [RFT PATCH v4 3/5] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20190523093549.GA13560@e107155-lin>
References: <20190428002529.14229-1-atish.patra@wdc.com>
 <20190428002529.14229-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428002529.14229-4-atish.patra@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 05:25:27PM -0700, Atish Patra wrote:
> Both RISC-V & ARM64 are using cpu-map device tree to describe
> their cpu topology. It's better to move the relevant code to
> a common place instead of duplicate code.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  arch/arm64/include/asm/topology.h |  23 ---
>  arch/arm64/kernel/topology.c      | 303 +-----------------------------
>  drivers/base/arch_topology.c      | 298 ++++++++++++++++++++++++++++-
>  drivers/base/topology.c           |   1 +
>  include/linux/arch_topology.h     |  28 +++
>  5 files changed, 330 insertions(+), 323 deletions(-)
> 
> -void store_cpu_topology(unsigned int cpuid);
[...]


> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index edfcf8d982e4..2b0758c01cee 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -6,8 +6,8 @@
>   * Written by: Juri Lelli, ARM Ltd.
>   */
>
> -#include <linux/acpi.h>
>  #include <linux/arch_topology.h>
> +#include <linux/acpi.h>

I assume this was to avoid compilation errors, when I rebased I got
conflict and I ordered them back alphabetically as before and hit the
compilation error.

The actual fix would be to include linux/arch_topology.h in linux/topology.h
as you are moving contents of asm/topology.h which it includes.

I did the change and get it tested by kbuild. See [1]

Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/cpu_topology
