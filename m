Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B104CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C89D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TnzD6LOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfJVJc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:32:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38537 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVJc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:32:56 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so19541880iom.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p6B5vIq4mBCEi2j6VspXkHH98NRmRELS3pKey0pcg9A=;
        b=TnzD6LOK7P2cm5iTTfxxd8SPWst7kL9joiV3t5ft/tKMF5foCxZLRbKa4F5aRkxz2i
         DQJUNzvTCXWpjTuunUPGnVQZpLIVL2wj5To4595cjUa81Gwm4BEo6XFYoKNB7liyhmLE
         F1HJchnDcQ25TY39p4HEskEy+oJRzXgCunSObjsyrNorFkTpVRzADJDjvJZ6ImiNCryI
         VY5P+Mw4BAcehGCbz/KSaQXlNsyBZXPgdb5vfT7x9+/A0urnbxf8/qqXbkE/usv5PTWo
         IWrMmHooqxXW7MR0cX7qBVJXCAOy4+j/k4sOcTf+DNZxB6YkUTcCuK6uuijUWKbScAub
         yFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p6B5vIq4mBCEi2j6VspXkHH98NRmRELS3pKey0pcg9A=;
        b=YsSkElVW5g3+oJYUxk+/Kh7FMMwNEgENC8suSDQKh1on70V8cECEv3XlWL6lhxqpBd
         2l41tVfsZgoRHzMFeWyBfoH/9CjbuggFTF+zdKzTQgkv/n0axZC1ZUg+GZuVY74GfB4s
         +DrZp481AyxctkFsqE4WYPln2btHjk11R9/ryv/tswl+SGRduudCK+Jn5aIMrfjrDtyf
         5MntzkF3Tc1MYdC+9Er8w4Kvkv1aRdrBWZT3XVebZYdBQiQjV04AZ1OEnWo+2tEdAQH9
         Ds1wqVexOXeE98+ntuQCUmg7D9eiXFpv05DEsRBz7BTqVKIRJLJ7RL3JZBJnNSlV9KhM
         mwbA==
X-Gm-Message-State: APjAAAXz4FzkuLR4QiyFlg1zMqCqikGisApc8GQM6mtwHBmFbhOJDxgE
        eJflEXomMmn8iXhBuSQLfsDgkRMqW2yyczhUY67/MQ==
X-Google-Smtp-Source: APXvYqz2/snQXHiOFBHAJHp4uTYsYA49vZLl9SSWul/3XwSH9uBc4EiHcU7yJIzgHgu1vrDGv/JFbkX6SHqYPhpPGDA=
X-Received: by 2002:a02:920f:: with SMTP id x15mr2782918jag.57.1571736774365;
 Tue, 22 Oct 2019 02:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191021202626.5246-1-navid.emamdoost@gmail.com>
In-Reply-To: <20191021202626.5246-1-navid.emamdoost@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 22 Oct 2019 11:32:43 +0200
Message-ID: <CAMRc=MfpS+iTmoey0mSjH63Cm_fgfqjdebd07HY522bGcZv6dA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/davinci: Fix memory leak in davinci_timer_register
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 21 pa=C5=BA 2019 o 22:26 Navid Emamdoost <navid.emamdoost@gmail.com>
napisa=C5=82(a):
>
> In the impelementation of davinci_timer_register() the allocated memory
> for clockevent should be released if request_irq() fails.
>
> Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clocke=
vents")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/clocksource/timer-davinci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/ti=
mer-davinci.c
> index 62745c962049..910d4d2f0d64 100644
> --- a/drivers/clocksource/timer-davinci.c
> +++ b/drivers/clocksource/timer-davinci.c
> @@ -299,6 +299,7 @@ int __init davinci_timer_register(struct clk *clk,
>                          "clockevent/tim12", clockevent);
>         if (rv) {
>                 pr_err("Unable to request the clockevent interrupt");
> +               kfree(clockevent);
>                 return rv;
>         }
>
> --
> 2.17.1
>

Any failure in this driver means the system is fried. I explicitly
didn't bother freeing any resources. Nack.

Bart
