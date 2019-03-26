Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DEC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759412075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="geksEQ3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfCZPCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:02:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZPCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:02:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2QEx0wV109342;
        Tue, 26 Mar 2019 15:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=TAR6lj1pmWecWAX0kQ9QEEEWKqV4yHmB5d5OtEQrFz8=;
 b=geksEQ3Bf26Xdg+u7uhi9Bm0s+KIazhk5mzxkz8seal/U8UYXzEWlC7BZ825uLWEqcZR
 n80qPy1dwpvcPgFoo6mx7D1Sn6pKdb9i8PSMkumA1GGL+LtiVqSHatZtDXxsLHWGFDxV
 iP8yfyn96wJzVJSTzIvkxoES99I7C4SxCKG56Mh1q+xU6oLmeTNmuqBHihikmk0icuMa
 N8BsG7OCWcBWKap2NWuSrl2QAPGxJBSUD0RecOW6n1XG9v0OcZjxnp4UwyWtHqjpXSKR
 vP5KdRAjVpaBDgPRu2LGKbn3E3NS5mGUTA68NOy7dPOclwPdYh9/SsMrcy8WHqjF/xie KA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2re6djb2fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 15:02:33 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2QF2WrJ022477
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 15:02:32 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2QF2W2v032601;
        Tue, 26 Mar 2019 15:02:32 GMT
Received: from [10.0.5.57] (/213.57.127.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 08:02:31 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] KVM: x86: nVMX: allow RSM to restore VMXE CR4 flag
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <87k1glagqj.fsf@vitty.brq.redhat.com>
Date:   Tue, 26 Mar 2019 17:02:27 +0200
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jon Doron <arilou@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <06E50BD4-B3AC-4DBB-B700-80C30F2DC8BB@oracle.com>
References: <20190326130746.28748-1-vkuznets@redhat.com>
 <DFD60850-CD9B-4FF3-9C46-EF4AF53C76CA@oracle.com>
 <87k1glagqj.fsf@vitty.brq.redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 26 Mar 2019, at 15:48, Vitaly Kuznetsov <vkuznets@redhat.com> =
wrote:
>=20
> Liran Alon <liran.alon@oracle.com> writes:
>=20
>>> On 26 Mar 2019, at 15:07, Vitaly Kuznetsov <vkuznets@redhat.com> =
wrote:
>>> - Instread of putting the temporary HF_SMM_MASK drop to
>>> rsm_enter_protected_mode() (as was suggested by Liran), move it to
>>> emulator_set_cr() modifying its interface. emulate.c seems to be
>>> vcpu-specifics-free at this moment, we may want to keep it this way.
>>> - It seems that Hyper-V+UEFI on KVM is still broken, I'm observing =
sporadic
>>> hangs even with this patch. These hangs, however, seem to be =
unrelated to
>>> rsm.
>>=20
>> Feel free to share details on these hangs ;)
>>=20
>=20
> You've asked for it)
>=20
> The immediate issue I'm observing is some sort of a lockup which is =
easy
> to trigger with e.g. "-usb -device usb-tablet" on Qemu command line; =
it
> seems we get too many interrupts and combined with preemtion timer for
> L2 we're not making any progress:
>=20
> kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
> kvm_set_irq:          gsi 18 level 1 source 0
> kvm_msi_set_irq:      dst 0 vec 177 (Fixed|physical|level)
> kvm_apic_accept_irq:  apicid 0 vec 177 (Fixed|edge)
> kvm_fpu:              load
> kvm_entry:            vcpu 0
> kvm_exit:             reason VMRESUME rip 0xfffff80000848115 info 0 0
> kvm_entry:            vcpu 0
> kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff800f4448e01 =
info 0 0
> kvm_nested_vmexit:    rip fffff800f4448e01 reason PREEMPTION_TIMER =
info1 0 info2 0 int_info 0 int_info_err 0
> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 =
int_info 800000b1 int_info_err 0
> kvm_entry:            vcpu 0
> kvm_exit:             reason APIC_ACCESS rip 0xfffff8000081fe11 info =
10b0 0
> kvm_apic:             apic_write APIC_EOI =3D 0x0
> kvm_eoi:              apicid 0 vector 177
> kvm_fpu:              unload
> kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
> ...
> (and the pattern repeats)
>=20
> Maybe it is a usb-only/Qemu-only problem, maybe not.
>=20
> --=20
> Vitaly

The trace of kvm_apic_accept_irq should indicate that =
__apic_accept_irq() was called to inject an interrupt to L1 guest.
(I know that now we are running in L1 because next exit is a VMRESUME).

However, it is surprising to see that on next entry to guest, no =
interrupt was injected by vmx_inject_irq().
It may be because L1 guest is currently running with interrupt disabled =
and therefore only an IRQ-window was requested.
(Too bad we don=E2=80=99t have a trace for this=E2=80=A6)

Next, we got an exit from L1 guest on VMRESUME. As part of it=E2=80=99s =
handling, active VMCS was changed from vmcs01 to vmcs02.
I believe the immediate exit later on preemption-timer was because the =
immediate-exit-request mechanism was invoked
which is now implemented by setting a VMX preemption-timer with value of =
0 (Thanks to Sean).
(See vmx_vcpu_run() -> vmx_update_hv_timer() -> vmx_arm_hv_timer(vmx, =
0)).
(Note that the pending interrupt was evaluated because of a recent patch =
of mine to nested_vmx_enter_non_root_mode()
to request KVM_REQ_EVENT when vmcs01 have requested an IRQ-window)

Therefore when entering L2, you immediately get an exit on =
PREEMPTION_TIMER which will cause eventually L0 to call
vmx_check_nested_events() which notices now the pending interrupt that =
should have been injected before to L1
and now exit from L2 to L1 on EXTERNAL_INTERRUPT on vector 0xb1.

Then L1 handles the interrupt by performing an EOI to LAPIC which =
propagate an EOI to IOAPIC which immediately re-inject
the interrupt (after clearing the remote_irr) as the irq-line is still =
set. i.e. QEMU=E2=80=99s ioapic_eoi_broadcast() calls ioapic_service() =
immediate after it clears remote-irr for this pin.

Also note that in trace we see only a single kvm_set_irq to level 1 but =
we don=E2=80=99t see immediately another kvm_set_irq to level 0.
This should indicate that in QEMU=E2=80=99s IOAPIC redirection-table, =
this pin is configured as level-triggered interrupt.
However, the trace of kvm_apic_accept_irq indicates that this interrupt =
is raised as an edge-triggered interrupt.

To sum up:
1) I would create a patch to add a trace to vcpu_enter_guest() when =
calling enable_smi_window() / enable_nmi_window() / enable_irq_window().
2) It is worth investigating why MSI trigger-mode is edge-triggered =
instead of level-triggered.
3) If this is indeed a level-triggered interrupt, it is worth =
investigating how the interrupt source behaves. i.e. What cause this =
device to lower the irq-line?
(As we don=E2=80=99t see any I/O Port or MMIO access by L1 guest =
interrupt-handler before performing the EOI)
4) Does this issue reproduce also when running with kernel-irqchip? =
(Instead of split-irqchip)

-Liran




