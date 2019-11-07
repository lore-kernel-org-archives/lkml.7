Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53D8C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7059020673
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAChVYxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbfKGJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:31:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44538 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:31:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id c19so1400191otr.11;
        Thu, 07 Nov 2019 01:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iuasj2afgMJAzja6uysg+1QDLDZRD47UOISLXL9pb2M=;
        b=mAChVYxcoSkGwnhp7ff0QokhxUd9QPmLoT9Cn1E5xIr6i0h+cx4rUyZ+2s5Xciwe/i
         Kq4kM1DVxxmaURAxoZGrw+n/+u10deLVn2EQpK/BzXp8JvX+qpdFP6mu/BJgzNKVqvus
         Zf8mTPaeOflRCP43BUE0t5I5xFGekUFkw0KjgYSTC3QxMZV3o/1Hm4mLGZ2ntTOtERUF
         F7kYt6w5xMOSvINLjuEcwvaqvMMNY6g6uy/k2pa3Gv9Gd4uBV6k2YrUj+N+54vPfLVnB
         Movv9Q+DXqaspibA9j9xhl8o1i20Y1d74H70SIvtktZr5MOD0HjDgGD8jXq9Rm6axuHc
         h2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iuasj2afgMJAzja6uysg+1QDLDZRD47UOISLXL9pb2M=;
        b=euef7+ndpJZuI+gpbtn9hNwciUDDyo2j3bmmw/6iSfCtpPNWdso3nuvjLgyRPYupho
         Lb0TuFKiooQkK1TmlKxnwnrGJScyZZdxwmplODlJFB99ElJXhpWfMyAjJ2FVLg6yExWw
         wbPb4fJ8eTHWgvGOP/nEDf2cCoq935L3N1bKQWgMmCAD/iN/oOy3rWFlV7kf1BaeIuxi
         n5rqd+GaJFBvXphFhrym/VFHBn1D9FNJW84WEWEHJUw30HmqkF5Y83f0GqfokW6oHKC6
         VfHZgJNtFYtYoEV22qjnyCPcObgtwW6ckIVU98wQBwaTdZIETrkygBzWzmek1AektT9s
         b8Ow==
X-Gm-Message-State: APjAAAXFgPV706cUm2AXOMx56hFL9PF5SCycCkebNfiviHawPGgTCZKJ
        O+meNXNwIIvRVNZp6Ay2Flt6e+uhKZ//iyxEasY=
X-Google-Smtp-Source: APXvYqxM2u5buXTzjVMjKs0NiT8xZ4gQE9rzxlSnRNK0x5jTIg9zCq0fAgqpl2XlavGpu0oHc0B6P/uQpa0ir3k8lhM=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr193968otl.84.1573119106712;
 Thu, 07 Nov 2019 01:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20191106140748.13100-1-gch981213@gmail.com> <20191106140748.13100-2-gch981213@gmail.com>
 <bc917a56-e688-d701-2279-87df460d6055@ti.com>
In-Reply-To: <bc917a56-e688-d701-2279-87df460d6055@ti.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 7 Nov 2019 17:31:35 +0800
Message-ID: <CAJsYDVJgUNxLhcO9iLKwRZHPQ9FT8XuKQq8ru_djD2nryT5o9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: mtk-quadspi: add support for memory-mapped flash reading
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Nov 7, 2019 at 2:05 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> > @@ -272,6 +273,11 @@ static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
> >       mtk_nor_set_read_mode(mtk_nor);
> >       mtk_nor_set_addr(mtk_nor, addr);
> >
> > +     if (mtk_nor->flash_base) {
> > +             memcpy_fromio(buffer, mtk_nor->flash_base + from, length);
> > +             return length;
> > +     }
> > +
>
> Don't you need to check if access is still within valid memory mapped
> window?

The mapped area is 256MB and I don't quite believe there will be such
a big NOR flash.
I'll add a check here in the next version.

>
> >       for (i = 0; i < length; i++) {
> >               ret = mtk_nor_execute_cmd(mtk_nor, MTK_NOR_PIO_READ_CMD);
> >               if (ret < 0)
> > @@ -475,6 +481,11 @@ static int mtk_nor_drv_probe(struct platform_device *pdev)
> >       if (IS_ERR(mtk_nor->base))
> >               return PTR_ERR(mtk_nor->base);
> >
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +     mtk_nor->flash_base = devm_ioremap_resource(&pdev->dev, res);
>
> There is a single API now: devm_platform_ioremap_resource().

Cool. I'll change it.
Should I add another patch to change the same mapping operation right
above this piece of code?

Regards,
Chuanhong Guo
