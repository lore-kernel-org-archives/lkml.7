Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1168BC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F2F2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfKFBBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:01:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:35686 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729614AbfKFBBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 20:01:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 17:01:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; 
   d="scan'208";a="205687897"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.239.198.110]) ([10.239.198.110])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2019 17:01:18 -0800
Subject: Re: [PATCH] KVM: X86: Dynamically allocating MSR number
 lists(msrs_to_save[], emulated_msrs[], msr_based_features[])
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20191105092031.8064-1-chenyi.qiang@intel.com>
 <4a5fd5b4-64b7-726a-57a5-a5c669ce84f6@redhat.com>
 <477da390-4bdb-c25d-24b1-5b57c3bf78bb@intel.com>
 <cd930947-2621-550c-8a41-e1a396650928@redhat.com>
From:   cqiang <chenyi.qiang@intel.com>
Message-ID: <f55f719d-7aca-a0e4-54cd-8a2420dc2618@intel.com>
Date:   Wed, 6 Nov 2019 09:01:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cd930947-2621-550c-8a41-e1a396650928@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2019 9:03 PM, Paolo Bonzini wrote:
> On 05/11/19 13:51, Xiaoyao Li wrote:
>> On 11/5/2019 7:30 PM, Paolo Bonzini wrote:
>>> On 05/11/19 10:20, Chenyi Qiang wrote:
>>>> The three msr number lists(msrs_to_save[], emulated_msrs[] and
>>>> msr_based_features[]) are global arrays of kvm.ko, which are
>>>> initialized/adjusted (copy supported MSRs forward to override the
>>>> unsupported MSRs) when installing kvm-{intel,amd}.ko, but it doesn't
>>>> reset these three arrays to their initial value when uninstalling
>>>> kvm-{intel,amd}.ko. Thus, at the next installation, kvm-{intel,amd}.ko
>>>> will initialize the modified arrays with some MSRs lost and some MSRs
>>>> duplicated.
>>>>
>>>> So allocate and initialize these three MSR number lists dynamically when
>>>> installing kvm-{intel,amd}.ko and free them when uninstalling.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> ---
>>>>    arch/x86/kvm/x86.c | 86 ++++++++++++++++++++++++++++++----------------
>>>>    1 file changed, 57 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>>> index ff395f812719..08efcf6351cc 100644
>>>> --- a/arch/x86/kvm/x86.c
>>>> +++ b/arch/x86/kvm/x86.c
>>>> @@ -1132,13 +1132,15 @@ EXPORT_SYMBOL_GPL(kvm_rdpmc);
>>>>     * List of msr numbers which we expose to userspace through
>>>> KVM_GET_MSRS
>>>>     * and KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.
>>>>     *
>>>> - * This list is modified at module load time to reflect the
>>>> + * The three msr number lists(msrs_to_save, emulated_msrs,
>>>> msr_based_features)
>>>> + * are allocated and initialized at module load time and freed at
>>>> unload time.
>>>> + * msrs_to_save is selected from the msrs_to_save_all to reflect the
>>>>     * capabilities of the host cpu. This capabilities test skips MSRs
>>>> that are
>>>> - * kvm-specific. Those are put in emulated_msrs; filtering of
>>>> emulated_msrs
>>>> + * kvm-specific. Those are put in emulated_msrs_all; filtering of
>>>> emulated_msrs
>>>>     * may depend on host virtualization features rather than host cpu
>>>> features.
>>>>     */
>>>>    -static u32 msrs_to_save[] = {
>>>> +const u32 msrs_to_save_all[] = {
>>>
>>> This can remain static.
>>
>> How about static const u32 msrs_to_save_all[] ?
>>
>> Or you think static is enough?
> 
> "static const" is best indeed (that's what I meant, but I wasn't very
> clear).
> 

Yes, considering the read-only property and scope of these arrays, 
"static const" is more accurate. Thanks.

> Paolo
> 
>>>>        MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP,
>>>> MSR_IA32_SYSENTER_EIP,
>>>>        MSR_STAR,
>>>>    #ifdef CONFIG_X86_64
>>>> @@ -1179,9 +1181,10 @@ static u32 msrs_to_save[] = {
>>>>        MSR_ARCH_PERFMON_EVENTSEL0 + 16, MSR_ARCH_PERFMON_EVENTSEL0 + 17,
>>>>    };
>>>>    +static u32 *msrs_to_save;
>>>
>>> You can use ARRAY_SIZE to allocate the destination arrays statically.
>>
>> It's much better, then we don't need to allocation and free.
>>

Got it. Thanks!

>>> Paolo
>>>
> 
