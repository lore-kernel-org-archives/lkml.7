Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E009AC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97B92072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bNfU3pqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgAHR7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:59:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38856 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgAHR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:59:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so3323338edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uEGBOLSJ2/X/0eS51RiNhJGw7wJMIxKLyleFhVXCjU=;
        b=bNfU3pqQAxrJLz5YamHpEVqhAqbwtCyAQtia8G0VcYhNt4oMjsMyEKEFJSsaPM023k
         WwYyZCoRFiDvgBZqyHWGBIwb33HRviCqZzPQ9Rwvnv+3mXF6zDMBX3LYLNWRmADSxWnU
         AhTLCkfwuKN5URHZy0XQG0kOUs2ESmqZZBjf0yO6gd7DiHyWEZal/nUYAH4tnfghehRx
         Hwhd0v7hpxd/nXxGkC6sxAB4fgSJFoTM9sld6Z/jH37HNI8+Uto9KE3qombk7p4dmMtc
         pULM+JnTaOvu7dHzcEFKAWuMIvImdzzHZ74vUt8yadsb9zL1bvktTIkcoeJkG0CZjuJB
         wQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uEGBOLSJ2/X/0eS51RiNhJGw7wJMIxKLyleFhVXCjU=;
        b=JgI23a3MQj5dE/XeW9gnihP2X/eAtRz1mIpbqoK7TgWdnGS8hah4HO5KmFn02mo98Z
         Zf4wKG6a0Pc6rrChdPI9i5Fd2mhiYsRUulUyl+RL3cgElSB7EThlLdpGBvMLaXkudLPm
         zeRgq1SZ5NvfE5R14ZzMWVRqAwBVAFsgkS7HmFWfxhwmDzUFdeW45rjlxQKqrecERPOl
         fovPMTBZXc4bqOSP8SPPEbuxULincNb4VS0L7Mhx69nqR4yTCKTJQ6FzOBkx3sXRNv0E
         hCg9nAVwLz97NHNwfhitCPULz+h18NGw7nbb4WUThjCzrdW9kRm9WLJaD/ocIUfUrevr
         5FFQ==
X-Gm-Message-State: APjAAAWIw7c+yVaYvrCBxD/9vOinYh1o2epWk/rVwrTSYaJ1s4onJkbv
        PeV3dVwBIeRjRaGmSEOeSjIxKlREVJ0IrbU8oyZ8Kw==
X-Google-Smtp-Source: APXvYqzJNhUYj7BUDWq/b5VLfPHGhXZOH/nyV2Gie8IiGDhSBzYXZZsk8IWFKTu5blsELnHIiDrlPgfetGRZnwf7rWQ=
X-Received: by 2002:a17:906:3798:: with SMTP id n24mr6133397ejc.15.1578506343460;
 Wed, 08 Jan 2020 09:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20191216021247.24950-1-takahiro.akashi@linaro.org>
 <20191216021247.24950-3-takahiro.akashi@linaro.org> <20200108174839.GB21242@willie-the-truck>
In-Reply-To: <20200108174839.GB21242@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 8 Jan 2020 12:58:52 -0500
Message-ID: <CA+CK2bBg2zaUONC_wf5na4CF0Tj3sThEPT7AgNmevycSZRdMeA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: kexec_file: add crash dump support
To:     Will Deacon <will@kernel.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, Bhupesh Sharma <bhsharma@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Pasha

On Wed, Jan 8, 2020 at 12:48 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Dec 16, 2019 at 11:12:47AM +0900, AKASHI Takahiro wrote:
> > Enabling crash dump (kdump) includes
> > * prepare contents of ELF header of a core dump file, /proc/vmcore,
> >   using crash_prepare_elf64_headers(), and
> > * add two device tree properties, "linux,usable-memory-range" and
> >   "linux,elfcorehdr", which represent respectively a memory range
> >   to be used by crash dump kernel and the header's location
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > Tested-and-reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  arch/arm64/include/asm/kexec.h         |   4 +
> >  arch/arm64/kernel/kexec_image.c        |   4 -
> >  arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
> >  3 files changed, 106 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index 12a561a54128..d24b527e8c00 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> >  struct kimage_arch {
> >       void *dtb;
> >       unsigned long dtb_mem;
> > +     /* Core ELF header buffer */
> > +     void *elf_headers;
> > +     unsigned long elf_headers_mem;
> > +     unsigned long elf_headers_sz;
> >  };
>
> This conflicts with the cleanup work from Pavel. Please can you check my
> resolution? [1]
>
> Will
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/diff/?h=for-kernelci&id=aef73191765a88cadc0a627cdc070e5a0086b015
>
