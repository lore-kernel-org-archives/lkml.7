Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598CBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3564A2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfH1HaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfH1HaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:30:22 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52BF1806D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:30:22 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id u13so397189wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ueqkpbyP1ubtGaLxgAbGdw9aVC+mMhLE/TY03oCkmFY=;
        b=L4y7K0vSJGT9heYrDvucNmUHjQCr7vODVmhLmxZlbEZd9TAXIdDMQqIbO4lKGSK8ih
         n6XZlOv6mCfo35yhkjwk9UWhQ/odKxSHhFH+qNZFzVgAzXePAF8b6qk2k0Y+Y/lnnqS9
         t8YCq5z1/rZAQhPkiTqa4lllxLDejJQ8Z6Ccph2lLHM5VuUmXG5ehdaibegILO9LDhMU
         ZkUDprLB8YJ+RTqcE5N7UYpK0k7H8prksE++w/gh1dph8JgJokhKG318uL24U0QvqOZ+
         cCSjU+c+G/0zTqwcDAKGQy/eAcUmLy3d6Ma5azLA2TyMr51e0gWjgibJQWUNQbVmbVDx
         3Q8A==
X-Gm-Message-State: APjAAAWkWBmp2B42mWUUgvD7zSEVWIi4ZXHY8VC85hOdGorNw9imkp5K
        J6055Q28EkWoqR00iEWJxQbmp/WyRVTZLV0K90ltMBdx4jVrFqGZ8B/CiwHggA7iY793yrexcZG
        g1FkP6vSYIh8heVTreZf4mM8v
X-Received: by 2002:a1c:a383:: with SMTP id m125mr2993622wme.57.1566977420364;
        Wed, 28 Aug 2019 00:30:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwq3WXDR8/8BaKVCYWFgg9755Ezm/7Lys3X0fvMndwJ41MWuRxZIS+ZlMXkDXS9hnPrnMvG+w==
X-Received: by 2002:a1c:a383:: with SMTP id m125mr2993570wme.57.1566977419919;
        Wed, 28 Aug 2019 00:30:19 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z25sm1854857wml.5.2019.08.28.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:30:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 3/3] KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS support only when it is available
In-Reply-To: <20190827195224.GI27459@linux.intel.com>
References: <20190827160404.14098-1-vkuznets@redhat.com> <20190827160404.14098-4-vkuznets@redhat.com> <CALMp9eRyabQA8v5cJ1AwmtFdNFvWQz2jQ+iGTRQjow7r4FV3xA@mail.gmail.com> <20190827195224.GI27459@linux.intel.com>
Date:   Wed, 28 Aug 2019 09:30:18 +0200
Message-ID: <878srdlpbp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Aug 27, 2019 at 09:54:39AM -0700, Jim Mattson wrote:
>> On Tue, Aug 27, 2019 at 9:04 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >
>> > It was discovered that after commit 65efa61dc0d5 ("selftests: kvm: provide
>> > common function to enable eVMCS") hyperv_cpuid selftest is failing on AMD.
>> > The reason is that the commit changed _vcpu_ioctl() to vcpu_ioctl() in the
>> > test and this one can't fail.
>> >
>> > Instead of fixing the test is seems to make more sense to not announce
>> > KVM_CAP_HYPERV_ENLIGHTENED_VMCS support if it is definitely missing
>> > (on svm and in case kvm_intel.nested=0).
>> >
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > ---
>> >  arch/x86/kvm/x86.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> > index d1cd0fcff9e7..ef2e8b138300 100644
>> > --- a/arch/x86/kvm/x86.c
>> > +++ b/arch/x86/kvm/x86.c
>> > @@ -3106,7 +3106,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>> >         case KVM_CAP_HYPERV_EVENTFD:
>> >         case KVM_CAP_HYPERV_TLBFLUSH:
>> >         case KVM_CAP_HYPERV_SEND_IPI:
>> > -       case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
>> >         case KVM_CAP_HYPERV_CPUID:
>> >         case KVM_CAP_PCI_SEGMENT:
>> >         case KVM_CAP_DEBUGREGS:
>> > @@ -3183,6 +3182,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>> >                 r = kvm_x86_ops->get_nested_state ?
>> >                         kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
>> >                 break;
>> > +       case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
>> > +               r = kvm_x86_ops->nested_enable_evmcs != NULL;
>> 
>> You should probably have an explicit break here, in case someone later
>> adds another case below.
>
> Yep, this will trigger a warning on compilers with -Wimplicit-fallthrough.

I always forget there's more than checkpatch.pl :-) Thanks you your
reviews guys, I'm going to send v2 of this patchset without PATCH1 which
was already queued by Radim.

-- 
Vitaly
