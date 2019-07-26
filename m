Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5428AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD8422BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdzKnBbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfGZD4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:56:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45282 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZD4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:56:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so23795827pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 20:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2ixpnnhJdbF/TFE1cgm/Jip2PWsYGdR7zCTnF/foik=;
        b=JdzKnBbxX3fk7ToB/YhvmQEkrZoCOKo5DjMS4ZsbOGC5leke9OPQts5nbPLHmA6OPe
         eCbSfIXbhxOlfZagoH0cKM9Yh/y2lBRUl+ievyQyAZMdLJCKWyTJSDy2DwzU00eb/fzs
         iJVE3qMtPdq8D71bncxnpHaypE84XWyTN1dMm19t4/XyVIlYplOqbt3xFFLlP+78wIUf
         YTmuN8J5PIDvciU0sE1qYv+JNnVXoxcENOhAXF3e/pOZwUIZgH4goNV5Pl6DZAsrjWH1
         lSYjZQfGXdA8j2hTpPNoHw9gpawc1UQd5KbFALsC0qU+yF+ezGBsfrxNRfvYolpf0VWY
         H1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2ixpnnhJdbF/TFE1cgm/Jip2PWsYGdR7zCTnF/foik=;
        b=fQyIYB+/8/1GZhCbpyszWWckbxko87hUfi5yoegfoUoDhWWKiwa8qN1f1j2SSKnimT
         jbnk/ro+CZ4K3IBI83gSQvCkAY4gaoAoNlXN0NseNYnWjZ3eghbhvyQC+AKb4Y3/crpm
         nNWkB2rkp95nY2iU1T06qX0Ptm3PGTCGV3sOV0oAv6DAfKJQHJbWY9GR29k1kdoL3juA
         7ZDVhWrqkbI0pOI/dvMm1TaJWIiXtIL6fCekRQjt1nxepjp7w9baeiYg1bh1tgJhlY6q
         FVFTpk+u4UjfeeO2P8m504COciZmKJJ+whxpYBM44n4QPkXy/NCU4/GXlrExS4GYgXhB
         wTAA==
X-Gm-Message-State: APjAAAWOhW7CYDp7ZtLLgYHt4wxj/+MwKUFKrV4AHbfTdYRUEa0yN3SZ
        zD0wN7hM1S/qL4pWPTnnJlfRhu9l44pQ11d646FIufqeKEo=
X-Google-Smtp-Source: APXvYqwrh91kLPy8p8fpsH2g14+xbrorindSIEuFuMyx/vFTsiJsXYuRJneF0Ewmg7jjG0SSdzKcN5jt0mWNqGVRJKo=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr96679291pjs.73.1564113388994;
 Thu, 25 Jul 2019 20:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190724002233.9813-1-k0ma@utam0k.jp>
In-Reply-To: <20190724002233.9813-1-k0ma@utam0k.jp>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Jul 2019 20:56:17 -0700
Message-ID: <CAKwvOdk6ENe-K3V67rt26L8HOn7xMpueBwZgg=+r5LM4XrN6PA@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: Add compilation database file
To:     Toru Komatsu <k0ma@utam0k.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 5:22 PM Toru Komatsu <k0ma@utam0k.jp> wrote:
>
> This file is used by clangd to use language server protocol.
> It can be generated at each compile using scripts/gen_compile_commands.py.
> Therefore it is different depending on the environment and should be
> ignored.
>
> Signed-off-by: Toru Komatsu <k0ma@utam0k.jp>

Thank you again for this patch.  We're working on adding clang-tidy
checks for the Linux kernel, which will make use of this file soon.
Keep yours eyes out for it!
https://reviews.llvm.org/D59963
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 8f5422cba6e2..2030c7a4d2f8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -142,3 +142,6 @@ x509.genkey
>
>  # Kdevelop4
>  *.kdev4
> +
> +# Clang's compilation database file
> +/compile_commands.json
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
