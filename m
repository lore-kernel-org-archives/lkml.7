Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B2AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8327C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="1xK3uATZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCMHaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:30:11 -0400
Received: from www.scalemp.com ([169.44.78.149]:41742 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMHaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0Iblm/3i7hHJ0/qgglLyRtd3BIr8HICbygeY7e8SqgU=; b=1xK3uATZ2j/At0IP9EaX0rwGPv
        96bYfAafs04+N9YDIMXOLPiqMA6XxyNH7fCZk1sjewZ8J1cO76HI0+k+DA4mt2oiZuWcE0ihMDJSb
        6z0xq81+7HmCdXoQI4f9gxeEM6ReK6x5oUIZCuJ8gtOnj4C9RVaRJDu0m+xVaVfFyWas=;
Received: from bzq-80-45-146.red.bezeqint.net ([82.80.45.146]:22843 helo=[10.100.0.166])
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <oren@scalemp.com>)
        id 1h3yL2-000Gh2-Ov; Wed, 13 Mar 2019 03:30:08 -0400
Subject: Re: [PATCH] svm: Fix AVIC incomplete IPI emulation
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d53d2240-d1f1-da04-9126-9eb3518d0047@scalemp.com>
 <ab2b29ac-adcf-12ab-7c53-cc427995e94c@amd.com>
From:   Oren Twaig <oren@scalemp.com>
Message-ID: <752f5b0a-381c-d559-ec8a-dc41b1e36010@scalemp.com>
Date:   Wed, 13 Mar 2019 09:30:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ab2b29ac-adcf-12ab-7c53-cc427995e94c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: oren@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: oren@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

Please see below..

On 03/11/2019 01:38 PM, Suthikulpanit, Suravee wrote:
> Hi Oren,
>
> Sorry for delay response.
>
> On 3/5/19 1:15 AM, Oren Twaig wrote:
>> Hello Suravee,
>>
>> According to AMD's SDM, the target-not-running incomplete
>> ipi exit is only received if any of the destination cpus had the
>> not-running bit set in the avic backing page.
> I believe you are referring to the "isRunning" (IR) bit is in the
> AVIC physical APIC ID table entry.
I meant cause ID=1 in IPI Delivery Failure Cause (SDM rev 3.30, sep 
2018, Table 15-28):

"
1: IPI Target Not Running:

IsRunning bit of the target for a
Singlecast/Broadcast/Multicast IPI is not set in
the physical APIC ID table.

"

>
>> However, not before the CPU _already_ set the relevant IRR bit
>> in all these cpus.
> Not sure what you meant here.

Here is the full snippet from the specifications:
"
5.For every valid destination:
- Atomically set the appropriate IRR bit in each of the destinations’
   vAPIC backing page.
- Check the IsRunning status of each destination.
- If the destination IsRunning bit is set, send a doorbell message
   using the host physical core number from the Physical APIC ID table.

6. If any destinations are identified as not currently scheduled on
  a physical core (i.e., the IsRunning
  bit for that virtual processor is not set), cause a #VMEXIT.
"

According to the specification above, the HW should first
set the appropriate bit in the IRR (Interrupt Request Register)
_before_ causing VMEXIT of IPI-delivery-not-completed
with  ID=1 (Target not running).

>
>> In this change, the patch forces KVM to send another interrupt
>> to the vcpu whether SVM already did that or not. Which means
>> the vcpu/s, under some conditions, can get an EXTRA interrupt
>> it never intended to get >> Example:
>>     1. vcpu B: Is in "not-running" state.
>>     2. vcpu A: Writes to the ICR to send vector 80 to vcpu B
>>     3. vcpu A: SVM updates vcpu B IRR with bit 80
>>     4. vcpu A: SVM exits on incomplete IPI target-not-running exit.
>>     5. vcpu A: Now stops executing any code @ hypervisor level.
>>     6. vcpu B: Due to another interrupt (like lapic timer)
>>        resumes running the guest. While handling interrupts,
>>        it also handles interrupt vector 80 (as it's in his IRR)
>>     7. vcpu A: resumes executing the below code and sends
>>        an _additional_interrupt to vcpu B.
>>
>> Overall, vcpu B got two interrupts. The second is unwanted and
>> not documented in the system architecture.
>>
>> Can you please elaborate more to why the implementation
>> below conflict with the specifications (which was the code
>> before this commit) ?
> This patch was introduced to fix an issue where the SVM driver tries to
> handle the step 5 above by scheduling vcpu B into _running_ state to handle
> the IPI from vcpu A. However, prior to this patch, vcpu B was never get
> scheduled to run unless there are other interrupts (e.g. timer).
Exactly. Only what needed here is *only* to wakeup the vcpu B. Why ? because
the apic of vcpu B _already_ contains the interrupt in the pending
IRR. Than, once vcpu B will run it will process the IRR which contains
the vector placed by the HW and will deliver it.
> This should not be the case as Vcpu B should have been running regardless
> of other interrupts. So, I don't think step 6 and 7 above are correct.
The example of vcpu A that stops executing is just to highlight that
the code can't depend on that the kvm code of vcpu A will finish the
ICR "fake" call before vcpu B runs (beacuse of any interrupt) and process
that IRR request placed by the HW.
>
> The issue was caused by the apic->irr_pending not set to true when trying to
> get vcpu B scheduled. This flag is checked in apic_find_highest_irr() before
> searching for the highest bit.
>
> To fix the issue, I decided to leverage the existing emulation code for
> ICR and ICR2, which in turn calls apic_send_ipi() to deliver interrupt to vpu B.
>
> However, looking a bit more closely, I notice the logic in svm_deliver_avic_intr()
> should also have been changed from kvm_vcpu_wake_up() to kvm_vcpu_kick()
> since the latter will result in clearing the IRR bit for the IPI vector
> when trying to send IPI as part of the following call path.
>
>     vcpu_enter_guest()
>       |-- inject_pending_event()
>         |-- kvm_cpu_get_interrupt()
>           |--  kvm_get_apic_interrupt()
>             |-- apic_clear_irr()
>             |-- apic_set_isr()
>             |-- apic_update_ppr() ....
>
> Please see the patch below.
>
> Not sure if this would address the problem you are seeing.
I still think there a bug here where vcpu B will get two interrupts
instead of one.

Thanks,
Oren
>
> Thanks,
> Suravee
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 24dfa6a93711..d2841c3dbc04 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5219,11 +5256,13 @@ static void svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
>           kvm_lapic_set_irr(vec, vcpu->arch.apic);
>           smp_mb__after_atomic();
>
> -       if (avic_vcpu_is_running(vcpu))
> +       if (avic_vcpu_is_running(vcpu)) {
>                   wrmsrl(SVM_AVIC_DOORBELL,
>                          kvm_cpu_get_apicid(vcpu->cpu));
> -       else
> -               kvm_vcpu_wake_up(vcpu);
> +       } else {
> +               kvm_make_request(KVM_REQ_EVENT, vcpu);
> +               kvm_vcpu_kick(vcpu);
> +       }
>    }
>
>    static void svm_ir_list_del(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)

