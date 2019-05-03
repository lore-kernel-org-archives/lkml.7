Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4F3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9B22063F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loJhy4XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfECKhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:37:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44000 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfECKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:37:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id u27so3803589lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y49iuZlGEFRKXGMhL/FW153snu1fMi8v/es25880oE8=;
        b=loJhy4XJ97xuNf+RrpSA+jCJMImzpJ6++PjvZ3i+MfQK3dS1nWqOJbjKYB4QcVeQHU
         18pp/eByTT443pvkHn8G3n8oY/EpCXnMMlJjlVjJSKM34iB8HzqJ74dogtIAyYQx5wwi
         SDDuxo4bNGGgSoNkV6ngd2ulv2Lg1eveOEwULJvBt2juAmdWqOkMr4c7zcC1VqIChbNt
         yk+HgI4/yiG/SlUDJj8aDQdNTdAwUN1L+dhvQZGkQImNLMC+deS5j3/304qUhcQyNB7r
         LsUARKemMOAfqft34Qg6d3Epi1ObP6uDY3/xsEy08J8YFfp1qBEgGjayFLOCLOISgr6O
         d2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y49iuZlGEFRKXGMhL/FW153snu1fMi8v/es25880oE8=;
        b=SqQU9hLIcGmcXcatXYcR65Gy4ZW29TDQ3ZguTE3GXZ/X9bSWCXzW/kntm257vONw0s
         5yBf/TMzmVd/q51t+K+abj8ApPyWX4+l/gCWZQuBbqtLomM6zWTiakCLUghbhE9aO5TJ
         04N+RH8DwxPehgb9mxz09cC+qb55DIq6TzDiU+hbBHBRpsndTOjShPy8B9QhdEI/Y6Aj
         Q6B56efic5Ps20VROKjEf6KjYzzOVSg22ug3SOdjbNUvK06bCc7zasKqqOiFQdF2ak8a
         CiCPljy9l97a5Ki1HJ7yffVxYVI0HDS16jxiL3nd/olQm1pP1NRTNZ3kV//WbJY3Y+iL
         JZyA==
X-Gm-Message-State: APjAAAWEewW2YdhzagN0q/4UqQ4Oa25ZXALMTgrKLhENq3VW0l7bD/YG
        IGfgf27C5q/V8itLYAS8KczQV5u7cdq7NwSRGQ4=
X-Google-Smtp-Source: APXvYqxU+UuYktvsztEvJ9/ariHXzb6Ot8TO3Mjaxpfia5I1sJ6/SrkkV2s5OAkU7J7gMftr/G2qyyQxowiQWzM4eiA=
X-Received: by 2002:a19:ec12:: with SMTP id b18mr4411872lfa.149.1556879836632;
 Fri, 03 May 2019 03:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190503085327.5180-1-simon.k.r.goldschmidt@gmail.com> <8161008c-fafd-a89f-d2d8-413224844cd2@gmail.com>
In-Reply-To: <8161008c-fafd-a89f-d2d8-413224844cd2@gmail.com>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Fri, 3 May 2019 12:37:05 +0200
Message-ID: <CAAh8qsyBHCD9o_wyk6cHxyxagpQvX0dtXxy_P4KqZgoeU8VrEg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: enable 4B opcodes for n25q256a
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 12:00 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>
> On 5/3/19 10:53 AM, Simon Goldschmidt wrote:
> > Tested on socfpga cyclone5 where this is required to ensure that the
> > boot rom can access this flash after warm reboot.
>
> Are you sure _all_ variants of the N25Q256 support 4NB opcodes ?
> I think there were some which didn't, but I might be wrong.

Oh, damn, you're right. The documentation [1] statest that 4-byte erase and
program opcodes are only supported for part numbers N25Q256A83ESF40x,
N25Q256A83E1240x and N25QA83ESFA0F.

Any idea of how I can still enable 4-byte opcodes for my chip?

Regards,
Simon

>
> > Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> > ---
> >
> >  drivers/mtd/spi-nor/spi-nor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index fae147452..4cdec2cc2 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1874,7 +1874,7 @@ static const struct flash_info spi_nor_ids[] = {
> >       { "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
> >       { "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
> >       { "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
> > -     { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +     { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> >       { "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
> >       { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
> >       { "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
> >
>
>
