Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6625AC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CA721849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfGSLJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:09:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50447 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfGSLJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:09:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so28426914wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZTpt124xkvIC199mqq/Y1JoK7GIwu0z9IqI5bP/sDw=;
        b=Xr3k9i5F5DJu1/S7/rCxV4AX6IUw0oz8z1WAHK4jJuBlI22iSiuyo3c2j88U82TD8C
         m0WMYwrzxenCXAT65hUgUKZpPxX2UXyil+6x1xli09trz91/g22Ojk67n4MY3y3DYyG6
         ovOsMqowWafm1te2BdSU9g8N+FTvnMqpj4oXvUHG+dbv8f+eBhzmq9fZxNUAqms2diJC
         jIXW1HpdEfRNZrBp8SH5Z++Fiw+uga/mHk47jIzZVFN01EcPjY2P1pEB3N18i2PqR4rw
         RZiWrUKkclhuBRzcgf+PGKfSXE/yDaxHnr9hE8YyQXm19f3UqlV6K5BwakPTc+SySvVh
         gkOg==
X-Gm-Message-State: APjAAAWywainqqz39MaNq+WYwALdiHY3T995Bn+u2uT5WBnZPTwAXCR2
        nwAoUi7+RP+lidFORHKkM67zCQ==
X-Google-Smtp-Source: APXvYqy8J64o/W1vhWCroMIOpTpGntL1yVyaLhpT/aa7pg1hpD5LFTyt3PBsqrwCwNryxxXKXqVQVA==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr47986773wmi.38.1563534544929;
        Fri, 19 Jul 2019 04:09:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8? ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
        by smtp.gmail.com with ESMTPSA id l2sm20503956wmj.4.2019.07.19.04.09.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 04:09:04 -0700 (PDT)
Subject: Re: [5.2 regression] x86/fpu changes cause crashes in KVM guest
To:     Wanpeng Li <kernellwp@gmail.com>,
        Thomas Lambertz <mail@thomaslambertz.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, kvm <kvm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Orr <marcorr@google.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <217248af-e980-9cb0-ff0d-9773413b9d38@thomaslambertz.de>
 <CANRm+CxWbkr0=DB7DBdaQOsTTt0XS5vSk_BRL2iFeAAm81H8Bg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3ae96202-a121-70a9-fe00-4b5bb4970242@redhat.com>
Date:   Fri, 19 Jul 2019 13:09:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CxWbkr0=DB7DBdaQOsTTt0XS5vSk_BRL2iFeAAm81H8Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/19 10:59, Wanpeng Li wrote:
> https://lkml.org/lkml/2017/11/14/891, "The scheduler will save the
> guest fpu context when a vCPU thread is preempted, and restore it when
> it is scheduled back in." But I can't find any scheduler codes do
> this.

That's because applying commit 240c35a37 was completely wrong.  The idea
before commit 240c35a37 was that you have the following FPU states:

               userspace (QEMU)             guest
---------------------------------------------------------------------------
               processor                    vcpu->arch.guest_fpu
>>> KVM_RUN: kvm_load_guest_fpu
               vcpu->arch.user_fpu          processor
>>> preempt out
               vcpu->arch.user_fpu          current->thread.fpu
>>> preempt in
               vcpu->arch.user_fpu          processor
>>> back to userspace
>>> kvm_put_guest_fpu
               processor                    vcpu->arch.guest_fpu
---------------------------------------------------------------------------

After removing user_fpu, QEMU's FPU state is destroyed when KVM_RUN is
preempted.  So that's already messed up (I'll send a revert), and given
the diagram above your patch makes total sense.

With the new lazy model we want to hook into kvm_vcpu_arch_load and get
the state back to the processor from current->thread.fpu, and indeed
switch_fpu_return is essentially copy_kernel_to_fpregs(&current->thread.
fpu->state).

However I would keep the fpregs_assert_state_consistent in
kvm_arch_vcpu_load, and also
WARN_ON_ONCE(test_thread_flag(TIF_NEED_FPU_LOAD)) in vcpu_enter_guest.

Paolo
