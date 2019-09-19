Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8194C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7295B218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCrPP6Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfISDVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:21:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46114 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfISDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:21:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so1956788ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 20:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SheHqmoXK4AdV5+vGmfATk2h64jzJnZ57gWh81c0NIc=;
        b=gCrPP6Fi5BklCd9AKcjCVM7EBrpNx5SlsnmQGIp1P5koL0rb9UcNwK95nWP1y0/6Oe
         qCcJr79PsfvUx5xaitoNXSEKiHAATB1qAh0Gc4uJokW5rTvyUoZO9P4GawTXM/hZfLaq
         ZQc8Nj0W01J1XuW8r3GTpNuzaCvW9bHbIxJUla/9EiXQcRAR+Icg6269/UNb867+Yh/Y
         UXaesxXt5gVDY1UlscuveA7VExQGe+zCSXkhWe89LsHIvffVmklgoi6VS7MG5yHgzgJ4
         fk3l6hG5SwOIixgVGxxZleSPcMiAJTMFwQgYlXVYl4OS7ZeURWZFXKcS7Hy0mBxxfYzN
         FooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SheHqmoXK4AdV5+vGmfATk2h64jzJnZ57gWh81c0NIc=;
        b=Zc0ivFTMYvhRRi1bHDgZYuPocmJw7/Whw48E9GUnknOU5UsTDjtJ/1iZWu8grgGsoS
         vuMUtsFjGDsE4c9U4O/oetdZcmv3poLKIGS5rxpBvFWojiCt+tko249yQoEhzueSDmzr
         ig3Khl7MlqjGcvppwEZ9+lftSlxFYy7G25OJtqG4NpEvOWCiwM3EtS2Vh5IXsZBBC3eE
         73+SdHceUChi1es91jr5GzVMfMAd2TirP/klhHYkrPc6TyYsYBpz6+hmIQ7ZpVR0i8Cz
         UHVKKcHwEbGzUl8dDDmg33tw4fRIxiWO7MQ6phP7zSWP1RJrcKoE4QQMb+2/K4NlTRWp
         tq2A==
X-Gm-Message-State: APjAAAVlKkHJP6bNCONI2uFP2W0Orzr4Kvc0+N3cV+Tfik+mD78WDtP4
        i0r111UrrMnMxtIHX2LSsYbrm3+9vg64026v8lqaTw==
X-Google-Smtp-Source: APXvYqwWowghwYhIrQ1FL9lka2e20bcYcODgGLF0/fNEgTO9LPyh72qtAP4i4AVtgXcoxa+OQYS206XvZvV/c7fwuHk=
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr4034070ljj.142.1568863282258;
 Wed, 18 Sep 2019 20:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <f112a741c053ac5fb0637e2f058be81e17f78ccc.1568862391.git.liuhhome@gmail.com>
In-Reply-To: <f112a741c053ac5fb0637e2f058be81e17f78ccc.1568862391.git.liuhhome@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 19 Sep 2019 11:21:07 +0800
Message-ID: <CAMz4kuJzYa_4TsvgdWo4nZ9ReroEf9+LCqQh4DD5jO8jfSnf3w@mail.gmail.com>
Subject: Re: [PATCH v2] serial: sprd: Add polling IO support
To:     Lanqing Liu <liuhhome@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?B?5YiY5bKa5riFIChMYW5xaW5nIExpdSk=?= 
        <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Sep 2019 at 11:10, Lanqing Liu <liuhhome@gmail.com> wrote:
>
> In order to access the UART without the interrupts, the kernel uses
> the basic polling methods for IO with the device. With these methods
> implemented, it is now possible to enable kgdb during early boot over serial.
>
> Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
> ---
> Change from v1:
>  - Add poll_init() support.

Looks good to me and the KGDB can work well on my board, so feel free
to add my tags:
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/tty/serial/sprd_serial.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 73d71a4..d833160 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -911,6 +911,34 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
>         }
>  }
>
> +#ifdef CONFIG_CONSOLE_POLL
> +static int sprd_poll_init(struct uart_port *port)
> +{
> +       if (port->state->pm_state != UART_PM_STATE_ON) {
> +               sprd_pm(port, UART_PM_STATE_ON, 0);
> +               port->state->pm_state = UART_PM_STATE_ON;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sprd_poll_get_char(struct uart_port *port)
> +{
> +       while (!(serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK))
> +               cpu_relax();
> +
> +       return serial_in(port, SPRD_RXD);
> +}
> +
> +static void sprd_poll_put_char(struct uart_port *port, unsigned char ch)
> +{
> +       while (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
> +               cpu_relax();
> +
> +       serial_out(port, SPRD_TXD, ch);
> +}
> +#endif
> +
>  static const struct uart_ops serial_sprd_ops = {
>         .tx_empty = sprd_tx_empty,
>         .get_mctrl = sprd_get_mctrl,
> @@ -928,6 +956,11 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
>         .config_port = sprd_config_port,
>         .verify_port = sprd_verify_port,
>         .pm = sprd_pm,
> +#ifdef CONFIG_CONSOLE_POLL
> +       .poll_init      = sprd_poll_init,
> +       .poll_get_char  = sprd_poll_get_char,
> +       .poll_put_char  = sprd_poll_put_char,
> +#endif
>  };
>
>  #ifdef CONFIG_SERIAL_SPRD_CONSOLE
> --
> 1.9.1
>


-- 
Baolin Wang
Best Regards
