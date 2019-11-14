Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9617AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69888206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru/B8kdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKNITc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:19:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39668 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNITc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:19:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so4501806oif.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 00:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaJ/24ug8EOdA634pqQxtCQHNaGQDoT5QO/cUZAPyN8=;
        b=ru/B8kdyEF+8X/F+RYI6XxfAscZ4dA2WpcMuSnAZQ7WAJSxwzRdMQvN0jzwHqC9gN9
         MNdMczMdLpc/WgDZiKA0LV/xvQbjtogEuJPVtriyZpBxNVtMzJlI+oRt+niwdo/rLmJq
         SQkLAyb+/Oxth0R0eRylxl43ZOHalSyElhvjecGxdIgxSnmH1HD73n0n3ItBzlLN4kzP
         8xwpxzUDXL1C1A9HfYAWkdt+JGwVSfciyg18trUIu7EJzLAzcpqQDEvqrLrwU2hKN7Zm
         0i71MX8xdta7xrSfgL1OLgWdJxIfsJyLI53J1jF2ZetcJHtkcJFN8uC5GF5LIY8Ixv2D
         NC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaJ/24ug8EOdA634pqQxtCQHNaGQDoT5QO/cUZAPyN8=;
        b=CGSmwYpt7o8iK3bCSPeU/EIA8vmG6TWfio1aUKklZrv0d9J8olNU1EkQXdL7bsxOJL
         JwVbgdAWW7pTJ9+WFjqX2ZjFydRKZ3booythMioJhygTJQ8Izx7qkRgxOQuruf3SKFjk
         Lgc8BPOo/QpNK+niwVqMr00hNCZqekpbT33Zjsbnn5DpC8NUER81BBicRH9Ms6Si7u64
         mKmxQKuN+Ik3wFosJDuVO453M5Z1tcgCkYfsrqLFix0RnUTiLgt54YKaQsa264kJWxn8
         G6/h6vlnKqi2IyoPebrqXG+1k95PBZ2VLI+yfpcMqlWN8mc8HYwEloixyDmFZhMcndK1
         JSmA==
X-Gm-Message-State: APjAAAU50idJ+goT97DyNIA9IR64NFIFM9P6dlzVz4cb9mWfZp7dnLrv
        Jx24HDtDmt2njZdP4a6/q1trzqBj79+F4cpFILs=
X-Google-Smtp-Source: APXvYqx8D9GlJ385oYygjCaMSvLMvmBz7OT2vUysUTVFxuEaxfasZyDjLfPaArprQ3D6hB+O99WzCUmlXvxlMWh3J2U=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr2587853oia.30.1573719569553;
 Thu, 14 Nov 2019 00:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20191110052104.5502-1-gch981213@gmail.com> <201911121507.ANXNexIL%lkp@intel.com>
In-Reply-To: <201911121507.ANXNexIL%lkp@intel.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 14 Nov 2019 16:19:18 +0800
Message-ID: <CAJsYDV+nGHtvmnfY8jN+fR8E8m2vh7OTe7Y0zQvSX8HKBidszA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: mtk-quadspi: add support for DMA reading
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Tue, Nov 12, 2019 at 3:29 PM kbuild test robot <lkp@intel.com> wrote:
> [...]
> All warnings (new ones prefixed by >>):
>
>    drivers/mtd/spi-nor/mtk-quadspi.c: In function 'mtk_nor_read_dma_bounce':
> >> drivers/mtd/spi-nor/mtk-quadspi.c:349:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      mem_unaligned_len = (u32)buf % MTK_NOR_DMA_ALIGN;
>                          ^
>    drivers/mtd/spi-nor/mtk-quadspi.c: In function 'mtk_nor_read':
>    drivers/mtd/spi-nor/mtk-quadspi.c:369:6: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>          (u32)buffer % MTK_NOR_DMA_ALIGN || from % MTK_NOR_DMA_ALIGN)
>          ^
>

DMA mode on this controller requires that source address, destination
address and reading
length should all be 16-byte aligned. And because of this, I didn't
use the bounce buffer
provided by spi-nor framework and allocate its own one.
Should I just cast all these pointers to ulong or are there better
ways to check for address
alignments and/or obtain an aligned buffer?

Regards,
Chuanhong Guo
