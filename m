Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD90C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 13:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743ED21743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 13:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkvPoGww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfHJNSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 09:18:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40674 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJNSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 09:18:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so47209590pgj.7;
        Sat, 10 Aug 2019 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NvrY3qoVddy+LNcxJ9KyKM2rwocIx782phIQYmB54w=;
        b=pkvPoGww5akaFsUTObfrSMZfcG0CeAPquUlg8ix66+R5WB3SmUwE/Qloyvvk2VJI35
         2Pbf9sQu7sg+Ivvm32S7RiTSaTs5CZ/s5r0FcR8YrX3P8y5N3yshy5VRp5FS+o5CPOMs
         wJCTT8nA1aPv/X2ZJ5gpIvEpLLvNGKlQX3dVM4CF1N2sJrglvxbP0PcrmJdCzV5Xf30E
         su8PV05h61oBKtCDxVjhgWdt+f4Q7iS8C8Hna/D1krN9QF12imA59oYlxQXrOOc3UIs+
         9PPaVsNFSZxUFuesN8iIwJtffY1UQ+mh32tnhXFRG00i6mI2MMAgO2Putn4hn8+hkD2i
         Q+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NvrY3qoVddy+LNcxJ9KyKM2rwocIx782phIQYmB54w=;
        b=q0+5ImoImkuypBLihme7OmPzO5CSuSRkPu4LAy5F1bieG0JVJjnOH7/YoUJ4znf4Ph
         vOyo7z5G/PSr75myHcYJKr9fFTrfQm40C8A/c3jvt6Yjos8sUvX+tXwj1m9w8z9D2Hyd
         65nQ2UhMALToI/1F7jY5p8xJCsNz8l/YHLgMCOpuCeAhwENYI7s+MI+YbcOYDOqVs4+R
         ZMNBfJAG9dyPb2ssUXK6+XLRllIsiGjtAw7DREQiHZ954J5RILOsiLEBx1au7u3NObC3
         7OJmtFED3bFnipW68z2ObmIRHLOj/5WdMxYkyKbDAxPsS1djb5lr+8routm7pWOdqa9x
         e40Q==
X-Gm-Message-State: APjAAAWmRJ/SlWwvwLgeGfUYbwJI8h7TtIQmQsp+V6VALGm10pV+fblJ
        NPitIgE6tnbks3RaXgnuVfiZBk6PQsEotnLM2Uc=
X-Google-Smtp-Source: APXvYqyznzrfX8U9AuOajf53ORRoK9sgkeoRzvEnFmkMHwqNSJnAjRiC2qta8jmYmhRtONZBSBnC+mpwyqtTwDro0jo=
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr14583634pjb.20.1565443092952;
 Sat, 10 Aug 2019 06:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190809190130.30773-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190809190130.30773-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 10 Aug 2019 16:18:01 +0300
Message-ID: <CAHp75VeGs8K+da+4CaqNjm_ci86KoLcmhY8GaJO7jm__J0TcSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Add support for Sunix serial boards
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Morris Ku <morris_ku@sunix.com>,
        Debbie Liu <debbie_liu@sunix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 10:05 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Add support to Sunix serial boards with up to 16 ports.
>
> Sunix board need its own setup callback instead of using Timedia's, to
> properly support more than 4 ports.
>

Can you, please, split out the Sunix quirk driver to a separate module
(see examples like: 8250_exar, 8250_lpss, 8250_mid)?
And then with a fewer LOCs add a new boards.

> Cc: Morris Ku <morris_ku@sunix.com>
> Cc: Debbie Liu <debbie_liu@sunix.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  use div64_s64() instead of do_div()
>
>  drivers/tty/serial/8250/8250_pci.c  | 93 +++++++++++++++++++++++------
>  drivers/tty/serial/8250/8250_port.c |  8 +++
>  include/uapi/linux/serial_core.h    |  3 +
>  3 files changed, 87 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 7f740b37700b..b2a5c2228858 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1692,6 +1692,30 @@ pci_wch_ch38x_setup(struct serial_private *priv,
>         return pci_default_setup(priv, board, port, idx);
>  }
>
> +static int
> +pci_sunix_setup(struct serial_private *priv,
> +               const struct pciserial_board *board,
> +               struct uart_8250_port *port, int idx)
> +{
> +       int bar;
> +       int offset;
> +
> +       port->port.flags |= UPF_FIXED_TYPE;
> +       port->port.type = PORT_SUNIX;
> +
> +       if (idx < 4) {
> +               bar = 0;
> +               offset = idx * board->uart_offset;
> +       } else {
> +               bar = 1;
> +               idx -= 4;
> +               idx = div_s64_rem(idx, 4, &offset);
> +               offset = idx * 64 + offset * board->uart_offset;
> +       }
> +
> +       return setup_port(priv, port, bar, offset, 0);
> +}
> +
>  #define PCI_VENDOR_ID_SBSMODULARIO     0x124B
>  #define PCI_SUBVENDOR_ID_SBSMODULARIO  0x124B
>  #define PCI_DEVICE_ID_OCTPRO           0x0001
> @@ -2289,21 +2313,14 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
>                 .setup          = pci_timedia_setup,
>         },
>         /*
> -        * SUNIX (Timedia) cards
> -        * Do not "probe" for these cards as there is at least one combination
> -        * card that should be handled by parport_pc that doesn't match the
> -        * rule in pci_timedia_probe.
> -        * It is part number is MIO5079A but its subdevice ID is 0x0102.
> -        * There are some boards with part number SER5037AL that report
> -        * subdevice ID 0x0002.
> +        * Sunix PCI serial boards
>          */
>         {
>                 .vendor         = PCI_VENDOR_ID_SUNIX,
>                 .device         = PCI_DEVICE_ID_SUNIX_1999,
>                 .subvendor      = PCI_VENDOR_ID_SUNIX,
>                 .subdevice      = PCI_ANY_ID,
> -               .init           = pci_timedia_init,
> -               .setup          = pci_timedia_setup,
> +               .setup          = pci_sunix_setup,
>         },
>         /*
>          * Xircom cards
> @@ -2757,6 +2774,11 @@ enum pci_board_num_t {
>         pbn_pericom_PI7C9X7952,
>         pbn_pericom_PI7C9X7954,
>         pbn_pericom_PI7C9X7958,
> +       pbn_sunix_pci_1s,
> +       pbn_sunix_pci_2s,
> +       pbn_sunix_pci_4s,
> +       pbn_sunix_pci_8s,
> +       pbn_sunix_pci_16s,
>  };
>
>  /*
> @@ -3494,6 +3516,31 @@ static struct pciserial_board pci_boards[] = {
>                 .base_baud      = 921600,
>                 .uart_offset    = 0x8,
>         },
> +       [pbn_sunix_pci_1s] = {
> +               .num_ports      = 1,
> +               .base_baud      = 921600,
> +               .uart_offset    = 0x8,
> +       },
> +       [pbn_sunix_pci_2s] = {
> +               .num_ports      = 2,
> +               .base_baud      = 921600,
> +               .uart_offset    = 0x8,
> +       },
> +       [pbn_sunix_pci_4s] = {
> +               .num_ports      = 4,
> +               .base_baud      = 921600,
> +               .uart_offset    = 0x8,
> +       },
> +       [pbn_sunix_pci_8s] = {
> +               .num_ports      = 8,
> +               .base_baud      = 921600,
> +               .uart_offset    = 0x8,
> +       },
> +       [pbn_sunix_pci_16s] = {
> +               .num_ports      = 16,
> +               .base_baud      = 921600,
> +               .uart_offset    = 0x8,
> +       },
>  };
>
>  static const struct pci_device_id blacklist[] = {
> @@ -4532,17 +4579,29 @@ static const struct pci_device_id serial_pci_tbl[] = {
>                 pbn_b0_bt_1_921600 },
>
>         /*
> -        * SUNIX (TIMEDIA)
> +        * Sunix PCI serial boards
>          */
>         {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
> -               PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
> -               PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00,
> -               pbn_b0_bt_1_921600 },
> -
> +               PCI_VENDOR_ID_SUNIX, 0x0001, 0, 0,
> +               pbn_sunix_pci_1s },
>         {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
> -               PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
> -               PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
> -               pbn_b0_bt_1_921600 },
> +               PCI_VENDOR_ID_SUNIX, 0x0002, 0, 0,
> +               pbn_sunix_pci_2s },
> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
> +               PCI_VENDOR_ID_SUNIX, 0x0004, 0, 0,
> +               pbn_sunix_pci_4s },
> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
> +               PCI_VENDOR_ID_SUNIX, 0x0084, 0, 0,
> +               pbn_sunix_pci_4s },
> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
> +               PCI_VENDOR_ID_SUNIX, 0x0008, 0, 0,
> +               pbn_sunix_pci_8s },
> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
> +               PCI_VENDOR_ID_SUNIX, 0x0088, 0, 0,
> +               pbn_sunix_pci_8s },
> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
> +               PCI_VENDOR_ID_SUNIX, 0x0010, 0, 0,
> +               pbn_sunix_pci_16s },
>
>         /*
>          * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index c1cec808571b..8900112ed232 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -308,6 +308,14 @@ static const struct serial8250_config uart_config[] = {
>                 .rxtrig_bytes   = {1, 4, 8, 14},
>                 .flags          = UART_CAP_FIFO,
>         },
> +       [PORT_SUNIX] = {
> +               .name           = "Sunix",
> +               .fifo_size      = 128,
> +               .tx_loadsz      = 128,
> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> +               .rxtrig_bytes   = {1, 32, 64, 112},
> +               .flags          = UART_CAP_FIFO | UART_CAP_SLEEP,
> +       },
>  };
>
>  /* Uart divisor latch read */
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 3cc3af1c2ee1..055626ca0a40 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -290,4 +290,7 @@
>  /* SiFive UART */
>  #define PORT_SIFIVE_V0 120
>
> +/* Sunix UART */
> +#define PORT_SUNIX     121
> +
>  #endif /* _UAPILINUX_SERIAL_CORE_H */
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
