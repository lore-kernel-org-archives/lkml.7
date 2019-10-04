Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78F9215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f4g8tW/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfJDSO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:14:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41133 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJDSO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:14:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so4357105pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1AHLlO9o/KwaGki4nKPADtfseKYS/v6djCxFOcNMEm0=;
        b=f4g8tW/7NPjiZFgD98Bpc5zywpQpU15RMmETwu0TcYEDHqjebqWt9F3kzpngjibbV/
         XxXaszVfDIFshLEiVE4BPQhnLppOz8lGVpmr8dgzMsp1p3E/VJwj3gOpGrKdMzIDaO1A
         DgxZ5C3FyN92ipNzWjM5Q1WZm5i67feHeK1KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1AHLlO9o/KwaGki4nKPADtfseKYS/v6djCxFOcNMEm0=;
        b=pwRT5GHtdw/lkt17SW0VqsUKQrGSZ4X2Br3ng+/XEPFoWxaW4VH5a3kEtn0xCMMGoS
         tryyK5wEkXk4zla0iVvYaqpjRjrGPYlSkG6Nxh/VS5ruRZHkeQbkgyGieTInuk95uFU/
         VoU0PmnK05EZ+T2aiL+0JcLNP4tuMA0Jp9xA3d/66OjDT60VoXkDcFCnTPf0NuuzknWF
         U5qvRDm/4b6YcrgYUDIxqLsMJBxld0oHaDKnuQejPH+aQrmHvTGecuLWG4w8bFlao2lh
         l054q9dmmdbt0h5uqRvffMYm9LtYOkvOjXJgbzNMLSK13hAy7/PV1hC5YePiBlAg3Krt
         EzuQ==
X-Gm-Message-State: APjAAAXzlxkxzWfJJ6eV5u06gSuk4NmbD5BGk0MzJfmAu5aAN7vmFt0C
        DxMLhxJZhfReVKVrykK6g7xz9g==
X-Google-Smtp-Source: APXvYqwvlV3oQO8IOH+I7CsrDCej3Z39SgfZYy/fw+YC1RqhMDuaWlsBi899LDWqup41ef6LHyEzPQ==
X-Received: by 2002:a63:7342:: with SMTP id d2mr16987362pgn.264.1570212865922;
        Fri, 04 Oct 2019 11:14:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l27sm10318277pgc.53.2019.10.04.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:14:25 -0700 (PDT)
Date:   Fri, 4 Oct 2019 14:14:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
Message-ID: <20191004181424.GI253167@google.com>
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:40:07AM +0000, Dmitry Goldin wrote:
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

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

> 
> ---
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
>  	xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
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
