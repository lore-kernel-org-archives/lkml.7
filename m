Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB61C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED872054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NDu1fs3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfGJPxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:53:13 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36706 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfGJPxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:53:13 -0400
Received: by mail-ed1-f52.google.com with SMTP id k21so2679688edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OooCPJ+TfmCiIkPVCQN9rBe4Zl+T7uS7oe42m2m8dO8=;
        b=NDu1fs3Jx5NnJxsIJXbuNNaTY9DeNvY++yCZH2Aqe/HCWCLe0jW0MSpBbjrkQ3HVdh
         uxtulPIk/CNjS0NRv1JMzmYodopKY/+CANbJ9grsV8q3Sn48x93g5QYRcjv6aOZ7sxUN
         99tk+HQN99ShqhLlvW4RAYTOM8pl+1SCJtKjilRR5H1lijlbXBbReR/YgW3ifQCsFIlV
         znzAj3ymqFOeEuooUCLRv9BhhsUSrftPWhTW9SKEzhoTFv3JdKPwXjDmopcHpA9ABmb9
         M+1GSzxxVDUtgogYv358LkymKGrRnRIgU61uxTZHbwe2dMH2ljUmEAlx5upSYZZnSaeE
         mchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OooCPJ+TfmCiIkPVCQN9rBe4Zl+T7uS7oe42m2m8dO8=;
        b=okLnX5Eb4ufM7nB9PVRWDoOl9pDcFo8alm3CYrCSJfHlDvUtc+CVetSuglLBPejUrp
         R+jCawzLwaNhX/Z//dgFloCJjiVi/aUe9hho3WnqEWFwjZ/VxAG5Uk2hL/+eNJdQKwSR
         gPd1ycmIA5csLNqsHgXSsq67gK8cRjvKZ2NHtt90SVdz8nchr/+vuIbw5Yz5R0UUUK3n
         2CpGxHhzHUax9qM0U4OsBenuk0pJWjQA6prbKxyOY3oxQauudRZDmpgfCBHrxkJaUp3D
         o/WVBAgq6kNjMnGmg9lwBWBERt3aP1yquiWWaIUsJ62efnbWQnnh3tcY29wHLbdoSmNh
         YZqA==
X-Gm-Message-State: APjAAAX8ITv4VkNduZIJKYNoRGQzeOjI7Fo/2EnHA9VGU8/vR1aNvW3Z
        5vzIM+YofQ+jPW63yqg59Px18a/hkBwNsTvkFjv24A==
X-Google-Smtp-Source: APXvYqwRyg+PK6CmK98TU5RngQ5JLVQLW1ax1AQSLUknwWFZptyHZ0BZxbGoMORI2mU52aMjJ96sVgompk4jkkn7/ao=
X-Received: by 2002:a17:906:b203:: with SMTP id p3mr27035845ejz.223.1562773991171;
 Wed, 10 Jul 2019 08:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190709182014.16052-1-pasha.tatashin@soleen.com> <20190710065953.GA4744@localhost.localdomain>
In-Reply-To: <20190710065953.GA4744@localhost.localdomain>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 10 Jul 2019 11:53:00 -0400
Message-ID: <CA+CK2bAC2371999HMMCv6TCf1351u_nV4R1gBLc=79dpLakhHA@mail.gmail.com>
Subject: Re: [v2 0/5] arm64: allow to reserve memory for normal kexec kernel
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The crashkernel reservation for kdump is a must, there are already a lot
> of different problems need to consider, for example the low and high
> memory issues, and a lot of other things.  I'm not convinced to enable
> this for kexec reboot.
>
> This really looks to workaround the arm64 issue and move the
> complication to kernel.

I will be working on MMU arm64 kernel relocation solution.

Pasha

>
> > On, the other hand hibernate does something similar already, but there
> > MMU never needs to be disabled, and also by the time machine_kexec()
> > is called, allocator is not available, as we can't fail to do reboot,
> > so page table must be pre-allocated during kernel load time.
> >
> > Note: the above time is relocation time only. Purgatory usually also
> > computes checksum, but that is skipped, because --no-check is used when
> > kernel image is loaded via kexec.
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
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
> Thanks
> Dave
