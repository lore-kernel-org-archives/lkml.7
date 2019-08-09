Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E8EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CC0208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nk6FZnAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406981AbfHIOZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:25:21 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33151 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:25:21 -0400
Received: by mail-vk1-f193.google.com with SMTP id j5so256592vkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaNaUNE2Lm/DgVn/kiWl1beHyjX5/83GtVA//BN/oCU=;
        b=nk6FZnAYm3f6V38YcMyeSsu0Umh0fsof410CcKVZQaxBC8x/YE8E6oR2ruW26hoC9D
         Zj6QS0XfftZ1LoWs7MHDOd3CmVWpYuokUYAMVyeKYU9BwWdndrSPV2Q0Yy/PaRS1k0mr
         8pspJyF+4DaavEjWM8n7ntRTD5FhspUmjDDUqC6FChsB4BVpzCDu+BwYrwRiIvj4UABy
         yzAmlatWQ4E+MUKHXZOXi8O9/iXBVV3dXwyxpfK0+yldGpI8eRlud78B4DAR22xeCvHH
         Vcq1q7f15wJAHBRnVG2ooSHpngu3PqEw2txKOrLa6G/2dx8v3DeGn+TeCH7JsbM/v/kr
         AyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaNaUNE2Lm/DgVn/kiWl1beHyjX5/83GtVA//BN/oCU=;
        b=CHiXg/voCMwPEF+3TCgI0/3Yfi1p6p1qkzbjh4sCxqcWGrP/pDgwu9SKjTU5KdReON
         Uylnm2DbTZXIE8MILBfzFy3tizMYMswczLPoR59pMadppANJCbpZq5wTMjPAZSObnzIU
         yY2OUY4NPdNR0DfbYYllahWuIV4ZWws7hzzeH9/E6Z+nN3fN1weg/L5Q2Tu4TCxIKcNj
         5SOSWy4dxvgfhSvvxkn4tJBSdKxac/+3P6uSin63JJAdx1D7sg1SlSR2bz5VPLL/9IJ7
         8PASSYMQzraNNiWCW76/nXeuaSvXFlYsVt7L+hsgvrH+ljUuJrpxh8FH/DWr/K42vOIf
         PFXQ==
X-Gm-Message-State: APjAAAU0sOezlXrsYDwg8ifXi+nMKzKq55RrHxp1+NG/B5RaWPyCYDwD
        bKE/w0qSRCFfeCnPeiZIz9bqhkn2Tku9DEPat/U3oA==
X-Google-Smtp-Source: APXvYqxlwwv+mIYjMSLT6AYQcdMGIum7Lac0W7UqF0yof/9MA/LBA+pmeTrwvMQqMxircZURRx/x9Iljguiqp22qud4=
X-Received: by 2002:ac5:c24e:: with SMTP id n14mr3363758vkk.23.1565360720450;
 Fri, 09 Aug 2019 07:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
 <1562092745-11541-3-git-send-email-sagar.kadam@sifive.com> <5d1d10be-d01f-51ca-0a08-c5a52cd467b9@ti.com>
In-Reply-To: <5d1d10be-d01f-51ca-0a08-c5a52cd467b9@ti.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Fri, 9 Aug 2019 19:55:09 +0530
Message-ID: <CAARK3HnBg2bY5DG=JM+zG9TtNDSRgj5Nqz3+1shiK3AUC-zv9Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mtd: spi-nor: fix nor->addr_width for is25wp256
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On Fri, Aug 9, 2019 at 5:05 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
>
>
> On 03/07/19 12:09 AM, Sagar Shrikant Kadam wrote:
> > Use the post bfpt fixup hook for the is25wp256 device as done for
> > is25lp256 device to overwrite the address width advertised by BFPT.
> >
> > For instance the standard devices eg: IS25WP256D-JMLE where J stands
> > for "standard" does not support SFDP.
> >
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>
Thankyou for reviewing.

BR,
Sagar
> >  drivers/mtd/spi-nor/spi-nor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index 971f0f3..315eeec 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1860,7 +1860,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
> >       { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> >                       SPI_NOR_4B_OPCODES)
> > -     },
> > +                     .fixups = &is25lp256_fixups },
> >       /* Macronix */
> >       { "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> >       { "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
> >
>
> --
> Regards
> Vignesh
