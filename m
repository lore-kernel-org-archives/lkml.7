Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D0CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B202147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EyGUhTcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfCKVE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:04:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36493 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfCKVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:04:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id t206so312408oib.3;
        Mon, 11 Mar 2019 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyEh/q1GP+1TyFUYOgVLvvn+RIucRiEc6k1EbDSBA+o=;
        b=EyGUhTcuTghuetEBkt2+jsJOxfLGtCb8lsuNzw6mUtAQHjZ/MxHGGeu78tpFGmiYaU
         QuOQJSXwTGzPx57TFEV32wbFVS9eDLS/FtTYZus87W9p6oMYu9d1gBWg1SYasoZzVwqL
         NMXA/jRkNYxSkd1KaIytdw/Yw8AvcyYE4eG6BwuRTiQmH9O2I2aHxx4E+AVTWjsrywUk
         aXgekKfN43Y2pwsnXrLql30VlpTCrexJRQRcmBzLTwU3viBtiYIhiYvEcK15dDkn33fI
         sxR1JEDVwm46VdWqsJjPtmiMYr+HbINMwVR6NzkLLUyDebBaYamPyYdz9nRqv7XfxrOx
         hx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyEh/q1GP+1TyFUYOgVLvvn+RIucRiEc6k1EbDSBA+o=;
        b=PrFfbeO7O4qjjXH0ODotqx+CDuibuAas3GUqaRCYxhX3IT+3k6+untsnYPG7wZS02G
         YGabS74XQUMUHj+B4/3OYaKPV8Xt3AreF4fCwSKj6D7xEgOBsnnmTLxglT3ZUyKFk6TA
         mAbu+9x7hQvlaGNNbZ4LySrizLMNtEFsIG5yHYnobzsxa5Mwz64ky/N+E7fEWyX7mXhi
         IxNeAon8uHQBP4G6GgmDdBB8wgOEkCdC0+G2iKZ5j4nM6N/8javKgEUUf6avAuFomDGs
         9EL+yAoESQ4Ajj3tPMMtoGtdR5YBquLZAaH9Mo98q04qnJkA0wRcpZofPSgw/RfDI67v
         QNfA==
X-Gm-Message-State: APjAAAX5mU/ggwPkyfHdWf8ywl0sa4NSPt2Z8qsrlXex6QQMSPJnO1rn
        /iyWVTAp2QNDrewYoMz4qm1E9tzIzSVMSkwvRYI=
X-Google-Smtp-Source: APXvYqyUMz74cjyyJyPY950MjOdrXSuPDzrF2i3ApYJtGbQefLPpFqXhEy1ibyXj6TkjGZI6pVygfhf3cPeIdIp4MsU=
X-Received: by 2002:aca:c286:: with SMTP id s128mr137941oif.39.1552338298130;
 Mon, 11 Mar 2019 14:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190304103846.2060-1-narmstrong@baylibre.com>
 <20190304103846.2060-6-narmstrong@baylibre.com> <CAFBinCAacdsjwtg_RK=e=Lnep7oLF+eTBmkb1FB4nFR129z1jA@mail.gmail.com>
 <bd9d1b4b-4dd7-864e-b197-c5993d3dd24f@baylibre.com>
In-Reply-To: <bd9d1b4b-4dd7-864e-b197-c5993d3dd24f@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 11 Mar 2019 22:04:47 +0100
Message-ID: <CAFBinCCuWvm203nQFw6y3Nwoj_TxqgRk7X-N8O_P=SjAGJwDWA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: amlogic: add Amlogic G12A USB2 PHY Driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Mar 7, 2019 at 9:41 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> >> +static int phy_meson_g12a_usb2_exit(struct phy *phy)
> >> +{
> >> +       struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
> >> +
> >> +       return reset_control_reset(priv->reset);
> > do you know whether we should reset_control_assert here instead of
> > reset_control_reset?
> > the probe function below already uses reset_control_deassert, so the
> > current implementation is inconsistent. in v1 you replied with "Maybe
> > it would be better, indeed." - if there's a reason why
> > reset_control_assert doesn't work here then I would like to have a
> > comment stating why
>
> It's not clear yet, I implemented it safe here since in my tests, when
> I left the USB2 PHYs resetted, it was kept resetted on a soft system reset
> and the ROM was not able to setup the PHY correctly.
that's probably why Amlogic's kernel also uses a reset pulse

> So maybe it's wrong for power management, it's safer to simply to keep the
> PHYs unresetted when unused.
if you re-send this patch anyways (to clean up the #include) can you
please add a comment with the explanation from above?

> > Apart from these two this is looking good!
> > Human readable BIT/GENMASK #defines for the register bits would be
> > nice, but I'm not sure if you have the details to add these.
>
> I have the registers set in the doc, but it's much longer than copying
> the registers structs from the vendor kernel, so I postponed it.
>
> I'll try adding these, but for now it's low priority unless the PHY maintainer
> asks for them.
ACK, it's not high priority, so it's fine for now

with the #include changed and a comment for the reset pulse you can add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
