Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DF8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A137227AC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/tT8++/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfFCOLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:11:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52926 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfFCOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:11:34 -0400
Received: by mail-it1-f193.google.com with SMTP id l21so5727889ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahQ7VoRg99S/6Xj+DanoRYoblw6xRVRqCQUI0HAUIyI=;
        b=K/tT8++/1Efb+YAtts49FvOfQZD+rmNnrYDw4UqoTwtlU1J/fhDcandBGT984w+C+D
         DSPFN7TYYMIZktx/KJTBksrZQdqxhSOO/rOkViB3e9jAQpElEHeTP/TNdXVFok5e2oGm
         xbe+talBRpM791KvKfNxnuQUs0CT9mX/VXP+A7r3LK2yfhrtvLZtnpjFw778WrsLrx1s
         R6yCr5u3+l4ELF0ic/pVGCf2X/cS7BNRfSsV/d9zo63wqT1gxUgG2Lj3DllxzEQzA4nD
         GenVdhFZsPa1aP8qfPYWT5F1ZiZiAL0uprJwr1QuK4qXmgE4eGKkBmNc9jLr6yEbfQBV
         L2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahQ7VoRg99S/6Xj+DanoRYoblw6xRVRqCQUI0HAUIyI=;
        b=lrVlKWCj3Xs2bhrpKXvgPIwSdIJr+R/lPoPmA/wanpVbq7FJMgZCIJuQZk0/lBIuFG
         I7Nfek71lIPexF2MAjjWsUY15TuUXrYcMvIFui2ZitaBhD7YQd35JsK03odzKXH1ZEcj
         EF66thgtFEIfGBfJ5NUqmNVsGSjgiBIm2mjyMOppycVIv8iILjWOvXs6gnnsbrN5OHGp
         HrfY2aKjguTYgOXfqVTyfioaPGbpi7pBgO3pDk2rm9m0IfFESx92TeZ+C32WnTSVR53j
         mveSAh+QXG7o4Inm83OaqRZZh7wt6RzHGWNWd3Xdf9wuoW4esGgXvTLvJhHfPDMnDwOT
         amew==
X-Gm-Message-State: APjAAAXxpsXnv4TAKUpZj8PC6oYbgW6bCACX1P9XQ/pN+wU6KXJSkDdA
        fPlBrhDbYdO2qQq81EljZppsX6gD7UT+ZTvbsBw=
X-Google-Smtp-Source: APXvYqzFcJ2ZmwK+aB+bEQ2RTNygZhJGFn/p7+CFUQ/hSJO8saN/oMGgPjOQMI0wmykpNh+ptf3YUK1OSXulWL9tyQs=
X-Received: by 2002:a24:6294:: with SMTP id d142mr17467565itc.102.1559571093293;
 Mon, 03 Jun 2019 07:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <1559251257-12383-1-git-send-email-kdasu.kdev@gmail.com> <20190601095748.35d1c1aa@collabora.com>
In-Reply-To: <20190601095748.35d1c1aa@collabora.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 3 Jun 2019 10:11:20 -0400
Message-ID: <CAC=U0a1q2CTZx+btLBJNewK8Rv3WXVE-ZV+j5fFWZPJLoJ94NA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: nand: raw: brcmnand: Refactored code and
 introduced inline functions
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,

On Sat, Jun 1, 2019 at 3:57 AM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 30 May 2019 17:20:35 -0400
> Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> > Refactored NAND ECC and CMD address configuration code to use inline
> > functions.
>
> I'd expect the compiler to be smart enough to decide when inlining is
> appropriate. Did you check that adding the inline specifier actually
> makes a difference?

This was done to make the code more readable. It does not make any
difference to performance.

>
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 100 +++++++++++++++++++------------
> >  1 file changed, 62 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > index ce0b8ff..77b7850 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -588,6 +588,54 @@ static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
> >       __raw_writel(val, ctrl->nand_fc + word * 4);
> >  }
> >
> > +static inline void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
> > +{
> > +
> > +     /* Clear error addresses */
> > +     brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_ADDR, 0);
> > +     brcmnand_write_reg(ctrl, BRCMNAND_CORR_ADDR, 0);
> > +     brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_EXT_ADDR, 0);
> > +     brcmnand_write_reg(ctrl, BRCMNAND_CORR_EXT_ADDR, 0);
> > +}
> > +
> > +static inline u64 brcmnand_get_uncorrecc_addr(struct brcmnand_controller *ctrl)
> > +{
> > +     u64 err_addr;
> > +
> > +     err_addr = brcmnand_read_reg(ctrl, BRCMNAND_UNCORR_ADDR);
> > +     err_addr |= ((u64)(brcmnand_read_reg(ctrl,
> > +                                          BRCMNAND_UNCORR_EXT_ADDR)
> > +                                          & 0xffff) << 32);
> > +
> > +     return err_addr;
> > +}
> > +
> > +static inline u64 brcmnand_get_correcc_addr(struct brcmnand_controller *ctrl)
> > +{
> > +     u64 err_addr;
> > +
> > +     err_addr = brcmnand_read_reg(ctrl, BRCMNAND_CORR_ADDR);
> > +     err_addr |= ((u64)(brcmnand_read_reg(ctrl,
> > +                                          BRCMNAND_CORR_EXT_ADDR)
> > +                                          & 0xffff) << 32);
> > +
> > +     return err_addr;
> > +}
> > +
> > +static inline void brcmnand_set_cmd_addr(struct mtd_info *mtd, u64 addr)
> > +{
> > +     struct nand_chip *chip =  mtd_to_nand(mtd);
> > +     struct brcmnand_host *host = nand_get_controller_data(chip);
> > +     struct brcmnand_controller *ctrl = host->ctrl;
> > +
> > +     brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
> > +                        (host->cs << 16) | ((addr >> 32) & 0xffff));
> > +     (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
> > +     brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS,
> > +                        lower_32_bits(addr));
> > +     (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
> > +}
> > +
> >  static inline u16 brcmnand_cs_offset(struct brcmnand_controller *ctrl, int cs,
> >                                    enum brcmnand_cs_reg reg)
> >  {
> > @@ -1213,9 +1261,12 @@ static void brcmnand_send_cmd(struct brcmnand_host *host, int cmd)
> >  {
> >       struct brcmnand_controller *ctrl = host->ctrl;
> >       int ret;
> > +     u64 cmd_addr;
> > +
> > +     cmd_addr = brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
> > +
> > +     dev_dbg(ctrl->dev, "send native cmd %d addr 0x%llx\n", cmd, cmd_addr);
> >
> > -     dev_dbg(ctrl->dev, "send native cmd %d addr_lo 0x%x\n", cmd,
> > -             brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS));
> >       BUG_ON(ctrl->cmd_pending != 0);
> >       ctrl->cmd_pending = cmd;
> >
> > @@ -1374,12 +1425,7 @@ static void brcmnand_cmdfunc(struct nand_chip *chip, unsigned command,
> >       if (!native_cmd)
> >               return;
> >
> > -     brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
> > -             (host->cs << 16) | ((addr >> 32) & 0xffff));
> > -     (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
> > -     brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS, lower_32_bits(addr));
> > -     (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
> > -
> > +     brcmnand_set_cmd_addr(mtd, addr);
> >       brcmnand_send_cmd(host, native_cmd);
> >       brcmnand_waitfunc(chip);
> >
> > @@ -1597,20 +1643,10 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
> >       struct brcmnand_controller *ctrl = host->ctrl;
> >       int i, j, ret = 0;
> >
> > -     /* Clear error addresses */
> > -     brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_ADDR, 0);
> > -     brcmnand_write_reg(ctrl, BRCMNAND_CORR_ADDR, 0);
> > -     brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_EXT_ADDR, 0);
> > -     brcmnand_write_reg(ctrl, BRCMNAND_CORR_EXT_ADDR, 0);
> > -
> > -     brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
> > -                     (host->cs << 16) | ((addr >> 32) & 0xffff));
> > -     (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
> > +     brcmnand_clear_ecc_addr(ctrl);
> >
> >       for (i = 0; i < trans; i++, addr += FC_BYTES) {
> > -             brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS,
> > -                                lower_32_bits(addr));
> > -             (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
> > +             brcmnand_set_cmd_addr(mtd, addr);
> >               /* SPARE_AREA_READ does not use ECC, so just use PAGE_READ */
> >               brcmnand_send_cmd(host, CMD_PAGE_READ);
> >               brcmnand_waitfunc(chip);
> > @@ -1630,21 +1666,15 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
> >                                       host->hwcfg.sector_size_1k);
> >
> >               if (!ret) {
> > -                     *err_addr = brcmnand_read_reg(ctrl,
> > -                                     BRCMNAND_UNCORR_ADDR) |
> > -                             ((u64)(brcmnand_read_reg(ctrl,
> > -                                             BRCMNAND_UNCORR_EXT_ADDR)
> > -                                     & 0xffff) << 32);
> > +                     *err_addr = brcmnand_get_uncorrecc_addr(ctrl);
> > +
> >                       if (*err_addr)
> >                               ret = -EBADMSG;
> >               }
> >
> >               if (!ret) {
> > -                     *err_addr = brcmnand_read_reg(ctrl,
> > -                                     BRCMNAND_CORR_ADDR) |
> > -                             ((u64)(brcmnand_read_reg(ctrl,
> > -                                             BRCMNAND_CORR_EXT_ADDR)
> > -                                     & 0xffff) << 32);
> > +                     *err_addr = brcmnand_get_correcc_addr(ctrl);
> > +
> >                       if (*err_addr)
> >                               ret = -EUCLEAN;
> >               }
> > @@ -1711,7 +1741,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
> >       dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)addr, buf);
> >
> >  try_dmaread:
> > -     brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_COUNT, 0);
> > +     brcmnand_clear_ecc_addr(ctrl);
> >
> >       if (has_flash_dma(ctrl) && !oob && flash_dma_buf_ok(buf)) {
> >               err = brcmnand_dma_trans(host, addr, buf, trans * FC_BYTES,
> > @@ -1858,15 +1888,9 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
> >               goto out;
> >       }
> >
> > -     brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
> > -                     (host->cs << 16) | ((addr >> 32) & 0xffff));
> > -     (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
> > -
> >       for (i = 0; i < trans; i++, addr += FC_BYTES) {
> >               /* full address MUST be set before populating FC */
> > -             brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS,
> > -                                lower_32_bits(addr));
> > -             (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
> > +             brcmnand_set_cmd_addr(mtd, addr);
> >
> >               if (buf) {
> >                       brcmnand_soc_data_bus_prepare(ctrl->soc, false);
>

Thanks
Kamal
