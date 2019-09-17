Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A973C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4837E20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfIQJda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfIQJda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:33:30 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB7E4369AC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:33:29 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c188so622229wmd.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 02:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=USt1kKGPYmtgyFTYD/y0A1jODqobnZ9DDJDhO5ylVlA=;
        b=I3A9AhDScszE5WxFO5vnLGnDtngvc2lHM0AyeJup+RwhP6HRSsE+ybVMNzXaJjN3+K
         0KsEapZ5+c+bPQfWIL3XKVzgP7PFkq800gOtG4muyYXysLsVQ7k/VBiwSaD8AfUuy530
         1qD1tCxfBm2Ixqctf3I/lzzeB6foOkT1srQEEpT9/36tvg1tKhFzsrJqc0p3gEYmL8lB
         8Y925210RXdr7zJEicsm6uCGMFKWYZ6lj3p63JuD0vS7olQR/jzLQLY6k82QmVAYU5cd
         TMQaWc+f/Rf3I3nH5ZLsMP3JAYvZaGUWvWF0UdmeUYQCXiTOPaVAR+KtwoSYDbJV0iDv
         RVFQ==
X-Gm-Message-State: APjAAAVv0/7cmwJ454B8lvH2lVWf5BijYgMbKU9H82IALzZD+ZIqra8U
        yoMgQTEabaUnLBXzUj1Fkl4C39eXDMNc2M+PAhxZpSJiDypMNqQxUn5UWjXAVJVLe7ydNmizCfS
        myx53D3w6/Prb8jd838zAcL+7
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr2538070wmg.177.1568712808286;
        Tue, 17 Sep 2019 02:33:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxE0OwLxxEExBqqFmu5jEGpfsU1LN8pNgOQBJRy2TH+nRrjttR1HYteSzAvN5aajblv2RTsXQ==
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr2538044wmg.177.1568712808057;
        Tue, 17 Sep 2019 02:33:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g185sm4109888wme.10.2019.09.17.02.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 02:33:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 2/3] KVM: x86: hyper-v: set NoNonArchitecturalCoreSharing CPUID bit when SMT is impossible
In-Reply-To: <CALMp9eRa0-HO+JWGDoAFO1zOtNjrutfT7d4pLxjsxn-XiAJwwQ@mail.gmail.com>
References: <20190916162258.6528-1-vkuznets@redhat.com> <20190916162258.6528-3-vkuznets@redhat.com> <CALMp9eRa0-HO+JWGDoAFO1zOtNjrutfT7d4pLxjsxn-XiAJwwQ@mail.gmail.com>
Date:   Tue, 17 Sep 2019 11:33:26 +0200
Message-ID: <87ef0fb72x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Mon, Sep 16, 2019 at 9:23 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Hyper-V 2019 doesn't expose MD_CLEAR CPUID bit to guests when it cannot
>> guarantee that two virtual processors won't end up running on sibling SMT
>> threads without knowing about it. This is done as an optimization as in
>> this case there is nothing the guest can do to protect itself against MDS
>> and issuing additional flush requests is just pointless. On bare metal the
>> topology is known, however, when Hyper-V is running nested (e.g. on top of
>> KVM) it needs an additional piece of information: a confirmation that the
>> exposed topology (wrt vCPU placement on different SMT threads) is
>> trustworthy.
>>
>> NoNonArchitecturalCoreSharing (CPUID 0x40000004 EAX bit 18) is described in
>> TLFS as follows: "Indicates that a virtual processor will never share a
>> physical core with another virtual processor, except for virtual processors
>> that are reported as sibling SMT threads." From KVM we can give such
>> guarantee in two cases:
>> - SMT is unsupported or forcefully disabled (just 'disabled' doesn't work
>>  as it can become re-enabled during the lifetime of the guest).
>> - vCPUs are properly pinned so the scheduler won't put them on sibling
>> SMT threads (when they're not reported as such).
>
> That's a nice bit of information. Have you considered a mechanism for
> communicating this information to kvm guests in a way that doesn't
> require Hyper-V enlightenments?
>

(I haven't put much thought in this) but can we re-use MD_CLEAR CPUID
bit for that? Like if the hypervisor can't guarantee usefulness
(e.g. when two random vCPUs can be put on sibling SMT threads) of
flushing, is there any reason to still make the guest think the feature
is there?

-- 
Vitaly
