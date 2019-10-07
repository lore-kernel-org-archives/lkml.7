Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FBFECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F59E20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g52E3LKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfJGNis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:38:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41662 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJGNis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:38:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id f20so12454277edv.8;
        Mon, 07 Oct 2019 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BogXmgVnKqJ+AQ/JaMHMUj54c+Ae56aiHU6T/FwepGs=;
        b=g52E3LKX6HzncFVPxZhtjKw6pzGAaTXm9pWBf1tyC/3EvHOGfeYSjJC/9vSg9xxmfa
         r3uKIl8xFPHHEHiFDi6fcw7E0y07LBlcfMssl3B7vfFWz507YOGAIidkMreErohT20Ix
         MUdABIzGLoCRcGgZkucj7jox/H/qzcDKcbDwzcy4pOfMlOosuf6LMx7acjxldQOiPSFL
         bE+FvjHpt7Ln2cVW19G/Udu+7RyUjF1WdQZ6CF6/6XIdKd0CDwSippukcvLTaHdJcvaV
         zeYRDN10gAPnSErN1fDAq4E88/n3O7YNSnJrJU+85Pw0eGbDz4tLhDCbZx40a/6L4oPU
         vaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BogXmgVnKqJ+AQ/JaMHMUj54c+Ae56aiHU6T/FwepGs=;
        b=Hc0bcmT243ari4fxqwtgU20h+mdfFpp4+yNuK+bXDxtzJiEjkEq+cEnsYN8dr8ka2B
         0xmlWVeYjXhWPAKHqKDShRbVxY3C18x4cyOgCIUV2viJoH8mEEzGp9biYFLwVwDDvbJ8
         sBzbW1TQGmUk2RywBFmw/myLPeftnVASCDuxdV/WwhLAA/UzPmfqI+RJqMhs3IiWE1AM
         7e6pIS9UF0avKRDLIgDQ7eajcwIzAWDZxZ2lRDg1lPh/eFVHdTq/ss32ujaRqjUN+obI
         kiBWeoh8YwKeX9QmjHgoR/giZG+8gOIsyB/9EWvMukb9bybpZoHM/T+KRR0GVd0fRzVd
         EyWg==
X-Gm-Message-State: APjAAAVmRka6O9OnxNgl9OhnALy1JLbw9un/FOZrMuxkNG1IUKq21UvM
        pYArKSZ2SNMtZgW/sNQC4YtbTqM+MZajdApci2g=
X-Google-Smtp-Source: APXvYqwYkVkAMrD9bm9pPuHaU98To0XXlkK7s5HbAS2iqjb1se9dDWzI/lBmBgrEvZmI5h4RHnsiv+YVuiBgR4hMKbU=
X-Received: by 2002:a17:907:211c:: with SMTP id qn28mr24238258ejb.244.1570455524911;
 Mon, 07 Oct 2019 06:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191007124607.20618-1-igor.opaniuk@gmail.com>
 <20191007124607.20618-3-igor.opaniuk@gmail.com> <CAOMZO5B-XWxiu3iqc85UZT0c5WTHBx9on8x1Za_dS7Gj7h1K2w@mail.gmail.com>
In-Reply-To: <CAOMZO5B-XWxiu3iqc85UZT0c5WTHBx9on8x1Za_dS7Gj7h1K2w@mail.gmail.com>
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
Date:   Mon, 7 Oct 2019 16:38:33 +0300
Message-ID: <CAByghJZBy2gU_98aM++YANDAvvY_Mtbow4fvzYp=Fd+mzJTTuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] usb: phy: mxs: optimize disconnect line condition
To:     Fabio Estevam <festevam@gmail.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Li Jun <jun.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Fabio,

On Mon, Oct 7, 2019 at 3:51 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Igor,
>
> On Mon, Oct 7, 2019 at 9:47 AM Igor Opaniuk <igor.opaniuk@gmail.com> wrot=
e:
> >
> > From: Igor Opaniuk <igor.opaniuk@toradex.com>
> >
> > We only have below cases to disconnect line when suspend:
> > 1. Device mode without connection to any host/charger(no vbus).
> > 2. Device mode connect to a charger, usb suspend when
> > system is entering suspend.
> >
> > This patch can fix cases, when usb phy wrongly does disconnect
> > line in case usb host enters suspend but vbus is off.
> >
> > Signed-off-by: Li Jun <jun.li@nxp.com>
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
>
> Who is the original author of this patch, is it you or Li Jun?
>
> If it is Li Jun, then his name should appear in the From field.
right, it's Li Jun, will fix in v1.

>
> Also, it seems a Fixes tag is needed here.
right, will do.

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+380 (93) 836 40 67
http://ua.linkedin.com/in/iopaniuk
