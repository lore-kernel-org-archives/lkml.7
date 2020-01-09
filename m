Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DC9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9C22080D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgAIWT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:19:59 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:59571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgAIWT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:19:59 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N62mG-1jmzzB3n1E-016NPz for <linux-kernel@vger.kernel.org>; Thu, 09 Jan
 2020 23:19:58 +0100
Received: by mail-qk1-f182.google.com with SMTP id r14so74292qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 14:19:57 -0800 (PST)
X-Gm-Message-State: APjAAAWb4g2pKdXCu7yz/zsCXg1nK71Tkf7kJ3A75PZf500YTJLYPRs6
        tWrDz2wur/RUjSL0+hD+XNqNO+pl139B2VpfLeQ=
X-Google-Smtp-Source: APXvYqyT8y2PQRDEVJJy8s5BknNwJ1sBDnC3Pl/5gE07byX63pRmUHqBZ8Pq5Y6k/CRVXUZbJKuYf7bI8G/0FQ1vGb4=
X-Received: by 2002:a37:84a:: with SMTP id 71mr146826qki.138.1578608396826;
 Thu, 09 Jan 2020 14:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20191210200014.949529-1-arnd@arndb.de> <20200109202110.2af111dc@xps13>
In-Reply-To: <20200109202110.2af111dc@xps13>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Jan 2020 23:19:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1mKOt+LMiECJn8uvgbwPkA+DNR9=cJGjKmhsgRP+p9+w@mail.gmail.com>
Message-ID: <CAK8P3a1mKOt+LMiECJn8uvgbwPkA+DNR9=cJGjKmhsgRP+p9+w@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: cadence: fix address space mixup
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Piotr Sroka <piotrs@cadence.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BS09xqYDtws4bo76KH6rmYbnF8OzTGVB05ceIaKCeCcmY95PGlA
 SEWkMTyp9VgMSYMh9FEe7HO4TmxdyVwf1iTsFIKRulKeXKekdLSXi6ISfaeC7gBy1My4DKb
 DFt/YfjcXfsGuMsW0ShWn4xnbozu4E/i9ez/kS7PmAqn+wv2RKfDxoei3jg5DJYc81bsPPO
 ug87+PRL52/EfwVoZ4KXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kKtC2R6gf0s=:eZW9We0EZnbJ0ZbnIz+Exa
 W9DiQAWRgjnLNce8bX7nX4/GoMTLtOEaHKrMvtUf01RZhq7Mo7oNOCvVnPyhOxTThPTihDIKm
 fpo9tWBwCGEATU0S2L8ukK4QDfuLmKD8mcuOq65QROMgiEHHyfoelaDmyY0084bONmOb/1Jdy
 9ZnCN7sQ239RBppaW26bFvILJfjcvHszP5WY9l7Pv2salx4Es+UP8JA/rhi5OO/vhHYRaSr4l
 1GqRpR9lnGV1HpoJuOZfAdArmJPqF9uP1ERvo+U/bNaASo8HMGZr3VxaVK8UxZTNbVnp08k3e
 HxZk4Aop0q70Z2KZai1xZAT97tk8InfBkSty9u7Aa/N+kKt10gB0bstS42GA2J6OSD1f6XuEA
 i59uVHRHkwBJADBH4hRKrn6XwadZP1GrQhenhou9iHsUC7Coe4qubC91rW53CMt1eYj2bg6Yu
 liSzHfvUnIn+MKfxJkrVI44X0JqPjCQ4nTDSBIjCrCLmQQUoAhhMV4Flkw5cr9Rj4N3Dbpige
 HNi7XPciBq1FMGvsqyRCaJCHeW/tAbBjh/vXvLFNJzCJdra/9qKXfO1Wau9/o8ox0+fU/UuFb
 XSQufSy987gaWqPJFOCkf3ZDrXG5cJfdfpGUel2sHg06dW6DwebeHxpBYksew4An3h8bv7dDR
 9ZGLLOQRQ0BYLb6H/qtDudk6MpjgSni6WXqND4BeswTnzmApRrByqDSMt5T114kQUZvHrwnqN
 S5pHadrKhWqBwnWtLyzq9eaeScrsVGvgrEw6ayzdCQ1phFU8ISSsqRXuDwsz/jYW3Gc6IYZ6n
 qEO03ri3j8XjrQ9VlObC+n61nzHfQMavujdIJHdjnqBYTO/EtXD17YXmKkrbQY1l4W6tDAejA
 Aa/yA3NnXWFKabzXKA9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 8:21 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Arnd,
>
> Arnd Bergmann <arnd@arndb.de> wrote on Tue, 10 Dec 2019 20:59:55 +0100:
>
> > dma_addr_t and pointers can are not interchangeable, and can
> > be different sizes:
> >
> > drivers/mtd/nand/raw/cadence-nand-controller.c: In function 'cadence_nand_cdma_transfer':
> > drivers/mtd/nand/raw/cadence-nand-controller.c:1283:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >             (void *)dma_buf, (void *)dma_ctrl_dat,
> >             ^
> > drivers/mtd/nand/raw/cadence-nand-controller.c:1283:29: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >             (void *)dma_buf, (void *)dma_ctrl_dat,
> >                              ^
> >
> > Use dma_addr_t consistently here, which cleans up a couple of casts
> > as a side-effect.
> >
> > Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I just realized that I received three patches for the same issue in a
> very tight timeframe about a month ago, yours was of course entirely
> valid but I choose to apply the one from someone not contributing a lot
> to encourage him, hope you don't mind :)

Sounds good to me, thanks for getting it fixed

      Arnd
