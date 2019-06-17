Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51184C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BF7208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ed4ihMNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfFQPSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:18:45 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43102 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFQPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:18:45 -0400
Received: by mail-vk1-f196.google.com with SMTP id m193so2131315vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avGzyCxZclKT79pADY4DKIxqTozcBYUh0WnJ9dBhi1E=;
        b=ed4ihMNWHG89e7Xaq5+FGLxCCA+5JtfbgMQTrutcVtIUFc/8Xc5p7ERp90dJ5a/5lF
         I3MGOvl69DQXjZF3l5qryq0cR5T9YK/n7VaKJIq8hQYccky5s/xwoqen9GCkilKTSuxr
         AOWz1z+0Y+6fxqgfwix4gWIl+ilS5v/XR8eTCycB790d93Cc9++z4t8IOSbvO5teSBI5
         lEEHEiIwabUNKwbt+MXom5V9VOXoBLX2Rxtf3aW4eo8I5FnOBSAc3SW5aWluQArodm2k
         qtImm0+eKkSivZ+3lgV2Y7j+JamcqthViHOiZj8EcoF25bQFpsL5ypPvdyqcBHiLMus1
         Ut0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avGzyCxZclKT79pADY4DKIxqTozcBYUh0WnJ9dBhi1E=;
        b=C0bE/smpVKJghCgos+T4TrRtSGGHYPkJsrqDTI3aTtoAcwwcet+TKo6Fw4LREKpFnF
         zomUbratNwPXCmuNfv4qJDIoEF+g4O52QN3zBGc0STTINBKsLmXlSGxCdPu3+kJ9oeJk
         GXs49z2vLSX9N8KqKlo9K1Gxk5u2LBwaKkLmd9Nl+B2S/CjdKx/+Qew6OVI3Qngc/kv+
         qiiXwrHb28yAKml7p3dC06m10+1gsQsjeByNRWuD6BNK+xdx+8qT1PJvVuwzlScjsE47
         kjtyTDabsHLCRqq+sO9wN3XCyJ6UIIsS02YAwt75nhZ4euMXcKrFgCUO3XulM5/NMoRU
         /Ydw==
X-Gm-Message-State: APjAAAUdh6vVtD+U79FvcxOOYSVZt/jhnO4du0IADtgj+O2Z0QMOGhXi
        8vt+VymxYjwXwj3yDozHnPUaEQvxv0N2sjPVkY4Rjw==
X-Google-Smtp-Source: APXvYqybEt7W3M5qE6N0FBs9dBKJrhuavtDPLL4WFwFs7pHHWurEb3V/bgCHCADGQFV/vQ+BSWlb509dkOgV0n8YRMo=
X-Received: by 2002:a1f:2909:: with SMTP id p9mr27668514vkp.23.1560784724394;
 Mon, 17 Jun 2019 08:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
 <1560336476-31763-2-git-send-email-sagar.kadam@sifive.com> <325855d0-00f9-df8a-ea57-c140d39dd6ef@ti.com>
In-Reply-To: <325855d0-00f9-df8a-ea57-c140d39dd6ef@ti.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 17 Jun 2019 20:48:33 +0530
Message-ID: <CAARK3H=O=h1VDgOMxs_0ThcisrH=2tzpW5pQqt0O9oYs=MFFVw@mail.gmail.com>
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

Thanks for your review comments.

On Sun, Jun 16, 2019 at 6:14 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi,
>
> On 12-Jun-19 4:17 PM, Sagar Shrikant Kadam wrote:
> [...]
>
> > @@ -4129,7 +4137,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >       if (ret)
> >               return ret;
> >
> > -     if (nor->addr_width) {
> > +     if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
> >               /* already configured from SFDP */
>
> Hmm, why would you want to ignore addr_width that's read from SFDP table?

The SFDP table for ISSI device considered here, has addr_width set to
3 byte, and the flash considered
here is 32MB. With 3 byte address width we won't be able to access
flash memories higher address range.
Hence I have ignored the addr width from SFDP.  I have verified that
with 3 byte address width, the
flascp util fails while verifying the written data.  Please let me
know your views on this?

BR,
Sagar Kadam

> Regards
> Vignesh
>
>
> >       } else if (info->addr_width) {
> >               nor->addr_width = info->addr_width;
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index b3d360b..ff13297 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -19,6 +19,7 @@
> >  #define SNOR_MFR_ATMEL               CFI_MFR_ATMEL
> >  #define SNOR_MFR_GIGADEVICE  0xc8
> >  #define SNOR_MFR_INTEL               CFI_MFR_INTEL
> > +#define SNOR_MFR_ISSI                0x9d            /* ISSI */
> >  #define SNOR_MFR_ST          CFI_MFR_ST      /* ST Micro */
> >  #define SNOR_MFR_MICRON              CFI_MFR_MICRON  /* Micron */
> >  #define SNOR_MFR_MACRONIX    CFI_MFR_MACRONIX
> >
