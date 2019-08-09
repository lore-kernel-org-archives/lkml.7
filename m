Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96226C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6907D2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qngOGQfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406234AbfHIKwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:52:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45855 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:52:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so2708458plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9HDsquoQnWGY2Yw3Kfkbv6/ZXNBRqTo9t134alaPj8=;
        b=qngOGQfQjxY/kQfpIY54hOjEIf3tZ3RdUiL3zMJy1sXKBCGvHAwMV77/zSr6OseuHH
         NCQY9YekeTxtA3sRqLLk/PzUAL9ZcMcdH/rjT2+m5qzNLjIc8Fe3knqniVrjM85oprhM
         pHNbqTrEkV6oMe5vzR0CKZ12zJ/tXPd9dNNJgM+gedyoWoKmJ2LfiHt80re5u5p+tUjS
         xLDPsrUqzpZN0xvyq5V6+dGnl5rVx+/gaJl61AxaqNKHr6DZVdShFqID/nFZnJLifr8+
         0JrGkiJQ0xHgriTrK1viaMh+QpwtOPaTTW22WjXbVlOMpQBh3E9hVUoH8nxwoP+XP4of
         wKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9HDsquoQnWGY2Yw3Kfkbv6/ZXNBRqTo9t134alaPj8=;
        b=f2j+JZ8tP5RL9/028s5JMcTLamwqVwi0HavyBcmykF7SHsuM7pSGWob5ampe0JKJZU
         O3la9xarY1TRxFOPBLdKuoP+GYBZVjUpepNCUehMe6+uWcgA4X5RfPaQfQigDfW6xfrJ
         WDiU4I7Ch/BCELly5ZctnIAHXIdsYCEbchQR0yH+2n0fLVZlWyTvoD/hCP3Zx8CT95LQ
         oTq/sg4n3HccSHlTBGdwTb71MZq+iqGm3LFHrSl6sYZAHYOwDBdjCDVMx2V7N7xkTxHy
         7mnEs4yvt4UKAEBeedPUejMJsg/PgFOPCpbh0nUUbP09CWyeaMNRids26n163mfIv+Zd
         FkQw==
X-Gm-Message-State: APjAAAWE/NjFVEJoftMZs4OfI+4/2BFTHJtCck3DdkxWRfTyLnn4PsuE
        q6MoLvjnvDTkA4ILAVhDxEOYERauuEPWMB+UXoc=
X-Google-Smtp-Source: APXvYqygiOlPOQ2p3gIb9pbDZ+zj2E5cQdy7bzL7DE12niRJnkmYdVsEbo7PlsV9AxFvHnRzoWFV1zytAAPmfE61mXs=
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr18174157plp.262.1565347928212;
 Fri, 09 Aug 2019 03:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190809012457.56685-1-justin.he@arm.com>
In-Reply-To: <20190809012457.56685-1-justin.he@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Aug 2019 13:51:57 +0300
Message-ID: <CAHp75VcR1rJ5AX_Nj3n2NnMasLRp74Y3R6Mh4XQ5s64aKrF6tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vsprintf: Prevent crash when dereferencing invalid
 pointers for %pD
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 4:28 AM Jia He <justin.he@arm.com> wrote:
>
> Commit 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid
> pointers") prevents most crash except for %pD.
> There is an additional pointer dereferencing before dentry_name.
>
> At least, vma->file can be NULL and be passed to printk %pD in
> print_bad_pte, which can cause crash.
>
> This patch fixes it with introducing a new file_dentry_name.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Perhaps you need to add a Fixes tag

> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  lib/vsprintf.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 63937044c57d..b4a119176fdb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -869,6 +869,15 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
>         return widen_string(buf, n, end, spec);
>  }
>
> +static noinline_for_stack
> +char *file_dentry_name(char *buf, char *end, const struct file *f,
> +                       struct printf_spec spec, const char *fmt)
> +{
> +       if (check_pointer(&buf, end, f, spec))
> +               return buf;
> +
> +       return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> +}
>  #ifdef CONFIG_BLOCK
>  static noinline_for_stack
>  char *bdev_name(char *buf, char *end, struct block_device *bdev,
> @@ -2166,9 +2175,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>         case 'C':
>                 return clock(buf, end, ptr, spec, fmt);
>         case 'D':
> -               return dentry_name(buf, end,
> -                                  ((const struct file *)ptr)->f_path.dentry,
> -                                  spec, fmt);
> +               return file_dentry_name(buf, end, ptr, spec, fmt);
>  #ifdef CONFIG_BLOCK
>         case 'g':
>                 return bdev_name(buf, end, ptr, spec, fmt);
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
