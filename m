Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22625C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E223D2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LUayqOWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbfKGPg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:36:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46024 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfKGPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:36:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id k2so2280736oij.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 07:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/0QmpTHdszdDld83EaT+X3ggfjq8Mz3NqPw6QuTcas=;
        b=LUayqOWnipTR/TKkaWPhaTduXoy5QCegWpfsPLfgBcJmoE1C0X3HrcxQ4isHywgNSC
         jgODxHj/POkEtoGl77mRxsMP95EOxnO65OBfTqkbTen7ITdqYrCq3WZbaiOVAfj/Ace5
         g6gQmdNGfOJu28fIoz9WdBB0ECsA6wA63yPF6ix0C5R92oIHsNab0Gm1vYwkdyBB0Ncz
         GKFVEtV2E9CqYeGqOqb0C51pNZLqsIF7RMSRjkzRXhg15m8PeWc1m/o953q1NsGCh9HY
         iigMR+4gIK4jXifI2ofGojyEwyDB35ytI5PCNotABtOyz10gkojvZSN9DlX7TlzWK33o
         IoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/0QmpTHdszdDld83EaT+X3ggfjq8Mz3NqPw6QuTcas=;
        b=BkFyU6V+fmPtGo2OmTDhV/rHJvWeORMaLolIV/IUVcXWyetsXnQFBUHpz09YlfM7jZ
         5zJrfCHoI4kBwjTDlJM2JYrdjKTxAE1TxW1Ei3jQuIgxZ8dROxx5rpI6z2P6Pz8yIhhU
         yGX11Jv/beLZQx4Aq01wuhCdPCfwFUaeYOmFupjwejj54FH8KMIF4M41RGruYm8gwBo6
         oY81MQyAC9jS6wLSn8hj+8ZKvq0xgloE9a00gG7X6aux10+HEayUxX0y3rcpKOc9H11r
         C0uAmgNXBTB8I90rfDtKkLrdhPnUJOWpMDEh2xrzcvU4lITQB9w7VeIHmZMXDOirPsF5
         Ql6w==
X-Gm-Message-State: APjAAAVa7EKR/TE8Ayg7HlXHXFDK3ShJYrqSdRXCLms7Z2YfG2BQAqUo
        MQoo1/v/O8OmXN+7c7LvGB7arT3PHwLLipabr+WaJw==
X-Google-Smtp-Source: APXvYqxk2byGngdnsr1kXeFkXsy1rs64Bm6zy01FhFd1GqpN0XN2vjw4Tyi2B3rFKGm0E+66W6Hwbx9AGQ5+o0WYshc=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr4254618oib.105.1573141016670;
 Thu, 07 Nov 2019 07:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20191106170727.14457-1-sean.j.christopherson@intel.com>
 <20191106170727.14457-2-sean.j.christopherson@intel.com> <CAPcyv4gJk2cXLdT2dZwCH2AssMVNxUfdx-bYYwJwy1LwFxOs0w@mail.gmail.com>
 <1cf71906-ba99-e637-650f-fc08ac4f3d5f@redhat.com> <CAPcyv4hMOxPDKAZtTvWKEMPBwE_kPrKPB_JxE2YfV5EKkKj_dQ@mail.gmail.com>
 <20191106233913.GC21617@linux.intel.com> <CAPcyv4jysxEu54XK2kUYnvTqUL7zf2fJvv7jWRR=P4Shy+3bOQ@mail.gmail.com>
 <CAPcyv4i3M18V9Gmx3x7Ad12VjXbq94NsaUG9o71j59mG9-6H9Q@mail.gmail.com> <0db7c328-1543-55db-bc02-c589deb3db22@redhat.com>
In-Reply-To: <0db7c328-1543-55db-bc02-c589deb3db22@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Nov 2019 07:36:45 -0800
Message-ID: <CAPcyv4gMu547patcROaqBqbwxut5au-WyE_M=XsKxyCLbLXHTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: MMU: Do not treat ZONE_DEVICE pages as being reserved
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 3:12 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/11/19 06:48, Dan Williams wrote:
> >> How do mmu notifiers get held off by page references and does that
> >> machinery work with ZONE_DEVICE? Why is this not a concern for the
> >> VM_IO and VM_PFNMAP case?
> > Put another way, I see no protection against truncate/invalidate
> > afforded by a page pin. If you need guarantees that the page remains
> > valid in the VMA until KVM can install a mmu notifier that needs to
> > happen under the mmap_sem as far as I can see. Otherwise gup just
> > weakly asserts "this pinned page was valid in this vma at one point in
> > time".
>
> The MMU notifier is installed before gup, so any invalidation will be
> preceded by a call to the MMU notifier.  In turn,
> invalidate_range_start/end is called with mmap_sem held so there should
> be no race.
>
> However, as Sean mentioned, early put_page of ZONE_DEVICE pages would be
> racy, because we need to keep the reference between the gup and the last
> time we use the corresponding struct page.

If KVM is establishing the mmu_notifier before gup then there is
nothing left to do with that ZONE_DEVICE page, so I'm struggling to
see what further qualification of kvm_is_reserved_pfn() buys the
implementation.

However, if you're attracted to the explicitness of Sean's approach
can I at least ask for comments asserting that KVM knows it already
holds a reference on that page so the is_zone_device_page() usage is
safe?

David and I are otherwise trying to reduce is_zone_device_page() to
easy to audit "obviously safe" cases and converting the others with
additional synchronization.
