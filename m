Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3058DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138720720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCbKiMCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgAHRvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:51:07 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40631 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgAHRvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:51:06 -0500
Received: by mail-il1-f196.google.com with SMTP id c4so3378494ilo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QsbHvRt75FxPOQ+y58oumWYh9J8V/b3eTBzwoHKeaw=;
        b=tCbKiMCiuZ8LXtaIeoCfHzwXywRMt3AbSS6VTt2tEf5JYciG/tYfOgXtR9oSEmpNcn
         seCLibvJQ8LvS9pksTuKyuZ6s2sOxlv78VIRNCSm6z+PlVEsuk3QUggp3NvXbkL44MEr
         l7wxL8pkmD0/RLyArPicz+HA5stqG10GrFuttb1K9Vim4Nw66mOKTu8y/SBSy0F12svd
         kQxIuHwIHGDwfOrdX4tBKv2UN/Ati7KbiHLdcCXqCvxGuuHQVqK2dpy3aO6px11sqyGL
         +KyMvRZ7iSd5z40dZeR88G6Sjw654wgiH5c5WLZWaaQYnXguBBXgrQUui6Tcx9h/6EbL
         Pp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QsbHvRt75FxPOQ+y58oumWYh9J8V/b3eTBzwoHKeaw=;
        b=b3efu0fZyeqqzAS17mrrbsiRGCtixcN0RmEIlr9bvSv8VURYR9BXiDUBaIs7Bi2PdE
         1Jc5YirN/85K4POaUu9mKDOoZ0KCOWtbEzUFWBEmPHOLTCOSK1Eq30NgClQt/cTmNfpo
         aUWi1JoHo2c93PMbq2JwbWS7Ng4w0oerNKR243bGyR6KEoOwSsdGWmKXVvid9YpO0oE1
         VQ666ZgCSVWilw+89CKnB3/Iq7gOuZ4XhwNG+6zrrCvCkVHOzpGWRS8eKFVPFd1BvyDB
         T5aKZ2RlBIAn0g4+zhp1QObr5lnr8PARvFKiezKh61F0fe3L+lhIJWAPnc6O4Ak/ierw
         aARg==
X-Gm-Message-State: APjAAAUMrtNbQdVhroHK0VT6IWQJQ1T4pEF9WEmfu7VK8/jMC/A/SF/y
        pybWCGFnJd6Uc0uATMCa9JMd8aO+KEirhpbyr+G8UA==
X-Google-Smtp-Source: APXvYqwi7A0ngVdaUFrSuc7X9bqPXpVU6UNhMOccSl7eKdCXvL4e8wU8qNHDb/KIQLv+kQp7Vcqx2OYJtBV59j4WkxI=
X-Received: by 2002:a92:3b98:: with SMTP id n24mr5220217ilh.108.1578505865855;
 Wed, 08 Jan 2020 09:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20200108001859.25254-1-sean.j.christopherson@intel.com> <87d0bus1b7.fsf@vitty.brq.redhat.com>
In-Reply-To: <87d0bus1b7.fsf@vitty.brq.redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 8 Jan 2020 09:50:55 -0800
Message-ID: <CALMp9eS47Gip-yZq0tP5s8xRJ-fcbp41O7n2tBc=8Q-urZ3E6A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Fix a benign Bitwise vs. Logical OR mixup
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 2:13 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>
> > Use a Logical OR in __is_rsvd_bits_set() to combine the two reserved bit
> > checks, which are obviously intended to be logical statements.  Switching
> > to a Logical OR is functionally a nop, but allows the compiler to better
> > optimize the checks.
> >
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 7269130ea5e2..72e845709027 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3970,7 +3970,7 @@ __is_rsvd_bits_set(struct rsvd_bits_validate *rsvd_check, u64 pte, int level)
> >  {
> >       int bit7 = (pte >> 7) & 1, low6 = pte & 0x3f;
> >
> > -     return (pte & rsvd_check->rsvd_bits_mask[bit7][level-1]) |
> > +     return (pte & rsvd_check->rsvd_bits_mask[bit7][level-1]) ||
> >               ((rsvd_check->bad_mt_xwr & (1ull << low6)) != 0);
>
> Redundant parentheses detected!

I think you mean superfluous rather than redundant.

> >  }
>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
