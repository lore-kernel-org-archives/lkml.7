Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80346C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54434212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PjycnB6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfFXMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:40:33 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35492 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfFXMkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:40:32 -0400
Received: by mail-vk1-f195.google.com with SMTP id k1so2708353vkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbbBl9v654ofW7tpEPGffdLt3++9EBoXMdvBpwh+0tY=;
        b=PjycnB6Lc0fHTMb2RhE5dSXv/9OzcmZy+SccDVQKTEBkxtQHtnxto9nHOPmx107tPl
         sY3TqT1AjjnnF4BY3UJ/+UvxGSqKQBBDHT24z5L68KxjQms7BLrPgMComPJh4KUh85jf
         XL4/9iS4FO3JmHO3Es1SoAtnasHxpi6EesFCYngw1bvnm8irnbMrk4ZITQc3MMQ9dfGb
         OP9aGkXBWXkLKJm6KxYzuL4e7u4Ff+Vqr0cVqR8/gC+BH8KqgUTDK/ImQko75xwgD1Bk
         96R1Tz2vLMqEQSkWAU4iGtf7bibOnf9mOJHRu9ixnc9CMyDjqZN3CRjO2EP2qkBdoNKf
         KA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbbBl9v654ofW7tpEPGffdLt3++9EBoXMdvBpwh+0tY=;
        b=uKCNm8ymCmwu7XnfKK0TT1EKkc42FDQ9dgHxxJc1exdW2va7mYR+SPkRpjW2C3i5Bt
         FYPrX4kL8X3fOcuKCt2qHq4G9oMqsIDZIgu4UFE/BJxhLDC8Jxv70NPct7NHdUIUqarY
         CY03zfgQDJJNiyWmSo2APyNjwzqYbLKUk7R3IsiB/euA2GcXWqjgL6a/BigwXeM6/Tfz
         /CKMYH1vcBWWP/QA6bKpwVY81+D3omdy7YCrGwUFRkkSy/xGZ8W7jKteCc6c7yjPOWEJ
         h3aZ2FWcO8pzjSnDYrJn3gx3KLRbZuO8zuOpIjgRsnXi9YS2LzIrjJ3o7cWz+F2XBnzJ
         02LA==
X-Gm-Message-State: APjAAAXHyr2HUTs8ICz4vc3zCmhZDvKcY9+Jt4vRQYCpiEgrd3HQnLSh
        Qti9jSbdhcEKZB+U24peISRyB6IWeyYSy/7b7PZ44AfLXpo=
X-Google-Smtp-Source: APXvYqxrZZzNE88Z+lazI8IQXlyISaS4UXodF/q7xO2AqU+bKNeJi6OKXD0s5n303/WcdjhwOUhS9TMPF7v2FUhUWPs=
X-Received: by 2002:a1f:2909:: with SMTP id p9mr4510285vkp.23.1561380031042;
 Mon, 24 Jun 2019 05:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
 <1560336476-31763-2-git-send-email-sagar.kadam@sifive.com>
 <325855d0-00f9-df8a-ea57-c140d39dd6ef@ti.com> <CAARK3H=O=h1VDgOMxs_0ThcisrH=2tzpW5pQqt0O9oYs=MFFVw@mail.gmail.com>
 <93b9c5fd-8f59-96d7-5e40-2b9d540965dd@ti.com> <CAARK3H=CmxSG2srUaoxN1HF6W7CVKtpATrf89n6kuht2Paqp8A@mail.gmail.com>
 <3fe68154-5d1e-a395-4c53-d8e806b2cc6d@ti.com>
In-Reply-To: <3fe68154-5d1e-a395-4c53-d8e806b2cc6d@ti.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 24 Jun 2019 18:10:19 +0530
Message-ID: <CAARK3HmNSOqhv_+Y2dMTRTyg=Jtry7J-j419CS5GTAiPiPLLdw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] mtd: spi-nor: add support for is25wp256
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vignesh,

On Mon, Jun 24, 2019 at 3:04 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi,
>
> On 21/06/19 3:58 PM, Sagar Kadam wrote:
> > Hello Vignesh,
> >
> > On Fri, Jun 21, 2019 at 11:33 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>
> >> Hi,
> >>
> >> On 17/06/19 8:48 PM, Sagar Kadam wrote:
> >>> Hello Vignesh,
> >>>
> >>> Thanks for your review comments.
> >>>
> >>> On Sun, Jun 16, 2019 at 6:14 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 12-Jun-19 4:17 PM, Sagar Shrikant Kadam wrote:
> >>>> [...]
> >>>>
> >>>>> @@ -4129,7 +4137,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >>>>>       if (ret)
> >>>>>               return ret;
> >>>>>
> >>>>> -     if (nor->addr_width) {
> >>>>> +     if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
> >>>>>               /* already configured from SFDP */
> >>>>
> >>>> Hmm, why would you want to ignore addr_width that's read from SFDP table?
> >>>
> >>> The SFDP table for ISSI device considered here, has addr_width set to
> >>> 3 byte, and the flash considered
> >>> here is 32MB. With 3 byte address width we won't be able to access
> >>> flash memories higher address range.
> >>
> >> Is it specific to a particular ISSI part as indicated here[1]? If so,
> >> please submit solution agreed there i.e. use spi_nor_fixups callback
> >>
> >> [1]https://patchwork.ozlabs.org/patch/1056049/
> >>
> >
> > Thanks for sharing the link.
> > From what I understand here, it seems that "Address Bytes" of SFDP
> > table for the device under
> > consideration (is25lp256) supports 3 byte only Addressing mode
> > (DWORD1[18:17] = 0b00.
> > where as that of ISSI device (is25LP/WP 256Mb/512/Mb/1Gb) support 3 or
> > 4 byte Addressing mode DWORD1[18:17] = 0b01.
> >
>
> Okay, so that SFDP table entry is correct. SPI NOR framework should
> using 4 byte addressing if WORD1[18:17] = 0b01. Could you see if below
> diff helps:
>
Thank-you for the suggestion.
I applied it, and observed, that data in SFDP table mentioned in
document received
from ISSI support doesn't match with what is actually present on the
device (I have raised a query with issi support for the same)
The WP device also has the same SFDP entry as the LP device (the one
which you shared).
So, will submit V7 with the solution agreed in the link you shared above.
     https://patchwork.ozlabs.org/patch/1056049/
Apologies for the confusion, so please excuse the v6 which I submitted earlier.

Thanks & BR,
Sagar Kadam

> --->8---
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index c0a8837c0575..ebf32aebe5e9 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2808,6 +2808,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>                 break;
>
>         case BFPT_DWORD1_ADDRESS_BYTES_4_ONLY:
> +       case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
>                 nor->addr_width = 4;
>                 break;


>
>
>
>
> --
> Regards
> Vignesh
