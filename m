Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E99CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1E0208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="etN7QHE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfFUK3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:29:03 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36765 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUK3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:29:03 -0400
Received: by mail-vs1-f67.google.com with SMTP id l20so3510107vsp.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 03:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENYQKCQSfeszZWYCN2yKfX/JBpyCK1CYVFLjD6oifQ0=;
        b=etN7QHE7JyTa4lpmcwrjRdg6TnTrZT71qn5QpWXhPeGHVs5LbKB7on5lmX86ologtL
         7XbiDc7JUkNc4+BQeGqzuFBGbVVr8ocD+vYfvpGft4Mc7w356kUy3V65LZHBdflyDdks
         pBnwhTO5D9DEj5J/u+iqjckNNj7Rc97GntY5i1S4zc6On50LZARTYCXQk/LRR36V2BlE
         SMgPRFHAm5TPfEKUQGV8T+s/54ZNmcHw0scr7/QgnsXjtHxX88yXLRu4TMT87r/wBFOJ
         mvAG7S8pio6EeqFl3vC68qkeAUBhNY/8eY1lWfcVTJ2jGeTtOnlK9TON7Lasld8xB/6K
         HjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENYQKCQSfeszZWYCN2yKfX/JBpyCK1CYVFLjD6oifQ0=;
        b=MTo0jWd0K2so135Zs30KarEVFex3/wGvrqew0zlJC6ORSBLUfr7SU6673GrKcvKnzk
         1RcSmBekRFOLseZLtKWeoKFdKShyEqboDDv2mWC3Sqzq3yNPlhb/s6crX1ogXeahrUYp
         e//rUGmkKUjsB7iL8iDR25JcXfMFy0C8wyOyeZTfEYYbAS7wSdf4uZGlNf62ABuSXrrd
         opqaIUb48I384UhtsAGqJqjws00YdR5lOX6X5OFtD3+xnWSoGaKWC2QD1x5Bley86g1w
         +K3tgQF64kKyeFORn0SygqGywD5goxVyialJS5IuLG0K1KfcwI7QWHRl+M9dnFtncYFE
         iLWw==
X-Gm-Message-State: APjAAAVXzfn/WlaJPot5NWD14J3xzZQ1D6z9HdPxPY2NPUWOqQqtcUS1
        Mwbw9LZQOIeUr2/MCVXe+9NJr3fPIQNCAC5TWnAyoQ==
X-Google-Smtp-Source: APXvYqyXXbRJwvoUm1/ZU9MgYql7iUjK+l3n4H+mOYUP5gGfjYQ9PO1P5xFbBOShDCcwOuvRyoqJmEPbMxH/uNId6ZQ=
X-Received: by 2002:a67:7346:: with SMTP id o67mr50970360vsc.92.1561112942493;
 Fri, 21 Jun 2019 03:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
 <1560336476-31763-2-git-send-email-sagar.kadam@sifive.com>
 <325855d0-00f9-df8a-ea57-c140d39dd6ef@ti.com> <CAARK3H=O=h1VDgOMxs_0ThcisrH=2tzpW5pQqt0O9oYs=MFFVw@mail.gmail.com>
 <93b9c5fd-8f59-96d7-5e40-2b9d540965dd@ti.com>
In-Reply-To: <93b9c5fd-8f59-96d7-5e40-2b9d540965dd@ti.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Fri, 21 Jun 2019 15:58:50 +0530
Message-ID: <CAARK3H=CmxSG2srUaoxN1HF6W7CVKtpATrf89n6kuht2Paqp8A@mail.gmail.com>
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

On Fri, Jun 21, 2019 at 11:33 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi,
>
> On 17/06/19 8:48 PM, Sagar Kadam wrote:
> > Hello Vignesh,
> >
> > Thanks for your review comments.
> >
> > On Sun, Jun 16, 2019 at 6:14 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12-Jun-19 4:17 PM, Sagar Shrikant Kadam wrote:
> >> [...]
> >>
> >>> @@ -4129,7 +4137,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>> -     if (nor->addr_width) {
> >>> +     if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
> >>>               /* already configured from SFDP */
> >>
> >> Hmm, why would you want to ignore addr_width that's read from SFDP table?
> >
> > The SFDP table for ISSI device considered here, has addr_width set to
> > 3 byte, and the flash considered
> > here is 32MB. With 3 byte address width we won't be able to access
> > flash memories higher address range.
>
> Is it specific to a particular ISSI part as indicated here[1]? If so,
> please submit solution agreed there i.e. use spi_nor_fixups callback
>
> [1]https://patchwork.ozlabs.org/patch/1056049/
>

Thanks for sharing the link.
From what I understand here, it seems that "Address Bytes" of SFDP
table for the device under
consideration (is25lp256) supports 3 byte only Addressing mode
(DWORD1[18:17] = 0b00.
where as that of ISSI device (is25LP/WP 256Mb/512/Mb/1Gb) support 3 or
4 byte Addressing mode DWORD1[18:17] = 0b01.

> > Hence I have ignored the addr width from SFDP.  I have verified that
> > with 3 byte address width, the
> > flascp util fails while verifying the written data.  Please let me
> > know your views on this?
> >
> If this affects multiple ISSI parts then:
> Instead of checking for mfr code, look for SNOR_F_4B_OPCODES flag in
> flash_info struct of the device and let it take precedence over SFDP in
> case size is over 16MB
>

So as per your suggestion I think second approach is a better one.
I will send this in V6.

Thanks & Regards,
Sagar

> Regards
> Vignesh
>
> > BR,
> > Sagar Kadam
> >
> >> Regards
> >> Vignesh
> >>
> >>
> >>>       } else if (info->addr_width) {
> >>>               nor->addr_width = info->addr_width;
> >>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> >>> index b3d360b..ff13297 100644
> >>> --- a/include/linux/mtd/spi-nor.h
> >>> +++ b/include/linux/mtd/spi-nor.h
> >>> @@ -19,6 +19,7 @@
> >>>  #define SNOR_MFR_ATMEL               CFI_MFR_ATMEL
> >>>  #define SNOR_MFR_GIGADEVICE  0xc8
> >>>  #define SNOR_MFR_INTEL               CFI_MFR_INTEL
> >>> +#define SNOR_MFR_ISSI                0x9d            /* ISSI */
> >>>  #define SNOR_MFR_ST          CFI_MFR_ST      /* ST Micro */
> >>>  #define SNOR_MFR_MICRON              CFI_MFR_MICRON  /* Micron */
> >>>  #define SNOR_MFR_MACRONIX    CFI_MFR_MACRONIX
> >>>
>
> --
> Regards
> Vignesh
