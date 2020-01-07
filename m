Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD9C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B385F2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578394040;
	bh=lx0N24QV2sC8n2uwTIpJFQ48++uOCaPRG7lhAflolis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2UpRHy7QSb0hFnXL0sKb4NoUQG61XuNkBYf+h+2cL6gkb8cOD2Owu7aWEPjpsSBZJ
	 zsp76GpQvNvf/eDsW9kbq3CSV0KnKzfRR3HTqILc5QF9ty6YjsnGadg5SCKrLdnfL8
	 eoAmJFxTseLj48LP0bsRoo7Ucn/pn5R24rZBGqv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgAGKrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:47:20 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:54127 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:47:19 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 007Al5UM008952;
        Tue, 7 Jan 2020 19:47:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 007Al5UM008952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578394026;
        bh=OYNGV4JvNCCmwqcWZMh74h89ilsmJbXDDxowiwIXyfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oNK6akEl9+VaXgqOCIv/Yj2Hy8K2Vx0Wx+KeZOq59aU0cZ6OMr0JOelff7VugJ5b3
         0r0+Qx4v32juhRTUdXsZIYHq9hIzbPchR9qxN/DoZV4xiQNqSD4kRH8XVd54tUUFz1
         SFxuprGGx2J88DumBZx1xmBauZV7L3gdij8tvM8MdW+XiJMzZjIHJFpT9dI482S0So
         JVUIGQM+arnEzliiA5WJNvMnGD4XyRjaVzMN92w9kl8NEZ/Lkv1hUh8TMXgNBkdVCU
         YraJUL3NiUEqk3SVQrpujf+d/zfWlYuZ1EqMOXJD+lDrKwPqEPBBiUepV8UrSiq0AX
         2VVxwVH7dY92g==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id g15so33605107vsf.1;
        Tue, 07 Jan 2020 02:47:06 -0800 (PST)
X-Gm-Message-State: APjAAAUhyRPPYKq+Wv//NWSvpX2rE1mVlm0l+dtKgFI7LfQFAmjRG1BT
        2gAaxukJd/J7Oc60GqCvJzjL/CBxgZuhfEP1SDU=
X-Google-Smtp-Source: APXvYqz9JS/aZkeux6B8QGJdYFwEGdW/zjyZwos0iNnJPfN/UBIsyusPgdvKO47WfxbRljnG2ie6qxkRvLPTPhcDl0s=
X-Received: by 2002:a05:6102:190:: with SMTP id r16mr54996236vsq.215.1578394025191;
 Tue, 07 Jan 2020 02:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20200104150238.19834-1-masahiroy@kernel.org> <20200104150238.19834-2-masahiroy@kernel.org>
In-Reply-To: <20200104150238.19834-2-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Jan 2020 19:46:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+SfvRRu=WHzh6eghBNusMiEaxuqj0L+5jnA0W=HOy+Q@mail.gmail.com>
Message-ID: <CAK7LNAS+SfvRRu=WHzh6eghBNusMiEaxuqj0L+5jnA0W=HOy+Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] initramfs: replace klibcdirs in Makefile with FORCE
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC: Ben Hutchings, H. Peter Anvin)

On Sun, Jan 5, 2020 at 12:03 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> 'klibcdirs' was added by commit d39a206bc35d ("kbuild: rebuild initramfs
> if content of initramfs changes"). If this is just a matter of forcing
> execution of the recipe line, we can replace it with FORCE.
>
> I do not understand the purpose of
>
>    $(deps_initramfs): klibcdirs


Perhaps, the 'klibcdirs' target might be intended
to control the directory descending
in case klibc is dropped in the kernel tree.

Anyway, klibc is built independently
of Linux kernel, and this 'klibcdirs' target
is just a no-op stub as far as the kernel tree is concerned.

Clean it up.


> Remove it.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - New patch (I forgot to submit this in v1 series)
>
>  usr/Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/usr/Makefile b/usr/Makefile
> index e6f7cb2f81db..55c942da01cd 100644
> --- a/usr/Makefile
> +++ b/usr/Makefile
> @@ -3,9 +3,6 @@
>  # kbuild file for usr/ - including initramfs image
>  #
>
> -klibcdirs:;
> -PHONY += klibcdirs
> -
>  suffix_y = $(subst $\",,$(CONFIG_INITRAMFS_COMPRESSION))
>  datafile_y = initramfs_data.cpio$(suffix_y)
>  datafile_d_y = .$(datafile_y).d
> @@ -50,13 +47,12 @@ targets := $(datafile_y)
>  # do not try to update files included in initramfs
>  $(deps_initramfs): ;
>
> -$(deps_initramfs): klibcdirs
>  # We rebuild initramfs_data.cpio if:
>  # 1) Any included file is newer than initramfs_data.cpio
>  # 2) There are changes in which files are included (added or deleted)
>  # 3) If gen_init_cpio are newer than initramfs_data.cpio
>  # 4) Arguments to gen_initramfs.sh changes
> -$(obj)/$(datafile_y): $(obj)/gen_init_cpio $(deps_initramfs) klibcdirs
> +$(obj)/$(datafile_y): $(obj)/gen_init_cpio $(deps_initramfs) FORCE
>         $(Q)$(initramfs) -l $(ramfs-input) > $(obj)/$(datafile_d_y)
>         $(call if_changed,initfs)
>
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
