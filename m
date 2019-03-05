Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF89C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB4C20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCEIBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:01:31 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40192 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfCEIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:01:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so8085737qta.7;
        Tue, 05 Mar 2019 00:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKhbe60C0wirjNE5o0bqdU75fTBTp1R5NQugGO5JnjE=;
        b=fW9tZ/PbgHHa7jX+p2GkN0nxzhx3NX/V4OAo8fRwcL+N/2GSF7RnH0eEoBEbZfJRx3
         8R3x2tGjL4jfClctDmR61nq8207Z4xnO0yzBTjhyvD6JQDvZB1lMIXgkT5JIWpiNjE79
         gp5qHVuQc8fL0wOv0EYT1oP6WyPb8bxG04av/jDexCyiuT3S13/gdiNZ+ei8Jgb84AHo
         DQaKLg1AYA8mXKuycSR8EwmfyOum+goVwWXjW++IehSoaVrGwGqLrGIt4UZP3Bl8m/Rn
         QqRgeShLyxWQBeG64+FzzjsUzKljUk53pOJl6HzkIJ8eWcfEGb/zq/souteLIEDckOs4
         TmUw==
X-Gm-Message-State: APjAAAUGgeeCtEHSLsFInNCEb8+VoMshNJjPuF4Ddnp2XkkBXCNh2jrS
        8lOEgcX7nhoN3EuzCNpOICqwStBFCuQhN4sqQ0I=
X-Google-Smtp-Source: APXvYqy7q9l6qrpjo7S5rvtT3cJ6qPYReoNCFI2qXqaavDktMpwKMRD8d3Mz2rkyjWmF6VTZSl3Ida2RMI0n7NLJ9W4=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr441086qtb.343.1551772889379;
 Tue, 05 Mar 2019 00:01:29 -0800 (PST)
MIME-Version: 1.0
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com> <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 09:01:13 +0100
Message-ID: <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
Subject: Re: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        gregkh <gregkh@linuxfoundation.org>, Jeremy Kerr <jk@ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 10:37 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
> between the SOC (acting as a BMC) and a host processor in a server.
>
> This commit adds a driver to control the XDMA engine and adds functions
> to initialize the hardware and memory and start DMA operations.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Hi Eddie,

Thanks for your submission! Overall this looks well-implemented, but
I fear we already have too many ways of doing the same thing at
the moment, and I would hope to avoid adding yet another user space
interface for a specific hardware that does this.

Your interface appears to be a fairly low-level variant, just doing
single DMA transfers through ioctls, but configuring the PCIe
endpoint over sysfs.

Please have a look at the drivers/pci/endpoint framework first
and see if you can work on top of that interface instead.
Even if it doesn't quite do what you need here, we may be
able to extend it in a way that works for you, and lets others
use the same user interface extensions in the future.

It may also be necessary to split out the DMA engine portion
into a regular drivers/dma/ back-end to make that fit in with
the PCIe endpoint framework.

If you have already tried this without success, please let us
know in the description what problems you have hit, and why you
decided to create a new framework instead.

> +/*
> + * aspeed_xdma_op
> + *
> + * upstream: boolean indicating the direction of the DMA operation; upstream
> + *           means a transfer from the BMC to the host
> + *
> + * host_addr: the DMA address on the host side, typically configured by PCI
> + *            subsystem
> + *
> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
> + */
> +struct aspeed_xdma_op {
> +       __u8 upstream;
> +       __u64 host_addr;
> +       __u32 len;
> +} __packed;

Side-note: packed structures are generally not great user space
interfaces. Regardless of where we end up with this, I'd recommend
naturally aligning each member inside of the structure, and using
explicit padding here.


     Arnd
