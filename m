Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C7AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DB420706
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksvnu7eS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKOB7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:59:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32884 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKOB7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:59:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so3570510plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 17:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWeLycX3A0XaEIn+C9Dl7zk7yTPULHadgCfDLM9l7TE=;
        b=ksvnu7eSOO4terAkNlaOfyb15/oDqNrOy0ORpo0bHBI2rhd9yD5pOsdT6WUKTLlDTv
         J3JM4RVHvP1LJP0mmL5H2hRq7oVoun79yD7ZM4D3ylcuToJckasjdaZzwaLyznvO1xGX
         wWplbFAv1VywWbeyraIAphIp4UTV+24rqlE/SPn9mI2gTrXkZd1AGTREWWhZ5k7/IvWr
         E+8slo2iwqf+Q3vUc2O/7jO5L09+LMQfXHB6zZi0ziq+EGgeuIm6prEdgznpSwxbTuqO
         AALvwT9E10R6YtyJ/ZMXbbxs5wHUuvk7o7Fc+eJ7FDvcLZkmZhAYVnqslFS8A99XyfHH
         V4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UWeLycX3A0XaEIn+C9Dl7zk7yTPULHadgCfDLM9l7TE=;
        b=rrd750MR8ksyq4g8ITr2rJ4uRJ2NuUfYZ9lv7ZQEDmtoxMJaNo9sVIxi7ZuW33XqSe
         HKc/swMySWZWOj6f2hcpve3tkAYRqtRfgXT0r190ciy76FmcqeSJ1JhZjo38XjKyc5Iv
         tjzRtLCC76hXmWmEvY/FSnh27A47UTMTBWocsUEdlQPTn5GCX+2Bb41LEImC16RMb7gQ
         hdbRqWhzuY+Od/ReGTysnP/yWMvYj0BgBfcgHTNSq9AWLEAn0tMQIeayOy24k4xFGDyj
         7WG5+rAFmF88R1inN2UobBhyIVPZKx4ifiEIOXT3vEQau/utWrsz+6Y0mh1kySepEoiF
         4feQ==
X-Gm-Message-State: APjAAAWoxh3fpLjCNPxAXiU0I0qsqVOkXMW3PrkArbF9ZZciiBP35JMK
        WGD0n35Mfwswbl078kchz1/s7g==
X-Google-Smtp-Source: APXvYqwwRjwshy7pinCg9/dmaFEcUvuH69/xmFxI9FD5260D/dHSoq8L8gvQV0tVbWbwCJmg9b2XGA==
X-Received: by 2002:a17:90a:d102:: with SMTP id l2mr16852070pju.132.1573783146553;
        Thu, 14 Nov 2019 17:59:06 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id v15sm8132141pfe.44.2019.11.14.17.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 17:59:05 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:00:00 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v4 0/3] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191115015959.GI22427@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
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
References: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
 <20191113063858.GE22427@linaro.org>
 <CACi5LpP54d9DKW63G5W6X4euBjAm2NwkHOiM01dB7g8d60s=4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpP54d9DKW63G5W6X4euBjAm2NwkHOiM01dB7g8d60s=4w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhupesh,

On Fri, Nov 15, 2019 at 01:24:17AM +0530, Bhupesh Sharma wrote:
> Hi Akashi,
> 
> On Wed, Nov 13, 2019 at 12:11 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Hi Bhupesh,
> >
> > Do you have a corresponding patch for userspace tools,
> > including crash util and/or makedumpfile?
> > Otherwise, we can't verify that a generated core file is
> > correctly handled.
> 
> Sure. I am still working on the crash-utility related changes, but you
> can find the makedumpfile changes I posted a couple of days ago here
> (see [0]) and the github link for the makedumpfile changes can be seen
> via [1].
> 
> I will post the crash-util changes shortly as well.
> Thanks for having a look at the same.

Thank you.
I have tested my kdump patch with a hacked version of crash
where VA_BITS_ACTUAL is calculated from tcr_el1_t1sz in vmcoreinfo.

-Takahiro Akashi


> [0]. http://lists.infradead.org/pipermail/kexec/2019-November/023963.html
> [1]. https://github.com/bhupesh-sharma/makedumpfile/tree/52-bit-va-support-via-vmcore-upstream-v4
> 
> Regards,
> Bhupesh
> 
> >
> > Thanks,
> > -Takahiro Akashi
> >
> > On Mon, Nov 11, 2019 at 01:31:19PM +0530, Bhupesh Sharma wrote:
> > > Changes since v3:
> > > ----------------
> > > - v3 can be seen here:
> > >   http://lists.infradead.org/pipermail/kexec/2019-March/022590.html
> > > - Addressed comments from James and exported TCR_EL1.T1SZ in vmcoreinfo
> > >   instead of PTRS_PER_PGD.
> > > - Added a new patch (via [PATCH 3/3]), which fixes a simple typo in
> > >   'Documentation/arm64/memory.rst'
> > >
> > > Changes since v2:
> > > ----------------
> > > - v2 can be seen here:
> > >   http://lists.infradead.org/pipermail/kexec/2019-March/022531.html
> > > - Protected 'MAX_PHYSMEM_BITS' vmcoreinfo variable under CONFIG_SPARSEMEM
> > >   ifdef sections, as suggested by Kazu.
> > > - Updated vmcoreinfo documentation to add description about
> > >   'MAX_PHYSMEM_BITS' variable (via [PATCH 3/3]).
> > >
> > > Changes since v1:
> > > ----------------
> > > - v1 was sent out as a single patch which can be seen here:
> > >   http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
> > >
> > > - v2 breaks the single patch into two independent patches:
> > >   [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
> > >   [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)
> > >
> > > This patchset primarily fixes the regression reported in user-space
> > > utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
> > > with the availability of 52-bit address space feature in underlying
> > > kernel. These regressions have been reported both on CPUs which don't
> > > support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
> > > and also on prototype platforms (like ARMv8 FVP simulator model) which
> > > support ARMv8.2 extensions and are running newer kernels.
> > >
> > > The reason for these regressions is that right now user-space tools
> > > have no direct access to these values (since these are not exported
> > > from the kernel) and hence need to rely on a best-guess method of
> > > determining value of 'vabits_actual' and 'MAX_PHYSMEM_BITS' supported
> > > by underlying kernel.
> > >
> > > Exporting these values via vmcoreinfo will help user-land in such cases.
> > > In addition, as per suggestion from makedumpfile maintainer (Kazu),
> > > it makes more sense to append 'MAX_PHYSMEM_BITS' to
> > > vmcoreinfo in the core code itself rather than in arm64 arch-specific
> > > code, so that the user-space code for other archs can also benefit from
> > > this addition to the vmcoreinfo and use it as a standard way of
> > > determining 'SECTIONS_SHIFT' value in user-land.
> > >
> > > Cc: Boris Petkov <bp@alien8.de>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: James Morse <james.morse@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Steve Capper <steve.capper@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Dave Anderson <anderson@redhat.com>
> > > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > > Cc: x86@kernel.org
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-doc@vger.kernel.org
> > > Cc: kexec@lists.infradead.org
> > >
> > > Bhupesh Sharma (3):
> > >   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
> > >   arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
> > >   Documentation/arm64: Fix a simple typo in memory.rst
> > >
> > >  Documentation/arm64/memory.rst         | 2 +-
> > >  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
> > >  arch/arm64/kernel/crash_core.c         | 9 +++++++++
> > >  kernel/crash_core.c                    | 1 +
> > >  4 files changed, 12 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.7.4
> > >
> >
> 
