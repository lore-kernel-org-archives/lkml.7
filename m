Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97373C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695172082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duz81vOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfEPOw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:52:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34336 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfEPOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:52:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so2348673wrt.1;
        Thu, 16 May 2019 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=novTqX8VvyU0HXZyZbhAxQptriFkKNdmf0KSk9TZzOw=;
        b=Duz81vOL3a+Ms57KLi31wimSiefhtpZHyZ3ftpLvkBDZ2hPQt5xdsAw5jPh3gMw4i6
         RYrHuknu9z4Rsy4VzsQeFvsMomSRdfNup2H0Xh80xnRvAisrraeJHqPkDEmOkdBPANQt
         Ty0YuUjtrxkZ+sTNzT57666ht00QA3SglQpY13pLiM5VBWYfCQcw6grU8OAQS4X+OthZ
         qZUBypk9Xx6x8i8NVI8Wi5TbK0XzB7OdNmQCu2KmLG6PEioGTr6MjHfbjUddEhGAH03N
         3kTN89jUtvFFT3N8gi6k5iVGNGIVkkqxLtd0XR1Y9F9MvdZu9yeuS3tcBRijwxiRcjXp
         9DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=novTqX8VvyU0HXZyZbhAxQptriFkKNdmf0KSk9TZzOw=;
        b=YRRBIY/T3+rkaA2Iiaskm0OwDoLhST5qY+0YX0ABb0ZqFyioDZ1Uzg/SwXyeBtJW1m
         DWraoV0qjqLVHj+BxeUi58hu9KBQfa/oWR3AB00ZLJtwbnmYvNp5PdrD+Mfuznmkqj5c
         mPMfyItzUAq43I3g16Gvr4n16mmM9AGd3QU7hQmzrCBQSCJ+U4VQCidNQkWy+/xZoG9A
         lfrRjMOqr0BkqW4vWYsnWaAHTjj9rJqEw4vJ/P5ZOn2l4nSpvG3h2balODsPHPhJNbY0
         O6Qx6e61GV0x2u9Ki7e4DcCXH359O9qaADsxztSV9PqO3ccUcEBXUIux1B2SKEhfZXbX
         w+yg==
X-Gm-Message-State: APjAAAV7g5vRC5NEbVxEdLMA2wKF/XPIejryFA+kVR5Bny1HhQU826D3
        unqcib+1OfrKjrb/hiwuLaPQik1KJJB3lO06HiU=
X-Google-Smtp-Source: APXvYqzKo9qM1ZH0hfE3YV+GVvhhregyfQ4zzLWVl9mchehCFapJcFXkOhjF34o/FqFXL8uhGkgf9xIbxO+yJhGhviE=
X-Received: by 2002:adf:9023:: with SMTP id h32mr19240055wrh.95.1558018343668;
 Thu, 16 May 2019 07:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190516040931.16276-1-yuehaibing@huawei.com>
In-Reply-To: <20190516040931.16276-1-yuehaibing@huawei.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Thu, 16 May 2019 20:22:12 +0530
Message-ID: <CAKfKVtG5zKZDGK68pY9t1Xupr-Ak+bWK0jRBwxCZ2e=TG8NEpA@mail.gmail.com>
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jacmet@sunsite.dk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,
Thanks for the patch.

On Thu, May 16, 2019 at 9:42 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> If ulite_probe is not called or failed to registed
s/registed/register
> uart_register_driver, unload the module will call
> uart_unregister_driver, which will tigger NULL
s/tigger/trigger
> pointer dereference like this:
>
> BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
> Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246
>
> CPU: 0 PID: 4246 Comm: syz-executor.0 Tainted: G         C        5.1.0+ #26
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  dump_stack+0xa9/0x10e
>  ? tty_unregister_driver+0x19/0x100
>  ? tty_unregister_driver+0x19/0x100
>  __kasan_report+0x171/0x18d
>  ? tty_unregister_driver+0x19/0x100
>  kasan_report+0xe/0x20
>  tty_unregister_driver+0x19/0x100
>  uart_unregister_driver+0x30/0xc0
>  __x64_sys_delete_module+0x244/0x330
>  ? __ia32_sys_delete_module+0x330/0x330
>  ? __x64_sys_clock_gettime+0xe3/0x160
>  ? trace_hardirqs_on_thunk+0x1a/0x1c
>  ? trace_hardirqs_off_caller+0x3e/0x130
>  ? lockdep_hardirqs_off+0xb5/0x100
>  ? mark_held_locks+0x1a/0x90
>  ? do_syscall_64+0x14/0x2a0
>  do_syscall_64+0x72/0x2a0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> This patch fix this by moving uart_unregister_driver
> to ulite_remove.
>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/tty/serial/uartlite.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index b8b912b..2e49fb6 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>         pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       uart_unregister_driver(&ulite_uart_driver);
>         return rc;
>  }
>
> @@ -897,7 +898,6 @@ static int __init ulite_init(void)
>  static void __exit ulite_exit(void)
>  {
>         platform_driver_unregister(&ulite_platform_driver);
> -       uart_unregister_driver(&ulite_uart_driver);
>  }
>
>  module_init(ulite_init);
> --
> 1.8.3.1
>
>
