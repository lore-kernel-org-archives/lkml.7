Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB11DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1D7222C2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfKDM1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:27:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbfKDM1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:27:01 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A192B85529
        for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2019 12:27:00 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id d140so5950687wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 04:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ozlzVOl3s+SOV/pUKKavAs7xHDlg0fo60/2LxRPsJKs=;
        b=pYn/d5TtkjVFWO48Q29tiQdOPjS4B+SRDz3evBypzysM0cP76jxTeDdn2CXKCYyTo9
         CvcuBPgzvvQ6qbBMqPrFTylczKCqGVBfdiw78QC47IHBlque84LefOsARLevUelN5SFY
         /C7FBRC+m7iSjsSkE8QCwFKz1M+Vz1xKOAOhzfEYZjyT3kGVPBotnvoKBZOE9ggTI22b
         Bu2ZqQyjA6OD3itY32oXmsyNBeZ40gDzXfcRDNFSPRKP24bkU+FEKyM7o/YWNGksiO+K
         vkfbnk3d8HV4cKGDxHX52NQk8xMKbMaRcK1j7fe8qXNNhFhAKnkPCSboi6tQEAYXi66m
         ERdg==
X-Gm-Message-State: APjAAAUM7SZCcmRtTxozcBBgx4N+VRojy+Gu6jK3dOtf4wS9gGp/v7Lg
        +qJr5vDB6D2xgsLHMB0R3ZkJC1TAuxVvaJhoE4Iyv1ajaMwSTwwjrkcMHY88lkT4+ZS9UT2Ykb4
        fCWgjaJ6ySZ9TDK/0Uiy+MhFH
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr14767795wmj.84.1572870419166;
        Mon, 04 Nov 2019 04:26:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmoF4fUOScacJagfmSFTj7qEakXGqgaweR/e/MrQBo15IbxOTMab8PdLeortax1r4WuEbBag==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr14767760wmj.84.1572870418861;
        Mon, 04 Nov 2019 04:26:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id b196sm20734566wmd.24.2019.11.04.04.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:26:58 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: Fix rcu splat if vm creation fails
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1572848879-21011-1-git-send-email-wanpengli@tencent.com>
 <1572848879-21011-2-git-send-email-wanpengli@tencent.com>
 <c32d632b-8fb0-f7c6-4937-07c30769b924@redhat.com>
 <CANRm+CzkbrbE2C2yFKL1=mQCBCZMfVH8Tue3eXXqTL5Z1VUB5w@mail.gmail.com>
 <ee896a34-0914-8d3c-bcdd-5aede1743190@redhat.com>
 <CANRm+CyLiP_EncGnpMug9hbJYO+hC0DT2a-p5mOKUKHnUadO9w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9e88b51b-9b37-3f14-8d98-0bb3ddbe6378@redhat.com>
Date:   Mon, 4 Nov 2019 13:26:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CyLiP_EncGnpMug9hbJYO+hC0DT2a-p5mOKUKHnUadO9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 13:25, Wanpeng Li wrote:
> On Mon, 4 Nov 2019 at 20:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 04/11/19 13:16, Wanpeng Li wrote:
>>>> I don't understand this one, hasn't
>>>>
>>>>         WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
>>>>
>>>> decreased the conut already?  With your patch the refcount would then
>>>> underflow.
>>>
>>> r = kvm_arch_init_vm(kvm, type);
>>> if (r)
>>>     goto out_err_no_arch_destroy_vm;
>>>
>>> out_err_no_disable:
>>>     kvm_arch_destroy_vm(kvm);
>>>     WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
>>> out_err_no_arch_destroy_vm:
>>>
>>> So, if kvm_arch_init_vm() fails, we will not execute
>>> WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
>>
>> Uuh of course.  But I'd rather do the opposite: move the refcount_set
>> earlier so that refcount_dec_and_test can be moved after
>> no_arch_destroy_vm.  Moving the refcount_set is not strictly necessary,
>> but avoids the introduction of yet another label.
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index e22ff63e5b1a..e7a07132cd7f 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -650,6 +650,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
>>         if (init_srcu_struct(&kvm->irq_srcu))
>>                 goto out_err_no_irq_srcu;
>>
>> +       refcount_set(&kvm->users_count, 1);
>>         for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
>>                 struct kvm_memslots *slots = kvm_alloc_memslots();
>>
>> @@ -667,7 +668,6 @@ static struct kvm *kvm_create_vm(unsigned long type)
>>                         goto out_err_no_arch_destroy_vm;
>>         }
>>
>> -       refcount_set(&kvm->users_count, 1);
>>         r = kvm_arch_init_vm(kvm, type);
>>         if (r)
>>                 goto out_err_no_arch_destroy_vm;
>> @@ -696,8 +696,8 @@ static struct kvm *kvm_create_vm(unsigned long type)
>>         hardware_disable_all();
>>  out_err_no_disable:
>>         kvm_arch_destroy_vm(kvm);
>> -       WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
>>  out_err_no_arch_destroy_vm:
>> +       WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
>>         for (i = 0; i < KVM_NR_BUSES; i++)
>>                 kfree(kvm_get_bus(kvm, i));
>>         for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
> 
> Good point, I will handle these two patches later.

No problem, I can send v2 after testing.

Paolo

