Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E469C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6287C206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfHAANn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:13:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39651 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfHAANm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:13:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so18412915wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 17:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=di1CbJV8AoCoXfsvq5UpSjzqXIQkfCIKrUbqfdd0AvI=;
        b=ix6s9jYVNaQIpAdnywtYVRCtCfCUuh4mVNXVQvkG1++qmOYnIV+C89u64fBIYhmsVt
         VpqMMV1z5BMSODtEZLVBC3dPjovUcY4w/3PUglzBAwrZUnqdV2R+eOyCzYZzekh++3FW
         hYf9QA1aOJkAMUnvC8bVeU4uVmoGABf6TpSyRpobL+vmbG/UPFBHMtAgRrVqMCcAa/WE
         XicCXa88DYUoHhcitVIvNLFTFyUZPGiG7ZFhekLNXh+chiQFJ3ZKRwkFQJ8UnluxzvsQ
         Ca1tHuvqA7NiyDYX24Lx98IuePLGT8ji80+T3/MvcLc48gnMjdPtb/5jo7+VPV/YHReQ
         SWTg==
X-Gm-Message-State: APjAAAUaaJoyVJzjTElokxTKXSyhTSpNs2PHO9DuO4R+5LsBE4UMV4KA
        7w1fd2i7S8cZjKRsHbUvoS2ZkA==
X-Google-Smtp-Source: APXvYqzxFazYeZJBnkG+SpKM3qQhT56YpMVSEbuFJQpGvOQyo/0PWWK3YBsxhva+ttJSLjvQLUamKA==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr130219031wro.162.1564618420470;
        Wed, 31 Jul 2019 17:13:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3? ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
        by smtp.gmail.com with ESMTPSA id j10sm121657303wrd.26.2019.07.31.17.13.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 17:13:39 -0700 (PDT)
Subject: Re: [PATCH RFC 3/5] x86: KVM: svm: clear interrupt shadow on all
 paths in skip_emulated_instruction()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20190620110240.25799-1-vkuznets@redhat.com>
 <20190620110240.25799-4-vkuznets@redhat.com>
 <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
 <87ftmm71p3.fsf@vitty.brq.redhat.com>
 <36a9f411-f90c-3ffa-9ee3-6ebee13a763f@redhat.com>
 <CALMp9eQLCEzfdNzdhPtCf3bD-5c6HrSvJqP7idyoo4Gf3i5O1w@mail.gmail.com>
 <20190731233731.GA2845@linux.intel.com>
 <CALMp9eRRqCLKAL4FoZVMk=fHfnrN7EnTVxR___soiHUdrHLAMQ@mail.gmail.com>
 <20190731235637.GB2845@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <46f3cf18-f167-f66e-18b4-b66c8551dcd8@redhat.com>
Date:   Thu, 1 Aug 2019 02:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731235637.GB2845@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/19 01:56, Sean Christopherson wrote:
> On Wed, Jul 31, 2019 at 04:45:21PM -0700, Jim Mattson wrote:
>> On Wed, Jul 31, 2019 at 4:37 PM Sean Christopherson
>> <sean.j.christopherson@intel.com> wrote:
>>
>>> At a glance, the full emulator models behavior correctly, e.g. see
>>> toggle_interruptibility() and setters of ctxt->interruptibility.
>>>
>>> I'm pretty sure that leaves the EPT misconfig MMIO and APIC access EOI
>>> fast paths as the only (VMX) path that would incorrectly handle a
>>> MOV/POP SS.  Reading the guest's instruction stream to detect MOV/POP SS
>>> would defeat the whole "fast path" thing, not to mention both paths aren't
>>> exactly architecturally compliant in the first place.
>>
>> The proposed patch clears the interrupt shadow in the VMCB on all
>> paths through svm's skip_emulated_instruction. If this happens at the
>> tail end of emulation, it doesn't matter if the full emulator does the
>> right thing.
> 
> Unless I'm missing something, skip_emulated_instruction() isn't called in
> the emulation case, x86_emulate_instruction() updates %rip directly, e.g.:

Indeed.  skip_emulated_instruction() is only used when the vmexit code
takes care of emulation directly.

Paolo

> 	if (writeback) {
> 		unsigned long rflags = kvm_x86_ops->get_rflags(vcpu);
> 		toggle_interruptibility(vcpu, ctxt->interruptibility);
> 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
> 		kvm_rip_write(vcpu, ctxt->eip);
> 		if (r == EMULATE_DONE && ctxt->tf)
> 			kvm_vcpu_do_singlestep(vcpu, &r);
> 		if (!ctxt->have_exception ||
> 		    exception_type(ctxt->exception.vector) == EXCPT_TRAP)
> 			__kvm_set_rflags(vcpu, ctxt->eflags);
> 
> 		/*
> 		 * For STI, interrupts are shadowed; so KVM_REQ_EVENT will
> 		 * do nothing, and it will be requested again as soon as
> 		 * the shadow expires.  But we still need to check here,
> 		 * because POPF has no interrupt shadow.
> 		 */
> 		if (unlikely((ctxt->eflags & ~rflags) & X86_EFLAGS_IF))
> 			kvm_make_request(KVM_REQ_EVENT, vcpu);
> 	}
> 

