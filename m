Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10013CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14B2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZV5ThvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfJXWI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:08:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42751 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbfJXWI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:08:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id c16so113547plz.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wPBWsyoRhhryb3J0bD0S+K3mPGWRQAeLMgGyEAh8NA=;
        b=hZV5ThvEMUe1+H05W87KipW9wh8W8qyemLiokSK/yWiGkKnR/ch3kMUXgljY2w7zvW
         /Ipbf87Yb3kijE0T/t66H8q1lyMED+KuoZVVkIu8AfIue0j3r1w3INIvCHuyClmQZ5qJ
         L5yoYY48V7XqsWggkovSZkM4/DzpOMEyr2Q4PTDLkvIsHvpRpGGzYvQnho9QSFySXs95
         VYbtizX1cePFwi4McJi5HaVzUpTEt/ComD7KFvZXiO8HRrPPaZAB855XykN4NaXJiAcv
         r9Ev5jxZak+jKKW4lYvE0WZA/72DJ5Fmz3n3K3BXGaCsXeW4xlijy41BM1lXyl3ttbJD
         Kimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wPBWsyoRhhryb3J0bD0S+K3mPGWRQAeLMgGyEAh8NA=;
        b=VyiI0YxQRgDpvJvyantgEnovhvsax5ubuabT5M8wfNLXgquv2MhGYyX3d1Uk2ud1+L
         rhr6XTtL4sEMCn5x3LptAsXjW8c+oAoEjmmHse7CeMJM77purgZyJ1LbgPthl6pK0d++
         Oj9aXYT2vfqcwwz1PgWxLquoLPwCb7eRwmVafAOEdDvn6HxXw54dzMGvXyMpqZjWeaPQ
         IXu8H8c64en7/OmYQoSx+Ja0JGaq6GlPEt4rH3SQ3IAC9LS4Fpz/DFdeUbAChriMjtVb
         iBia7U2zaJKuSIa3HDJiflc+s7I0mfXeqd9b/wTj9fkXYsQlRqG9taYikpVm/rtZdMZs
         dWXA==
X-Gm-Message-State: APjAAAX2amL0jVglS6ME/fHQOaEarPDQ5tccoKbWMtr2Ltf9QzZ8hpb9
        f/9VrUdCt75mftzUG442Fo8s5kzFOlRE6QK4dk8NdQ==
X-Google-Smtp-Source: APXvYqzMMqI2/Ki1cf7/37Wuw+l9BTH1Xi6VyQPxUeoQt6GTWlVjj1sr7Smw/haUnuNf40UudnwnXjn6LWFu59enO2A=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr40405plp.179.1571954937563;
 Thu, 24 Oct 2019 15:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191016230209.39663-1-ndesaulniers@google.com>
In-Reply-To: <20191016230209.39663-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 24 Oct 2019 15:08:44 -0700
Message-ID: <CAKwvOdkDCeNCg7N0jyjo9oQmVX6seOXjSv06DvQDCDz_7qSo=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amdgpu: fix stack alignment ABI mismatch
To:     Harry Wentland <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        yshuiv7@gmail.com, "S, Shirish" <shirish.s@amd.com>
Cc:     andrew.cooper3@citrix.com, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 4:02 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The x86 kernel is compiled with an 8B stack alignment via
> `-mpreferred-stack-boundary=3` for GCC since 3.6-rc1 via
> commit d9b0cde91c60 ("x86-64, gcc: Use -mpreferred-stack-boundary=3 if supported")
> or `-mstack-alignment=8` for Clang. Parts of the AMDGPU driver are
> compiled with 16B stack alignment.
>
> Generally, the stack alignment is part of the ABI. Linking together two
> different translation units with differing stack alignment is dangerous,
> particularly when the translation unit with the smaller stack alignment
> makes calls into the translation unit with the larger stack alignment.
> While 8B aligned stacks are sometimes also 16B aligned, they are not
> always.
>
> Multiple users have reported General Protection Faults (GPF) when using
> the AMDGPU driver compiled with Clang. Clang is placing objects in stack
> slots assuming the stack is 16B aligned, and selecting instructions that
> require 16B aligned memory operands.
>
> At runtime, syscall handlers with 8B aligned stack call into code that
> assumes 16B stack alignment.  When the stack is a multiple of 8B but not
> 16B, these instructions result in a GPF.
>
> Remove the code that added compatibility between the differing compiler
> flags, as it will result in runtime GPFs when built with Clang.
>
> The series is broken into 3 patches, the first is an important fix for
> Clang for ChromeOS. The rest are attempted cleanups for GCC, but require
> additional boot testing. The first patch is critical, the rest are nice
> to have. I've compile tested the series with ToT Clang, GCC 4.9, and GCC
> 8.3 **but** I do not have hardware to test on, so I need folks with the
> above compilers and relevant hardware to help test the series.
>
> The first patch is a functional change for Clang only. It does not
> change anything for any version of GCC. Yuxuan boot tested a previous
> incarnation on hardware, but I've changed it enough that I think it made
> sense to drop the previous tested by tag.

Thanks for testing the first patch Shirish. Are you or Yuxuan able to
test the rest of the series with any combination of {clang|gcc < 7.1|
gcc >= 7.1} on hardware and report your findings?

>
> The second patch is a functional change for GCC 7.1+ only. It does not
> affect older versions of GCC or Clang (though if someone wanted to
> double check with pre-GCC 7.1 it wouldn't hurt).  It should be boot
> tested on GCC 7.1+ on the relevant hardware.
>
> The final patch is also a functional change for GCC 7.1+ only. It does
> not affect older versions of GCC or Clang. It should be boot tested on
> GCC 7.1+ on the relevant hardware. Theoretically, there may be an issue
> with it, and it's ok to drop it. The series was intentional broken into
> 3 in order to allow them to be incrementally tested and accepted. It's
> ok to take earlier patches without the later patches.
>
> And finally, I do not condone linking object files of differing stack
> alignments.  Idealistically, we'd mark the driver broken for pre-GCC
> 7.1.  Pragmatically, "if it ain't broke, don't fix it."

Harry, Alex,
Thoughts on the series? Has AMD been able to stress test these more internally?

>
> Nick Desaulniers (3):
>   drm/amdgpu: fix stack alignment ABI mismatch for Clang
>   drm/amdgpu: fix stack alignment ABI mismatch for GCC 7.1+
>   drm/amdgpu: enable -msse2 for GCC 7.1+ users
>
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 19 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 19 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 19 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 19 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 19 ++++++++++++-------
>  5 files changed, 60 insertions(+), 35 deletions(-)
>
> --
> 2.23.0.700.g56cf767bdb-goog
>


-- 
Thanks,
~Nick Desaulniers
