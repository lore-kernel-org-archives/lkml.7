Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE27C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393FB20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567773293;
	bh=0RRGodMGSFVYeuGwha1VwK3yRA+aNtZOHwBE4UXrLfw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xSsPU08tYxf9YOgLp8pnT54atxvhzUzOU1nB32DKcXdl23rpBNNpcsJNrpI7ngYHo
	 wjRQ2EoD+gVVKmEjN2pIrwqRMtyQN0VC8kxXvAnGRduID0fpDTbpkcHy1v2h3RngDv
	 GhZgzbXJ43KcKZccE7KTqmB2SIGYwQQusgNlDzks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392080AbfIFMew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:34:52 -0400
Received: from foss.arm.com ([217.140.110.172]:55638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbfIFMew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:34:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57B971570;
        Fri,  6 Sep 2019 05:34:51 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52B373F718;
        Fri,  6 Sep 2019 05:34:50 -0700 (PDT)
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
To:     Alexander Graf <graf@amazon.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Cc:     =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
References: <20190904180736.29009-1-xypron.glpk@gmx.de>
 <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com>
 <86mufjrup7.wl-maz@kernel.org>
 <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
 <20190905092223.GC4320@e113682-lin.lund.arm.com>
 <4b6662bd-56e4-3c10-3b65-7c90828a22f9@kernel.org>
 <20190906080033.GF4320@e113682-lin.lund.arm.com>
 <a58c5f76-641a-8381-2cf3-e52d139c4236@amazon.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <0a99ce2b-7700-2a2f-eb3a-4922631cbe02@kernel.org>
Date:   Fri, 6 Sep 2019 13:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a58c5f76-641a-8381-2cf3-e52d139c4236@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2019 13:08, Alexander Graf wrote:
> 
> 
> On 06.09.19 10:00, Christoffer Dall wrote:
>> On Thu, Sep 05, 2019 at 02:09:18PM +0100, Marc Zyngier wrote:

[...]

>>>> @@ -673,6 +694,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>>   		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
>>>>   		if (ret)
>>>>   			return ret;
>>>> +	} else if (run->exit_reason == KVM_EXIT_ARM_NISV) {
>>>> +		kvm_inject_undefined(vcpu);
>>>
>>> Just to make sure I understand: Is the expectation here that userspace
>>> could clear the exit reason if it managed to handle the exit? And
>>> otherwise we'd inject an UNDEF on reentry?
>>>
>>
>> Yes, but I think we should change that to an external abort.  I'll test
>> something and send a proper patch with more clear documentation.
> 
> Why not leave the injection to user space in any case? API wise there is 
> no need to be backwards compatible, as we require the CAP to be enabled, 
> right?
> 
> IMHO it should be 100% a policy decision in user space whether to 
> emulate and what type of exception to inject, if anything.

The exception has to be something that the trapped instruction can
actually generate. An UNDEF is definitely wrong, as the guest would have
otherwise UNDEF'd at EL1, and KVM would have never seen it. You cannot
deviate from the rule of architecture, and userspace feels like the
wrong place to enforce it.

	M.
-- 
Jazz is not dead, it just smells funny...
