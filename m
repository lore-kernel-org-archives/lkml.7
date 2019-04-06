Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD20BC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F77B21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDFKhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:37:20 -0400
Received: from foss.arm.com ([217.140.101.70]:59592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfDFKhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 06:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D88015BF;
        Sat,  6 Apr 2019 03:37:19 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B6B3F557;
        Sat,  6 Apr 2019 03:37:17 -0700 (PDT)
Subject: Re: [PATCH v8 4/9] KVM: arm/arm64: preserve host HCR_EL2 value
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1554172037-4516-1-git-send-email-amit.kachhap@arm.com>
 <1554172037-4516-5-git-send-email-amit.kachhap@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f27a3e70-2099-45a6-48e6-481a67e360eb@arm.com>
Date:   Sat, 6 Apr 2019 11:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554172037-4516-5-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 02/04/2019 03:27, Amit Daniel Kachhap wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> When restoring HCR_EL2 for the host, KVM uses HCR_HOST_VHE_FLAGS, which
> is a constant value. This works today, as the host HCR_EL2 value is
> always the same, but this will get in the way of supporting extensions
> that require HCR_EL2 bits to be set conditionally for the host.
> 
> To allow such features to work without KVM having to explicitly handle
> every possible host feature combination, this patch has KVM save/restore
> for the host HCR when switching to/from a guest HCR. The saving of the
> register is done once during cpu hypervisor initialization state and is
> just restored after switch from guest.
> 
> For fetching HCR_EL2 during kvm initialisation, a hyp call is made using
> kvm_call_hyp and is helpful in non-VHE case.
> 
> For the hyp TLB maintenance code, __tlb_switch_to_host_vhe() is updated
> to toggle the TGE bit with a RMW sequence, as we already do in
> __tlb_switch_to_guest_vhe().
> 
> The value of hcr_el2 is now stored in struct kvm_cpu_context as both host
> and guest can now use this field in a common way.

These HCR_EL2 flags have had me confused for quite a while.
I thought this was preserving the value that head.S or cpufeature.c had set, and with
ptrauth we couldn't know what this register should be anymore, the host flags has to vary.

Kristina's explanation of it[0], clarified things, and with a bit more digging it appears
we always set API/APK, even if the hardware doesn't support the feature (as its harmless).
So we don't need to vary the host flags...

My question is, what breaks if this patch isn't merged? (the MDCR change is cleanup we can
do because of this HCR change), is this HCR change just cleanup too? If so, can we merge
ptrauth without either, so we only make the change when its needed? (it will cause some
changes in your patch 7, but I can't see where you depend on the host flags).

I recall Christoffer wanting to keep the restored DAIF register value on guest-exit static
to avoid extra loads/stores when we know what the value would be. I think the same logic
applies here.

You mentioned in the cover letter the series has some history to it!


Thanks,

James

[0] http://lore.kernel.org/r/7ec2f950-7587-5ecd-6caa-c2fd091ad22c@arm.com
