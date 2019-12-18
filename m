Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F932C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D600921D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmI09wwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLRU5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:57:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45306 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfLRU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:57:53 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so3429948ioi.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inKqnos5046WrWgn5UE3rym7nvBjtaXbFA12BVwLtlA=;
        b=fmI09wwXzbjy6iG5cyiLPXBUkRwYG1XXPyfzDldMM0nqIVSeYBCQrfcBuzZzU2B+Pl
         RVMxrin7lt5baTDaDLpa/57S1oPrmq5wGPJcSvKnMU6bACMHUoVfRVV1HtUZisSvSZZg
         lYvGxhloh223aUdGD41a5s9PtQdMgsiMyhqjEEwWulDZqcA3utDqRLq24jDtLfeqz20f
         vOIOyC0yvrqnzTmZCqWlJGnKfaFeiIiProXzfG40wm9N8Ca6g8mSJqQJbXEj6ZFXy7bI
         V2ntzZwkMi1uQB4zyRXLjdaVfihLH1bAHaIxr8NkFNdkjMzMU0mh7YEQccKKn+kM/Xoo
         bAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inKqnos5046WrWgn5UE3rym7nvBjtaXbFA12BVwLtlA=;
        b=kh6qWl20zghxuuYhnPHZ+WWafduuf8HaPvqNKJtLFbIxT0f6uVptxA1YeuNM9TPZXX
         0hFgrNdJp6eO/RU0PpSonq3fm6MQbJKPURPfZJi7JWy8jLGtV/3m86eFwoCXs9+I07tM
         hYGD/7qC/VCweFeeRs6vaRKZ3I+JCnqMFcnDkj36wPL+5+arJjShuyX4T5dMkJQ+1qfd
         29KOn8dXdLo+MD7RlOW+Yj0693G9+fAP+SF8lXayBhwW4/Q9okAt4F3EnKXZyJEnQhib
         MjqOEq+Z/7j5TQm8EW5W9IHdwdP55bYyfi3xPGX20Bhq8M6k4WKcBM49lKaTSNKy8a3p
         5BPA==
X-Gm-Message-State: APjAAAUAhUWd3pmx73QUcY/yP63ZIoDbFVLwFoUSfwxn+/eEX18yKzw7
        IYm9QyzgTK1A39aLAr80JcE9p8FA0yXLs+vgyE4tdA==
X-Google-Smtp-Source: APXvYqzWGWl1XsDxPNju7boOmP1EB/fyj4sdiAFe9RF51gwzT5Sr1GkhhBR7XjdtcBTlbDQmFo0s9yX2YxLck21reQU=
X-Received: by 2002:a5d:8cda:: with SMTP id k26mr3293835iot.26.1576702672194;
 Wed, 18 Dec 2019 12:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20191218174255.30773-1-sean.j.christopherson@intel.com>
 <CALMp9eR-ssCUT_6oZntZ=-5SEN7Y8q-HnraKW=WDHuAn9gYZfQ@mail.gmail.com> <20191218201002.GE25201@linux.intel.com>
In-Reply-To: <20191218201002.GE25201@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 18 Dec 2019 12:57:41 -0800
Message-ID: <CALMp9eRthVZGXFV_18Mg07BdU30J5O+TLC-GLp6M6+4VA6m=-A@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: x86: Disallow KVM_SET_CPUID{2} if the vCPU is in
 guest mode
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:10 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Wed, Dec 18, 2019 at 11:38:43AM -0800, Jim Mattson wrote:
> > On Wed, Dec 18, 2019 at 9:42 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > Reject KVM_SET_CPUID{2} with -EBUSY if the vCPU is in guest mode (L2) to
> > > avoid complications and potentially undesirable KVM behavior.  Allowing
> > > userspace to change a guest's capabilities while L2 is active would at
> > > best result in unexpected behavior in the guest (L1 or L2), and at worst
> > > induce bad KVM behavior by breaking fundamental assumptions regarding
> > > transitions between L0, L1 and L2.
> >
> > This seems a bit contrived. As long as we're breaking the ABI, can we
> > disallow changes to CPUID once the vCPU has been powered on?
>
> I can at least concoct scenarios where changing CPUID after KVM_RUN
> provides value, e.g. effectively creating a new VM/vCPU without destroying
> the kernel's underlying data structures and without putting the file
> descriptors, for performance (especially if KVM avoids its hardware on/off
> paths) or sandboxing (process has access to a VM fd, but not /dev/kvm).
>
> A truly contrived, but technically architecturally accurate, scenario would
> be modeling SGX interaction with the machine check architecutre.  Per the
> SDM, #MCs or clearing bits in IA32_MCi_CTL disable SGX, which is reflected
> in CPUID:
>
>   Any machine check exception (#MC) that occurs after Intel SGX is first
>   enables causes Intel SGX to be disabled, (CPUID.SGX_Leaf.0:EAX[SGX1] == 0)
>   It cannot be enabled until after the next reset.
>
>   Any act of clearing bits from '1 to '0 in any of the IA32_MCi_CTL register
>   may disable Intel SGX (set CPUID.SGX_Leaf.0:EAX[SGX1] to 0) until the next
>   reset.
>
> I doubt a userspace VMM would actively model that behavior, but it's at
> least theoretically possible.  Yes, it would technically be possible for
> SGX to be disabled while L2 is active, but I don't think it's unreasonable
> to require userspace to first force the vCPU out of L2.

IIt's perfectly reasonable for a machine check to be handled by L2, in
which case, it would be rather onerous to require userspace to force
the vCPU out of L2 to clear CPUID.SGX_Leaf.0:EAX[SGX1].
