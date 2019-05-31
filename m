Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A735C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36A726A9A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQG2/gyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEaO3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:29:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44728 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfEaO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:29:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so4078601pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evy368hWiI+gBYUbtpZ/Z/NwaFGt0gP/Ku0Se7jRDIs=;
        b=sQG2/gyFbhvQgnnYVMoq8Kda68VVztjS6NpVGpn+TJ/0x1CnUPLFGI7CfwhDx4Acpv
         +b2SfJPlJiXKHOPX0vraeScgQBz7b7Nl6PyJKu6e145lCoysI0y6J5myuuCSNlucfPw4
         OziFqAsvBRMmxzPBSxXT6y9ZOWT1qftFo2UhubNHkIM+xAKIuSxRN1IDkqLlB5D+IEDh
         9Lbkk942zOUUnqGLz1d6wvbTAZV2QEf8AYds1RPyvHK7XFYBgL+gUTiPMyMH1+mL85z0
         rHLvvgL9h/d8SCsWwDzjC1mOEMEITHFigTDJGZoVkvgiZ6th+Bg/aZrVlKENNn6Dl+G9
         3qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evy368hWiI+gBYUbtpZ/Z/NwaFGt0gP/Ku0Se7jRDIs=;
        b=gBIzXxu7OOOgZYohRGlWxIYrOg9ZKmLhQyQxjzhUWeAZiCOxiA6WJMc9yLDutvdAyY
         lTLgB5lZmAjNL4N/D7S5jJgzOWOmhtUHCiGbIUxo0TZm4m3eu5i7VgwPpAIkA64bgKuO
         rC/4Zgb9MWRhzvTmv4qStUSp7TfzelT1GIyNrB5xvi6UZqTio6os4acGIbNpFCL9yusk
         fXIPikcqjIU/bwCr/vPAWW5pOYyOwT84EcxQ0N6BK5lP+f4gc8ip6O8NeqczLVkHYHAW
         5SAaNHUAg0LnstABcYpJTMUYFTuICUNu9Vv4LccaYWY8kvqNd+oAePlP22wH5N4obzhh
         KpVQ==
X-Gm-Message-State: APjAAAXrFPdriXYH7eGHoIzDhKemIslwlGWegx2vSyQ5n+n0sxoFvpub
        O/BDqbgg4nX1B2puryx8zgd1arbISDYTuR5AYIzIOw==
X-Google-Smtp-Source: APXvYqzZNq7ZmlghEU+anyWYnwjjhfBSO821IIVYI0unmJhzupp13rZUJ7jf2s8ZHPUTRKkSRgHsOXgkfcRcIwbO8eo=
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr9244481plo.252.1559312961740;
 Fri, 31 May 2019 07:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190517144931.GA56186@arrakis.emea.arm.com> <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp> <201905211633.6C0BF0C2@keescook>
 <6049844a-65f5-f513-5b58-7141588fef2b@oracle.com> <20190523201105.oifkksus4rzcwqt4@mbp>
 <ffe58af3-7c70-d559-69f6-1f6ebcb0fec6@oracle.com> <20190524101139.36yre4af22bkvatx@mbp>
 <c6dd53d8-142b-3d8d-6a40-d21c5ee9d272@oracle.com> <CAAeHK+yAUsZWhp6xPAbWewX5Nbw+-G3svUyPmhXu5MVeEDKYvA@mail.gmail.com>
 <20190530171540.GD35418@arrakis.emea.arm.com>
In-Reply-To: <20190530171540.GD35418@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 31 May 2019 16:29:10 +0200
Message-ID: <CAAeHK+y34+SNz3Vf+_378bOxrPaj_3GaLCeC2Y2rHAczuaSz1A@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elliott Hughes <enh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 7:15 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, May 28, 2019 at 04:14:45PM +0200, Andrey Konovalov wrote:
> > Thanks for a lot of valuable input! I've read through all the replies
> > and got somewhat lost. What are the changes I need to do to this
> > series?
> >
> > 1. Should I move untagging for memory syscalls back to the generic
> > code so other arches would make use of it as well, or should I keep
> > the arm64 specific memory syscalls wrappers and address the comments
> > on that patch?
>
> Keep them generic again but make sure we get agreement with Khalid on
> the actual ABI implications for sparc.

OK, will do. I find it hard to understand what the ABI implications
are. I'll post the next version without untagging in brk, mmap,
munmap, mremap (for new_address), mmap_pgoff, remap_file_pages, shmat
and shmdt.

>
> > 2. Should I make untagging opt-in and controlled by a command line argument?
>
> Opt-in, yes, but per task rather than kernel command line option.
> prctl() is a possibility of opting in.

OK. Should I store a flag somewhere in task_struct? Should it be
inheritable on clone?

>
> > 3. Should I "add Documentation/core-api/user-addresses.rst to describe
> > proper care and handling of user space pointers with untagged_addr(),
> > with examples based on all the cases seen so far in this series"?
> > Which examples specifically should it cover?
>
> I think we can leave 3 for now as not too urgent. What I'd like is for
> Vincenzo's TBI user ABI document to go into a more common place since we
> can expand it to cover both sparc and arm64. We'd need an arm64-specific
> doc as well for things like prctl() and later MTE that sparc may support
> differently.

OK.

>
> --
> Catalin
