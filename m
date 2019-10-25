Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B2CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB5821D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN3Udkn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfJYTpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:45:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45851 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJYTpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:45:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id q13so3620883wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neabhCzzi0dq4nLNqnclhYb/Pn2frsP1v9KepipEQQk=;
        b=tN3Udkn6rXw0ASKbmxNonRtzyZjPXxP+XW7ltVENS9FzkhHJ/OaMCKURBzv/kN0GdT
         FL1VHVXit7YEHoKoxOl5UXYO7Axk38YebX2HKWrjks0Z7nZaAEsjAPhf3id1HBXJjiPx
         Mhs3QRTACVktCEewkVHAU7yXjKf7nx6VUVbB2SzTqjszSYnuWP0iV6HNaGSnLj7RXAMl
         moQerOHlF5bbC9FIRCX/l+eO6Yr2aaeMe3/3mfV4ZxBEDBtpeS3rKwxow1YhwOqplXbn
         5yWSt9hGNN9Mdn7CsZ4EtNK49uPTI1xHYmFBwwkKG4BnGp1K3+hiQ19WB0rxzZjnJ/ga
         3bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neabhCzzi0dq4nLNqnclhYb/Pn2frsP1v9KepipEQQk=;
        b=GJb1djFVI8eq8rmo2EE9J8JdhRQ8p6cdUha5n05hvAsQJ4rrpE+okJ2VbcIdqpVEJp
         Asnx9aI06bDIsW+ogj3aC/T728UKaB2JKi+ATl4IBpBFLha2Iluz33N5yPIVYYIK/OXu
         Zu2psZkWPjuveF2XDF+e5y6GfLF77aVFkkM/2If1jVdPkZIXU7rh52qHYU+BfHKltwMU
         6fI6NEKrUngDmhByZeF1s4p66mD1f1jygRcT/7sAnwqNxq4paHUCqAPp3ibNWH5Mw58d
         jkSsfpcZulg4y9eOYyRqc1npKcjJUTaMZ5UByzhqxwF3np8+6oduwnJKlcFEuGiumS4P
         SbLg==
X-Gm-Message-State: APjAAAUFpS0zHHmEdzFJwQQiB51Zt3fGQ+0YVIEjnqAisKVHnFA+oY9J
        y+DUZWe+xwy5wAVLMyzZmrSX9dsfMLNJcgBGLUM=
X-Google-Smtp-Source: APXvYqw8M5JpRty/x0BnoaSToC5HrUPFTyeuBjCnesfWvrJO/jV0nB830PVVzqDBI2Vb9UAD0B2Ykr+LaOZdxMo8TY0=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr4688572wrw.206.1572032743513;
 Fri, 25 Oct 2019 12:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191016230209.39663-1-ndesaulniers@google.com> <CAKwvOdkDCeNCg7N0jyjo9oQmVX6seOXjSv06DvQDCDz_7qSo=Q@mail.gmail.com>
In-Reply-To: <CAKwvOdkDCeNCg7N0jyjo9oQmVX6seOXjSv06DvQDCDz_7qSo=Q@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 25 Oct 2019 15:45:32 -0400
Message-ID: <CADnq5_PbUQV5vvgN6yQuiQVpG0Ssk6r_G9tJEhT8XWKf-fOuFQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amdgpu: fix stack alignment ABI mismatch
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        yshuiv7@gmail.com, "S, Shirish" <shirish.s@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Matthias Kaehlcke <mka@google.com>,
        "Koenig, Christian" <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 4:12 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Oct 16, 2019 at 4:02 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > The x86 kernel is compiled with an 8B stack alignment via
> > `-mpreferred-stack-boundary=3` for GCC since 3.6-rc1 via
> > commit d9b0cde91c60 ("x86-64, gcc: Use -mpreferred-stack-boundary=3 if supported")
> > or `-mstack-alignment=8` for Clang. Parts of the AMDGPU driver are
> > compiled with 16B stack alignment.
> >
> > Generally, the stack alignment is part of the ABI. Linking together two
> > different translation units with differing stack alignment is dangerous,
> > particularly when the translation unit with the smaller stack alignment
> > makes calls into the translation unit with the larger stack alignment.
> > While 8B aligned stacks are sometimes also 16B aligned, they are not
> > always.
> >
> > Multiple users have reported General Protection Faults (GPF) when using
> > the AMDGPU driver compiled with Clang. Clang is placing objects in stack
> > slots assuming the stack is 16B aligned, and selecting instructions that
> > require 16B aligned memory operands.
> >
> > At runtime, syscall handlers with 8B aligned stack call into code that
> > assumes 16B stack alignment.  When the stack is a multiple of 8B but not
> > 16B, these instructions result in a GPF.
> >
> > Remove the code that added compatibility between the differing compiler
> > flags, as it will result in runtime GPFs when built with Clang.
> >
> > The series is broken into 3 patches, the first is an important fix for
> > Clang for ChromeOS. The rest are attempted cleanups for GCC, but require
> > additional boot testing. The first patch is critical, the rest are nice
> > to have. I've compile tested the series with ToT Clang, GCC 4.9, and GCC
> > 8.3 **but** I do not have hardware to test on, so I need folks with the
> > above compilers and relevant hardware to help test the series.
> >
> > The first patch is a functional change for Clang only. It does not
> > change anything for any version of GCC. Yuxuan boot tested a previous
> > incarnation on hardware, but I've changed it enough that I think it made
> > sense to drop the previous tested by tag.
>
> Thanks for testing the first patch Shirish. Are you or Yuxuan able to
> test the rest of the series with any combination of {clang|gcc < 7.1|
> gcc >= 7.1} on hardware and report your findings?
>
> >
> > The second patch is a functional change for GCC 7.1+ only. It does not
> > affect older versions of GCC or Clang (though if someone wanted to
> > double check with pre-GCC 7.1 it wouldn't hurt).  It should be boot
> > tested on GCC 7.1+ on the relevant hardware.
> >
> > The final patch is also a functional change for GCC 7.1+ only. It does
> > not affect older versions of GCC or Clang. It should be boot tested on
> > GCC 7.1+ on the relevant hardware. Theoretically, there may be an issue
> > with it, and it's ok to drop it. The series was intentional broken into
> > 3 in order to allow them to be incrementally tested and accepted. It's
> > ok to take earlier patches without the later patches.
> >
> > And finally, I do not condone linking object files of differing stack
> > alignments.  Idealistically, we'd mark the driver broken for pre-GCC
> > 7.1.  Pragmatically, "if it ain't broke, don't fix it."
>
> Harry, Alex,
> Thoughts on the series? Has AMD been able to stress test these more internally?
>

Was out of the office most of the week.  They look good to me.  I'll
pull them in today and see what happens.

Alex

> >
> > Nick Desaulniers (3):
> >   drm/amdgpu: fix stack alignment ABI mismatch for Clang
> >   drm/amdgpu: fix stack alignment ABI mismatch for GCC 7.1+
> >   drm/amdgpu: enable -msse2 for GCC 7.1+ users
> >
> >  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 19 ++++++++++++-------
> >  drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 19 ++++++++++++-------
> >  drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 19 ++++++++++++-------
> >  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 19 ++++++++++++-------
> >  drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 19 ++++++++++++-------
> >  5 files changed, 60 insertions(+), 35 deletions(-)
> >
> > --
> > 2.23.0.700.g56cf767bdb-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
