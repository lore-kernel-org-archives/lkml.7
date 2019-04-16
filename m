Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2496520674
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfDPNJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:09:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfDPNJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:09:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9854EBD;
        Tue, 16 Apr 2019 06:09:35 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 313253F706;
        Tue, 16 Apr 2019 06:09:32 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:09:26 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFT/RFC PATCH v3 4/5] arm: Use common cpu_topology
Message-ID: <20190416130916.GA24669@e107155-lin>
References: <20190320234806.19748-1-atish.patra@wdc.com>
 <20190320234806.19748-5-atish.patra@wdc.com>
 <20190415153147.GB28623@e107155-lin>
 <41f890e9-3893-9092-bac7-3daca99f181b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f890e9-3893-9092-bac7-3daca99f181b@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 02:16:43PM -0700, Atish Patra wrote:
> On 4/15/19 8:31 AM, Sudeep Holla wrote:
> > On Wed, Mar 20, 2019 at 04:48:05PM -0700, Atish Patra wrote:
> > > Currently, ARM32 and ARM64 uses different data structures to
> > > represent their cpu toplogies. Since, we are moving the ARM64
> > > topology to common code to be used by other architectures, we
> > > can reuse that for ARM32 as well.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >   arch/arm/include/asm/topology.h | 22 +---------------------
> > >   arch/arm/kernel/topology.c      | 10 +++++-----
> > >   include/linux/arch_topology.h   | 10 +++++++++-
> > >   3 files changed, 15 insertions(+), 27 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > > index d4e76e0a..7c850611 100644
> > > --- a/include/linux/arch_topology.h
> > > +++ b/include/linux/arch_topology.h
> > > @@ -36,17 +36,25 @@ unsigned long topology_get_freq_scale(int cpu)
> > >   struct cpu_topology {
> > >   	int thread_id;
> > >   	int core_id;
> > > +#ifdef CONFIG_ARM_CPU_TOPOLOGY
> > > +	int socket_id;
> >
> > Sorry, but I can't find any reason why we need to do this ifdef dance
> > here, especially for socket_id vs package_id ?
>
> I was not sure if we can rename socket_id to package_id from a semantic
> point of view. If you are okay with it, I will change it to package_id and
> send a v4.
>

Thanks, all make sure to cc linux-arm-kernel@lists.infradead.org,
just noticed that's missing and you are asking for testing on ARM
platforms :)

> Other's I can understand
> > as there are new, but I am sure we can find a way and get away with
> > #ifdefery here completely.
> >
> That would be good. Any suggestions on how to do that?
>

Do you see any issues having extra structure members for ARM ?
Something like below seem to compile + boot fine on my 32-bit TC2 with
proper topology info on top of your series. Of course, more testing is
better, but I don't see any issue keeping llc_{id,sibling} around for
ARM eliminating the need for #ifdefs

Let me know if I am missing something.

-->8

diff --git i/arch/arm/kernel/topology.c w/arch/arm/kernel/topology.c
index 0ddb24c76c17..f2aa942e0cfa 100644
--- i/arch/arm/kernel/topology.c
+++ w/arch/arm/kernel/topology.c
@@ -206,7 +206,7 @@ void update_siblings_masks(unsigned int cpuid)
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->socket_id != cpu_topo->socket_id)
+		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
@@ -250,12 +250,12 @@ void store_cpu_topology(unsigned int cpuid)
 			/* core performance interdependency */
 			cpuid_topo->thread_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+			cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
 		} else {
 			/* largely independent cores */
 			cpuid_topo->thread_id = -1;
 			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+			cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 		}
 	} else {
 		/*
@@ -265,7 +265,7 @@ void store_cpu_topology(unsigned int cpuid)
 		 */
 		cpuid_topo->thread_id = -1;
 		cpuid_topo->core_id = 0;
-		cpuid_topo->socket_id = -1;
+		cpuid_topo->package_id = -1;
 	}
 
 	update_siblings_masks(cpuid);
@@ -275,7 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
 	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
 		cpuid, cpu_topology[cpuid].thread_id,
 		cpu_topology[cpuid].core_id,
-		cpu_topology[cpuid].socket_id, mpidr);
+		cpu_topology[cpuid].package_id, mpidr);
 }
 
 static inline int cpu_corepower_flags(void)
@@ -306,7 +306,7 @@ void __init init_cpu_topology(void)
 
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id =  -1;
-		cpu_topo->socket_id = -1;
+		cpu_topo->package_id = -1;
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_clear(&cpu_topo->thread_sibling);
 	}
diff --git i/include/linux/arch_topology.h w/include/linux/arch_topology.h
index 7c850611986d..8e82389c2bed 100644
--- i/include/linux/arch_topology.h
+++ w/include/linux/arch_topology.h
@@ -36,13 +36,9 @@ unsigned long topology_get_freq_scale(int cpu)
 struct cpu_topology {
 	int thread_id;
 	int core_id;
-#ifdef CONFIG_ARM_CPU_TOPOLOGY
-	int socket_id;
-#else
 	int package_id;
 	int llc_id;
 	cpumask_t llc_sibling;
-#endif
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
 };
@@ -50,11 +46,7 @@ struct cpu_topology {
 #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
 extern struct cpu_topology cpu_topology[NR_CPUS];
 
-#ifdef CONFIG_ARM_CPU_TOPOLOGY
-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
-#else
 #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
-#endif
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
