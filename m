Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D4FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C730D206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmUXBPg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNTyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:54:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56749 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbfKNTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573761278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipOfIuZv4n7OMTuT05ttv+XiU0MiZdbWkcgUyU+rx/Q=;
        b=fmUXBPg8Zr1oKF8gZ7LEfuLnqor+S26BYNqNz7pjTDOis6EFk1AKX8IdNjiC5j9z8xnlJo
        Wy5FdQqXv5aVVufziVFBOEHIwYjD9yPvO6d2p82kelFIkENm+TlHLZCUVbh6sKEbvOhNBz
        pgrUVALA/hz/CP/42VXWpUi+Id2m9f4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-C3Kv_C9RMLusc_lu8uq9jw-1; Thu, 14 Nov 2019 14:54:37 -0500
Received: by mail-lj1-f198.google.com with SMTP id o20so980110ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MDqH19kOOKY+TUPNPG0CxeBoBcGPMQfXKESSJwySm9E=;
        b=jgDT7hWfsHX5DiiuwBV93zxnJ1JRRhB1csx/CQMU32f03mQp7oCSxdqHxcU39yE5px
         QapNhXrF+US2riuCeWAoszMIZQLOL3o/HQQIUTPlvSk6Nt/cWZqW2RrR7Eo2OEZEej3t
         ZHn+7yu9lmvE6inI4Knsf4Ut5nIUQEerNMOENT3BuMxKLrhv9Tc8qaoddxB5f339/who
         3/8KRrmJG8lc1osIH48B3ojic+2nWOCleLlmYl22XaVLpCKWmvOqf/k7FM7/iSzltEsS
         YTt6Jd9DZeIN+lCgLC5KLFyR7x54OebZ+WELOiKRnXIR4sMBxeKA1vZBZIaxl4ycTbEN
         UeRg==
X-Gm-Message-State: APjAAAUxyHNdxIPNnSyt+lC62N6lNWSFCa2vY5tAlB3QMSWzp6U9Y2GF
        1Fe8ZjmgC74jJLWn7jfnjykx0xr+oNBIsB0doaohzDXNL8Lx9zY6pcGDZ87we9WnVeXuvbPujfr
        WUNQruQKWUnDBhsYfKG/d60elfrWPo9TAl6E/2QaN
X-Received: by 2002:a2e:9695:: with SMTP id q21mr7771487lji.206.1573761275770;
        Thu, 14 Nov 2019 11:54:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvZP1Wg9zN6nJYQIloLkjVhepGTmfmXrp4BqyWB295YviNhYt2NN6gtXuLQLlI9WPMoiGos+kqPi2No7ektKQ=
X-Received: by 2002:a2e:9695:: with SMTP id q21mr7771458lji.206.1573761275378;
 Thu, 14 Nov 2019 11:54:35 -0800 (PST)
MIME-Version: 1.0
References: <1573459282-26989-1-git-send-email-bhsharma@redhat.com> <20191113063858.GE22427@linaro.org>
In-Reply-To: <20191113063858.GE22427@linaro.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 15 Nov 2019 01:24:17 +0530
Message-ID: <CACi5LpP54d9DKW63G5W6X4euBjAm2NwkHOiM01dB7g8d60s=4w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
X-MC-Unique: C3Kv_C9RMLusc_lu8uq9jw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On Wed, Nov 13, 2019 at 12:11 PM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi Bhupesh,
>
> Do you have a corresponding patch for userspace tools,
> including crash util and/or makedumpfile?
> Otherwise, we can't verify that a generated core file is
> correctly handled.

Sure. I am still working on the crash-utility related changes, but you
can find the makedumpfile changes I posted a couple of days ago here
(see [0]) and the github link for the makedumpfile changes can be seen
via [1].

I will post the crash-util changes shortly as well.
Thanks for having a look at the same.

[0]. http://lists.infradead.org/pipermail/kexec/2019-November/023963.html
[1]. https://github.com/bhupesh-sharma/makedumpfile/tree/52-bit-va-support-=
via-vmcore-upstream-v4

Regards,
Bhupesh

>
> Thanks,
> -Takahiro Akashi
>
> On Mon, Nov 11, 2019 at 01:31:19PM +0530, Bhupesh Sharma wrote:
> > Changes since v3:
> > ----------------
> > - v3 can be seen here:
> >   http://lists.infradead.org/pipermail/kexec/2019-March/022590.html
> > - Addressed comments from James and exported TCR_EL1.T1SZ in vmcoreinfo
> >   instead of PTRS_PER_PGD.
> > - Added a new patch (via [PATCH 3/3]), which fixes a simple typo in
> >   'Documentation/arm64/memory.rst'
> >
> > Changes since v2:
> > ----------------
> > - v2 can be seen here:
> >   http://lists.infradead.org/pipermail/kexec/2019-March/022531.html
> > - Protected 'MAX_PHYSMEM_BITS' vmcoreinfo variable under CONFIG_SPARSEM=
EM
> >   ifdef sections, as suggested by Kazu.
> > - Updated vmcoreinfo documentation to add description about
> >   'MAX_PHYSMEM_BITS' variable (via [PATCH 3/3]).
> >
> > Changes since v1:
> > ----------------
> > - v1 was sent out as a single patch which can be seen here:
> >   http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
> >
> > - v2 breaks the single patch into two independent patches:
> >   [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, wher=
eas
> >   [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel c=
ode (all archs)
> >
> > This patchset primarily fixes the regression reported in user-space
> > utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
> > with the availability of 52-bit address space feature in underlying
> > kernel. These regressions have been reported both on CPUs which don't
> > support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernel=
s
> > and also on prototype platforms (like ARMv8 FVP simulator model) which
> > support ARMv8.2 extensions and are running newer kernels.
> >
> > The reason for these regressions is that right now user-space tools
> > have no direct access to these values (since these are not exported
> > from the kernel) and hence need to rely on a best-guess method of
> > determining value of 'vabits_actual' and 'MAX_PHYSMEM_BITS' supported
> > by underlying kernel.
> >
> > Exporting these values via vmcoreinfo will help user-land in such cases=
.
> > In addition, as per suggestion from makedumpfile maintainer (Kazu),
> > it makes more sense to append 'MAX_PHYSMEM_BITS' to
> > vmcoreinfo in the core code itself rather than in arm64 arch-specific
> > code, so that the user-space code for other archs can also benefit from
> > this addition to the vmcoreinfo and use it as a standard way of
> > determining 'SECTIONS_SHIFT' value in user-land.
> >
> > Cc: Boris Petkov <bp@alien8.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Steve Capper <steve.capper@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Dave Anderson <anderson@redhat.com>
> > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > Cc: x86@kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-doc@vger.kernel.org
> > Cc: kexec@lists.infradead.org
> >
> > Bhupesh Sharma (3):
> >   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
> >   arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
> >   Documentation/arm64: Fix a simple typo in memory.rst
> >
> >  Documentation/arm64/memory.rst         | 2 +-
> >  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
> >  arch/arm64/kernel/crash_core.c         | 9 +++++++++
> >  kernel/crash_core.c                    | 1 +
> >  4 files changed, 12 insertions(+), 1 deletion(-)
> >
> > --
> > 2.7.4
> >
>

