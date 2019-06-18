Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AABDC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA8920823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dnubXJRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfFRH3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:29:14 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35563 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:29:14 -0400
Received: by mail-ua1-f66.google.com with SMTP id r7so4918857ual.2;
        Tue, 18 Jun 2019 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxJ79RvfS8xTGGHk3lU4pCRiaPbdWZEeJRdyViiST9Q=;
        b=dnubXJRQK3hiDpYMMshy/4fyXtHs7/S0ZGAGDAGYh0FpnxP5Ef0E25m2fT824ceKaJ
         z0IfmZF+piRaLFkFiVG7Sbm8doRzrs/pF4j+QrWmWyuT9LrhCxUDtpFjiP7hXWcbT5VS
         fWAuIfbKX1AHuqbqet6ihdgMTR0pSnUCImXE6QTn9yBZnJ+Nz9JnLPsY0UFsC2sdGn6p
         6/FFTl3Itg0m7AgUKAVVpw/pTrfCVe5BYIojn/xawjROF/xiGt3TR68rF4g1/k63m9mw
         ovhUFsUYLthzj7WAAAetSRH0rEWmKVhkVs3S05O7YrT69OiFGgdhPEDhtgXY97QkjDes
         PROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxJ79RvfS8xTGGHk3lU4pCRiaPbdWZEeJRdyViiST9Q=;
        b=pz/RlifiohNcPd0SqZ8Rqt7MG6n7G1PtBNsmYODgHhnv16g3Iysc7zeoCLR6TKq6SM
         sHdjslK9+OiVFrgcCNfl406SeKytHNoDM09bwnd9hipGcVNb1+ERJ+syC1MW1ePf1n89
         1bjadL3C2ss2OBjdiW96NsrEfRTLSdWstHjNpGidsv2bH5LD9QTvGcvupZHOEp3r+ENC
         loespQKYWwVUKPSk1g01bKgpPn3y9NHSfeU8vd5k7w0aqnIo9vamGiz49tGCenhTqvMr
         E0hM+CEfWaGR1cGP8MBY/QVMKXJvSifjfJLh55JqO5GJD7FdWvbZmbmfGwBLKI3GgZqN
         gtBQ==
X-Gm-Message-State: APjAAAX9J6Xn4Wrd6dJ8UWW9Myo4aV8TW8yhtyHunSdvnMCaQYU8N5p5
        BycOkMvWU5EzH9M/5Tp/hJsYsQsPXYOpijcwOza2ifeO
X-Google-Smtp-Source: APXvYqxorcYultTz4itoFc8m0921L8vUBqKJGeuSj5YuKrfjjuCJ7Nz9OgTyWLfKoXnLhfahBnbbfdDEyE9ic/BoWXc=
X-Received: by 2002:a05:6102:8c:: with SMTP id t12mr23010808vsp.143.1560842952991;
 Tue, 18 Jun 2019 00:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190617145952.4848-1-sr@denx.de> <20190617145952.4848-2-sr@denx.de>
In-Reply-To: <20190617145952.4848-2-sr@denx.de>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Tue, 18 Jun 2019 09:28:47 +0200
Message-ID: <CAGm1_kv6_NZZtR=66A+jKxtJoxt7nDaNrMF8C7Of1u3wcC0gWw@mail.gmail.com>
Subject: Re: [PATCH 2/3 v7] serial: 8250: Add MSR/MCR TIOCM conversion wrapper functions
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 4:59 PM Stefan Roese <sr@denx.de> wrote:
>
> This patch adds wrapper functions to convert MSR <-> TIOCM and also
> MCR <-> TIOCM. These functions are used now in serial8250_do_set_mctrl()
> and serial8250_do_get_mctrl().
>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>

Tested-by: Yegor Yefremov <yegorslists@googlemail.com>

> ---
> v7:
> - No change
>
> v6:
> - New patch
>
>  drivers/tty/serial/8250/8250.h      | 54 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c | 25 ++-----------
>  2 files changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index ebfb0bd5bef5..793da2e510e0 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -139,6 +139,60 @@ void serial8250_rpm_put_tx(struct uart_8250_port *p);
>  int serial8250_em485_init(struct uart_8250_port *p);
>  void serial8250_em485_destroy(struct uart_8250_port *p);
>
> +/* MCR <-> TIOCM conversion */
> +static inline int serial8250_TIOCM_to_MCR(int tiocm)
> +{
> +       int mcr = 0;
> +
> +       if (tiocm & TIOCM_RTS)
> +               mcr |= UART_MCR_RTS;
> +       if (tiocm & TIOCM_DTR)
> +               mcr |= UART_MCR_DTR;
> +       if (tiocm & TIOCM_OUT1)
> +               mcr |= UART_MCR_OUT1;
> +       if (tiocm & TIOCM_OUT2)
> +               mcr |= UART_MCR_OUT2;
> +       if (tiocm & TIOCM_LOOP)
> +               mcr |= UART_MCR_LOOP;
> +
> +       return mcr;
> +}
> +
> +static inline int serial8250_MCR_to_TIOCM(int mcr)
> +{
> +       int tiocm = 0;
> +
> +       if (mcr & UART_MCR_RTS)
> +               tiocm |= TIOCM_RTS;
> +       if (mcr & UART_MCR_DTR)
> +               tiocm |= TIOCM_DTR;
> +       if (mcr & UART_MCR_OUT1)
> +               tiocm |= TIOCM_OUT1;
> +       if (mcr & UART_MCR_OUT2)
> +               tiocm |= TIOCM_OUT2;
> +       if (mcr & UART_MCR_LOOP)
> +               tiocm |= TIOCM_LOOP;
> +
> +       return tiocm;
> +}
> +
> +/* MSR <-> TIOCM conversion */
> +static inline int serial8250_MSR_to_TIOCM(int msr)
> +{
> +       int tiocm = 0;
> +
> +       if (msr & UART_MSR_DCD)
> +               tiocm |= TIOCM_CAR;
> +       if (msr & UART_MSR_RI)
> +               tiocm |= TIOCM_RNG;
> +       if (msr & UART_MSR_DSR)
> +               tiocm |= TIOCM_DSR;
> +       if (msr & UART_MSR_CTS)
> +               tiocm |= TIOCM_CTS;
> +
> +       return tiocm;
> +}
> +
>  static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
>  {
>         serial_out(up, UART_MCR, value);
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 2304a84eee3b..47f0a8d01a57 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1944,22 +1944,12 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
>  {
>         struct uart_8250_port *up = up_to_u8250p(port);
>         unsigned int status;
> -       unsigned int ret;
>
>         serial8250_rpm_get(up);
>         status = serial8250_modem_status(up);
>         serial8250_rpm_put(up);
>
> -       ret = 0;
> -       if (status & UART_MSR_DCD)
> -               ret |= TIOCM_CAR;
> -       if (status & UART_MSR_RI)
> -               ret |= TIOCM_RNG;
> -       if (status & UART_MSR_DSR)
> -               ret |= TIOCM_DSR;
> -       if (status & UART_MSR_CTS)
> -               ret |= TIOCM_CTS;
> -       return ret;
> +       return serial8250_MSR_to_TIOCM(status);
>  }
>  EXPORT_SYMBOL_GPL(serial8250_do_get_mctrl);
>
> @@ -1973,18 +1963,9 @@ static unsigned int serial8250_get_mctrl(struct uart_port *port)
>  void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>         struct uart_8250_port *up = up_to_u8250p(port);
> -       unsigned char mcr = 0;
> +       unsigned char mcr;
>
> -       if (mctrl & TIOCM_RTS)
> -               mcr |= UART_MCR_RTS;
> -       if (mctrl & TIOCM_DTR)
> -               mcr |= UART_MCR_DTR;
> -       if (mctrl & TIOCM_OUT1)
> -               mcr |= UART_MCR_OUT1;
> -       if (mctrl & TIOCM_OUT2)
> -               mcr |= UART_MCR_OUT2;
> -       if (mctrl & TIOCM_LOOP)
> -               mcr |= UART_MCR_LOOP;
> +       mcr = serial8250_TIOCM_to_MCR(mctrl);
>
>         mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
>
> --
> 2.22.0
>
