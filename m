Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B8B222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="p+8DSviJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfJCBvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:51:06 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:22090 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCBvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:51:05 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x931ohLg013800
        for <linux-kernel@vger.kernel.org>; Thu, 3 Oct 2019 10:50:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x931ohLg013800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570067444;
        bh=O01tOM31Ksvj1XDJuI7hCp7yiI9mA1FnOV4QJnkzssM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p+8DSviJzvELq2Tlsp42cY10s++mlwE1tKCkT5yKggnTuWLdSP0q9UVtfcs+kfDE1
         l3XhQRP0VbvHr8fREyzXybewgVoxEL9afbDIoHvzpqXDRU2KHMrg9YtZZDWe4TVN0s
         RLuuEZLb1hLbQt03K8m6DWR35J96KYVxgeC0qlX3k+vNtv8BCt6bd3JTYZUjn4luAq
         uhUMcskQh6b/IHawz4hU6Du+7NnJOFMvsRKRexAo1w8g5z2ZBUtv3+ok9dwS4f/QkX
         1ceJ+uOYT4NdTH/44M9KVWqctIRWNSi1j7hctaaa/0d1s3Nh9Ys4SIMLc5T3wFYgKu
         6IlyhYtwEvr0w==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id p13so601926vsr.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 18:50:43 -0700 (PDT)
X-Gm-Message-State: APjAAAWN0EiULcsd+c8/jyzMMoHDiric5AIOvMMcpVt4caZTquksKxdb
        3Xf6fGj9rSDFS6dm2WDUd6ba9cYPndC/G7fok80=
X-Google-Smtp-Source: APXvYqxmtMjv/Qsxwd4MJdXiytj911/yWnWNu7CTaEdQWZgab+Pt6eqx5+l1G42dFRXV5J7AQmp9Wp7cERNVO3H+u1A=
X-Received: by 2002:a67:7c03:: with SMTP id x3mr3829260vsc.155.1570067442689;
 Wed, 02 Oct 2019 18:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <IQMyD-PDXUKT0AUM6nMO2xzV3oJqgdois_F-LtaUnpMXywiuwxH1pPZL_SAv4eYu-PwyhoTxPHqXQ295i2DsjMwUyQqm6ARydcgqySKoqlo=@protonmail.ch>
In-Reply-To: <IQMyD-PDXUKT0AUM6nMO2xzV3oJqgdois_F-LtaUnpMXywiuwxH1pPZL_SAv4eYu-PwyhoTxPHqXQ295i2DsjMwUyQqm6ARydcgqySKoqlo=@protonmail.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Oct 2019 10:50:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS1-HnsGTD1=sUm0L-gFjf3+q0qpuRQb1wREmzTs4UuVw@mail.gmail.com>
Message-ID: <CAK7LNAS1-HnsGTD1=sUm0L-gFjf3+q0qpuRQb1wREmzTs4UuVw@mail.gmail.com>
Subject: Re: [PATCH] kheaders: making headers archive reproducible
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

Hi Dmitry,


(+CC Ben Hutchings, who might be interested)


On Sun, Sep 22, 2019 at 10:38 PM Dmitry Goldin <dgoldin@protonmail.ch> wrote:
>
> From: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
>
> In commit 43d8ce9d65a5 ("Provide in-kernel headers to make
> extending kernel easier") a new mechanism was introduced, for kernels
> >=5.2, which embeds the kernel headers in the kernel image or a module
> and exposed them in procfs for use by userland tools.
>
> The archive containing the header files has nondeterminism through the
> header files metadata. This patch normalizes the metadata and utilizes
> KBUILD_BUILD_TIMESTAMP if provided and otherwise falls back to the
> default behaviour.
>
> In commit f7b101d33046 ("kheaders: Move from proc to sysfs") it was
> modified to use sysfs and the script for generation of the archive was
> renamed to what is being patched.
>
> Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
> ---
>  kernel/gen_kheaders.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)


Thanks, this produced the deterministic archive for me.


While you are here, could you also update the following hunk
in Documentation/kbuild/reproducible-builds.rst

---------->8---------------
The kernel embeds a timestamp in two places:

* The version string exposed by ``uname()`` and included in
  ``/proc/version``

* File timestamps in the embedded initramfs
---------->8---------------


With the documentation updated, I will pick it soon.

Thank you.




> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 9ff449888d9c..2e154741e3b2 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -71,7 +71,10 @@ done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
>  find $cpio_dir -type f -print0 |
>         xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
>
> -tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
> +# Create archive and try to normalized metadata for reproducibility
> +tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
> +    --owner=0 --group=0 --sort=name --numeric-owner \
> +    -Jcf $tarfile -C $cpio_dir/ . > /dev/null
>
>  echo "$src_files_md5" >  kernel/kheaders.md5
>  echo "$obj_files_md5" >> kernel/kheaders.md5
> --
> 2.19.2
>
>
>


-- 
Best Regards
Masahiro Yamada
