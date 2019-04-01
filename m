Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658722086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VuIE/q9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfDAKIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:08:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60830 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:08:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x31A604V141939;
        Mon, 1 Apr 2019 10:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=X+rIyJ0QQfWxb3wvNs8B9usSAXkS7iVp+Q4mCPq9nC4=;
 b=VuIE/q9x4k0gCyzhYisTtWbYI9CoYj7OfsayAiPhlwXdmZsK/6PI3fzV2rFEqH6TOACi
 nNJ0v8eiNC11EeIAWUHOZCibHWZNmpyY6unVmvlsY8t2srCktVHmhwvME6EbS5l/KPBK
 UxI9A7is1OTN9hr46xXSUh1728T8E2MFp9H2Y8bvWjVrhzy/AxdHfXMc24BdPcJx0zJM
 JLMrUnH1VjDllIrPTF8B5KelfFMQLitHzd1DFZNfoVvyuTj2/oGl3m2BCUhzw/l9PbgD
 4yJS3OVafaBjKNvE2XQr4ywlWLn+OkHYGKK9ZjXtr/zXUTIIOAXenrmcQZ6WvqgF7cpT Zw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2rhyvsx1b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 10:08:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x31A8Wsm024998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 10:08:32 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x31A8W1a025590;
        Mon, 1 Apr 2019 10:08:32 GMT
Received: from [192.168.14.112] (/109.65.229.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 03:08:32 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through
 preemtion timer to assist buggy guests
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <87v9zy15mc.fsf@vitty.brq.redhat.com>
Date:   Mon, 1 Apr 2019 13:08:27 +0300
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B70317FC-A5AF-41B7-8D1E-A38B14806FE4@oracle.com>
References: <20190328203110.20655-1-vkuznets@redhat.com>
 <f64742ef-c67d-db0f-d812-2b6f5048d7ee@redhat.com>
 <87d0m93frp.fsf@vitty.brq.redhat.com>
 <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com>
 <63F1B6AE-F7A0-40D9-9582-558723800682@oracle.com>
 <32296de3-8ce0-c20a-5948-a7eef267a328@redhat.com>
 <87v9zy15mc.fsf@vitty.brq.redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=874 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 1 Apr 2019, at 11:39, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 29/03/19 16:32, Liran Alon wrote:
>>> Paolo I am not sure this is the case here. Please read my other
>>> replies in this email thread.
>>>=20
>>> I think this is just a standard issue of a level-triggered interrupt
>>> handler in L1 (Hyper-V) that performs EOI before it lowers the
>>> irq-line. I don=E2=80=99t think vector 96 is even related to the =
issue at
>>> hand here. This is why after it was already handled, the loop of
>>> EXTERNAL_INTERRUPT happens on vector 80 and not vector 96.
>>=20
>> Hmm... Vitaly, what machine were you testing on---does it have =
APIC-v?
>> If not, then you should have seen either an EOI for irq 96 or a TPR
>> below threshold vmexit.  However, if it has APIC-v then you wouldn't
>> have seen any of this (you only see the EOI for irq 80 because it's
>> level triggered) and Liran is probably right.
>>=20
>=20
> It does, however, the issue is reproducible with and without
> it. Moreover, I think the second simultaneous IRQ is just a red =
herring;
> Here is another trace (enable_apicv). Posting it non-stripped and hope
> your eyes will catch something I'm missing:
>=20
> [001] 513675.736316: kvm_exit:             reason VMRESUME rip =
0xfffff80002cae115 info 0 0
> [001] 513675.736321: kvm_entry:            vcpu 0
> [001] 513675.736565: kvm_exit:             reason EXTERNAL_INTERRUPT =
rip 0xfffff80362dcd26d info 0 800000ec
> [001] 513675.736566: kvm_nested_vmexit:    rip fffff80362dcd26d reason =
EXTERNAL_INTERRUPT info1 0 info2 0 int_info 800000ec int_info_err 0
> [001] 513675.736568: kvm_entry:            vcpu 0
> [001] 513675.736650: kvm_exit:             reason EPT_VIOLATION rip =
0xfffff80362dcd230 info 182 0
> [001] 513675.736651: kvm_nested_vmexit:    rip fffff80362dcd230 reason =
EPT_VIOLATION info1 182 info2 0 int_info 0 int_info_err 0
> [001] 513675.736651: kvm_page_fault:       address 261200000 =
error_code 182
>=20
> -> injecting
>=20
> [008] 513675.737059: kvm_set_irq:          gsi 23 level 1 source 0
> [008] 513675.737061: kvm_msi_set_irq:      dst 0 vec 80 =
(Fixed|physical|level)
> [008] 513675.737062: kvm_apic_accept_irq:  apicid 0 vec 80 =
(Fixed|edge)
> [001] 513675.737233: kvm_nested_vmexit_inject: reason =
EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
> [001] 513675.737239: kvm_entry:            vcpu 0
> [001] 513675.737243: kvm_exit:             reason EOI_INDUCED rip =
0xfffff80002c85e1a info 50 0
>=20
> -> immediate EOI causing re-injection (even preemption timer is not
> involved here).
>=20
> [001] 513675.737244: kvm_eoi:              apicid 0 vector 80
> [001] 513675.737245: kvm_fpu:              unload
> [001] 513675.737246: kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI =
(26)
> [001] 513675.737256: kvm_set_irq:          gsi 23 level 1 source 0
> [001] 513675.737259: kvm_msi_set_irq:      dst 0 vec 80 =
(Fixed|physical|level)
> [001] 513675.737260: kvm_apic_accept_irq:  apicid 0 vec 80 =
(Fixed|edge)
> [001] 513675.737264: kvm_fpu:              load
> [001] 513675.737265: kvm_entry:            vcpu 0
> [001] 513675.737271: kvm_exit:             reason VMRESUME rip =
0xfffff80002cae115 info 0 0
> [001] 513675.737278: kvm_entry:            vcpu 0
> [001] 513675.737282: kvm_exit:             reason PREEMPTION_TIMER rip =
0xfffff80362dcc2d0 info 0 0
> [001] 513675.737283: kvm_nested_vmexit:    rip fffff80362dcc2d0 reason =
PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
> [001] 513675.737285: kvm_nested_vmexit_inject: reason =
EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
> [001] 513675.737289: kvm_entry:            vcpu 0
> [001] 513675.737293: kvm_exit:             reason EOI_INDUCED rip =
0xfffff80002c85e1a info 50 0
> [001] 513675.737293: kvm_eoi:              apicid 0 vector 80
> [001] 513675.737294: kvm_fpu:              unload
> [001] 513675.737295: kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI =
(26)
> [001] 513675.737299: kvm_set_irq:          gsi 23 level 1 source 0
> [001] 513675.737299: kvm_msi_set_irq:      dst 0 vec 80 =
(Fixed|physical|level)
> [001] 513675.737300: kvm_apic_accept_irq:  apicid 0 vec 80 =
(Fixed|edge)
> [001] 513675.737302: kvm_fpu:              load
> [001] 513675.737303: kvm_entry:            vcpu 0
> [001] 513675.737307: kvm_exit:             reason VMRESUME rip =
0xfffff80002cae115 info 0 0
>=20
> ...
>=20
> --=20
> Vitaly

So to sum-up: This matches what I mentioned in my previous emails right?
That vector 96 is not related, and the only issue here is that =
level-triggered interrupt handler for vector 80 is doing EOI before =
lowering the irq-line.
Which cause vector 80 to be injected in infinite loop.
And this is not even related to being a nested virtualization workload. =
It=E2=80=99s just an issue in Hyper-V (L1) interrupt handler for vector =
80.

Therefore the only action-items are:
1) Microsoft to fix Hyper-V vector 80 interrupt handler to lower =
irq-line before EOI.
2) Patch QEMU IOAPIC implementation to have a mechanism similar to KVM =
to delay injection of level-triggered interrupt
    in case we are injecting the same interrupt for X times in a row.

-Liran









