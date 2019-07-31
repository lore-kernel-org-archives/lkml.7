Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B4FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB11B206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gyHso0ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfGaQlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:41:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37669 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfGaQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:41:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so66322642eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9n08u3GJ3TkoLk8dAtSDxOBDU0rwKbPL2XSn71rR3Sw=;
        b=gyHso0psXZxIRwfoQB7/1x9EDd4ieIp7DfCBq0vQDlRLPKc83Ith5HUc27tIj39PbC
         Gx4ky8SttACB4JG6B7TQjhow6V22FEUz5uSXJP1/qvA6H3w4pmgNHe++Ase6vjR4ymUq
         d5TuYCkbYbkOjqQGaMvUxuarmKyyt1BNfIgWn7f3wMQEew7+sYqDbPlO3VZ4/v6QLcE8
         Rx5YvjwzS4nmQjfs+mg7tHD2+7INbG9VJnKRDWfnM/TGSHEKhpF1DW91yWc+2THEDai+
         2ocwzsL+0lxh3ZUjZKVTeeAw/Xqw5jHT6j2N3eZkRTvUtFbcxMeucRezrF/sa/pHfxUe
         gIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9n08u3GJ3TkoLk8dAtSDxOBDU0rwKbPL2XSn71rR3Sw=;
        b=bg8SXwShdSbrCpyOeM/xx39542pLPdq1OsqijX41jhnKHLs/gao6AHwxxFlHlWcHww
         iHhlPfGSFFhspqEIy1V1nmwiopY30uXXGNYL2vxnpCR8PM+KZL7N86WYWTwP53olfeKP
         oj9uBC9ePmQmHHUMB8/KQqDenuZQnA2IFnCjWkCqW7gjzIGSObga0iTetjX7b0RByiXv
         /WNOhiWQxsgA+aUQ0g5arX+yKwJVdInr4rtwxyfj0x0b3atGKMk9rPidavEw7YzwY71y
         cK+4O/XPBFPI1qou9cs8AEJUnQpHehUzJYAzCZPKUbo4UJ8s5U9IOPs7TdopSjchu5FJ
         CEtQ==
X-Gm-Message-State: APjAAAUEEa04OpxqFXRAEDBHio1951PCua+NiB8Nc8LJXdpiQDwitMGf
        R83Ks2svzPo9wFdyiSyCwGISmtYT++gCc8Loa3w=
X-Google-Smtp-Source: APXvYqxF+hy+jYmVua6SeP9iGGLWPE7SNYmJPpSCp47g0V8pOMefhRmMSdxqadCgF+tst3HOjgiapc7sIfKcI7O/FwM=
X-Received: by 2002:a17:906:b203:: with SMTP id p3mr94874464ejz.223.1564591261970;
 Wed, 31 Jul 2019 09:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153857.4045-1-pasha.tatashin@soleen.com> <20190731163258.GH39768@lakrids.cambridge.arm.com>
In-Reply-To: <20190731163258.GH39768@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 31 Jul 2019 12:40:51 -0400
Message-ID: <CA+CK2bAYUFBBGo-LHBK4UWRK1tpx3AZ4Z9NkDxiDK0UYEDozaQ@mail.gmail.com>
Subject: Re: [RFC v2 0/8] arm64: MMU enabled kexec relocation
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Pavel,
>
> Generally, the cover letter should state up-front what the goal is (or
> what problem you're trying to solve). It would be really helpful to have
> that so that we understand what you're trying to achieve, and why.
>
> Messing with the MMU is often fraught with danger (and very painful to
> debug, as you are now aware), and so far we've tried to minimize the
> number of places where we have to do so.

Hi Mark,

I understand, this is why I first went another route of solving this
problem: pre-reserving contiguous memory, and avoid relocation
entirely (the same as what happens during crash reboot). But, that
solution was not accepted because it introduces a change to the common
code to solve ARM specific problem. So, James Morse, and other
suggested that I take a look at the root of the problem, and enable
MMU during relocation by doing what is already done during hibernate
restore.

>
> On Wed, Jul 31, 2019 at 11:38:49AM -0400, Pavel Tatashin wrote:
> > Changelog from previous RFC:
> > - Added trans_table support for both hibernate and kexec.
> > - Fixed performance issue, where enabling MMU did not yield the
> >   actual performance improvement.
> >
> > Bug:
> > With the current state, this patch series works on kernels booted with EL1
> > mode, but for some reason, when elevated to EL2 mode reboot freezes in
> > both QEMU and on real hardware.
> >
> > The freeze happens in:
> >
> > arch/arm64/kernel/relocate_kernel.S
> >       turn_on_mmu()
> >
> > Right after sctlr_el2 is written (MMU on EL2 is enabled)
> >
> >       msr     sctlr_el2, \tmp1
> >
> > I've been studying all the relevant control registers for EL2, but do not
> > see what might be causing this hang:
> >
> > MAIR_EL2 is set to be exactly the same as MAIR_EL1 0xbbff440c0400
> >
> > TCR_EL2        0x80843510
> > Enabled bits:
> > PS      Physical Address Size. (0b100   44 bits, 16TB.)
> > SH0     Shareability    11 Inner Shareable
> > ORGN0   Normal memory, Outer Write-Back Read-Allocate Write-Allocate Cach.
> > IRGN0   Normal memory, Inner Write-Back Read-Allocate Write-Allocate Cach.
> > T0SZ    01 0000
> >
> > SCTLR_EL2     0x30e5183f
> > RES1    : Reserve ones
> > M       : MMU enabled
> > A       : Align check
> > C       : Cacheability control
> > SA      : SP Alignment check enable
> > IESB    : Implicit Error Synchronization event
> > I       : Instruction access Cacheability
> >
> > TTBR0_EL2      0x1b3069000 (address of trans_table)
> >
> > Any suggestion of what else might be missing that causes this freeze when
> > MMU is enabled in EL2?
> >
> > =====
>
> > Here is the current data from the real hardware:
> > (because of bug, I forced EL1 mode by setting el2_switch always to zero in
> > cpu_soft_restart()):
> >
> > For this experiment, the size of kernel plus initramfs is 25M. If initramfs
> > was larger, than the improvements would be even greater, as time spent in
> > relocation is proportional to the size of relocation.
> >
> > Previously:
> > kernel shutdown       0.022131328s
> > relocation    0.440510736s
> > kernel startup        0.294706768s
>
> In total this takes ~0.76s...
>
> >
> > Relocation was taking: 58.2% of reboot time
> >
> > Now:
> > kernel shutdown       0.032066576s
> > relocation    0.022158152s
> > kernel startup        0.296055880s
>
> ... and this takes ~0.35s
>
> So do we really need this complexity for a few blinks of an eye?

Yes, we have an extremely tight reboot budget, 0.35s is not an acceptable waste.

>
> Thanks,
> Mark.
