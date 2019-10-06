Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594EFC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D862053B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gZhGFaql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfJFSLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:11:44 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39567 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfJFSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:11:44 -0400
Received: by mail-ua1-f65.google.com with SMTP id b14so3401102uap.6;
        Sun, 06 Oct 2019 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xcfn+mZQOdodoxT/uHR1Hwqp6+VxlnUjvQrMHa6gp6I=;
        b=gZhGFaqlLzCZJc2zYB7x8xXP5V8WJopVAlPrzohOA6Pk6+VCeJM92yej0SJ2a0lEK2
         lBRhQX8hYIH6XeC4F/z8NYRkOKuXgCyzI2MfkBS4SMZ0hUur21UQ7xqZYt1hZI1twk7y
         gxzmwTWN+FX0t3rUijC/j1/Qiv6PS4QkwyXsAzDwM7fak5n+9RoV4R8R8XHp5+8F1wKR
         amXAQG3zoUvol7YOSWTLB9P7HAWHGyHdmxZygvdeXtrKy8yEdepFeMgkHsE4xTPVFA1D
         ZCMOiMEajGQs9N1f4MWDav4c56wwCVwHyfZEnFxVK9WP70A21v9T7u6l88WcuWMJRDjR
         G/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xcfn+mZQOdodoxT/uHR1Hwqp6+VxlnUjvQrMHa6gp6I=;
        b=NRyFnfXgeROZ8MzKcbpQoPif2EBXRvPtrTXwE+jg+a5DoPOEU//4DvsqjYaTGw2HAQ
         a8ef9ibDYTk3FmOZHh0/+mf8Ze99WaHPyWvH/c9HLh6CZpl5oNMf7/TtlmpwNv8JDW8O
         7xTSt0Hio+iBZvy0MXUAFFBp0wEJCC6i1+dODF+mg6ER1krk6+7ARDxX4NV4XdOIV25C
         FtOamyKtxZm6VETlMRR+oXNN04cwQDjGMRDOa2VB8TdEz9drluPUXJTZBRehBsPEajIz
         5r7+UnyGxyP3C+8vTQKxSHgQyFoLZtItHNULNzh4U7RxqBZ2KMk27xhbx2vNZillanTI
         Mu7w==
X-Gm-Message-State: APjAAAV87Kf8PRSLf04jF043MiP6zff96mc9Z0v4PN30iVIe6I6xPaIg
        MjrVH0SA74xmsGbsEcMwTr5sUmEbI9qPAUm4yuw=
X-Google-Smtp-Source: APXvYqylU/ZkQfIOgZq0eNMmCo/0/P6+jwQADlHqVpyb73E8Di8YyHYTBuaT8mNG4ZKt+wIgHxE6QjZp2lENpRvcVbc=
X-Received: by 2002:a9f:21f6:: with SMTP id 109mr1391780uac.109.1570385503167;
 Sun, 06 Oct 2019 11:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191006163314.23191-1-aford173@gmail.com> <20191006163314.23191-2-aford173@gmail.com>
In-Reply-To: <20191006163314.23191-2-aford173@gmail.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Sun, 6 Oct 2019 20:11:32 +0200
Message-ID: <CAGm1_kuoZ_sMDut7X_BGycsPYnb7J3K8_RWw+FdTJcYjCPjtrA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] serial: 8250_omap: Fix gpio check for auto RTS/CTS
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vignesh R <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 6:33 PM Adam Ford <aford173@gmail.com> wrote:
>
> There are two checks to see if the manual gpio is configured, but
> these the check is seeing if the structure is NULL instead it
> should check to see if there are CTS and/or RTS pins defined.
>
> This patch uses checks for those individual pins instead of
> checking for the structure itself to restore auto RTS/CTS.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Yegor Yefremov <yegorslists@googlemail.com>

> ---
> V2:  Made the NULL dererence check from patch 1/2 come before this.
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c68e2b3a1634..836e736ae188 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -141,7 +141,7 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
>
>         serial8250_do_set_mctrl(port, mctrl);
>
> -       if (!up->gpios) {
> +       if (!mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS)) {
>                 /*
>                  * Turn off autoRTS if RTS is lowered and restore autoRTS
>                  * setting if RTS is raised
> @@ -456,7 +456,8 @@ static void omap_8250_set_termios(struct uart_port *port,
>         up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
>
>         if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW &&
> -           !up->gpios) {
> +           !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS) &&
> +           !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_CTS)) {
>                 /* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
>                 up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
>                 priv->efr |= UART_EFR_CTS;
> --
> 2.17.1
>
