Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0163C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9237B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfCUIxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:53:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40652 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:53:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id w20so7629042qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98wt+YTrvd1eKLD0hqnsTV6MTBgHxu0nC2CNk4qhnXA=;
        b=MKbx0UmbADlfYnmwLtw2RCWQP8gNJ6Qw6x2ycWNaMht8TDDHBivnSwAZ5FYlcVXXdj
         NmENLYNPDDCLCmhmrm89Z3d2dAtr8FqEGG4G80GRWYre0s7yf+h7KfitpDcAT9m0u/Qq
         e2NEvy95422lhyRkM0xGhZG+vehTFhAh0N9itsF4zVBauyzM+LhGfqo2blJA2tbctpSL
         saT9VI33c3RJYy0pN6YgBzYYDBkcWnlbl1CEgnLzxzEo5II5iI9sOBdm1pre6miS0asy
         U5vFuzOE2GeKG6dLCgxgH9qb9Ip2Zecw8a8AGR5aTEvsIHG+UuQJdywpZxH3De4il5Rp
         BBbw==
X-Gm-Message-State: APjAAAWQAtmZSHy9GtiON9sp/ep5M7bu4ohH3Bqpxn8K2rYyiW3uO8mw
        /XQ1FaC0ZRnadh3RjQZgwJNV8WkaR87LjoM1cxo=
X-Google-Smtp-Source: APXvYqwoMcE8obj5TrB3qXUUyZ3SS5DBfmlRgZqicbWWGMmWXomphe59gPETWBL62bzaGy6YM/k7wfadU8Ey9eNmsBA=
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr1685694qkj.173.1553158411305;
 Thu, 21 Mar 2019 01:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190315100614.25027-1-saumah@gmail.com> <ef1abb26-4c88-1b11-da25-f6891bee0e21@metux.net>
In-Reply-To: <ef1abb26-4c88-1b11-da25-f6891bee0e21@metux.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Mar 2019 09:53:14 +0100
Message-ID: <CAK8P3a1TkKtG3E3U0xxpJrf=qph0dkn27Apd99EaHMAPOfPtpw@mail.gmail.com>
Subject: Re: [PATCH] Respond:add support for SUNIX Multi-I/O board
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Morris Ku <saumah@gmail.com>, gregkh <gregkh@linuxfoundation.org>,
        morris_ku@sunix.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 7:24 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 15.03.19 11:06, Morris Ku wrote:
> > +Oh, is there really a hard restriction on the max number of boards ?
> > +
> > +driver support maximum 4 boards can be installed incombination
> > +(up to 32 serial port and 2 parallel port)
>
> Could somebody install more than 4 boards in a machine ?
>
> Is there any problem w/ having this data allocated per board,
> associating it to the corresponding struct device instance ?
>
> You do know that - when using probe'able bus'es (eg. PCI) - the kernel
> automatically creates device instances (per card) for you ? You just
> have to register a driver w/ a table of the supported device IDs, and
> the kernel will instantiate a device for you, finally calling the
> probe() function to do the actual initialization.
>
> For PCI, an easily understandable example could be pata_cmd640.c.
> The other bus'es work in a similar way, even platform devices (those
> which usually aren't on a probe'able bus) when using oftree or acpi.

I think serial port drivers typically have a limit on the number of
ports, so we likely need the same here. However the number of
boards should not be limited in the mfd driver that just exports
the serial ports to the serial driver.

Similarly, there should be no limit for the parallel port driver and
the gpio driver.

> > +> +static int snx_ser_port_total_cnt;
> > +> +static int snx_par_port_total_cnt;
> > +> +
> > +> +int snx_board_count;
> > +> +
> > +> +static struct snx_ser_driver sunix_ser_reg = {
> > +> +     .dev_name = "ttySNX",
> > +> +     .major = 0,
> > +> +     .minor = 0,
> > +> +     .nr = (SNX_SER_TOTAL_MAX + 1),
> > +> +};
> > +
> > +can't this be const ?
> > +
> > i prefer keep it in current format.
>
> Why ? do you ever have to write into this struct ?

I think this will just go away after the rewrite into a proper
layered driver, so it doesn't matter.

> > +<snip>
> > +
> > +> +     if ((sb->par_port > 0) && (sb->par_isr != NULL)) {
> > +> +             pp = &sunix_par_table[sb->par_port_index];
> > +> +
> > +> +             if (!pp)
> > +> +                     status = 1;
> > +> +
> > +> +             status = sb->par_isr(sb, pp);
> > +> +     }
> > +> +
> > +> +     if (status != 0)
> > +> +             return handled;
> > +> +
> > +> +     handled = IRQ_HANDLED;
> > +> +     return handled;
> > +> +}
> > +
> > +btw: is there only one irq per board or one per port ?
> > +
> > only one irq per board.
>
> That is very unfortunate. if there was one per port, you could register
> one handler per port and let the kernel directly route to the right port
> instance. (see above: let it directly pass the pointer to the port data)
>
> Are there other devices on the board that share the same irq ?

The best way I can think of to do this would be to have a nested
irqchip in the mfd driver that handles the per-board interrupt and
provides a unique irq number to the individual port drivers.
This makes a very simple irq handler in the port driver, and keeps
the multiplexing where it belongs.

> > +if it already is a global, why not statically initialized ?
> > +Why not doing this in snx_pci_probe() on per-board basis, and let device
> > +registration be done by pci subsystem ?
> > +
> > i prefer keep it in current format.
>
> See above: when probing on per board-basis, the pci subsystem already
> handles most of the stuff for you, and the driver becomes smaller and
> easier to understand.

Agreed, this is only correct way to do it.

       Arnd
