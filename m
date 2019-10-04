Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA6C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C53C222D1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR58Eu0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfJDSZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:25:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51086 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbfJDSZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:25:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so6784613wmg.0;
        Fri, 04 Oct 2019 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EG4uhXwG5jrCbKoCifB7aoh41j2vEgUP8k3d/Yoz+3Y=;
        b=lR58Eu0k+JCfeIPEyEs/Ht4+UJtMI73bNG8K4mnf3RvCQUUmORvgI1pKfa/CtHvFfn
         Of9B+zQV5JIn3I+Ebz89qa5I0gdhExzuuBKrMcdHmPyHcG/IP/7W9ckKZZ7iJGeNiwLg
         aXlJ9moTioW6My3A+l6QVfHGbOozq44HdiKLGMyPc3+xl3m8mpLPahJ2n5i4uF74nlNT
         CO/NMcJXFuynhCpQB7D0sqJU4zFJE07iMQrHhiYJVQ8N5gbsMlrQBQSrjd3P4qdsEOxP
         z//WZ6fg/XMPh2IwF50R7ahW9Z4Z/GQtwJguQ0/AQJUypt9z5LnLlkgh9srpV6sWZa8H
         iaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EG4uhXwG5jrCbKoCifB7aoh41j2vEgUP8k3d/Yoz+3Y=;
        b=ElMgSrZsM1ocoEm4urTWxBU62gp2UwXLg+r8OhpHszv7GYv85ZHZD36x16g0JNZT7P
         OVaXTt6+J+ICMSRnKxkJnKUeGhP7nwqKHNLNYAHvFsRGGug7mgqf7VSBB4BxHS5hi9pq
         3q+MIMIXRIn7jJyNZp/wMEMPfsboE0+Gixvn50O6BvBjgvYh6XA2UNZICG1Mt9OEG14K
         U11CBhkMcfXaz/hpDe31hXVkVoMLmv1g9kQspxGG9RQJM1PGHLFJQ8LSz5Qhm5N/YETK
         LZ3xnO9q7sd0+bmuwdticNDwNdHLgKQnd/RReuG1COfLY72oNkyhx5/HVhOhG5ZpOi8g
         1/ow==
X-Gm-Message-State: APjAAAWiIXlUS01H3cTIvenNt1MIXpzxoyaCd77nIknBI8tNp4+8wvOE
        ldtPErJrOnNJQzdH0h0yU5BKIvtAthT5khGuX4E=
X-Google-Smtp-Source: APXvYqxPlTrfehCiFQd0k6mYGWobjxKW9B0GB8xUGkXN2ywGoTh0b2nz2WPHjHh+kXLT0dye9OuFq8FsQ/plZtQBNr8=
X-Received: by 2002:a05:600c:10cc:: with SMTP id l12mr11624477wmd.165.1570213545580;
 Fri, 04 Oct 2019 11:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190917231031.81341-1-maennich@google.com> <20191004095748.223119-1-maennich@google.com>
In-Reply-To: <20191004095748.223119-1-maennich@google.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 4 Oct 2019 11:25:33 -0700
Message-ID: <CAKi4VALPF7r25SJ+9jazeRz612pv_4MmhjOsJ8aumW_JO29VvA@mail.gmail.com>
Subject: Re: [PATCH] depmod: create and use System.map.no_namespaces
To:     Matthias Maennich <maennich@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:57 AM Matthias Maennich <maennich@google.com> wrote:
>
> depmod in its current version is not aware of symbol namespace in
> ksymtab entries introduced with 8651ec01daed ("module: add support for
> symbol namespaces."). They have the form
>
>   __ksymtab_NAMESPACE.symbol_name
>
> A fix for kmod's depmod has been proposed [1]. In order to support older
> versions of depmod as well, create a System.map.no_namespaces during
> scripts/depmod.sh that has the pre-namespaces format. That way users do
> not immediately upgrade the userspace tool.
>
> [1] https://lore.kernel.org/linux-modules/20191004094136.166621-1-maennich@google.com/
>
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-modules@vger.kernel.org
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>
> Please note this depends on the new ksymtab entry format proposed in
> https://lore.kernel.org/lkml/20191003075826.7478-2-yamada.masahiro@socionext.com/

I don't really agree with that thought, more below.

>
> That is likely to be merged soon as well as it fixes problems in 5.4-rc*, hence
> this patch depends on it.
>
> Cheers,
> Matthias
>
>  .gitignore        | 1 +
>  scripts/depmod.sh | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/.gitignore b/.gitignore
> index 70580bdd352c..5ed58a7cb433 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -59,6 +59,7 @@ modules.order
>  /vmlinux-gdb.py
>  /vmlinuz
>  /System.map
> +/System.map.no_namespaces
>  /Module.markers
>  /modules.builtin.modinfo
>
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index e083bcae343f..602e1af072c7 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -39,7 +39,13 @@ if $depmod_hack_needed; then
>         KERNELRELEASE=99.98.$KERNELRELEASE
>  fi
>
> -set -- -ae -F System.map
> +# Older versions of depmod do not support symbol namespaces in ksymtab entries,
> +# hence create an alternative System.map with namespace patched out to use for
> +# depmod. I.e. transform entries as follows:
> +#    __ksymtab_NAMESPACE.symbol_name -> __ksymtab_symbol_name
> +sed 's/__ksymtab_.*\./__ksymtab_/' System.map > System.map.no_namespaces

So people with old kmod will have to know they need to pass
System.map.no_namespaces rather than the usual
System.map. Also, distros will need to be update to also copy the new
file to the kernel package (or upgrade/patch kmod).

I'd rather maintain the current format and fix the bug that patch is
fixing. The namespace
in the end IMO is just a small annoyance with a reason to  exist.

Lucas De Marchi

> +
> +set -- -ae -F System.map.no_namespaces
>  if test -n "$INSTALL_MOD_PATH"; then
>         set -- "$@" -b "$INSTALL_MOD_PATH"
>  fi
> --
> 2.23.0.581.g78d2f28ef7-goog
>


-- 
Lucas De Marchi
