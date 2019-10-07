Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4E8C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5DE21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="PmV+hGbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfJGJeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:34:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44589 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfJGJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:34:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id q12so3796893lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pW/v9rAZUFz/EoQTWrEX0OSxD6rEJBtSsejlmsLkopw=;
        b=PmV+hGbVTsXwOx8ggwlU7N7+Z/R0TZ8g/q9zQs7etcACngKWx7QjRF/8Se581PyHZo
         u3fYJ1mAIOm7+YB2mk5oZtKwfXOzhWYHNQUKWRoa97aoIfbHRSJ4JxWzPsYymBurA3Mi
         Oey+WAMkyy36ll1cVpLCpGcSQZH9vSct27qk350b9oa3xb4SAw8nI0aGFKQbv4dAnZaU
         2dg4S56+G5bSvHXcin4rivmXG1Djkk1+V+vy6gok2S/UekWotIujENAlroppSFUkFuIF
         h+zbfpWdH9XV6tq2lk0V6AGe4oaDPsONzIUv1pWUqfTutbr7YH0TJ6MZq9mrxXVeDA6v
         8USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pW/v9rAZUFz/EoQTWrEX0OSxD6rEJBtSsejlmsLkopw=;
        b=b7rPIIXWxHrI8xCjHZoie7K/Sk4+daND0/k2+DaweZMcnRb4LZaV4TfbEDuLMcLbcX
         pVbPmHvSLSnVkP6ziMty+99xOWD7XO1SWQmm+omeLCBbyAf9AxR0Pw4TE4JTlFRpvI0p
         59872xOWG0xoL5S3BMhsrKd4j1iGV3f0J5nGS0pxzhepuRTfrV/caGi0xLVn8+771iH+
         gWMZKix8bpw7PdYXkD045SU1/tzEdNYFPWNgUxBUkhHkaMdCkNzIoxW0/NHDDA70xbIv
         2qGwh1shWcxeSo0/0QlY9/2d5yYVwbHMxKJYwAn3DiDDCjKM0tFWSrA+n53XmUGFiwqV
         BLug==
X-Gm-Message-State: APjAAAXnKc4NhrPYWBKuYx+H0dYMDdrWE33UUHQACGtR0GR9DGz2Bv0L
        A8BBjL4v5kU29pdl2i5lcxX30JsNWcEKDAP7Z1tn3g==
X-Google-Smtp-Source: APXvYqxqDny/0zgM/+tgxZ/E60Ozfjkfc7OLYNZZbgTXgeXtW8BH3ZhM+bjalWIqj/Sw5sCvH+97gPy9f+DdcOaWjsk=
X-Received: by 2002:a19:f617:: with SMTP id x23mr15911101lfe.97.1570440844243;
 Mon, 07 Oct 2019 02:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191006172016.873463083@linuxfoundation.org> <20191006172018.480360174@linuxfoundation.org>
In-Reply-To: <20191006172018.480360174@linuxfoundation.org>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 7 Oct 2019 11:33:53 +0200
Message-ID: <CAB0TPYGO8Nm_Qz0kzSvX69NApiPwu4xV19F=KhyLe5DO3DoLTw@mail.gmail.com>
Subject: Re: [PATCH 4.9 30/47] ANDROID: binder: remove waitqueue when thread exits.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Mattias Nissler <mnissler@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 7:23 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Martijn Coenen <maco@android.com>
>
> commit f5cb779ba16334b45ba8946d6bfa6d9834d1527f upstream.
>
> binder_poll() passes the thread->wait waitqueue that
> can be slept on for work. When a thread that uses
> epoll explicitly exits using BINDER_THREAD_EXIT,
> the waitqueue is freed, but it is never removed
> from the corresponding epoll data structure. When
> the process subsequently exits, the epoll cleanup
> code tries to access the waitlist, which results in
> a use-after-free.
>
> Prevent this by using POLLFREE when the thread exits.
>
> Signed-off-by: Martijn Coenen <maco@android.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: stable <stable@vger.kernel.org> # 4.14
> [backport BINDER_LOOPER_STATE_POLL logic as well]
> Signed-off-by: Mattias Nissler <mnissler@chromium.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/android/binder.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -334,7 +334,8 @@ enum {
>         BINDER_LOOPER_STATE_EXITED      = 0x04,
>         BINDER_LOOPER_STATE_INVALID     = 0x08,
>         BINDER_LOOPER_STATE_WAITING     = 0x10,
> -       BINDER_LOOPER_STATE_NEED_RETURN = 0x20
> +       BINDER_LOOPER_STATE_NEED_RETURN = 0x20,
> +       BINDER_LOOPER_STATE_POLL        = 0x40,
>  };
>
>  struct binder_thread {
> @@ -2628,6 +2629,18 @@ static int binder_free_thread(struct bin
>                 } else
>                         BUG();
>         }
> +
> +       /*
> +        * If this thread used poll, make sure we remove the waitqueue
> +        * from any epoll data structures holding it with POLLFREE.
> +        * waitqueue_active() is safe to use here because we're holding
> +        * the inner lock.

This should be "global lock" in 4.9 and 4.4 :)

Otherwise LGTM, thanks!

Martijn

> +        */
> +       if ((thread->looper & BINDER_LOOPER_STATE_POLL) &&
> +           waitqueue_active(&thread->wait)) {
> +               wake_up_poll(&thread->wait, POLLHUP | POLLFREE);
> +       }
> +
>         if (send_reply)
>                 binder_send_failed_reply(send_reply, BR_DEAD_REPLY);
>         binder_release_work(&thread->todo);
> @@ -2651,6 +2664,8 @@ static unsigned int binder_poll(struct f
>                 return POLLERR;
>         }
>
> +       thread->looper |= BINDER_LOOPER_STATE_POLL;
> +
>         wait_for_proc_work = thread->transaction_stack == NULL &&
>                 list_empty(&thread->todo) && thread->return_error == BR_OK;
>
>
>
