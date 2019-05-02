Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F642085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA/Hb8t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEBOKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:10:11 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39203 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:10:11 -0400
Received: by mail-it1-f194.google.com with SMTP id t200so3598169itf.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CzTxP9dt0cEMXB8ZLT3bRjyPydmwtmQUnqm59Ipu0B4=;
        b=nA/Hb8t6zTovVxuEPyklmYdY8j53hus6O8CQ38Q+5dhleYhDtgeBymV3sa5M28ICVj
         fmDBLtsYtXmcjdf15PVFxtxzM34IkSVqF6HIKVOprxxBedZVp27TlplVqtHXU89wTogK
         rcnj0busIRJz6arYPdZEmsIOGqsZkGz0RGaXdZaluJ7r06VdYT8J0+VZp3aWX9FrAfPo
         wQ3aEVOIwN7t8aE2iOiScg0Jk7a3U2TNAKcUWVFJf49P1Bd40J6pqnngAqr3UUTGFDu1
         qwdRsSADf2nQauOacVpLiKe7n/2kL0lFSsmwptI0Ltwa0aYQBOJtGhTsl7iLgzmkl/PR
         Cayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CzTxP9dt0cEMXB8ZLT3bRjyPydmwtmQUnqm59Ipu0B4=;
        b=fDgnnJH28AlORI3jA21QBi03xLHnSk3M/YMbWiF/bcq4ya1sN9576aB5AfdW3A887l
         G00EhUhZAWC+e+95F+Q9gerh9OR5ErU06l5D0C8CeEtwHehYkugB+eSfLqJR+AjZOhb3
         xxmMkzVb3DT/xXsy22Wtig7fST2MAIkxM5dhMoP4hV/i90HWQD3l1RcX5Lv7vKMsEifI
         HhE3RmXBBVxZke3YxTH6DQYG6NZ1/jGSz1yanD7D8BBDXdIdu3+qdzJMBsEtDPAAwxZp
         vOhtc6vj199F0GW9Nz4hEJ74V4VMRdQ9HUgLv1MM6oUSibodquGirq+DMVskU/X+OIyR
         Sjjg==
X-Gm-Message-State: APjAAAVSSMQbRdudFcwcXokdDaDj9pyjg+VRQMUad+xsabFe+aXHYXHQ
        c9SXSZvlKQVJlnUqQP3TZLQi5+9LbPyaBfj+kIc=
X-Google-Smtp-Source: APXvYqyQnBVy3tEgs5ZeUQB4BK48k9tZQKIHeXjzwFyc6B01aQ5kAp66xuotttqQt1dOlzXHQwgs9f3oiw+VqcpCsVE=
X-Received: by 2002:a24:1104:: with SMTP id 4mr2237306itf.10.1556806210165;
 Thu, 02 May 2019 07:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <1556733121-20133-1-git-send-email-kdasu.kdev@gmail.com> <20190502102504.32b45247@xps13>
In-Reply-To: <20190502102504.32b45247@xps13>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Thu, 2 May 2019 10:09:59 -0400
Message-ID: <CAC=U0a2O8V9O8b-dZhn7DRptP3fg1BBCbxhxKXVcsWHykQovaA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: brcmnand: When oops in progress use pio
 and interrupt polling
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 4:25 AM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Kamal,
>
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Wed,  1 May 2019 13:46:15
> -0400:
>
> > If mtd_oops is in progress switch to polling for nand command completio=
n
>
> s/nand/NAND/

Will change this.

>
> > interrupts and use PIO mode wihtout DMA so that the mtd_oops buffer can
> > be completely written in the assinged nand partition.
>
> What about:
>
> "If mtd_oops is in progress, switch to polling during NAND command
> completion instead of relying on DMA/interrupts so that the mtd_oops
> buffer can be completely written in the assigned NAND partition."
>

Will make this change as well

> > This is needed in
> > cases where the panic does not happen on cpu0 and there is only one onl=
ine
> > CPU and the panic is not on cpu0.
>
> "This is needed in case the panic does not happen on CPU0 and there is
> only one online CPU."
>
> I am not sure to understand the problem or how this can happen (and
> be a problem). Have you met such issue already or is this purely
> speculative?

We have seen this issue and tested it on multi core SoCs.

>
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 55 ++++++++++++++++++++++++=
++++++--
> >  1 file changed, 52 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nan=
d/raw/brcmnand/brcmnand.c
> > index 482c6f0..cfbe51a 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -823,6 +823,12 @@ static inline bool has_flash_dma(struct brcmnand_c=
ontroller *ctrl)
> >       return ctrl->flash_dma_base;
> >  }
> >
> > +static inline void disable_flash_dma_xfer(struct brcmnand_controller *=
ctrl)
> > +{
> > +     if (has_flash_dma(ctrl))
> > +             ctrl->flash_dma_base =3D 0;
> > +}
> > +
> >  static inline bool flash_dma_buf_ok(const void *buf)
> >  {
> >       return buf && !is_vmalloc_addr(buf) &&
> > @@ -1237,15 +1243,58 @@ static void brcmnand_cmd_ctrl(struct nand_chip =
*chip, int dat,
> >       /* intentionally left blank */
> >  }
> >
> > +static bool is_mtd_oops_in_progress(void)
> > +{
> > +     int i =3D 0;
> > +
> > +#ifdef CONFIG_MTD_OOPS
> > +     if (oops_in_progress && smp_processor_id()) {
> > +             int cpu =3D 0;
> > +
> > +             for_each_online_cpu(cpu)
> > +                     ++i;
> > +     }
> > +#endif
> > +     return i =3D=3D 1 ? true : false;
>
> I suppose return (i =3D=3D 1); is enough
>

Ok will make the change.

> > +}
> > +
> > +static bool brcmstb_nand_wait_for_completion(struct nand_chip *chip)
> > +{
> > +     struct brcmnand_host *host =3D nand_get_controller_data(chip);
> > +     struct brcmnand_controller *ctrl =3D host->ctrl;
> > +     bool err =3D false;
> > +     int sts;
> > +
> > +     if (is_mtd_oops_in_progress()) {
> > +             /* Switch to interrupt polling and PIO mode */
> > +             disable_flash_dma_xfer(ctrl);
> > +             sts =3D bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY |
> > +                                            NAND_STATUS_READY,
> > +                                            NAND_CTRL_RDY |
> > +                                            NAND_STATUS_READY, 0);
> > +             err =3D (sts < 0) ? true : false;
> > +     } else {
> > +             unsigned long timeo =3D msecs_to_jiffies(
> > +                                             NAND_POLL_STATUS_TIMEOUT_=
MS);
> > +             /* wait for completion interrupt */
> > +             sts =3D wait_for_completion_timeout(&ctrl->done, timeo);
> > +             err =3D (sts <=3D 0) ? true : false;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> >  static int brcmnand_waitfunc(struct nand_chip *chip)
> >  {
> >       struct brcmnand_host *host =3D nand_get_controller_data(chip);
> >       struct brcmnand_controller *ctrl =3D host->ctrl;
> > -     unsigned long timeo =3D msecs_to_jiffies(100);
> > +     bool err =3D false;
> >
> >       dev_dbg(ctrl->dev, "wait on native cmd %d\n", ctrl->cmd_pending);
> > -     if (ctrl->cmd_pending &&
> > -                     wait_for_completion_timeout(&ctrl->done, timeo) <=
=3D 0) {
>
> What about the wait_for_completion_timeout() call in brcmnand_write()?
>

brcmnand_write() too calls brcmnand_waitfunc(), will poll if it needs
to for completion.

> > +     if (ctrl->cmd_pending)
> > +             err =3D brcmstb_nand_wait_for_completion(chip);
> > +
> > +     if (err) {
> >               u32 cmd =3D brcmnand_read_reg(ctrl, BRCMNAND_CMD_START)
> >                                       >> brcmnand_cmd_shift(ctrl);
> >
>
>
> Thanks,
> Miqu=C3=A8l

Thanks
Kamal
