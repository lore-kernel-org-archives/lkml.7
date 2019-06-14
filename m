Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6683C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BFB2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfFNLwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:52:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:56902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727345AbfFNLwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:52:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AD3FAFEE;
        Fri, 14 Jun 2019 11:52:52 +0000 (UTC)
Subject: Re: [RFC PATCH 01/16] x86/xen: add xenhost_t interface
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-2-ankur.a.arora@oracle.com>
 <4b472ec7-73c2-f7ff-53d5-fc0ac436b62c@suse.com>
 <199b7183-1872-7342-4283-af2925e780c5@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <c80886fb-583a-a78e-62cb-4a7944ab7fab@suse.com>
Date:   Fri, 14 Jun 2019 13:52:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <199b7183-1872-7342-4283-af2925e780c5@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.19 09:16, Ankur Arora wrote:
> On 2019-06-07 8:04 a.m., Juergen Gross wrote:
>> On 09.05.19 19:25, Ankur Arora wrote:
>>> Add xenhost_t which will serve as an abstraction over Xen interfaces.
>>> It co-exists with the PV/HVM/PVH abstractions (x86_init, hypervisor_x86,
>>> pv_ops etc) and is meant to capture mechanisms for communication with
>>> Xen so we could have different types of underlying Xen: regular, local,
>>> and nested.
>>>
>>> Also add xenhost_register() and stub registration in the various guest
>>> types.
>>>
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>   arch/x86/xen/Makefile        |  1 +
>>>   arch/x86/xen/enlighten_hvm.c | 13 +++++
>>>   arch/x86/xen/enlighten_pv.c  | 16 ++++++
>>>   arch/x86/xen/enlighten_pvh.c | 12 +++++
>>>   arch/x86/xen/xenhost.c       | 75 ++++++++++++++++++++++++++++
>>>   include/xen/xen.h            |  3 ++
>>>   include/xen/xenhost.h        | 95 ++++++++++++++++++++++++++++++++++++
>>>   7 files changed, 215 insertions(+)
>>>   create mode 100644 arch/x86/xen/xenhost.c
>>>   create mode 100644 include/xen/xenhost.h
>>>
>>> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
>>> index 084de77a109e..564b4dddbc15 100644
>>> --- a/arch/x86/xen/Makefile
>>> +++ b/arch/x86/xen/Makefile
>>> @@ -18,6 +18,7 @@ obj-y                += mmu.o
>>>   obj-y                += time.o
>>>   obj-y                += grant-table.o
>>>   obj-y                += suspend.o
>>> +obj-y                += xenhost.o
>>>   obj-$(CONFIG_XEN_PVHVM)        += enlighten_hvm.o
>>>   obj-$(CONFIG_XEN_PVHVM)        += mmu_hvm.o
>>> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
>>> index 0e75642d42a3..100452f4f44c 100644
>>> --- a/arch/x86/xen/enlighten_hvm.c
>>> +++ b/arch/x86/xen/enlighten_hvm.c
>>> @@ -5,6 +5,7 @@
>>>   #include <linux/kexec.h>
>>>   #include <linux/memblock.h>
>>> +#include <xen/xenhost.h>
>>>   #include <xen/features.h>
>>>   #include <xen/events.h>
>>>   #include <xen/interface/memory.h>
>>> @@ -82,6 +83,12 @@ static void __init xen_hvm_init_mem_mapping(void)
>>>       xen_vcpu_info_reset(0);
>>>   }
>>> +xenhost_ops_t xh_hvm_ops = {
>>> +};
>>> +
>>> +xenhost_ops_t xh_hvm_nested_ops = {
>>> +};
>>> +
>>>   static void __init init_hvm_pv_info(void)
>>>   {
>>>       int major, minor;
>>> @@ -179,6 +186,12 @@ static void __init xen_hvm_guest_init(void)
>>>   {
>>>       if (xen_pv_domain())
>>>           return;
>>> +    /*
>>> +     * We need only xenhost_r1 for HVM guests since they cannot be
>>> +     * driver domain (?) or dom0.
>>
>> I think even HVM guests could (in theory) be driver domains.
>>
>>> +     */
>>> +    if (!xen_pvh_domain())
>>> +        xenhost_register(xenhost_r1, &xh_hvm_ops);
>>>       init_hvm_pv_info();
>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>>> index c54a493e139a..bb6e811c1525 100644
>>> --- a/arch/x86/xen/enlighten_pv.c
>>> +++ b/arch/x86/xen/enlighten_pv.c
>>> @@ -36,6 +36,7 @@
>>>   #include <xen/xen.h>
>>>   #include <xen/events.h>
>>> +#include <xen/xenhost.h>
>>>   #include <xen/interface/xen.h>
>>>   #include <xen/interface/version.h>
>>>   #include <xen/interface/physdev.h>
>>> @@ -1188,6 +1189,12 @@ static void __init 
>>> xen_dom0_set_legacy_features(void)
>>>       x86_platform.legacy.rtc = 1;
>>>   }
>>> +xenhost_ops_t xh_pv_ops = {
>>> +};
>>> +
>>> +xenhost_ops_t xh_pv_nested_ops = {
>>> +};
>>> +
>>>   /* First C function to be called on Xen boot */
>>>   asmlinkage __visible void __init xen_start_kernel(void)
>>>   {
>>> @@ -1198,6 +1205,15 @@ asmlinkage __visible void __init 
>>> xen_start_kernel(void)
>>>       if (!xen_start_info)
>>>           return;
>>> +    xenhost_register(xenhost_r1, &xh_pv_ops);
>>> +
>>> +    /*
>>> +     * Detect in some implementation defined manner whether this is
>>> +     * nested or not.
>>> +     */
>>> +    if (xen_driver_domain() && xen_nested())
>>> +        xenhost_register(xenhost_r2, &xh_pv_nested_ops);
>>
>> I don't think a driver domain other than dom0 "knows" this in the
>> beginning. It will need to register xenhost_r2
> Right. No point in needlessly registrating as xenhost_r2 without
> needing to handle any xenhost_r2 devices.
> 
>>  in case it learns about a pv device from L0 hypervisor.
> What's the mechanism you are thinking of, for this?
> I'm guessing this PV device notification could arrive at an
> arbitrary point in time after the system has booted.

I'm not sure yet how this should be handled.

Maybe an easy solution would be the presence of a Xen PCI device
passed through from L1 hypervisor to L1 dom0. OTOH this would
preclude nested Xen for L1 hypervisor running in PVH mode. And for
L1 driver domains this would need either a shared PCI device or
multiple Xen PCI devices or something new.

There is a design session planned for this topic at the Xen developer
summit in July.


Juergen
