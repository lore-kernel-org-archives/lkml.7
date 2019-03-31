Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981CBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6786820870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeOtk0my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfCaOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 10:40:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52494 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 10:40:48 -0400
Received: by mail-it1-f194.google.com with SMTP id g17so10724923ita.2;
        Sun, 31 Mar 2019 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kP40pwhes3z+V/FQcEriWr3dXl37/tkssjSAFxgoicg=;
        b=BeOtk0myR2QvCTVMq95f9ZLIH7sP/u9zAnascKVRy4Zcmld4wolJKKsYdCI9qdnfCR
         cG1eoSHHLF/5OWp2mPm4OUO7fMUgNCNu1Gcl5L2KXSDmx/nRFapTHeycjRHRbFWyJco8
         ng7FC+zQ6Y2iTUdFqvmnfTmEFuKMLSQMs07Xpzqea/ZMI3KUxKFNN3/ryRVRNnmgFgcE
         FUts0kNH5PjztbXNLmuroPrx2QpWrVSFlm9+9DYAHvjfLemcpUtpSpahpE0R00Vmmey/
         rNdcaqxFsX0iGWgTJ4tkTOJmegcvJTD79BOlvAuXYbpZ1rXKW9GfTIHyoU9Ym/72enJX
         tKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP40pwhes3z+V/FQcEriWr3dXl37/tkssjSAFxgoicg=;
        b=HH8loItn0J7khhAquEuvhTQJM73OGKd5Lqh8xKj6k/72LojrwB4t3CIgyVHJotozXs
         fPCdbDyMrcI03zHZxWOkS/b0xftB5joZBQDM/1vgY+2UslNV5MBJTr3rrcYWzSFqCKmL
         oLHpXwPku/coipOC0yqkJRxWkw04GOYYQ3lIGNfNy+IQd1vg6izuReX4DtXd3SKnNfLU
         06QX5tgEpfUrSJtbN0x4dudU9JWw0vz1RevUshPK/DPAmq9slQOhyp0GmdGHZw+QYSIZ
         FBtHeCVyzJD0MX5hcQVl+fAUlVaA3d2D/aJsCISQLtlMDZDn/0wDO9zKsEXC6lWqEoqQ
         f1bg==
X-Gm-Message-State: APjAAAWAtViFhoaFf4Rv+C5pOc+SIYhZVB1WxllNTfryWDrXjFfBjWzT
        Yyc5Oix1BsYIJVf/tdYIBTftGtiZM6kCORA4hT0=
X-Google-Smtp-Source: APXvYqxs3XuyY0ScEg/z+OlkdvWNspKSrPq/onkqZNMWIvGI1XzD3EBDC80Df/jotYhMXFqDiQR967tyHvePtAfla70=
X-Received: by 2002:a24:5493:: with SMTP id t141mr10511008ita.10.1554043247456;
 Sun, 31 Mar 2019 07:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <1549572447-45456-1-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1549572447-45456-1-git-send-email-justinpopo6@gmail.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Sun, 31 Mar 2019 10:40:35 -0400
Message-ID: <CAC=U0a3iidc1UyvXfedVBrPPU2qL9SomWu6yJwiMKpoXHwok=g@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
To:     justinpopo6@gmail.com
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 3:47 PM <justinpopo6@gmail.com> wrote:
>
> From: Justin Chen <justinpopo6@gmail.com>
>
> Currently we set the tx/rx buffer to 0xff when NULL. This causes
> problems with some spi slaves where 0xff is a valid command. Looking
> at other drivers, the tx/rx buffer is usually set to 0x00 when NULL.
> Following this convention solves the issue.
>
> Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

 Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
>  drivers/spi/spi-bcm-qspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
> index 584bcb0..79456aa 100644
> --- a/drivers/spi/spi-bcm-qspi.c
> +++ b/drivers/spi/spi-bcm-qspi.c
> @@ -681,7 +681,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
>                         if (buf)
>                                 buf[tp.byte] = read_rxram_slot_u8(qspi, slot);
>                         dev_dbg(&qspi->pdev->dev, "RD %02x\n",
> -                               buf ? buf[tp.byte] : 0xff);
> +                               buf ? buf[tp.byte] : 0x00);
>                 } else {
>                         u16 *buf = tp.trans->rx_buf;
>
> @@ -689,7 +689,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
>                                 buf[tp.byte / 2] = read_rxram_slot_u16(qspi,
>                                                                       slot);
>                         dev_dbg(&qspi->pdev->dev, "RD %04x\n",
> -                               buf ? buf[tp.byte] : 0xffff);
> +                               buf ? buf[tp.byte] : 0x0000);
>                 }
>
>                 update_qspi_trans_byte_count(qspi, &tp,
> @@ -744,13 +744,13 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
>         while (!tstatus && slot < MSPI_NUM_CDRAM) {
>                 if (tp.trans->bits_per_word <= 8) {
>                         const u8 *buf = tp.trans->tx_buf;
> -                       u8 val = buf ? buf[tp.byte] : 0xff;
> +                       u8 val = buf ? buf[tp.byte] : 0x00;
>
>                         write_txram_slot_u8(qspi, slot, val);
>                         dev_dbg(&qspi->pdev->dev, "WR %02x\n", val);
>                 } else {
>                         const u16 *buf = tp.trans->tx_buf;
> -                       u16 val = buf ? buf[tp.byte / 2] : 0xffff;
> +                       u16 val = buf ? buf[tp.byte / 2] : 0x0000;
>
>                         write_txram_slot_u16(qspi, slot, val);
>                         dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
> --
> 2.7.4
>
