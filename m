Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFADECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC412089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfJOKxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:53:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfJOKxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:53:24 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D767811D8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 10:53:23 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id p6so5165034wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=p/1yabDz8qKhRFkalHkrj4947RSYeZJkszdmHrfnxwc=;
        b=sfgd/10vGH73hWKS3FSdB0PuTSqWNapAy4zQSn5jRImLrz8HDllDW4mT6rXX2faxFg
         r8yaP3o6sr3cddbCC5fHTUardC7TBQayC639NKgouvrz7/aonvqfR95azFAYeBZB+Wwc
         xW7ybCFKDsN/Xzsy63PrmCTNcZ8ZNhN3gBy+TMLHFW6SkcQJN5nmAFbSu/2Gmgtg68fU
         7WWLjLOU1FYdDvJgVzXouYh4QojhcvgWySh/lvSmTp4eIuAzKatEkC8eDDyL06Hd+PZY
         OPll/tRmQrI+HHyIT8+y8MaVwySSlvLzqL/8qV4WybTZZfUXi6gNtYX7SLqCvsFTkwvC
         Cwvg==
X-Gm-Message-State: APjAAAUKp14W8DHjuoTLYf/HOMnGQ7w9WNnLMPuKD8aC0zcejTVXvpOd
        lyOc3LGz+uhQjP01csOe9S4z4mNovySQaHm2gmFK6TZhUXEq//XPzUVB1n7ARoK+lnB6mVqeFW0
        FFmWcSMekEOmMfdce750s1nvk
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr28329223wrn.97.1571136802294;
        Tue, 15 Oct 2019 03:53:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwu0QYUpkH9lGGmecEb8XIlX9PlulVL8sYPAzG3x9q/fyyIX2pqIq4BlP6J6f9jD1VdvCLLWQ==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr28329205wrn.97.1571136802066;
        Tue, 15 Oct 2019 03:53:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g17sm16952765wrq.58.2019.10.15.03.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 03:53:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] KVM: X86: Make fpu allocation a common function
In-Reply-To: <20191014183723.GE22962@linux.intel.com>
References: <20191014162247.61461-1-xiaoyao.li@intel.com> <87y2xn462e.fsf@vitty.brq.redhat.com> <20191014183723.GE22962@linux.intel.com>
Date:   Tue, 15 Oct 2019 12:53:20 +0200
Message-ID: <87v9sq46vz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Oct 14, 2019 at 06:58:49PM +0200, Vitaly Kuznetsov wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>> > They are duplicated codes to create vcpu.arch.{user,guest}_fpu in VMX
>> > and SVM. Make them common functions.
>> >
>> > No functional change intended.
>> 
>> Would it rather make sense to move this code to
>> kvm_arch_vcpu_create()/kvm_arch_vcpu_destroy() instead?
>
> Does it make sense?  Yes.  Would it actually work?  No.  Well, not without
> other shenanigans.
>
> FPU allocation can't be placed after the call to .create_vcpu() becuase
> it's consumed in kvm_arch_vcpu_init().   FPU allocation can't come before
> .create_vcpu() because the vCPU struct itself hasn't been allocated.

A very theoretical question: why do we have 'struct vcpu' embedded in
vcpu_vmx/vcpu_svm and not the other way around (e.g. in a union)? That
would've allowed us to allocate memory in common code and then fill in
vendor-specific details in .create_vcpu().

-- 
Vitaly
