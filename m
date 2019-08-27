Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08D4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD04C2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfH0Tw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:52:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:28013 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbfH0TwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:52:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 12:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="171307402"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2019 12:52:24 -0700
Date:   Tue, 27 Aug 2019 12:52:24 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 3/3] KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS
 support only when it is available
Message-ID: <20190827195224.GI27459@linux.intel.com>
References: <20190827160404.14098-1-vkuznets@redhat.com>
 <20190827160404.14098-4-vkuznets@redhat.com>
 <CALMp9eRyabQA8v5cJ1AwmtFdNFvWQz2jQ+iGTRQjow7r4FV3xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eRyabQA8v5cJ1AwmtFdNFvWQz2jQ+iGTRQjow7r4FV3xA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:54:39AM -0700, Jim Mattson wrote:
> On Tue, Aug 27, 2019 at 9:04 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > It was discovered that after commit 65efa61dc0d5 ("selftests: kvm: provide
> > common function to enable eVMCS") hyperv_cpuid selftest is failing on AMD.
> > The reason is that the commit changed _vcpu_ioctl() to vcpu_ioctl() in the
> > test and this one can't fail.
> >
> > Instead of fixing the test is seems to make more sense to not announce
> > KVM_CAP_HYPERV_ENLIGHTENED_VMCS support if it is definitely missing
> > (on svm and in case kvm_intel.nested=0).
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >  arch/x86/kvm/x86.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index d1cd0fcff9e7..ef2e8b138300 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -3106,7 +3106,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >         case KVM_CAP_HYPERV_EVENTFD:
> >         case KVM_CAP_HYPERV_TLBFLUSH:
> >         case KVM_CAP_HYPERV_SEND_IPI:
> > -       case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> >         case KVM_CAP_HYPERV_CPUID:
> >         case KVM_CAP_PCI_SEGMENT:
> >         case KVM_CAP_DEBUGREGS:
> > @@ -3183,6 +3182,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >                 r = kvm_x86_ops->get_nested_state ?
> >                         kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
> >                 break;
> > +       case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> > +               r = kvm_x86_ops->nested_enable_evmcs != NULL;
> 
> You should probably have an explicit break here, in case someone later
> adds another case below.

Yep, this will trigger a warning on compilers with -Wimplicit-fallthrough.
