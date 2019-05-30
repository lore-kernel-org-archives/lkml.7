Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD0BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9376C25A3D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA9bA+qW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfE3ONc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:13:32 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42179 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfE3ONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:13:32 -0400
Received: by mail-yb1-f195.google.com with SMTP id c7so702642ybs.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYJPRskixwn1nFPNV2wbt36LZ1ahlZ4OUxU9DsdvakQ=;
        b=rA9bA+qWjeYMvUekVTww//KlxVzlp/lmiBQ0SfyqIX/VLdFSNCXP38de2h9355NuVD
         ny4cdDMmCaTNXv4aonL8PkiCqH69daWrUkkJm5XRDO5GccDjB+Ds5PLeq2BMpcK6e3FZ
         ilBB7du8Z8YVnievNdukT1liMNkKtDYx5+XnrASMQxnNmFuiEC4GQU8kPOF+EJ5eT7no
         p2Sabns5mZbI+9LEbz2/Rhluk186KFEmcQGlwyEGjlargIb+o3xxL8hNDhjWrZmJYD/q
         8/hVXe3tZEmERQo+Vo7v5+n1DoDopc7KEFssE6GtYrbCLVfG6qtKnNKus79azZlOBwxB
         mzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYJPRskixwn1nFPNV2wbt36LZ1ahlZ4OUxU9DsdvakQ=;
        b=GcuIiztfcoIxqQkY1RXKium4g3YvI3MNBaUlBKSyIVvFz3YdN6/H8mjyTkX8bnYSHW
         3903i1N5fCGNJ5bQ7IA831iU9xkPAW+b/IzNpP0vpEKSwWMQLdmZ4le+ZFNq0CVnRaaG
         3PJreALfa55I0aOCgHsqRz1ccdFh9DfEV+sUMJQTBl+y6iY8wwnykCZK7euE2pEyxUmk
         tvVcK7s3RYtnQ0TsBzzaGvdz5m6F011YDOPVMsuwSitebUpJv3xjawKf9xyYSatDGKCY
         zOkoXqgS2CLzVjdKuBps82K2sWiQ4DGGUq0bvTzc6nIHD3qaTu3iDWaLF2x2wnjEpSss
         niww==
X-Gm-Message-State: APjAAAX+QSYow/aXO5qxQTv4xhF3/gFGvhaRL3Ja+krcoqqn9CuNBJeY
        KGMjzGHh3aM8imYFD0UKWRoP1ycOBpkWLk1SxnA=
X-Google-Smtp-Source: APXvYqyCsM/g4pEb9OIeM3Fv7ATI5xHJ5TOzuLvLBOO1HxB0g0rtYiBAKsDnN69WyJUMfi7ULBCsKNHW5D9Ad1zt6Mo=
X-Received: by 2002:a25:1f42:: with SMTP id f63mr1589876ybf.25.1559225611715;
 Thu, 30 May 2019 07:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <1559220098-9955-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1559220098-9955-1-git-send-email-linux@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 30 May 2019 07:13:20 -0700
Message-ID: <CAMo8Bf+m-a5YEubQMxuZuF0_-hZCop2F-+nomd7ELjz8SQToXg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Fix section mismatch between memblock_reserve and mem_reserve
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Thu, May 30, 2019 at 5:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Since commit 9012d011660ea5cf2 ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING"), xtensa:tinyconfig fails to build with section
> mismatch errors.
>
> WARNING: vmlinux.o(.text.unlikely+0x68): Section mismatch in reference
>         from the function ___pa()
>         to the function .meminit.text:memblock_reserve()
> WARNING: vmlinux.o(.text.unlikely+0x74): Section mismatch in reference
>         from the function mem_reserve()
>         to the function .meminit.text:memblock_reserve()
> FATAL: modpost: Section mismatches detected.
>
> This was not seen prior to the above mentioned commit because mem_reserve()
> was always inlined.
>
> Mark mem_reserve(() as __init_memblock to have it reside in the same
> section as memblock_reserve().
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/xtensa/kernel/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thank you for this fix! Applied to my xtensa tree.

-- 
Thanks.
-- Max
