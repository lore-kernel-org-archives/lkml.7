Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A7AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB5A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RwTKfi1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfDWTZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:25:32 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42299 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDWTZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:25:31 -0400
Received: by mail-ua1-f67.google.com with SMTP id h4so5162536uaj.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNhP9XFiYKNAYI3zNWxinSjmNUEz+3eqMPh7iKFclWk=;
        b=RwTKfi1jclEiPIKyxw/OuL0qVTm5S2IQocH4pbHlbP6F37kJ+X5sPPyStZaMCaigLm
         cFhH1N/EDBxkOWijKwgl2qwXF/1BaZ66a4BM6nGf5mrZqjTtwtwm4n82ez9DYtRJM6+j
         9DgUjuWDk0w5SDv0d6gSGvj1kGMvlW4aDhSag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNhP9XFiYKNAYI3zNWxinSjmNUEz+3eqMPh7iKFclWk=;
        b=DywLpFt7eN7A8frBZNMynMWATmndFc+emScL5VYMSJ0Z51jJCOYQxjMtvtbR+zufRL
         nTAYk2EW3ih50It+f/SYlA1SBRgoBtCoLmSG92ynxXuiYd2Y0lI3JFSzQ7kKid5B4gom
         nN7BUc+ZKgae2jPdUz5ONy4VHiBW4RhD+QOkj9Iij4a4mUFI/DdF/5mBuwLhmgoUNvr9
         k8ugA/NcuQ1gtvuoWbPD+pjHaojOmY9smPa55sZa1Rp2Qb2NUnbamrO/7/5rnzoowCPZ
         P6j4o8Eu6T7X3ExHdwfNifyxyV/zTVPXxtSjLaV79KnJsMVIQMTNUCTSfhhdw5WEKUr5
         jnPA==
X-Gm-Message-State: APjAAAXK7YZUtPL6Nsv+jyAdKKUISMhLQFuiCzhoD3DiTkjS3ElWqPpk
        28JeUmY11l6fN4J2KMTBaVwEYNP3AUM=
X-Google-Smtp-Source: APXvYqxox2E7RrdZ9pDWiC3l6SLVKkPGp/8A9ndeyKKBmHivpWrUEpFlo6qZokzuk5p5oktP6ZBSmQ==
X-Received: by 2002:ab0:7714:: with SMTP id z20mr3700123uaq.60.1556047530681;
        Tue, 23 Apr 2019 12:25:30 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id b197sm16761689vkd.9.2019.04.23.12.25.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 12:25:29 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id p13so5174294uaa.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:25:29 -0700 (PDT)
X-Received: by 2002:ab0:1646:: with SMTP id l6mr13713655uae.75.1556047528843;
 Tue, 23 Apr 2019 12:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190423181210.GA2443@beast> <CAG48ez0CeTEGDuwr+qAGBwsqm+Drj0dkFfr6_UDc+g-xM4BpiA@mail.gmail.com>
In-Reply-To: <CAG48ez0CeTEGDuwr+qAGBwsqm+Drj0dkFfr6_UDc+g-xM4BpiA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 12:25:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+H_f6NO8VB3JkJZCBbSosY-oqnkEcA8nnTokZGN2QdRw@mail.gmail.com>
Message-ID: <CAGXu5j+H_f6NO8VB3JkJZCBbSosY-oqnkEcA8nnTokZGN2QdRw@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern CPUs
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        musl@lists.openwall.com, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:02 PM Jann Horn <jannh@google.com> wrote:
> It's probably worth going a bit more into detail in this description
> on how libraries typically allocate thread stacks.
>
> It looks like glibc will be fine; before commit 54ee14b3882
> (https://sourceware.org/git/?p=glibc.git;a=blobdiff;f=nptl/allocatestack.c;h=dc501650b8629eda4502f2016016f09106cfb526;hp=6ada1fe1381de104153c0627e27f09fe5ad02caa;hb=54ee14b3882;hpb=16a76cd23ce9d3924fa192395e730423e3dc8b36),
> thread stacks were always RWX, and since then, from what I can tell,
> thread stacks were executable depending on the executable's ELF
> headers (as parsed by glibc).

2003, which seems safely (?) in the past. :)

> But e.g. musl's __pthread_create() seems to hardcode
> PROT_READ|PROT_WRITE, which I think would mean that if someone built a
> multithreaded program with nested functions and linked with musl, that
> program would stop working? Or maybe I'm just reading the code wrong.

Rephrasing for myself: this could break multithread binaries linked
with musl and marked with PT_GNU_STACK to RWE since musl doesn't check
ELF headers to determine stack executable-ness when allocating stack
space in __pthread_create().

> Then again, I'm not sure whether anyone actually uses nested functions...

It is blissfully rare, but it seems common (?) for Fortran binaries.
Are there multithreaded fortran binaries linked with musl that will
break because of this? I guess it's possible. If that happens, we can
adjust the logic with notes of an actual case. :)

-- 
Kees Cook
