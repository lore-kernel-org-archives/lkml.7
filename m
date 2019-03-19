Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C285C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfCSKBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:01:54 -0400
Received: from foss.arm.com ([217.140.101.70]:48478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfCSKBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:01:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 965481650;
        Tue, 19 Mar 2019 03:01:52 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23A993F575;
        Tue, 19 Mar 2019 03:01:48 -0700 (PDT)
Date:   Tue, 19 Mar 2019 10:01:41 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <eric.auger@redhat.com>, "Raslan, KarimAllah" <karahmed@amazon.de>,
        <christoffer.dall@arm.com>, <andre.przywara@arm.com>,
        <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <kvmarm@lists.cs.columbia.edu>,
        <mst@redhat.com>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <kvm@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <guoheyi@huawei.com>
Subject: Re: [RFC PATCH] KVM: arm/arm64: Enable direct irqfd MSI injection
Message-ID: <20190319100141.69821f8b@why.wild-wind.fr.eu.org>
In-Reply-To: <428b2aac-5a0f-e9da-8d74-8045f99a8c74@huawei.com>
References: <1552833373-19828-1-git-send-email-yuzenghui@huawei.com>
        <86o969z42z.wl-marc.zyngier@arm.com>
        <428b2aac-5a0f-e9da-8d74-8045f99a8c74@huawei.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 09:09:43 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

> Hi all,
> 
> On 2019/3/18 3:35, Marc Zyngier wrote:
> > On Sun, 17 Mar 2019 14:36:13 +0000,
> > Zenghui Yu <yuzenghui@huawei.com> wrote:  
> >>
> >> Currently, IRQFD on arm still uses the deferred workqueue mechanism
> >> to inject interrupts into guest, which will likely lead to a busy
> >> context-switching from/to the kworker thread. This overhead is for
> >> no purpose (only in my view ...) and will result in an interrupt
> >> performance degradation.
> >>
> >> Implement kvm_arch_set_irq_inatomic() for arm/arm64 to support direct
> >> irqfd MSI injection, by which we can get rid of the annoying latency.
> >> As a result, irqfd MSI intensive scenarios (e.g., DPDK with high packet
> >> processing workloads) will benefit from it.
> >>
> >> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> >> ---
> >>
> >> It seems that only MSI will follow the IRQFD path, did I miss something?
> >>
> >> This patch is still under test and sent out for early feedback. If I have
> >> any mis-understanding, please fix me up and let me know. Thanks!  
> > 
> > As mentioned by other folks in the thread, this is clearly wrong. The
> > first thing kvm_inject_msi does is to lock the corresponding ITS using
> > a mutex. So the "no purpose" bit was a bit too quick.
> > 
> > When doing this kind of work, I suggest you enable lockdep and all the
> > related checkers. Also, for any optimisation, please post actual
> > numbers for the relevant benchmarks. Saying "application X will
> > benefit from it" is meaningless without any actual data.
> >   
> >>
> >> ---
> >>   virt/kvm/arm/vgic/trace.h      | 22 ++++++++++++++++++++++
> >>   virt/kvm/arm/vgic/vgic-irqfd.c | 21 +++++++++++++++++++++
> >>   2 files changed, 43 insertions(+)
> >>
> >> diff --git a/virt/kvm/arm/vgic/trace.h b/virt/kvm/arm/vgic/trace.h
> >> index 55fed77..bc1f4db 100644
> >> --- a/virt/kvm/arm/vgic/trace.h
> >> +++ b/virt/kvm/arm/vgic/trace.h
> >> @@ -27,6 +27,28 @@
> >>   		  __entry->vcpu_id, __entry->irq, __entry->level)
> >>   );  
> >>   >> +TRACE_EVENT(kvm_arch_set_irq_inatomic,  
> >> +	TP_PROTO(u32 gsi, u32 type, int level, int irq_source_id),
> >> +	TP_ARGS(gsi, type, level, irq_source_id),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(	u32,	gsi		)
> >> +		__field(	u32,	type		)
> >> +		__field(	int,	level		)
> >> +		__field(	int,	irq_source_id	)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		__entry->gsi		= gsi;
> >> +		__entry->type		= type;
> >> +		__entry->level		= level;
> >> +		__entry->irq_source_id	= irq_source_id;
> >> +	),
> >> +
> >> +	TP_printk("gsi %u type %u level %d source %d", __entry->gsi,
> >> +		  __entry->type, __entry->level, __entry->irq_source_id)
> >> +);
> >> +
> >>   #endif /* _TRACE_VGIC_H */  
> >>   >>   #undef TRACE_INCLUDE_PATH  
> >> diff --git a/virt/kvm/arm/vgic/vgic-irqfd.c b/virt/kvm/arm/vgic/vgic-irqfd.c
> >> index 99e026d..4cfc3f4 100644
> >> --- a/virt/kvm/arm/vgic/vgic-irqfd.c
> >> +++ b/virt/kvm/arm/vgic/vgic-irqfd.c
> >> @@ -19,6 +19,7 @@
> >>   #include <trace/events/kvm.h>
> >>   #include <kvm/arm_vgic.h>
> >>   #include "vgic.h"
> >> +#include "trace.h"  
> >>   >>   /**  
> >>    * vgic_irqfd_set_irq: inject the IRQ corresponding to the
> >> @@ -105,6 +106,26 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
> >>   	return vgic_its_inject_msi(kvm, &msi);
> >>   }  
> >>   >> +/**  
> >> + * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
> >> + *
> >> + * Currently only direct MSI injecton is supported.
> >> + */
> >> +int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
> >> +			      struct kvm *kvm, int irq_source_id, int level,
> >> +			      bool line_status)
> >> +{
> >> +	int ret;
> >> +
> >> +	trace_kvm_arch_set_irq_inatomic(e->gsi, e->type, level, irq_source_id);
> >> +
> >> +	if (unlikely(e->type != KVM_IRQ_ROUTING_MSI))
> >> +		return -EWOULDBLOCK;
> >> +
> >> +	ret = kvm_set_msi(e, kvm, irq_source_id, level, line_status);
> >> +	return ret;
> >> +}
> >> +  
> > 
> > Although we've established that the approach is wrong, maybe we can
> > look at improving this aspect.
> > 
> > A first approach would be to keep a small cache of the last few
> > successful translations for this ITS, cache that could be looked-up by
> > holding a spinlock instead. A hit in this cache could directly be
> > injected. Any command that invalidates or changes anything (DISCARD,
> > INV, INVALL, MAPC with V=0, MAPD with V=0, MOVALL, MOVI) should nuke
> > the cache altogether.
> > 
> > Of course, all of that needs to be quantified.  
> 
> Thanks for all of your explanations, especially for Marc's suggestions!
> It took me long time to figure out my mistakes, since I am not very
> familiar with the locking stuff. Now I have to apologize for my noise.

No need to apologize. The whole point of this list is to have
discussions. Although your approach wasn't working, you did
identify potential room for improvement.

> As for the its-translation-cache code (a really good news to us), we
> have a rough look at it and start testing now!

Please let me know about your findings. My initial test doesn't show
any improvement, but that could easily be attributed to the system I
running this on (a tiny and slightly broken dual A53 system). The sizing
of the cache is also important: too small, and you have the overhead of
the lookup for no benefit; too big, and you waste memory.

Having thought about it a bit more, I think we can drop the
invalidation on MOVI/MOVALL, as the LPI is still perfectly valid, and
we don't cache the target vcpu. On the other hand, the cache must be
nuked when the ITS is turned off.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
