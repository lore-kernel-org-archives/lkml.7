Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B15C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA2020645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFZJD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:03:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:40168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZJD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:03:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80357AD09;
        Wed, 26 Jun 2019 09:03:26 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] x86/xen: nopv parameter support for HVM guest
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        peterz@infradead.org, srinivas.eeda@oracle.com,
        Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561377779-28036-6-git-send-email-zhenzhong.duan@oracle.com>
 <99a28880-c2bf-e328-ee52-afc782af3b74@suse.com>
 <f5478215-0e1a-8a2a-19ec-378ac5849936@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <feb2938b-ee09-7fac-12f7-fe2d9faf78f9@suse.com>
Date:   Wed, 26 Jun 2019 11:03:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f5478215-0e1a-8a2a-19ec-378ac5849936@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.19 10:56, Zhenzhong Duan wrote:
> 
> On 2019/6/25 20:31, Juergen Gross wrote:
>> On 24.06.19 14:02, Zhenzhong Duan wrote:
>>> PVH guest needs PV extentions to work, so nopv parameter is ignored
>>> for PVH but not for HVM guest.
>>>
>>> In order for nopv parameter to take effect for HVM guest, we need to
>>> distinguish between PVH and HVM guest early in hypervisor detection
>>> code. By moving the detection of PVH in xen_platform_hvm(),
>>> xen_pvh_domain() could be used for that purpose.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: xen-devel@lists.xenproject.org
>>> ---
>>>   arch/x86/xen/enlighten_hvm.c | 18 ++++++++++++------
>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
>>> index 7fcb4ea..26939e7 100644
>>> --- a/arch/x86/xen/enlighten_hvm.c
>>> +++ b/arch/x86/xen/enlighten_hvm.c
>>> @@ -25,6 +25,7 @@
>>>   #include "mmu.h"
>>>   #include "smp.h"
>>>   +extern bool nopv;
>>>   static unsigned long shared_info_pfn;
>>>     void xen_hvm_init_shared_info(void)
>>> @@ -226,20 +227,24 @@ static uint32_t __init xen_platform_hvm(void)
>>>       if (xen_pv_domain())
>>>           return 0;
>>>   +#ifdef CONFIG_XEN_PVH
>>> +    /* Test for PVH domain (PVH boot path taken overrides ACPI 
>>> flags). */
>>> +    if (!x86_platform.legacy.rtc && x86_platform.legacy.no_vga)
>>> +        xen_pvh = true;
>>
>> Sorry, this won't work, as ACPI tables are scanned only some time later.
> Hmm, right. Thanks for point out.
>>
>> You can test for xen_pvh being true here (for the case where the guest
>> has been booted via the Xen-PVH boot entry) and handle that case, but
>> the case of a PVH guest started via the normal boot entry (like via
>> grub2) and nopv specified is difficult. The only idea I have right now
>> would be to use another struct hypervisor_x86 for that case which will
>> only be used for Xen HVM/PVH _and_ nopv specified. It should be a copy
>> of the bare metal variant, but a special guest_late_init member issuing
>> a big fat warning in case PVH is being detected.
> 
> After that warning, I guess PVH will run into hang finally? If it's 
> true, BUG() is better?
> 
> Adding another hypervisor_x86 is a bit redundant, I think of below change.
> 
> I'll test it tomorrow. But appreciate your suggestion whether it's 
> feasible. Thanks

Yes, this seems to be a viable option.

> 
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -25,6 +25,7 @@
>   #include "mmu.h"
>   #include "smp.h"
> 
> +extern bool nopv;
>   static unsigned long shared_info_pfn;
> 
>   void xen_hvm_init_shared_info(void)
> @@ -221,11 +222,37 @@ bool __init xen_hvm_need_lapic(void)
>          return true;
>   }
> 
> +static __init void xen_hvm_nopv_guest_late_init(void)
> +{
> +#ifdef CONFIG_XEN_PVH
> +       if (x86_platform.legacy.rtc || !x86_platform.legacy.no_vga)
> +               return;
> +
> +       /* PVH detected. */
> +       xen_pvh = true;
> +
> +       printk(KERN_CRIT "nopv parameter isn't supported in PVH guest\n");
> +       BUG();
> +#endif
> +}
> +
> +
>   static uint32_t __init xen_platform_hvm(void)
>   {
>          if (xen_pv_domain())
>                  return 0;
> 
> +       if (xen_pvh_domain() && nopv)
> +       {
> +       /* guest booting via the Xen-PVH boot entry goes here */

Mind adjusting indentation of that comment?

> +               printk(KERN_INFO "nopv parameter is ignored in PVH 
> guest\n");
> +       }
> +       else if (nopv)
> +       {
> +       /* guest booting via normal boot entry (like via grub2) goes 
> here */

Same again?

With those corrected and no other changes you can add my:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
