Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854EDC32792
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 03:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CD420830
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 03:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="COJ/7kQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfJEDbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 23:31:45 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:60558 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJEDbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 23:31:45 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x953Vb23017252
        for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2019 12:31:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x953Vb23017252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570246298;
        bh=wdrix7BLC0yyJUdGOSxFzpfVJlld0/Th9nkSWXbSeko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=COJ/7kQlhSMTkV5yiAkp+Wb6CdlJ75hoNbDwyMc30lc1vUmEkKrvEX90PNAYkMWzL
         GrVpPflajQ6HKH8Ud2Es0dJ61byTAFN9KctMP7yNPRf5raM+huD3NMe3CHJRj7AYFr
         gVYtxWoAum/0hWCZLVxRP6580+ONo9ytyG+Rbsrl5gZOGVwZDtFLOgD97pCvE5pgmZ
         YpjPzE1nVkGGiqbJn0dH+/yHLdA61nup/21AlRlapxrleuJNkT1TQ38BQNbeH0RCFx
         OGnqulNwRatJ00FpDzDKRiIO2SxqWQaZ0JoEw6HtzfsJQ1CLRWjIGR9jG838xPj9uA
         5W6YTi3FXzQeQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id z14so5404478vsz.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 20:31:38 -0700 (PDT)
X-Gm-Message-State: APjAAAVqdZrE9PLPVyCvXOqYSE0On/EFxXIbPxYI6jH86myDDYJxk0sH
        rthVgWKtDqWHX+ZDxA2XlCPUXQQq7WC4gS2JCvk=
X-Google-Smtp-Source: APXvYqw82lLXqSNaK0/Szm7D0jz7yld2NsmMNVZGARheHzcciRuXkggwpd5i8wDz63XWWnNL+RCHYdCLQGbBTqSzg7o=
X-Received: by 2002:a67:ec09:: with SMTP id d9mr9864622vso.215.1570246297166;
 Fri, 04 Oct 2019 20:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
In-Reply-To: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 5 Oct 2019 12:31:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATz=j4zyF264rQD4fivw0BaW0nS5kHSBBLEjZbKoXf3yg@mail.gmail.com>
Message-ID: <CAK7LNATz=j4zyF264rQD4fivw0BaW0nS5kHSBBLEjZbKoXf3yg@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
To:     Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 7:40 PM Dmitry Goldin <dgoldin@protonmail.ch> wrote:
>
> From: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
>
> In commit 43d8ce9d65a5 ("Provide in-kernel headers to make
> extending kernel easier") a new mechanism was introduced, for kernels
> >=5.2, which embeds the kernel headers in the kernel image or a module
> and exposes them in procfs for use by userland tools.
>
> The archive containing the header files has nondeterminism caused by
> header files metadata. This patch normalizes the metadata and utilizes
> KBUILD_BUILD_TIMESTAMP if provided and otherwise falls back to the
> default behaviour.
>
> In commit f7b101d33046 ("kheaders: Move from proc to sysfs") it was
> modified to use sysfs and the script for generation of the archive was
> renamed to what is being patched.
>
> Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
>
> ---

Applied to linux-kbuild. Thanks.



>
> v1: Initial fix
>
> v2: Added a bit of info about kheaders to the reproducible builds
> documentation and used the opportunity to fix a few typos in the
> original patch.
>
> ---
>  Documentation/kbuild/reproducible-builds.rst | 13 +++++++++----
>  kernel/gen_kheaders.sh                       |  5 ++++-
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
> index ab92e98c89c8..ce6a408b3303 100644
> --- a/Documentation/kbuild/reproducible-builds.rst
> +++ b/Documentation/kbuild/reproducible-builds.rst
> @@ -16,16 +16,21 @@ the kernel may be unreproducible, and how to avoid them.
>  Timestamps
>  ----------
>
> -The kernel embeds a timestamp in two places:
> +The kernel embeds timestamps in three places:
>
>  * The version string exposed by ``uname()`` and included in
>    ``/proc/version``
>
>  * File timestamps in the embedded initramfs
>
> -By default the timestamp is the current time.  This must be overridden
> -using the `KBUILD_BUILD_TIMESTAMP`_ variable.  If you are building
> -from a git commit, you could use its commit date.
> +* If enabled via ``CONFIG_IKHEADERS``, file timestamps of kernel
> +  headers embedded in the kernel or respective module,
> +  exposed via ``/sys/kernel/kheaders.tar.xz``
> +
> +By default the timestamp is the current time and in the case of
> +``kheaders`` the various files' modification times. This must
> +be overridden using the `KBUILD_BUILD_TIMESTAMP`_ variable.
> +If you are building from a git commit, you could use its commit date.
>
>  The kernel does *not* use the ``__DATE__`` and ``__TIME__`` macros,
>  and enables warnings if they are used.  If you incorporate external
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 9ff449888d9c..aff79e461fc9 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -71,7 +71,10 @@ done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
>  find $cpio_dir -type f -print0 |
>         xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
>
> -tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
> +# Create archive and try to normalize metadata for reproducibility
> +tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
> +    --owner=0 --group=0 --sort=name --numeric-owner \
> +    -Jcf $tarfile -C $cpio_dir/ . > /dev/null
>
>  echo "$src_files_md5" >  kernel/kheaders.md5
>  echo "$obj_files_md5" >> kernel/kheaders.md5
> --
> 2.23.0



-- 
Best Regards
Masahiro Yamada
