Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0DCCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66CF21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOzu1xpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504871AbfJRHwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:52:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37867 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504842AbfJRHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:52:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so3353621pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jw+08rzVC/fHmnAThtEG2Qn+9HpheDHbFDslHO0mM5s=;
        b=tOzu1xpQvcr+wlJB6e8SwG8mmKso4P72iSeuBgY++OZXvMAmZFa89z6Hf+aPNZM8Ap
         umcy7LAvWc2FgwikUUx/st0ZcciaeTL81mofdlXMZlO+UAOZJ/rF1Hm5hI6BElMWLFcr
         GU2SoY3EW/u5pJRZkH797fvH0imvhbdzLM4wJutliRygOMZrM1ebLtM/aH+0pxj2oQRV
         CI329+fNPf8THkoqFIGOB45uqZhvFSsfhUTiMecuuKzP5DTB80tZj2bYhRvVWqj6dEKP
         rdoj1JvRwfpWaYMuBh2RQy8GdVlagHJ1t9+jJXuaQtWqTrkePGEmOFO+TAW/Y1EFr852
         qNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jw+08rzVC/fHmnAThtEG2Qn+9HpheDHbFDslHO0mM5s=;
        b=iOadZLthxWrtZh/1HsloPXSBJZtXfER0V9R3UgO/b94nyQQq33yv9ANnXyfX6gosM7
         jwaZDk2suCdyrb4hDgC4wY5WTHCZBTZcferi9+EcUvfYghWrXDejNCrxVHi3f+VWDYYN
         Pku72Ich9nKhbCZw78dLAy4YT3g40cAQ/5SkEqiFM3K1Ruwfur3uG3W2DgtRRyb/EbSj
         4icoqEE+Q9pEQ7pkcrRb4qx8ItDmERrzBYnjQikNlICHt2S9WqPY2l95xGqFnFs0sn7X
         xbCkcGwtATvecRi7pc11kbyz0624eGXxdBLKaOR8dnerZR/p4TbR+3lZa9/qoYqjf/mz
         mcTw==
X-Gm-Message-State: APjAAAWA483gWqfrxuJ7PESWwD3iCcRlIGnOwFVWwkFsrWjMEzSXgNYj
        NfWypsQgq/j5FZHW3mAYNdavsENcw50ggMWtG+8=
X-Google-Smtp-Source: APXvYqzc+ObLIA1pu/S/QFwSmNmEUQqDxP7yFfotnuqM8I5bDa5Qha8Z6q6EuI6vmxn8O4As86q341tXKQpk3FvwyRw=
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr9761480pjr.132.1571385125585;
 Fri, 18 Oct 2019 00:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com> <20191018031850.48498-19-wangkefeng.wang@huawei.com>
In-Reply-To: <20191018031850.48498-19-wangkefeng.wang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 10:51:55 +0300
Message-ID: <CAHp75VesP5qfk3r2o-R+OuBE1DA0-24ZGNgmAaSkfPiUjFAQDQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/33] platform/x86: asus-laptop: Use pr_warn instead
 of pr_warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:19 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Corentin Chary <corentin.chary@gmail.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/platform/x86/asus-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index fc6446209854..a666fbc2e73b 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1148,7 +1148,7 @@ static void asus_als_switch(struct asus_laptop *asus, int value)
>                 ret = write_acpi_int(asus->handle, METHOD_ALS_CONTROL, value);
>         }
>         if (ret)
> -               pr_warning("Error setting light sensor switch\n");
> +               pr_warn("Error setting light sensor switch\n");
>
>         asus->light_switch = value;
>  }
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
