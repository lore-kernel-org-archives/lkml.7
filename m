Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B944BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3EB214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="evhYXQ5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfDRXWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:22:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42004 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfDRXWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:22:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so1853682pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 16:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=FVLlsVBKPfRjq0jz3LI4f04+gYbfn8cXwIMogPX32xQ=;
        b=evhYXQ5fBqxSR4sehMjQd7L5X9P3J7KRJIuRUk5gxs8gUehY7LtsDSRdSg5eP/qF4A
         HPGhSefwEF6AiA6g5y+nZ2LgwxbPS28plivV+DfnvKqfjU1ysjurFK0+B/fD75dwYsrr
         hyLP9secffcdXrJNb/ON43yVUHnIRVttxsMBE3qd/dKLYPoMaVaxSesO0perhH9CyMHJ
         8K8caq6gwG9vK7t8x8ZPisWMd8h+eXJHPyl+76ssye8LpqnlVeNZHvZFjq1Tw5VD5O/F
         8mmwaXLho70RQZqwyJXOCHUjD2nLRPxAhJ/kjn71kbOkXipjw5g8bLHkKPLc/6KMtR66
         uI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FVLlsVBKPfRjq0jz3LI4f04+gYbfn8cXwIMogPX32xQ=;
        b=YzAggucYmo/7f4/JS8ZrnzFtXwp6pfzk0gxadRUXMzQkQXO8SOG769LNKbQjuvVl5P
         OAhU+IMMcsgKpX8tm7zuT7MlP4CWdvb2KUFEgHqOlD7mzceV7AoSdDmW+7sBL+wPaYz7
         ydNUHa4BeY3Nbvp2rkAOy/ZQG349dLKV2AlwDFvH6WIMYLG9hqp/Hb1RSSVofZg9rxJo
         57N2C/fkkiwHAu8PQvhBQHSc1fbksU29NQAQAmtNOYQvOQe1D7WE5VG+dDHev1IyRRBE
         ycwt6WVOvVmA3Z7u2bR0VF1ddxNQEC4wJ8yHeOUnc4JqY5DMg4IWEZbXkNbBiK7FDwKV
         I+9Q==
X-Gm-Message-State: APjAAAXo6GyYVFKbkFH4wYi4NZEPKGE+tozE5cxJkiy+SSmJJUF8DAK7
        BReEBjzSGVbHK6pXZDIwCF3LTA==
X-Google-Smtp-Source: APXvYqwSc0ZjKg1lhYfbFqOHu7X2yRH9Qj7zgZy8PMqw8Y0aNFP9SQGDlwEy4sOf3BTTbxu7BaHwjg==
X-Received: by 2002:a63:4644:: with SMTP id v4mr657735pgk.422.1555629754415;
        Thu, 18 Apr 2019 16:22:34 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:9c06:6f96:9c41:be05])
        by smtp.googlemail.com with ESMTPSA id h4sm3112858pgv.61.2019.04.18.16.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 16:22:33 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 0/2]  tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
In-Reply-To: <20190413020111.23400-1-paul.walmsley@sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
Date:   Thu, 18 Apr 2019 16:22:32 -0700
Message-ID: <7hmukmew5j.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Walmsley <paul.walmsley@sifive.com> writes:

> This series adds a serial driver, with console support, for the
> UART IP block present on the SiFive FU540 SoC.  The programming
> model is straightforward, but unique.
>
> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
> open-source FSBL (with appropriate patches to the DT data).
>
> This fifth version fixes a bug in the set_termios handler,
> found by Andreas Schwab <schwab@suse.de>.
>
> The patches in this series can also be found, with the PRCI patches,
> DT patches, and DT prerequisite patch, at:
>
> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4

I tried this branch, and it doesn't boot on my unleashed board.

Here's the boot log when I pass the DT built from your branch via
u-boot: https://termbin.com/rfp3.

I also tried the same thing, but using the DT that's hard-coded into
SBI/u-boot.  That doesn't boot fully either[1], but one thing I noted is
that with the DT from the kernel tree, the printk timestamps aren't
moving.  Maybe I'm still missing some kconfig options to enable the
right clock and/or IRQ controllers? I'm using this fragment[2] on top of
the default defconfig (arch/riscv/configs/defconfig).

Could you share the defconfig you're using when testing your branch?

Also for reference, I'm able to successfully build/boot the
5.1-rc1-unleashed branch from Atish's tree[3] using that kconfig
fragment[2] (and the hard-coded DT from u-boot/SBI).  Full log here[4].

Thanks,

Kevin

[1] https://termbin.com/wuc9
[2]
CONFIG_CLK_SIFIVE=y
CONFIG_CLK_SIFIVE_FU540_PRCI=y

CONFIG_SERIAL_SIFIVE=y
CONFIG_SERIAL_SIFIVE_CONSOLE=y

CONFIG_SIFIVE_PLIC=y
CONFIG_SPI=y
CONFIG_SPI_SIFIVE=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_SIFIVE=y
CONFIG_PWM_SIFIVE=y

CONFIG_CLK_U54_PRCI=y
CONFIG_CLK_GEMGXL_MGMT=y

[3] https://github.com/atishp04/linux/tree/5.1-rc1-unleashed
[4] https://termbin.com/12bg
