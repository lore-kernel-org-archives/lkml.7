Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB0FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E80B2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCGOp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:45:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46458 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfCGOp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:45:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C68EBD;
        Thu,  7 Mar 2019 06:45:55 -0800 (PST)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88B493F71D;
        Thu,  7 Mar 2019 06:45:54 -0800 (PST)
Date:   Thu, 7 Mar 2019 14:45:52 +0000
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 05/14] cpu topology: Export die_id
Message-ID: <20190307144552.GC19434@e105550-lin.cambridge.arm.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
 <43f15c3d7b5e0fd7e3f257d4c0736200f6198971.1551160674.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f15c3d7b5e0fd7e3f257d4c0736200f6198971.1551160674.git.len.brown@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

On Tue, Feb 26, 2019 at 01:20:03AM -0500, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Export die_id in cpu topology, for the benefit of hardware that
> has multiple-die/package.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/cputopology.txt   | 6 ++++++
>  arch/x86/include/asm/topology.h | 1 +
>  drivers/base/topology.c         | 4 ++++
>  include/linux/topology.h        | 3 +++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
> index cb61277e2308..4e6be7f68fd8 100644
> --- a/Documentation/cputopology.txt
> +++ b/Documentation/cputopology.txt
> @@ -12,6 +12,12 @@ physical_package_id:
>  	socket number, but the actual value is architecture and platform
>  	dependent.
>  
> +die_id:
> +
> +	the CPU die ID of cpuX. Typically it is the hardware platform's
> +	identifier (rather than the kernel's).  The actual value is
> +	architecture and platform dependent.
> +
>  core_id:

Can we add the details about die_id further down in cputopology.txt as
well?

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 6c25ce682c90..77b65583081e 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -97,6 +97,7 @@ For an architecture to support this feature, it must define some of
 these macros in include/asm-XXX/topology.h::
 
 	#define topology_physical_package_id(cpu)
+	#define topology_die_id(cpu)
 	#define topology_core_id(cpu)
 	#define topology_book_id(cpu)
 	#define topology_drawer_id(cpu)
@@ -116,10 +117,11 @@ provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 
 1) topology_physical_package_id: -1
-2) topology_core_id: 0
-3) topology_sibling_cpumask: just the given CPU
-4) topology_core_cpumask: just the given CPU
-5) topology_die_cpumask: just the given CPU
+2) topology_die_id: -1
+3) topology_core_id: 0
+4) topology_sibling_cpumask: just the given CPU
+5) topology_core_cpumask: just the given CPU
+6) topology_die_cpumask: just the given CPU
 
>  
>  	the CPU core ID of cpuX. Typically it is the hardware platform's
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 453cf38a1c33..281be6bbc80d 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -106,6 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
>  
>  #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
>  #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
> +#define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
>  #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
>  
>  #ifdef CONFIG_SMP

The above is x86 specific and seems to fit better with the next patch in
the series.

Morten
