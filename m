Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8A7C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA187212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfFGPEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:04:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:44060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729267AbfFGPET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8DE8ACD4;
        Fri,  7 Jun 2019 15:04:17 +0000 (UTC)
Subject: Re: [RFC PATCH 01/16] x86/xen: add xenhost_t interface
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-2-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <4b472ec7-73c2-f7ff-53d5-fc0ac436b62c@suse.com>
Date:   Fri, 7 Jun 2019 17:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> Add xenhost_t which will serve as an abstraction over Xen interfaces.
> It co-exists with the PV/HVM/PVH abstractions (x86_init, hypervisor_x86,
> pv_ops etc) and is meant to capture mechanisms for communication with
> Xen so we could have different types of underlying Xen: regular, local,
> and nested.
> 
> Also add xenhost_register() and stub registration in the various guest
> types.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   arch/x86/xen/Makefile        |  1 +
>   arch/x86/xen/enlighten_hvm.c | 13 +++++
>   arch/x86/xen/enlighten_pv.c  | 16 ++++++
>   arch/x86/xen/enlighten_pvh.c | 12 +++++
>   arch/x86/xen/xenhost.c       | 75 ++++++++++++++++++++++++++++
>   include/xen/xen.h            |  3 ++
>   include/xen/xenhost.h        | 95 ++++++++++++++++++++++++++++++++++++
>   7 files changed, 215 insertions(+)
>   create mode 100644 arch/x86/xen/xenhost.c
>   create mode 100644 include/xen/xenhost.h
> 
> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index 084de77a109e..564b4dddbc15 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -18,6 +18,7 @@ obj-y				+= mmu.o
>   obj-y				+= time.o
>   obj-y				+= grant-table.o
>   obj-y				+= suspend.o
> +obj-y				+= xenhost.o
>   
>   obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o
>   obj-$(CONFIG_XEN_PVHVM)		+= mmu_hvm.o
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index 0e75642d42a3..100452f4f44c 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -5,6 +5,7 @@
>   #include <linux/kexec.h>
>   #include <linux/memblock.h>
>   
> +#include <xen/xenhost.h>
>   #include <xen/features.h>
>   #include <xen/events.h>
>   #include <xen/interface/memory.h>
> @@ -82,6 +83,12 @@ static void __init xen_hvm_init_mem_mapping(void)
>   	xen_vcpu_info_reset(0);
>   }
>   
> +xenhost_ops_t xh_hvm_ops = {
> +};
> +
> +xenhost_ops_t xh_hvm_nested_ops = {
> +};
> +
>   static void __init init_hvm_pv_info(void)
>   {
>   	int major, minor;
> @@ -179,6 +186,12 @@ static void __init xen_hvm_guest_init(void)
>   {
>   	if (xen_pv_domain())
>   		return;
> +	/*
> +	 * We need only xenhost_r1 for HVM guests since they cannot be
> +	 * driver domain (?) or dom0.

I think even HVM guests could (in theory) be driver domains.

> +	 */
> +	if (!xen_pvh_domain())
> +		xenhost_register(xenhost_r1, &xh_hvm_ops);
>   
>   	init_hvm_pv_info();
>   
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index c54a493e139a..bb6e811c1525 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -36,6 +36,7 @@
>   
>   #include <xen/xen.h>
>   #include <xen/events.h>
> +#include <xen/xenhost.h>
>   #include <xen/interface/xen.h>
>   #include <xen/interface/version.h>
>   #include <xen/interface/physdev.h>
> @@ -1188,6 +1189,12 @@ static void __init xen_dom0_set_legacy_features(void)
>   	x86_platform.legacy.rtc = 1;
>   }
>   
> +xenhost_ops_t xh_pv_ops = {
> +};
> +
> +xenhost_ops_t xh_pv_nested_ops = {
> +};
> +
>   /* First C function to be called on Xen boot */
>   asmlinkage __visible void __init xen_start_kernel(void)
>   {
> @@ -1198,6 +1205,15 @@ asmlinkage __visible void __init xen_start_kernel(void)
>   	if (!xen_start_info)
>   		return;
>   
> +	xenhost_register(xenhost_r1, &xh_pv_ops);
> +
> +	/*
> +	 * Detect in some implementation defined manner whether this is
> +	 * nested or not.
> +	 */
> +	if (xen_driver_domain() && xen_nested())
> +		xenhost_register(xenhost_r2, &xh_pv_nested_ops);

I don't think a driver domain other than dom0 "knows" this in the
beginning. It will need to register xenhost_r2 in case it learns
about a pv device from L0 hypervisor.

> +
>   	xen_domain_type = XEN_PV_DOMAIN;
>   	xen_start_flags = xen_start_info->flags;
>   
> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> index 35b7599d2d0b..826c296d27a3 100644
> --- a/arch/x86/xen/enlighten_pvh.c
> +++ b/arch/x86/xen/enlighten_pvh.c
> @@ -8,6 +8,7 @@
>   #include <asm/e820/api.h>
>   
>   #include <xen/xen.h>
> +#include <xen/xenhost.h>
>   #include <asm/xen/interface.h>
>   #include <asm/xen/hypercall.h>
>   
> @@ -21,11 +22,22 @@
>    */
>   bool xen_pvh __attribute__((section(".data"))) = 0;
>   
> +extern xenhost_ops_t xh_hvm_ops, xh_hvm_nested_ops;
> +
>   void __init xen_pvh_init(void)
>   {
>   	u32 msr;
>   	u64 pfn;
>   
> +	xenhost_register(xenhost_r1, &xh_hvm_ops);
> +
> +	/*
> +	 * Detect in some implementation defined manner whether this is
> +	 * nested or not.
> +	 */
> +	if (xen_driver_domain() && xen_nested())
> +		xenhost_register(xenhost_r2, &xh_hvm_nested_ops);
> +
>   	xen_pvh = 1;
>   	xen_start_flags = pvh_start_info.flags;
>   
> diff --git a/arch/x86/xen/xenhost.c b/arch/x86/xen/xenhost.c
> new file mode 100644
> index 000000000000..ca90acd7687e
> --- /dev/null
> +++ b/arch/x86/xen/xenhost.c
> @@ -0,0 +1,75 @@
> +#include <linux/types.h>
> +#include <linux/bug.h>
> +#include <xen/xen.h>
> +#include <xen/xenhost.h>
> +
> +xenhost_t xenhosts[2];
> +/*
> + * xh_default: interface to the regular hypervisor. xenhost_type is xenhost_r0
> + * or xenhost_r1.
> + *
> + * xh_remote: interface to remote hypervisor. Needed for PV driver support on
> + * L1-dom0/driver-domain for nested Xen. xenhost_type is xenhost_r2.
> + */
> +xenhost_t *xh_default = (xenhost_t *) &xenhosts[0];
> +xenhost_t *xh_remote = (xenhost_t *) &xenhosts[1];
> +
> +/*
> + * Exported for use of for_each_xenhost().
> + */
> +EXPORT_SYMBOL_GPL(xenhosts);
> +
> +/*
> + * Some places refer directly to a specific type of xenhost.
> + * This might be better as a macro though.
> + */
> +EXPORT_SYMBOL_GPL(xh_default);
> +EXPORT_SYMBOL_GPL(xh_remote);
> +
> +void xenhost_register(enum xenhost_type type, xenhost_ops_t *ops)
> +{
> +	switch (type) {
> +		case xenhost_r0:
> +		case xenhost_r1:
> +			BUG_ON(xh_default->type != xenhost_invalid);
> +
> +			xh_default->type = type;
> +			xh_default->ops = ops;
> +			break;
> +		case xenhost_r2:
> +			BUG_ON(xh_remote->type != xenhost_invalid);
> +
> +			/*
> +			 * We should have a default xenhost by the
> +			 * time xh_remote is registered.
> +			 */
> +			BUG_ON(!xh_default);
> +
> +			xh_remote->type = type;
> +			xh_remote->ops = ops;
> +			break;
> +		default:
> +			BUG();
> +	}
> +}
> +
> +/*
> + * __xenhost_unregister: expected to be called only if there's an
> + * error early in the init.
> + */
> +void __xenhost_unregister(enum xenhost_type type)
> +{
> +	switch (type) {
> +		case xenhost_r0:
> +		case xenhost_r1:
> +			xh_default->type = xenhost_invalid;
> +			xh_default->ops = NULL;
> +			break;
> +		case xenhost_r2:
> +			xh_remote->type = xenhost_invalid;
> +			xh_remote->ops = NULL;
> +			break;
> +		default:
> +			BUG();
> +	}
> +}
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 0e2156786ad2..540db8459536 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -42,6 +42,9 @@ extern struct hvm_start_info pvh_start_info;
>   #define xen_initial_domain()	(0)
>   #endif	/* CONFIG_XEN_DOM0 */
>   
> +#define xen_driver_domain()	xen_initial_domain()
> +#define xen_nested()	0
> +
>   struct bio_vec;
>   bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>   		const struct bio_vec *vec2);
> diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
> new file mode 100644
> index 000000000000..a58e883f144e
> --- /dev/null
> +++ b/include/xen/xenhost.h
> @@ -0,0 +1,95 @@
> +#ifndef __XENHOST_H
> +#define __XENHOST_H
> +
> +/*
> + * Xenhost abstracts out the Xen interface. It co-exists with the PV/HVM/PVH
> + * abstractions (x86_init, hypervisor_x86, pv_ops etc) and is meant to
> + * expose ops for communication between the guest and Xen (hypercall, cpuid,
> + * shared_info/vcpu_info, evtchn, grant-table and on top of those, xenbus, ballooning),
> + * so these could differ based on the kind of underlying Xen: regular, local,
> + * and nested.
> + *
> + * Any call-sites which initiate communication with the hypervisor take
> + * xenhost_t * as a parameter and use the appropriate xenhost interface.
> + *
> + * Note, that the init for the nested xenhost (in the nested dom0 case,
> + * there are two) happens for each operation alongside the default xenhost
> + * (which remains similar to the one now) and is not deferred for later.
> + * This allows us to piggy-back on the non-trivial sequencing, inter-locking
> + * logic in the init of the default xenhost.
> + */
> +
> +/*
> + * xenhost_type: specifies the controlling Xen interface. The notation,
> + * xenhost_r0, xenhost_r1, xenhost_r2 is meant to invoke hypervisor distance
> + * from the guest.

This naming makes it hard to correlate the different things: In the
nested case xenhost_r2 means L0 hypervisor, same as in the non-nested
case xenhost_r1 does.

What about: xenhost_local (instead xenhost_r0), xenhost_direct (instead
xenhost_r1) and xenhost_nested (instead xenhost_r2). Or you use an
integer to denote the distance enabling even deeper nesting levels (at
least in theory).

> + *
> + * Note that the distance is relative, and so does not identify a specific
> + * hypervisor, just the role played by the interface: so, instance for L0-guest
> + * xenhost_r1 would be L0-Xen and for an L1-guest, L1-Xen.
> + */
> +enum xenhost_type {
> +	xenhost_invalid = 0,
> +	/*
> +	 * xenhost_r1: the guest's frontend or backend drivers talking
> +	 * to a hypervisor one level removed.
> +	 * This is the ordinary, non-nested configuration as well as for the
> +	 * typical nested frontends and backends.
> +	 *
> +	 * The corresponding xenhost_t would continue to use the current
> +	 * interfaces, via a redirection layer.
> +	 */
> +	xenhost_r1,
> +
> +	/*
> +	 * xenhost_r2: frontend drivers communicating with a hypervisor two
> +	 * levels removed: so L1-dom0-frontends communicating with L0-Xen.
> +	 *
> +	 * This is the nested-Xen configuration: L1-dom0-frontend drivers can
> +	 * now talk to L0-dom0-backend drivers via a separate xenhost_t.
> +	 */
> +	xenhost_r2,
> +
> +	/*
> +	 * Local/Co-located case: backend drivers now run in the same address
> +	 * space as the hypervisor. The driver model remains same as
> +	 * xenhost_r1, but with slightly different interfaces.
> +	 *
> +	 * Any frontend guests of this hypervisor will continue to be
> +	 * xenhost_r1.
> +	 */
> +	xenhost_r0,
> +};
> +
> +struct xenhost_ops;
> +
> +typedef struct {
> +	enum xenhost_type type;
> +
> +	struct xenhost_ops *ops;
> +} xenhost_t;
> +
> +typedef struct xenhost_ops {
> +} xenhost_ops_t;
> +
> +extern xenhost_t *xh_default, *xh_remote;
> +extern xenhost_t xenhosts[2];

Use a max nesting level define here and ...

> +
> +/*
> + * xenhost_register(): is called early in the guest's xen-init, after it detects
> + * in some implementation defined manner what kind of underlying xenhost or
> + * xenhosts exist.
> + * Specifies the type of xenhost being registered and the ops for that.
> + */
> +void xenhost_register(enum xenhost_type type, xenhost_ops_t *ops);
> +void __xenhost_unregister(enum xenhost_type type);
> +
> +
> +/*
> + * Convoluted interface so we can do this without adding a loop counter.
> + */
> +#define for_each_xenhost(xh) \
> +	for ((xh) = (xenhost_t **) &xenhosts[0];	\
> +		(((xh) - (xenhost_t **)&xenhosts) < 2) && (*xh)->type != xenhost_invalid; (xh)++)

... here, too.

> +
> +#endif /* __XENHOST_H */
> 


Juergen
