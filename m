Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCEDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFC121920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kll2SosY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfIRMK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:10:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41830 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfIRMK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:10:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id r2so5491706lfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgsq7iFzYE3p4qDNyeZTJM4NoqtMyN3PGzAwf47vS5Y=;
        b=kll2SosYbc0+jOOjTIjs3nGzOgS353meTeCupvJ6SglAWgtWsbbUA5eVSM2H1IVJ17
         MGYEJWeLcMfWEnV+V9ZocM6AJwn0t3zCoS/TZH8ko4Sbkg7JtH+VxD2v4Dn+mktaxos0
         b78OYABpy7cExoY2lS6pVPRwDlTsVY2HmwGL9vkNSIXHaD+smxNe9UzrVJpftUwI72uv
         HnP5GT5NIMy7k2Swa1O0iIKObK61d1fBV60pHKZ/bxwRGdZe97x5yDOnx21vkjB0M5HD
         oYFEk4tlIIizwbfqM1dXcgSF8mrDF/uaJMRffm5TlIa1af5YPbqQ4GYBy/JEcb2rCjQM
         B5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgsq7iFzYE3p4qDNyeZTJM4NoqtMyN3PGzAwf47vS5Y=;
        b=eaLglMMrf10vtuCn8nQ91kkjYQMj22yaabR5npl3EhxcqYZ5e/FkQuzwUR9okMMzvn
         SmkbEzi94alGgJr5JsGl/MssojvZam9GtAAvjz4w3rwWJShRoh2uvyTQOKIznXXJg7Xu
         E242tFpqCGljetWTYjhB/hwr7r9qjX1+gI2wh5QOVtMzZN+jqyDGpwR8B3JJbAY2j+Mt
         gzChZhTm9DuxKAHqIT/SKkPz42D3Mzx5OZPgGcd+t2AFVgXJzjD7y58yfiRGgSOpKiX+
         RQPGU+K/JRRH+cNJ8NR8lyMqKQxs/YlNcGH+5T2oFQGJprd48gmmUJ7oJ/ynVwHHerUZ
         KjxA==
X-Gm-Message-State: APjAAAWyOUMMBqVOWJBtV+9XOi3Zge7yMh/gJ2ILQ5567TnsY2QUxm6I
        1f112dJFqRR6o4ThqqpB0CZyAUF5Hpvkcy7+3gHEMQ==
X-Google-Smtp-Source: APXvYqzCo4K57KXCvQEu7a2DuEENyDip3qHR7LfJn3E3cAkgXs50OhSYkam339Ci1qXPsZbmTEmm0tZkZ+VHelQdRjk=
X-Received: by 2002:a19:3f47:: with SMTP id m68mr1934908lfa.108.1568808625711;
 Wed, 18 Sep 2019 05:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <a634860d9194cc235298d6d8bbd2282bf6f853c4.1568793195.git.liuhhome@gmail.com>
In-Reply-To: <a634860d9194cc235298d6d8bbd2282bf6f853c4.1568793195.git.liuhhome@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 18 Sep 2019 20:10:14 +0800
Message-ID: <CAMz4kuLrAWDaZj2Am452BX+aVO0yCQB_cCiNUx4FAamoX6KWtA@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Add polling IO support
To:     Lanqing Liu <liuhhome@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        lanqing.liu@unisoc.com, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lanqing,

On Wed, 18 Sep 2019 at 16:16, Lanqing Liu <liuhhome@gmail.com> wrote:
>
> In order to access the UART without the interrupts, the kernel uses
> the basic polling methods for IO with the device. With these methods
> implemented, it is now possible to enable kgdb during early boot over serial.
>
> Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
> ---
>  drivers/tty/serial/sprd_serial.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 73d71a4..579ab41 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -911,6 +911,24 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
>         }
>  }
>
> +#ifdef CONFIG_CONSOLE_POLL
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

When I tested your patch, I found only one case can work if the port
used by KGDB is same with the port selected as console, which means
this port will be powered on all the time. We had implemented the
power management for the UART ports, so I think you should enable the
clock for the port used by KGDB in poll_init(), then other ports can
be used by KGDB.

> +
>  static const struct uart_ops serial_sprd_ops = {
>         .tx_empty = sprd_tx_empty,
>         .get_mctrl = sprd_get_mctrl,
> @@ -928,6 +946,10 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
>         .config_port = sprd_config_port,
>         .verify_port = sprd_verify_port,
>         .pm = sprd_pm,
> +#ifdef CONFIG_CONSOLE_POLL
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
