Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4655C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45E42145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlBPvlGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfGOUgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:36:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39976 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbfGOUgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:36:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so17613705lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2Dnxb2ns6xhEs9ebe85/XBNTscvREDwZrH85VfP+g0=;
        b=VlBPvlGu2PgZxgv6ta6aut6KF0nQGbi1u6jjNATnVkQJ1iCQIpVTClPnc1UQhiJ2Ph
         MTqXGZiONw8zUZ4ZzXj9qIsIwAdJ5QRdm1vU/6p9WUyRfgBSZQZ4PqJR+XTcs9f3W0we
         j8aSLMeRF1CuhnEgciNBw5S+9nu71pLJXWgkAny7Kh/ku987MUW3ypEGR04IsTWhG2Wx
         a4WRjgMfbqxuNU4ZdeKXF4hidIW5zO72icBLjclFBAawGPKcB6M8uR7ZgskMOJDZjK2Z
         Vafbdx3moO3D5Q6c84CDj4hFpXhL1Xe3cDLsNQEYM9fZ82YwYL5m5BjhoTY/Sxp6S1L2
         d2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2Dnxb2ns6xhEs9ebe85/XBNTscvREDwZrH85VfP+g0=;
        b=bmFhZBs62ieAOc3y6uy59zjtrsSZTrvIcZqbIMljvhdYpHMeL7b8r3geUGS4SkOoSk
         QMU699i44z9yQAN3orAfQETdACeKKB0oidJZlr8A33kYY3GF1jWEnOuxpSI1QoeHXbBO
         LfYY/ySeCj/gDglkFX55I5KicCH4OfPyPD2rXxtDE3ojfxHFbOGJ35/Aq+JJM5ibEIIK
         QB8+vdhT/72j9oED0Zn0idijdmyeUn3F2u+0HQmdw8+oapxQ/EdYT/TzCnK9se8CeAb5
         8W22kWPIcY5d9+hWnLhTj2sO8HyNTVnb1QCnTVMxe4DVf3mwV/gorlhdJS43DIIAR8Fa
         o6dw==
X-Gm-Message-State: APjAAAXrc2WcqOEDqvB+K7RAtQZEZPXE8bXv65YOaZolPQQiG1nsMNP/
        KDeNmfoMj5gMvskTQF41yhyQhYZWutp76dCYNa7VzA==
X-Google-Smtp-Source: APXvYqwREjbA8VK0ftOGlkm4hSR26WLhAC+bf/M1wq9gN8iee0N6YxAzGgqTOUVxwTDkOVRm/XCm3sPwj0OkDsxALOo=
X-Received: by 2002:a2e:98d7:: with SMTP id s23mr14805474ljj.179.1563222993638;
 Mon, 15 Jul 2019 13:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190715191804.112933-1-hridya@google.com>
In-Reply-To: <20190715191804.112933-1-hridya@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 15 Jul 2019 13:36:22 -0700
Message-ID: <CAHRSSEwUJvO-iG6D-w8RUCi9S+iBRrX9pN3oJ=SbcHLHd0b74A@mail.gmail.com>
Subject: Re: [PATCH] binder: prevent transactions to context manager from its
 own process.
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:18 PM Hridya Valsaraju <hridya@google.com> wrote:
>
> Currently, a transaction to context manager from its own process
> is prevented by checking if its binder_proc struct is the same as
> that of the sender. However, this would not catch cases where the
> process opens the binder device again and uses the new fd to send
> a transaction to the context manager.
>
> Reported-by: syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com
> Signed-off-by: Hridya Valsaraju <hridya@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index e4d25ebec5be..89b9cedae088 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3138,7 +3138,7 @@ static void binder_transaction(struct binder_proc *proc,
>                         else
>                                 return_error = BR_DEAD_REPLY;
>                         mutex_unlock(&context->context_mgr_node_lock);
> -                       if (target_node && target_proc == proc) {
> +                       if (target_node && target_proc->pid == proc->pid) {
>                                 binder_user_error("%d:%d got transaction to context manager from process owning it\n",
>                                                   proc->pid, thread->pid);
>                                 return_error = BR_FAILED_REPLY;
> --
> 2.22.0.510.g264f2c817a-goog
>
