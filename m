Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EC5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436DF217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D17/1c7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfC2MJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:09:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59932 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfC2MJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:09:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TC490I084061;
        Fri, 29 Mar 2019 12:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=eBqpUH0RzJOp9Bol38nTfys1RXM3FFYrjB5hIvZcWjU=;
 b=D17/1c7B1PVvCu3O0OSVdpeb3alX/D7IEEbccchE4W++su8oStH+Y1SjIGwWhqQ/tYpn
 /e5dJdlZi/uQY9d5VZaVCmcFdPHfg78IyltWXS5aNrxnfHvDjxewlBpUeBQaNnbbUnMb
 kFNF971Tf2PXpeZ3F3OuMT+GnMuoHcVL7fHzqXm1MkRK7FNfB5SUg/vdkR7Pu/DwkQ3X
 QBQZ/pIltjAR68SpyQ51PxXC3JwPw1HAxYr7o+VtRF66AzRbSroM2KHKOui+ivEsh0/E
 h+ygO3PqJRiuCmhWIjGXCJvJlkOD4m5c7UqlWaJTU6lvSNUkoo9pYKNc7+UeZcChKqMO 0g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1m03b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 12:09:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TC9RO3019849
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 12:09:27 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2TC9RLh017737;
        Fri, 29 Mar 2019 12:09:27 GMT
Received: from [192.168.14.112] (/79.183.242.215)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 05:09:26 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through
 preemtion timer to assist buggy guests
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <87k1gim48q.fsf@vitty.brq.redhat.com>
Date:   Fri, 29 Mar 2019 15:09:22 +0300
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <93A454CA-58BB-463F-8248-E06670E68638@oracle.com>
References: <20190328203110.20655-1-vkuznets@redhat.com>
 <025FEE7C-C807-4451-8E57-1EE368A96069@oracle.com>
 <87k1gim48q.fsf@vitty.brq.redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 29 Mar 2019, at 12:14, Vitaly Kuznetsov <vkuznets@redhat.com> =
wrote:
>=20
> Liran Alon <liran.alon@oracle.com> writes:
>=20
>>> On 28 Mar 2019, at 22:31, Vitaly Kuznetsov <vkuznets@redhat.com> =
wrote:
>>>=20
>>> This is embarassing but we have another Windows/Hyper-V issue to =
workaround
>>> in KVM (or QEMU). Hope "RFC" makes it less offensive.
>>>=20
>>> It was noticed that Hyper-V guest on q35 KVM/QEMU VM hangs on boot =
if e.g.
>>> 'piix4-usb-uhci' device is attached. The problem with this device is =
that
>>> it uses level-triggered interrupts.
>>>=20
>>> The 'hang' scenario develops like this:
>>> 1) Hyper-V boots and QEMU is trying to inject two irq =
simultaneously. One
>>> of them is level-triggered. KVM injects the edge-triggered one and
>>> requests immediate exit to inject the level-triggered:
>>>=20
>>> kvm_set_irq:          gsi 23 level 1 source 0
>>> kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>>> kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>>> kvm_msi_set_irq:      dst 0 vec 96 (Fixed|physical|edge)
>>> kvm_apic_accept_irq:  apicid 0 vec 96 (Fixed|edge)
>>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 =
int_info 80000060 int_info_err 0
>>=20
>> There is no immediate-exit here.
>> Here QEMU just set two pending irqs: vector 80 and vector 96.
>> Because vCPU 0 is running at non-root-mode, KVM emulates an exit from =
L2 to L1 on EXTERNAL_INTERRUPT.
>> Note that EXTERNAL_INTERRUPT is emulated on vector 0x60=3D=3D96 which =
is the higher vector which is pending which is correct.
>>=20
>> BTW, I don=E2=80=99t know why both are set in LAPIC as edge-triggered =
and not level-triggered.
>> But it can be seen from trace pattern that these interrupts are both =
level-triggered. (See QEMU=E2=80=99s ioapic_service()).
>> How did you deduce that one is edge-triggered and the other is
>> level-triggered?
>=20
> "kvm_apic_accept_irq" event misreports level-triggered interrupts as
> edge-triggered, see my "KVM: x86: avoid misreporting level-triggered
> irqs as edge-triggered in tracing" patch.
>=20
> Other than that I double-checked, both in Qemu and KVM (and there's a
> lot of additional debug prints stripped) and I'm certain there's no
> disagreement anywhere: gsi 23/vec 80 is a level-triggered interrupt.
>=20
>>=20
>>>=20
>>> 2) Hyper-V requires one of its VMs to run to handle the situation =
but
>>> immediate exit happens:
>>>=20
>>> kvm_entry:            vcpu 0
>>> kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 =
0
>>> kvm_entry:            vcpu 0
>>> kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff8022f3d8350 =
info 0 0
>>> kvm_nested_vmexit:    rip fffff8022f3d8350 reason PREEMPTION_TIMER =
info1 0 info2 0 int_info 0 int_info_err 0
>>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 =
int_info 80000050 int_info_err 0
>>=20
>> I assume that as part of Hyper-V VMExit handler for =
EXTERNAL_INTERRUPT, it will forward the interrupt to the host.
>> As done in KVM vcpu_enter_guest() calling =
kvm_x86_ops->handle_external_intr().
>> Because vmcs->vm_exit_intr_info specifies vector 96, we are still =
left with vector 80 pending.
>>=20
>> I also assume that Hyper-V utilise VM_EXIT_ACK_INTR_ON_EXIT and thus =
vector 96 is cleared from LAPIC IRR
>> and the bit in LAPIC ISR for vector 96 is set.
>> This is emulated by L0 KVM at nested_vmx_vmexit() -> =
kvm_cpu_get_interrupt().
>>=20
>> I further assume that at the point that vector 96 runs in L1, =
interrupts are disabled.
>> Afterwards I would expect L1 to enable interrupts (Similar to =
vcpu_enter_guest() calling local_irq_enable() after =
kvm_x86_ops->handle_external_intr()).
>>=20
>> I would expect Hyper-V handler for vector 96 at some point to do EOI =
such that when interrupts are later enabled, vector 80 will also get =
injected.
>> All of this before attempting to resume back into L2.
>>=20
>> However, it can be seen that indeed at this resume, you receive, =
after an immediate-exit, an injection of EXTERNAL_INTERRUPT on vector =
0x50=3D=3D80.
>> As if Hyper-V never enabled interrupts after handling vector 96 =
before doing a resume again to L2.
>>=20
>> This is still valid of course but just a bit bizarre and
>> inefficient. Oh well. :)
>=20
> Reverse-engineering is always fun :-)

We can report this to Microsoft as-well. :)

>=20
>>=20
>>>=20
>>> 3) Hyper-V doesn't want to deal with the second irq (as its VM still =
didn't
>>> process the first one)
>>=20
>> Both interrupts are for L1 not L2.
>>=20
>>> so it just does 'EOI' for level-triggered interrupt
>>> and this causes re-injection:
>>>=20
>>> kvm_exit:             reason EOI_INDUCED rip 0xfffff80006a17e1a info =
50 0
>>> kvm_eoi:              apicid 0 vector 80
>>> kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
>>> kvm_set_irq:          gsi 23 level 1 source 0
>>> kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>>> kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>>> kvm_entry:            vcpu 0
>>=20
>> What happens here is that Hyper-V as a response to second =
EXTERNAL_INTERRUPT on vector 80,
>> it invokes vector 80 handler which performs EOI which is configured =
in ioapic_exit_bitmap to cause EOI_INDUCED exit to L0.
>> The EOI_INDUCED handler will reach handle_apic_eoi_induced() -> =
kvm_apic_set_eoi_accelerated() -> kvm_ioapic_send_eoi() -> =
kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT),
>> which will cause the exit on KVM_EXIT_IOAPIC_EOI to QEMU as required.
>>=20
>> As part of QEMU handling for this exit (ioapic_eoi_broadcast()), it =
will note that pin=E2=80=99s irr is still set (irq-line was not lowered =
by vector 80 interrupt handler before EOI),
>> and thus vector 80 is re-injected by IOAPIC at ioapic_service().
>>=20
>> If this is indeed a level-triggered interrupt, then it seems buggy to =
me that vector 80 handler haven=E2=80=99t lowered the irq-line before =
EOI.
>> I would suggest adding a trace to QEMU=E2=80=99s ioapic_set_irq() for =
when vector=3D80 and level=3D0 and ioapic_eoi_broadcast() to verify if =
this is what happens.
>> Another option is that even though vector 80 handler lowered =
irq-line, it got re-set by device between when it lowered the irq-line =
and until it did an EOI. Which is legit.
>>=20
>> If the former is what happens and vector 80 handler haven=E2=80=99t =
lowered
>> the irq-line before EOI, this is the real root-cause of your issue at
>> hand here.
>=20
> Yes, exactly - and sorry if I wasn't clear about that. Hyper-V does =
EOI
> for a still pending level-triggered interrupt (as it can't actually =
fix
> the reason - in needs Windows partition - L2 VM - to run and do the
> job).
>=20
> As a pure speculation I can guess: they don't want to keep a queue of
> interrupts which need L2 handling and they count on the fact that =
doing
> EOI with interrupts disabled in L1 -> VMRESUME will actually allow L2 =
VM
> to run for some time and make some progress.=20

It seems very unlikely to me that IOAPIC will delay re-evaluation of =
irq-lines after an EOI so much that
CPU will actually be able to get back into VMX non-root-mode and execute =
a bunch of code that will
eventually lower the irq-line.

If L1 requires L2 to handle the level-triggered interrupt, then L1 =
should not EOI the interrupt but
instead just use vmcs12 to inject interrupt to L2 and allow L2 interrupt =
handler to first lower the
irq-line and only then perform EOI.

Let=E2=80=99s discuss about this with Microsoft and see what they have =
to say :)
(Let=E2=80=99s open a private email thread with them regarding this. =
Feel free to Cc me)

>=20
>>=20
>>>=20
>>> 4) As we arm preemtion timer again we get stuck in the infinite =
loop:
>>>=20
>>> kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 =
0
>>> kvm_entry:            vcpu 0
>>> kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff8022f3d8350 =
info 0 0
>>> kvm_nested_vmexit:    rip fffff8022f3d8350 reason PREEMPTION_TIMER =
info1 0 info2 0 int_info 0 int_info_err 0
>>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 =
int_info 80000050 int_info_err 0
>>> kvm_entry:            vcpu 0
>>> kvm_exit:             reason EOI_INDUCED rip 0xfffff80006a17e1a info =
50 0
>>> kvm_eoi:              apicid 0 vector 80
>>> kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
>>> kvm_set_irq:          gsi 23 level 1 source 0
>>> kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>>> kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>>> kvm_entry:            vcpu 0
>>> kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 =
0
>>> ...
>>>=20
>>> How does this work on hardware? I don't really know but it seems =
that we
>>> were dealing with similar issues before, see commit 184564efae4d7 =
("kvm:
>>> ioapic: conditionally delay irq delivery duringeoi broadcast"). In =
case EOI
>>> doesn't always cause an *immediate* interrupt re-injection some =
progress
>>> can be made.
>>=20
>> This commit tries to handle with a bug exactly as I have described =
above.
>> In case a level-triggered interrupt handler in guest performs EOI =
before it lowers the irq-line, it will be re-injected in a loop forever =
with the level-triggered interrupt.
>> The reason this doesn=E2=80=99t happen on real hardware is because =
there is a very short delay between when an EOI is performed to IOAPIC =
and until IOAPIC attempts to serve a new interrupt.
>>=20
>> To handle this, this commit delays the evaluation of IOAPIC new =
pending interrupts when it receives an EOI for a level-triggered =
interrupt.
>>=20
>>>=20
>>> An alternative approach would be to port the above mentioned commit =
to
>>> QEMU's ioapic implementation. I'm, however, not sure that =
level-triggered
>>> interrupts is a must to trigger the issue.
>>=20
>> This seems like the right solution to me.
>> It seems to me that I have actually pinpointed it in this analysis
>> directly to level-triggered interrupts and it is a must to trigger =
the
>> issue.
>=20
> Yes, in this particular case it is directly linked to (mis-)handling =
of
> a level-triggered interrupt.
>=20
>>=20
>> This also explains why the issue doesn=E2=80=99t reproduce when you =
are using in-kernel irqchip.
>> It also explains why "piix4-usb-uhci=E2=80=9D must be present to =
re-produce
>> this issue as probably the bug is in that device interrupt handler.
>=20
> Level-triggered interrupts are rather rare but still present, I think
> that any device using them can cause similar hang.

Why? This kind of hang should occur only if guest have buggy =
level-triggered interrupt handler.
If handler is written properly such that it lowers irq-line and only =
then does EOI, there is no reason
it will hang. (If between the irq-line lowering and the EOI the line =
gets asserted again, then it is legit
that there will be another interrupt as it should be handled).

-Liran

>=20
>> (We should probably report this bug to Microsoft. Do we have any
>> contacts for this?)
>=20
> Yes, I just wanted to get KVM people's opinion first.
>=20
>>=20
>> Do you agree with above analysis?
>=20
> Thank you for it! I think we're in violent agreement here :-)
>=20
>> -Liran
>>=20
>>>=20
>>> HV_TIMER_THROTTLE/HV_TIMER_DELAY are more or less arbitrary. I =
haven't
>>> looked at SVM yet but their immediate exit implementation does
>>> smp_send_reschedule(), I'm not sure this can cause the above =
described
>>> lockup.
>>>=20
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>=20
>> As mentioned above, I think this patch should be dropped.
>>=20
>=20
> Yes, of course, I never expected it to be merged. I am, however, =
afraid
> that we'll have to get back to this discussion if another scenario =
with
> 'immediate eoi storm' appears. I can't think of anything in particular
> right away so I'm going to implement the throttling for level-triggred
> interrupt re-assertion in Qemu first.
>=20
>>> ---
>>> arch/x86/kvm/vmx/vmcs.h |  2 ++
>>> arch/x86/kvm/vmx/vmx.c  | 24 +++++++++++++++++++++++-
>>> 2 files changed, 25 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
>>> index cb6079f8a227..983dfc60c30c 100644
>>> --- a/arch/x86/kvm/vmx/vmcs.h
>>> +++ b/arch/x86/kvm/vmx/vmcs.h
>>> @@ -54,6 +54,8 @@ struct loaded_vmcs {
>>> 	bool launched;
>>> 	bool nmi_known_unmasked;
>>> 	bool hv_timer_armed;
>>> +	unsigned long hv_timer_lastrip;
>>> +	int hv_timer_lastrip_cnt;
>>> 	/* Support for vnmi-less CPUs */
>>> 	int soft_vnmi_blocked;
>>> 	ktime_t entry_time;
>>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>>> index 617443c1c6d7..8a49ec14dd3a 100644
>>> --- a/arch/x86/kvm/vmx/vmx.c
>>> +++ b/arch/x86/kvm/vmx/vmx.c
>>> @@ -6321,14 +6321,36 @@ static void vmx_arm_hv_timer(struct vcpu_vmx =
*vmx, u32 val)
>>> 	vmx->loaded_vmcs->hv_timer_armed =3D true;
>>> }
>>>=20
>>> +#define HV_TIMER_THROTTLE 100
>>> +#define HV_TIMER_DELAY 1000
>>> +
>>> static void vmx_update_hv_timer(struct kvm_vcpu *vcpu)
>>> {
>>> 	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
>>> 	u64 tscl;
>>> 	u32 delta_tsc;
>>>=20
>>> +	/*
>>> +	 * Some guests are buggy and may behave in a way that causes KVM =
to
>>> +	 * always request immediate exit (e.g. of a nested guest). At =
the same
>>> +	 * time guest progress may be required to resolve the condition.
>>> +	 * Throttling below makes sure we never get stuck completely.
>>> +	 */
>>> 	if (vmx->req_immediate_exit) {
>>> -		vmx_arm_hv_timer(vmx, 0);
>>> +		unsigned long rip =3D kvm_rip_read(vcpu);
>>> +
>>> +		if (vmx->loaded_vmcs->hv_timer_lastrip =3D=3D rip) {
>>> +			++vmx->loaded_vmcs->hv_timer_lastrip_cnt;
>>> +		} else {
>>> +			vmx->loaded_vmcs->hv_timer_lastrip_cnt =3D 0;
>>> +			vmx->loaded_vmcs->hv_timer_lastrip =3D rip;
>>> +		}
>>> +
>>> +		if (vmx->loaded_vmcs->hv_timer_lastrip_cnt > =
HV_TIMER_THROTTLE)
>>> +			vmx_arm_hv_timer(vmx, HV_TIMER_DELAY);
>>> +		else
>>> +			vmx_arm_hv_timer(vmx, 0);
>>> +
>>> 		return;
>>> 	}
>>>=20
>>> --=20
>>> 2.20.1
>>>=20
>>=20
>=20
> --=20
> Vitaly

