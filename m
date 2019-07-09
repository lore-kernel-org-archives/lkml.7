Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292B4C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED49A214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="H3WlmKui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfGIKz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:55:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40070 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIKz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:55:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so17319140eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuR0e69I7mgSfC2aZ+6Blt0AlnXi6b5+QGMHj0cl8wQ=;
        b=H3WlmKuijQsSU0a7TLuEFl5089i9cBj5bQlzW0gPvihWPMgP7G94S30SDDV2haeICa
         pGMt/tK8FnppDqzcxSyDW/ZGHEBCDZF9y+SItMZORqBsUrYu7gWSBoRGhqvDlsRgCk3L
         CJFf3ltd8JZY5lsUyIPS3BcsvbXDX+aEDXSYvTa69E4sO6vP3fGrxCVgD3jxFxcK3kWc
         7HgLFC117OAk1gqAJL9/arNhNxDJv5ZGq02OWiM5Qfyr+bIicJ4bYEBP7ydQ+0WcFv/L
         bDTQbUbW7RbXsY8zovPUrWR5ZXV+ttIdrqIfu0jz4gftf9++zkA4rDA/sSp6z/o/n0Et
         6f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuR0e69I7mgSfC2aZ+6Blt0AlnXi6b5+QGMHj0cl8wQ=;
        b=ul3PmaiYDKp9fdaeNt0SeDwTtZoZ8OS9sdaXHJZyeIoiTrgdmAvbhp2vv1XnQoAy26
         imNmlkc6hQ+kWLwduWnLeJyvjyvzcMLRI3EJlO0n0QI23kMfPPIePnMVRBk2atMOFq9d
         tBfbIyE/ZxaKH5wwv3dJp+W2CNloFO+sK7UKFbx34cI3Ji4n2JIEw0ORcqH7J5H3IAlS
         bPfOyIpJ9fYDedVegAL5SDPwP28PVJ2Wd1LYjMBc9GHW+wSbq0iV/UKRb8uEBUSJiDWv
         gt4kXY2QAd5vWk7XWYWsQHJqgOqTW5RBBohbHUdTxh7xEdvkKZX397jYDlKOUzJt6F7z
         TN9Q==
X-Gm-Message-State: APjAAAXQkiAwDWH3wXR0HjszYC++Wtkj/ddMxysosTss3I7i9VKtieYX
        l5nDVCVWhbmBErr/1fmIXX6R2cDK33DWP7/8B0mCqg==
X-Google-Smtp-Source: APXvYqx/6vJ3gKcKwyl7lr8xaD9C3sEOSHeUsI11wzdsW0Z+TsR9S678RUXH+ItREyVctYyP5WUXtxp+9zz/FamrbHo=
X-Received: by 2002:a05:6402:782:: with SMTP id d2mr25261183edy.80.1562669754543;
 Tue, 09 Jul 2019 03:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211528.12392-1-pasha.tatashin@soleen.com> <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
In-Reply-To: <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 9 Jul 2019 06:55:43 -0400
Message-ID: <CA+CK2bBrwBHhD-PFO_gVnDYoFi0Su6t456WNdtBWpOe4qM+oww@mail.gmail.com>
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 6:36 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Pavel,
>
> On Tue, Jul 9, 2019 at 2:46 AM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > Currently, it is only allowed to reserve memory for crash kernel, because
> > it is a requirement in order to be able to boot into crash kernel without
> > touching memory of crashed kernel is to have memory reserved.
> >
> > The second benefit for having memory reserved for kexec kernel is
> > that it does not require a relocation after segments are loaded into
> > memory.
> >
> > If kexec functionality is used for a fast system update, with a minimal
> > downtime, the relocation of kernel + initramfs might take a significant
> > portion of reboot.
> >
> > In fact, on the machine that we are using, that has ARM64 processor
> > it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
> > time:
> >
> > kernel shutdown 0.03s
> > relocation      0.35s
> > kernel startup  0.29s
> >
> > Image: 13M and initramfs is 24M. If initramfs increases, the relocation
> > time increases proportionally.
> >
> > While, it is possible to add 'kexeckernel=' parameters support to other
> > architectures by modifying reserve_crashkernel(), in this series this is
> > done for arm64 only.
> >
> > Pavel Tatashin (5):
> >   kexec: quiet down kexec reboot
> >   kexec: add resource for normal kexec region
> >   kexec: export common crashkernel/kexeckernel parser
> >   kexec: use reserved memory for normal kexec reboot
> >   arm64, kexec: reserve kexeckernel region
> >
> >  .../admin-guide/kernel-parameters.txt         |  7 ++
> >  arch/arm64/kernel/setup.c                     |  5 ++
> >  arch/arm64/mm/init.c                          | 83 ++++++++++++-------
> >  include/linux/crash_core.h                    |  6 ++
> >  include/linux/ioport.h                        |  1 +
> >  include/linux/kexec.h                         |  6 +-
> >  kernel/crash_core.c                           | 27 +++---
> >  kernel/kexec_core.c                           | 50 +++++++----
> >  8 files changed, 127 insertions(+), 58 deletions(-)
> >
> > --
> > 2.22.0
>
> This seems like an issue with time spent while doing sha256
> verification while in purgatory.
>
> Can you please try the following two patches which enable D-cache in
> purgatory before SHA verification and disable it before switching to
> kernel:
>
> http://lists.infradead.org/pipermail/kexec/2017-May/018839.html
> http://lists.infradead.org/pipermail/kexec/2017-May/018840.html

Hi Bhupesh,

The verification was taking 2.31s. This is why it is disabled via
kexec's '-i' flag. Therefore 0.35s is only the relocation part where
time is spent, and with my patches the time is completely gone.
Actually, I am glad you showed these patches to me because I might
pull them and enable verification for our needs.

>
> Note that these were not accepted upstream but are included in several
> distros in some form or the other :)

Enabling MMU and D-Cache for relocation  would essentially require the
same changes in kernel. Could you please share exactly why these were
not accepted upstream into kexec-tools?

Thank you,
Pasha

>
> Thanks,
> Bhupesh
