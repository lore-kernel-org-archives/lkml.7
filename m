Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B63C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA21F205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="raMrLPW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfDXTPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:15:51 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36159 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDXTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:15:51 -0400
Received: by mail-yb1-f194.google.com with SMTP id e76so7550276ybc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KXoQ7BFg8MCQ5w2hqas+YRo88Lj083QKeczBFQqo+mk=;
        b=raMrLPW2n1ySXsJ6Qmx9cvhAR1LPiM58H94Ej4RtkOTT/cuhxC+TgVkMETA3AMnIZW
         utg/Xp0jYhyNQ2H0AVcXTLZVJvOz9TLtcgtL+sReblkJjBdvC4PBznLzpAABE4F+EV9g
         LpzKI5aigxtjVsAe8KIdWlwvTIMSy7GJ/t8h7uXcvxZOZX+s8SBXcv3i9F0kl83jP46R
         rRrAr1i7EC8YDeAHhdSFtG1mSuZv4GATkUIjYr11v4HNq4rO825DI6hK0MfAOPwbhvU4
         8On6Xcpq3txtwSHoXqX6ZLDu5m6sTdXXCdgTROj7iE0SzYl/X6bmPveBwIOoGBYZUJHz
         uL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KXoQ7BFg8MCQ5w2hqas+YRo88Lj083QKeczBFQqo+mk=;
        b=fZZUQJdSFLHWq7rR6DrTfEko2d5dPp6iIf/2U6cI/cUf/kZ1qgJbLlGa/R74Z4pZns
         6lFq7COggiC2yGFqQHlOk7rl7P84Y+KlD5bXCzahM2FgwEy8JwZCzFae9wW8fhqIe+3U
         Y2LAzEJLhV+QsxUj6Ldwjt5gKakNtpNEYOEqskGvSR5KBg6j4Kd1o+Cn5d8HIeQSGTLM
         8vMvzmWbAimWw91NXcsj34fTlXlu56ZbreTIRbHXHLJuoQThyLsnwWxHszC+FwSCDOm0
         mwbxDnjGTqJmpzUHWbVcZrjGWCLv5hb4h/simIyoxxb6JdVtYSYbgMXflkhKmLphXBZJ
         OauQ==
X-Gm-Message-State: APjAAAXXjdlPWKWBGTYBvOlmMFFKYXbrnbh5zN3En9GnIeYhGvCyV5GR
        tLvSAAAbiIpLARcuUV8lOOsIPlCZsYkAmO5nOrVOdw==
X-Google-Smtp-Source: APXvYqwuvnaNjb+LHJwQCOoaewr1dMCcdZFhFpVWce8CYO3hVcV9gxLrABhtjfqSjY46v+1HYZXRfcPfBZu3clAo3O0=
X-Received: by 2002:a25:e081:: with SMTP id x123mr27613524ybg.152.1556133349594;
 Wed, 24 Apr 2019 12:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190424160942.13567-1-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-1-brijesh.singh@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Wed, 24 Apr 2019 12:15:12 -0700
Message-ID: <CABayD+eYsqT49-Smp0a9OGRt2or_L7LNKHpe-iraM62XzGq5_g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/10] Add AMD SEV guest live migration support
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:10 AM Singh, Brijesh <brijesh.singh@amd.com> wrot=
e:
>
> The series add support for AMD SEV guest live migration commands. To prot=
ect the
> confidentiality of an SEV protected guest memory while in transit we need=
 to
> use the SEV commands defined in SEV API spec [1].
>
> SEV guest VMs have the concept of private and shared memory. Private memo=
ry
> is encrypted with the guest-specific key, while shared memory may be encr=
ypted
> with hypervisor key. The commands provided by the SEV FW are meant to be =
used
> for the private memory only. The patch series introduces a new hypercall.
> The guest OS can use this hypercall to notify the page encryption status.
> If the page is encrypted with guest specific-key then we use SEV command =
during
> the migration. If page is not encrypted then fallback to default.
>
> The patch adds a new ioctl KVM_GET_PAGE_ENC_BITMAP. The ioctl can be used
> by the qemu to get the page encrypted bitmap. Qemu can consult this bitma=
p
> during the migration to know whether the page is encrypted.
>
> [1] https://developer.amd.com/wp-content/resources/55766.PDF
>
> The series is tested with the Qemu, I am in process of cleaning
> up the Qemu code and will submit soon.
>
> While implementing the migration I stumbled on the follow question:
>
> - Since there is a guest OS changes required to support the migration,
>   so how do we know whether guest OS is updated? Should we extend KVM
>   capabilities/feature bits to check this?
>
> TODO:
>  - add an ioctl to build encryption bitmap. The encryption bitmap is buil=
t during
>    the guest bootup/execution. We should provide an ioctl so that destina=
tion
>    can build the bitmap as it receives the pages.
>  - reset the bitmap on guest reboot.
>
> The complete tree with patch is available at:
> https://github.com/codomania/kvm/tree/sev-migration-rfc-v1
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> Brijesh Singh (10):
>   KVM: SVM: Add KVM_SEV SEND_START command
>   KVM: SVM: Add KVM_SEND_UPDATE_DATA command
>   KVM: SVM: Add KVM_SEV_SEND_FINISH command
>   KVM: SVM: Add support for KVM_SEV_RECEIVE_START command
>   KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA command
>   KVM: SVM: Add KVM_SEV_RECEIVE_FINISH command
>   KVM: x86: Add AMD SEV specific Hypercall3
>   KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS hypercall
>   KVM: x86: Introduce KVM_GET_PAGE_ENC_BITMAP ioctl
>   mm: x86: Invoke hypercall when page encryption status is changed
>
>  .../virtual/kvm/amd-memory-encryption.rst     | 116 ++++
>  Documentation/virtual/kvm/hypercalls.txt      |  14 +
>  arch/x86/include/asm/kvm_host.h               |   3 +
>  arch/x86/include/asm/kvm_para.h               |  12 +
>  arch/x86/include/asm/mem_encrypt.h            |   3 +
>  arch/x86/kvm/svm.c                            | 560 +++++++++++++++++-
>  arch/x86/kvm/vmx/vmx.c                        |   1 +
>  arch/x86/kvm/x86.c                            |  17 +
>  arch/x86/mm/mem_encrypt.c                     |  45 +-
>  arch/x86/mm/pageattr.c                        |  15 +
>  include/uapi/linux/kvm.h                      |  51 ++
>  include/uapi/linux/kvm_para.h                 |   1 +
>  12 files changed, 834 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>

What's the back-of-the-envelope marginal cost of transferring a 16kB
region from one host to another? I'm interested in what the end to end
migration perf changes look like for this. If you have measured
migration perf, I'm interested in that also.
