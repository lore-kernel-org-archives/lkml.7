Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE39C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34092081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBuZ0lTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFUUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:20:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43687 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgAFUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:20:06 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so48396586ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLp/ufTp0fYjzVGW4DuTeiICdn7BWt7SHYlnsorurds=;
        b=ZBuZ0lTtXh/HFFduyGbHQ9mz6qhkf8isglZMJ6rkGMDKlIz348zz+FJBrCXiecfNaM
         G9XU0aDZUJkspgvq3dFrptFOtCxw7/9q6e0oYnK4KIO+tN/R91Gho+qO1JCbvEKUAZ9B
         +DgRmsuBBUYTJ8icaKwHyadigaTDz5JFzR+Bo1+tsDQ0c0N2tI06q1X4Zz9aDcm0HIVR
         nTRaKaCZ91cXY6OTZ8kS7QNPWIxeMgLEwMscPMAiEggKYcabM9fBWnPCP9DCezGB+Fxa
         Mmws4V8umADBZPcQsWfcItQzOaa1cL8vCQopvUyD7PBZAt8gfpLwO1Y+ZF9DyQ43UM+Y
         Q+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLp/ufTp0fYjzVGW4DuTeiICdn7BWt7SHYlnsorurds=;
        b=aTlHWN9sBg+Ryiy+80L3mqybpVCef5NuqjkHEHBR4HF+SHVRuGw0h1zkBvVDb10S2f
         DNp69N4yvHZjWuzqNJQ0kFVl93lDAUidEK0YJ1e5fSoJPUaQL8/qJdRlzS/i15j7qEX/
         F0fzsvOiwLZJ2utgeGwJ0GW7hpa+danMzRASbzVkcb6erWKZ4Ka8MX28jnoP+JTXDP+c
         av9AsQZu7m6xnM+rIrFD7uOz8R+cDg2I6rMvLZNgtPaRs9BUrm8ttY8UlOievaIRjYcs
         LGdu8Udkjsz6libC0c5BJeA3ieEhcQxLy0UFA3HCJsziDvXZVGizx5s4TkUszJGFNIh8
         XpbA==
X-Gm-Message-State: APjAAAUZsClb01/0kuC+lI6SZQ26TPmLVpXy3bdPpOSvmS1ultLHPzBM
        YbGCvWq2lcfnQL1TIzRU3Lp679QcacFD9zmqhlNMMg==
X-Google-Smtp-Source: APXvYqwumr0YiUR0oP6hMxgSGdJNExJQPdoLDRU2fDq+CxkJ0j2PVxuRSCVAbrGf9CGxXEwqGtmFfotDtPJwPjeEIiU=
X-Received: by 2002:a02:3312:: with SMTP id c18mr79437851jae.24.1578342005752;
 Mon, 06 Jan 2020 12:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-14-pomonis@google.com>
In-Reply-To: <20191211204753.242298-14-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:19:53 -0800
Message-ID: <CALMp9eSixcb+LMxNV6t-_FHzxPHDRV45R3FZ835xvpqk6hM1Gg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] KVM: x86: Protect pmu_intel.c from
 Spectre-v1/L1TF attacks
To:     Marios Pomonis <pomonis@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:49 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes Spectre-v1/L1TF vulnerabilities in intel_find_fixed_event()
> and intel_rdpmc_ecx_to_pmc().
> kvm_rdpmc() (ancestor of intel_find_fixed_event()) and
> reprogram_fixed_counter() (ancestor of intel_rdpmc_ecx_to_pmc()) are
> exported symbols so KVM should treat them conservatively from a security
> perspective.
>
> Fixes: commit 25462f7f5295 ("KVM: x86/vPMU: Define kvm_pmu_ops to support vPMU function dispatch")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
