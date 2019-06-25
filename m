Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D12DC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D5B213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfFYPXO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:23:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33280 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfFYPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:23:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id i4so17893210otk.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gRnFrYoEfNfsdoVhVQW0Fet9FOWwAVGxt1dsfE11KLs=;
        b=gsQ05BH1W2doRe9AhawoKzkKtJi/NImQA31FF/d5awDQMGYWcnvJnFmTnoA1325Sjj
         w8hiLsiMlwwYf7brouFjVSYjMNrdf7yQJsiUp/82lxKMtkjRNCqmwpUCPYlg6GhmsqOL
         C84T69gewCl/WaN5q3/yqfkpItmysVvLMApBvMv91kABB4VK9kcV5u0o6CxiNEA8EEve
         f3kzGRyNTu5dzPOepqeDl+b41qFB471aiVmVsctC2XIcth15t5rZiOBf054xxliPKCus
         O9Bbemqo6GQAjqZkIBlBJhYMZkeHymen3ZG3m32q6FbOjuo3lTFGc0VR1nWiUrWwNF4Z
         jJIg==
X-Gm-Message-State: APjAAAV2HN9O22/L1f/5f2VPCe4o7xXwc+6CKDmXOaypUazN/Ci1+DTO
        Kv1/wRyuUpxP7S2XjR18hOzSGy4/OPR3atavQc4=
X-Google-Smtp-Source: APXvYqx7FUyHJAxzoNmkzQVpQoKhqHv22N+bGY9kRSc3sstmCdqnILXmddt697oOtVxwiUyqQV69PSEDOuLGztoUKmQ=
X-Received: by 2002:a9d:2f03:: with SMTP id h3mr91953526otb.107.1561476193134;
 Tue, 25 Jun 2019 08:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190614150638.28383-1-piotrs@cadence.com> <20190614150956.31244-1-piotrs@cadence.com>
 <dd96bd1b-e944-e95d-31c9-6dd1d0b5720f@gmail.com> <20190625130231.GA31865@global.cadence.com>
 <20110899-d456-8403-f9be-663be5fcd07e@gmail.com>
In-Reply-To: <20110899-d456-8403-f9be-663be5fcd07e@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jun 2019 17:23:01 +0200
Message-ID: <CAMuHMdXJ=DQgNzvwXiZd2-Xm=GwO0gFywOxpuX+xwHc3J7q+3g@mail.gmail.com>
Subject: Re: [v3 1/2] mtd: nand: Add Cadence NAND controller driver
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Piotr Sroka <piotrs@cadence.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 4:45 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 25.06.2019 16:02, Piotr Sroka пишет:
> > The 06/16/2019 16:42, Dmitry Osipenko wrote:
> >> 14.06.2019 18:09, Piotr Sroka пишет:
> >>> +/* Cadnence NAND flash controller capabilities get from driver data. */
> >>> +struct cadence_nand_dt_devdata {
> >>> +    /* Skew value of the output signals of the NAND Flash interface. */
> >>> +    u32 if_skew;
> >>> +    /* It informs if aging feature in the DLL PHY supported. */
> >>> +    u8 phy_dll_aging;
> >>> +    /*
> >>> +     * It informs if per bit deskew for read and write path in
> >>> +     * the PHY is supported.
> >>> +     */
> >>> +    u8 phy_per_bit_deskew;
> >>> +    /* It informs if slave DMA interface is connected to DMA engine. */
> >>> +    u8 has_dma;
> >>
> >> There is no needed to dedicate 8 bits to a variable if you only care about a single
> >> bit. You may write this as:
> >>
> >> bool has_dma : 1;
> > I modified it locally but it looks that checkpatch does not like such
> > notation
> > "WARNING: Avoid using bool as bitfield.  Prefer bool bitfields as
> > unsigned int or u<8|16|32>"
> > So maybe I will leave it as is.
>
> You may also use the "u8 : 1" form then, to satisfy the checkpatch. Probably
> "unsigned int : 1" will be the best in this case, it's up to you.

Exactly. The compiler will allocate the sufficient amount of space to store the
bitfield.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
