Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D365C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3247218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8JViSNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfC2Pco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:32:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54730 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfC2Pcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:32:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TFT5cn076374;
        Fri, 29 Mar 2019 15:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=mGWSACrkMo1yya3P4I6MhhCZpSkW9f4Lh5S0L5Z85JM=;
 b=m8JViSNAvwbT4lmmEiRlcbwRmXlWr/6C9hgfE1kSmV6FeMska8h/1B37NyqilxlXxQFo
 80ewalnT+8EApPFEHIu0n93X9kwb0iWDv50ngCiEBYBqWIVE3nr9dyaL7j9iQva1YDl3
 d8/04t2hc5T6vl2nE94RfFdELvcnNJbBt4auwBiBg8qYSMqEpWFcDFfV5idy4E6z3qOy
 alNX0RXOwwX3pVXHCRVyP1RBr4uxMbCOf6sJxOJkR4DF6pgj8kdUKnH5EmH+Ws3Kvn4I
 QYlJ2Qrn6bSR/WPZLkTZGBrGsnWuZnw6zTo26Fkn/fwjpKylQRMOtYJjzgpZ9cIBIYJa bg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2re6g1d5v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:32:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFWb5E004311
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:32:37 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFWakK024417;
        Fri, 29 Mar 2019 15:32:36 GMT
Received: from [192.168.14.112] (/79.183.242.215)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 08:32:36 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through
 preemtion timer to assist buggy guests
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com>
Date:   Fri, 29 Mar 2019 18:32:32 +0300
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <63F1B6AE-F7A0-40D9-9582-558723800682@oracle.com>
References: <20190328203110.20655-1-vkuznets@redhat.com>
 <f64742ef-c67d-db0f-d812-2b6f5048d7ee@redhat.com>
 <87d0m93frp.fsf@vitty.brq.redhat.com>
 <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 29 Mar 2019, at 18:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 29/03/19 15:40, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On 28/03/19 21:31, Vitaly Kuznetsov wrote:
>>>>=20
>>>> The 'hang' scenario develops like this:
>>>> 1) Hyper-V boots and QEMU is trying to inject two irq =
simultaneously. One
>>>> of them is level-triggered. KVM injects the edge-triggered one and
>>>> requests immediate exit to inject the level-triggered:
>>>>=20
>>>> kvm_set_irq:          gsi 23 level 1 source 0
>>>> kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>>>> kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>>>> kvm_msi_set_irq:      dst 0 vec 96 (Fixed|physical|edge)
>>>> kvm_apic_accept_irq:  apicid 0 vec 96 (Fixed|edge)
>>>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 =
int_info 80000060 int_info_err 0
>>>>=20
>>>> 2) Hyper-V requires one of its VMs to run to handle the situation =
but
>>>> immediate exit happens:
>>>>=20
>>>> kvm_entry:            vcpu 0
>>>> kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 =
0
>>>> kvm_entry:            vcpu 0
>>>> kvm_exit:             reason PREEMPTION_TIMER rip =
0xfffff8022f3d8350 info 0 0
>>>> kvm_nested_vmexit:    rip fffff8022f3d8350 reason PREEMPTION_TIMER =
info1 0 info2 0 int_info 0 int_info_err 0
>>>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 =
int_info 80000050 int_info_err 0
>>>=20
>>> I supposed before this there was an eoi for vector 96?
>>=20
>> AFAIR: no, it seems that it is actually the VM it is trying to resume
>> (Windows partition?) which needs to do some work and with the =
preemtion
>> timer of 0 we don't allow it to.
>=20
> kvm_apic_accept_irq placed IRQ 96 in IRR, and Hyper-V should be =
running
> with "acknowledge interrupt on exit" since int_info is nonzero in
> kvm_nested_vmexit_inject.
>=20
> Therefore, at the kvm_nested_vmexit_inject tracepoint KVM should have
> set bit 96 in ISR; and because PPR is now 96, interrupt 80 should have
> never been delivered.  Unless 96 is an auto-EOI interrupt, in which =
case
> this comment would apply
>=20
>          /*
>           * For auto-EOI interrupts, there might be another pending
>           * interrupt above PPR, so check whether to raise another
>           * KVM_REQ_EVENT.
>           */
>=20
> IIRC there was an enlightenment to tell Windows "I support auto-EOI =
but
> please don't use it".  If this is what's happening, that would also =
fix it.
>=20
> Thanks,
>=20
> Paolo

Paolo I am not sure this is the case here.
Please read my other replies in this email thread.

I think this is just a standard issue of a level-triggered interrupt =
handler in L1 (Hyper-V) that performs EOI before it lowers the irq-line.
I don=E2=80=99t think vector 96 is even related to the issue at hand =
here. This is why after it was already handled, the loop of =
EXTERNAL_INTERRUPT
happens on vector 80 and not vector 96.

In addition, there is a missing optimisation from Hyper-V that after it =
handles an EXTERNAL_INTERRUPT exit, it doesn=E2=80=99t enable interrupts
to receive other pending host interrupts (In our case, the pending =
vector 80) and will therefore only receive it once it enters back to L2
which will cause another EXTERNAL_INTERRUPT exit but this time on vector =
80.

-Liran


