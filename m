Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A3AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8616D21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jevIKBjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfJBWke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:40:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43664 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBWke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:40:34 -0400
Received: by mail-io1-f65.google.com with SMTP id v2so1032054iob.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CG5MaVf3Z1KMAMKeFQh1uIBejZ3JM9SIEVivV/4xQBs=;
        b=jevIKBjdKR1V3mLIz/l+pm0we5gJPbhgRbQ8X2bodPtCvQPufCir6WG5aChHXEJ6fe
         3yWu3+OYym7avxh6BJR7ggpqxsllyCM/3wqEa+i9gzUS37dQ2dgxjpW5RYbZ1+z0uQWv
         lSX5TRjUu8YVIDO+w6q3Qjbw9yY7sEqXpFLGddwA0E4cZ/cspfeX+jhV+DVm3xDIoodz
         ki1rOn1RktdVUzlBZUwkIIiXkf4lThlSpI+VWAcncYLlLhAjaDdXVB8E1eCCBtZtPagn
         P/leRFNJaY/E3FvbeAu/j6dl6F4b/T/5w469bFAEnPGTE+CGvPVKfrSaJJpgA3ALoY/3
         Bkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CG5MaVf3Z1KMAMKeFQh1uIBejZ3JM9SIEVivV/4xQBs=;
        b=mMPn2clFlnjYWWxal2vSu5B3bUlRCLWmtEaQN0GKnRKDz81ppyQUKce+xf7Tsu0lsn
         KaK7DRRqxm9dP68Anp/GJnxtwxAPPZYJiBItWgxc4ec9LSCP8BcIEr4v3yS1WqnkLvs3
         cR4vBMLPvBwTmmmzuTbtnl2XHQCgO3/Nx0aebkGSXN5DlHd33jv9hCVK4uIIP225Ouwe
         s8QmOSWdyUdnUuAf2L/qFk5WY9Z74S46dHGueN7hauLMFftJSG87rce0OIkx25yh6Pq+
         XyLr1TU0Taf3iIo6t25rPQqwjwdjwijYAS1Oc/JTnNUUw5XYiFi/Ojg44xRCVi4PEGwr
         qChg==
X-Gm-Message-State: APjAAAVLDyOg+acs9aI8JuXphPJGD4RqqxnyJI2bziZZq81+A0Z+hXfD
        mAnSognTkHx71G9zCLVaj5A35TyntgY4/vhdxx04kQ==
X-Google-Smtp-Source: APXvYqxlvrft8PEQmQKVcpj60hnbSIn5b3Wo5J8M0jMa3GanhZRFjB1WSH0wkNjSHkd0UvAXHVDf9v7GCXI8D7jkHl4=
X-Received: by 2002:a6b:9085:: with SMTP id s127mr5757464iod.26.1570056031670;
 Wed, 02 Oct 2019 15:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190927021927.23057-1-weijiang.yang@intel.com>
In-Reply-To: <20190927021927.23057-1-weijiang.yang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Oct 2019 15:40:20 -0700
Message-ID: <CALMp9eQ13Lve+9+61qCF1-7mQkeLLnhDufd-geKtz=34+YJdEg@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Introduce support for Guest CET feature
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 7:17 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> Control-flow Enforcement Technology (CET) provides protection against
> Return/Jump-Oriented Programming (ROP/JOP) attack. It includes two
> sub-features: Shadow Stack (SHSTK) and Indirect Branch Tracking (IBT).
>
> KVM modification is required to support Guest CET feature.
> This patch serial implemented CET related CPUID/XSAVES enumeration, MSRs
> and VMEntry configuration etc.so that Guest kernel can setup CET
> runtime infrastructure based on them. Some MSRs and related feature
> flags used in the patches reference the definitions in kernel patch.

I am still trying to make my way through the 358 page (!) spec for
this feature, but I already have some questions/comments about this
series:

1. Does CET "just work" with shadow paging? Shadow paging knows
nothing about "shadow-stack pages," and it's not clear to me how
shadow-stack pages will interact with dirty tracking.
2. I see non-trivial changes to task switch under CET. Does
emulator_do_task_switch need to be updated?
3. What about all of the emulator routines that emulate control
transfers (e.g. em_jmp_{far,abs}, em_call_(near_abs,far},
em_ret_{far,far_imm,near_imm}, etc)? Don't these have to be modified
to work correctly when CR4.CET is set?
4. You don't use the new "enable supervisor shadow stack control" bit
in the EPTP. I assume that this is entirely optional, right?
5. I think the easiest way to handle the nested issue (rather than
your explicit check for vmxon when setting CR4.CET when the vCPU is in
VMX operation) is just to leave CR4.CET out of IA32_VMX_CR4_FIXED1
(which is already the case).
6. The function, exception_class(), in x86.c, should be updated to
categorize #CP as contributory.
7. The function, x86_exception_has_error_code(), in x86.h, should be
updated to include #CP.
8. There appear to be multiple changes to SMM that you haven't
implemented (e.g saving/restoring the SSP registers in/from SMRAM.

CET is quite complex. Without any tests, I don't see how you can have
any confidence in the correctness of this patch series.
