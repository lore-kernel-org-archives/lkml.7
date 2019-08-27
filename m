Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5252173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LImm1Tiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfH0Qyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:54:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40194 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfH0Qyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:54:52 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so47934852ios.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOHjP5tc+yZEVIg0MRWpIDqFx5JGItaQGHN16Joy+r0=;
        b=LImm1TiukFBu1ne3V7tPK2lDYmzuj4dXh0BahpqBrLhOmjWkDLnm/+5PTe3ynD9tjH
         3XO3s77urhRAkPCJvyFYH2S/cMFGJGwZxjg2ayfTkmUG2Rivg5KffODDoQFNRXU80j8t
         d5cfVGq6PNQlHoymLKxlyBXEg+XYcR3YSqC5V4orbtB0uLss5o3lShya2h7UKi8EhK20
         a6Ie04+q1CTmYyMfDZ/9+cduzuB9Jtw56n677JSg5QmeYjrvThjfFgjahv2w/php93wL
         ROP+Q6EXNx+KrJf+TpmFmxO2HF+ENHmNFMQv0LMoCbbLTeEfuQXe8TVXTWsyVx9fwNkD
         b6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOHjP5tc+yZEVIg0MRWpIDqFx5JGItaQGHN16Joy+r0=;
        b=cwGgEC9KtbynyFDb0sA6XkdrJ2YgBOd36laXcaPklOmFFIMd7C12ak/4RBQF+fGzos
         37cuYu9z9rUI7f0YMH2CqdCOShrv0Pq0jzP/wz4Cl07YTzCNIi0tccZehmPqAlFFTxrc
         kCRSaorW5AFbMn0PiYnvlSmRWRqw6j0z18bi2g5jcRo9Fns8BDd71TcmcY03KMTxe6iU
         vJwtITJTVwQATZixZcGzR5rWYPMUF+pD1Dl1Yg5sTpEZtXTl7lqsWV8e6AZ1V7DjyOjG
         rC+2pF3c28Cikp2BIkU6QNGe0WTm0Xhkuzchf0qj+xUx5dS1dHYi2SQ5/kSGG4Fs66Oo
         LfxA==
X-Gm-Message-State: APjAAAVw/1gdvX/pkxRpceeKkM8BRpXYWo8vhJUk8l2XIgzMkotY2QXt
        1QQL2UoLbI/UJp266SGsiL8MUdIV4FslvgJyeyMn6w==
X-Google-Smtp-Source: APXvYqzBwOW0kq4D3Mw5u/JNKSwavZ6FcPJ53+ULO/GuH3d4BgNMAL73A0JC9I8uiX/MO/BzJqUbGTpEmT9lC18aBec=
X-Received: by 2002:a6b:6a15:: with SMTP id x21mr23262943iog.40.1566924890982;
 Tue, 27 Aug 2019 09:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190827160404.14098-1-vkuznets@redhat.com> <20190827160404.14098-4-vkuznets@redhat.com>
In-Reply-To: <20190827160404.14098-4-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 27 Aug 2019 09:54:39 -0700
Message-ID: <CALMp9eRyabQA8v5cJ1AwmtFdNFvWQz2jQ+iGTRQjow7r4FV3xA@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS
 support only when it is available
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 9:04 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It was discovered that after commit 65efa61dc0d5 ("selftests: kvm: provide
> common function to enable eVMCS") hyperv_cpuid selftest is failing on AMD.
> The reason is that the commit changed _vcpu_ioctl() to vcpu_ioctl() in the
> test and this one can't fail.
>
> Instead of fixing the test is seems to make more sense to not announce
> KVM_CAP_HYPERV_ENLIGHTENED_VMCS support if it is definitely missing
> (on svm and in case kvm_intel.nested=0).
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d1cd0fcff9e7..ef2e8b138300 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3106,7 +3106,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>         case KVM_CAP_HYPERV_EVENTFD:
>         case KVM_CAP_HYPERV_TLBFLUSH:
>         case KVM_CAP_HYPERV_SEND_IPI:
> -       case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
>         case KVM_CAP_HYPERV_CPUID:
>         case KVM_CAP_PCI_SEGMENT:
>         case KVM_CAP_DEBUGREGS:
> @@ -3183,6 +3182,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>                 r = kvm_x86_ops->get_nested_state ?
>                         kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
>                 break;
> +       case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> +               r = kvm_x86_ops->nested_enable_evmcs != NULL;

You should probably have an explicit break here, in case someone later
adds another case below.

>         default:
>                 break;
>         }
> --
> 2.20.1
>
