Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C795ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB3420873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfJNLUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:20:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41188 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfJNLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:20:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id v52so24860469qtb.8;
        Mon, 14 Oct 2019 04:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuFapTftEQf9u/dtPS/P5xJow9aqFFLyRZszruAo5Bc=;
        b=NZgw5jMo//jkehV1fNc2bm9JlM/nvbrirCVtIl28BMK+2ilyzJCuJepsfCNxNtI9SJ
         P0uyysV3ProtLmtgYWKeWhLuKwWCQeRqc8TKSrnvoRFdzBOZx5j27j6zbN79Zs5gINJZ
         48P4vOgGjx5g/IL7JM85qIUxCNfaV0Z52CN/EakcaYXBgFBAjgIWwgi1eIPUyJVL6khY
         O2HM4Psl5CTz4ry9N0glI5UA4yYFwrJ38SY8XdsSxAKi/ViywkWmUFEj0owAj2d3G/Gg
         rfkYPhjO9T7p+NEVzkwdrUm9JyzInFZQoMHF2OSEZDYemxV3ZX+ehykwSBHg/Zf3MC2q
         Vt2A==
X-Gm-Message-State: APjAAAUz9H9zuJLOQe63H8AD5erhoiBiDHbo2kqjB443KX9sPo1W+vGs
        JDY9/kI+oqrH/yXg5rliUHNHXH1EGTQTljla7fc=
X-Google-Smtp-Source: APXvYqwsnP673OnCHXRZvwy9QjA/gCKBnT6U/b+69dqA6I+lLlaW8DuwRbujiE7X6gEw4SUTnJVTK6qv7hv+OXJDmtE=
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr30329224qvt.197.1571052003441;
 Mon, 14 Oct 2019 04:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-1-daniel@0x0f.com> <20191014061617.10296-2-daniel@0x0f.com>
In-Reply-To: <20191014061617.10296-2-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 14 Oct 2019 13:19:46 +0200
Message-ID: <CAK8P3a2U7U31eF_POU2=eCU+E1DH-wnR2uHr-VZYWLy25hLjKg@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: mstar: Add machine for MStar infinity family SoCs
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Daniel Palmer <daniel@thingy.jp>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 8:21 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Initial support for the MStar infinity/infinity3 series of Cortex A7
> based IP camera SoCs.
>
> These chips are interesting in that they contain a Cortex A7,
> peripherals and system memory in a single tiny QFN package that
> can be hand soldered allowing almost anyone to embed Linux
> in their projects.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

> +
> +static void __init infinity_map_io(void)
> +{
> +       iotable_init(infinity_io_desc, ARRAY_SIZE(infinity_io_desc));
> +       miu_flush = (void __iomem *)(infinity_io_desc[0].virtual
> +                       + INFINITY_L3BRIDGE_FLUSH);
> +       miu_status = (void __iomem *)(infinity_io_desc[0].virtual
> +                       + INFINITY_L3BRIDGE_STATUS);
> +}

If you do this a little later in .init_machine, you can use a simple ioremap()
rather than picking a hardcoded physical address. It looks like nothing
uses the mapping before you set soc_mb anyway.

> +static DEFINE_SPINLOCK(infinity_mb_lock);
> +
> +static void infinity_mb(void)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&infinity_mb_lock, flags);
> +       /* toggle the flush miu pipe fire bit */
> +       writel_relaxed(0, miu_flush);
> +       writel_relaxed(INFINITY_L3BRIDGE_FLUSH_TRIGGER, miu_flush);
> +       while (!(readl_relaxed(miu_status) & INFINITY_L3BRIDGE_STATUS_DONE)) {
> +               /* wait for flush to complete */
> +       }
> +       spin_unlock_irqrestore(&infinity_mb_lock, flags);
> +}

Wow, this is a heavy barrier. From your description it doesn't sound like
there is anything to be done about it unfortunately.

Two possible issues I see here:

* It looks like it relies on CONFIG_ARM_HEAVY_BARRIER, but your Kconfig
  entry does not select that. In many configurations, CACHE_L2X0 would
  be set, but there is no need for yours on the Cortex-A7.

* You might get into a deadlock if you get an FIQ (NMI) interrupt while
   holding the infinity_mb_lock, and then issue another memory barrier
   from that handler, so you might need to use
   local_irq_disable()+local_fiq_disable()+raw_spin_lock() here, making
   it even more expensive.
   Not sure if it matters in practice, as almost nothing uses fiq any more.
   OTOH, maybe the lock is not needed at all? AFAICT if the sequence
   gets interrupted by a handler that also calls mb(), you would still
   continue in the original thread while observing a full l3 barrier. ;-)

        Arnd
