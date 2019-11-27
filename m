Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22EFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E842070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuJxa/Tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK0M4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:56:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43411 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfK0M4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:56:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so1185299ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 04:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESDNcX2j2wV3RRHvi0m7qOVxbKl8Gg1XKDDLUvrXiIM=;
        b=HuJxa/Tq0QGb5+BagvPzC2PTLPDPNNwk2IYcF247JKl7/vVSCcT9VAUlb6Ag8TikPd
         N7ELBvol/fGhVmrxs+2g11IAXRbC1xn4IG7PcZnMnM0IaGTX/4Wxb832LWuopQRAbXvN
         aNEDNpEWLLsmQoPePfXGA72ZlD+fHPAD+P6pyL9oRGEoEi5Ppfk0PFGdfZzFsv3Ab4yE
         /TGxNDVg3Gz/f9H/ofoApS/+ColNP9imUOt2LpQWkSJu5hsY+7bU/b5f8kpzUy7SAmeW
         cSs42ybbVb1SGDhKariqBQTqiVPJjc9WWOiFBQHlsdaEuryVnCkIope/AzJsScfarzxm
         QEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESDNcX2j2wV3RRHvi0m7qOVxbKl8Gg1XKDDLUvrXiIM=;
        b=GlrtfJMEpfdVHVeQdXaFK+Uc8HmwYyDH1G5cs8gBdC9MC6QPNfv8oIBZZBphN4ZSrk
         PCVp+0pvDZ3MAIrWz5HW+lBfTcHSCq81MOoGUFrVsfR3XiIjXVUVs8nz7/gYvCPOKRmQ
         gRqZ1aAA/6UaHRyneAyqILyzrvjDdpeHiJdKIbsdi4lw56X+zTIWPY/xbhtLQH7xbasr
         STUbR61AdHf6IjzMaTC4k8SiiJRbFsWMBD2x8SVN8O/RseXQMhnHfIZFUX3VIQ5Qm1Bt
         e2eIK1TYOuZdwI1ArXJsrjaLv7BlXMRruGVY7bqUZj3b2eRx9tFpzCGcahun7A7KjiWV
         hLng==
X-Gm-Message-State: APjAAAUwrQGbFRMlO98Y9soO+sj1FzIE95eraCk6wP7Dc7F8A0Qq81MK
        ZRiLtZOaXrVFvXUdvIiGspeZo0J5+RwbOzHx6nM=
X-Google-Smtp-Source: APXvYqzA+dgKYhQrhd9TT6pP/+G+Ktsp8HQvcijdWb9/lJcRbmVA0un8HyJU2yNu8Ii1CPwfrqnCBQOz9DHP77VBqhw=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr17373155ljh.17.1574859390206;
 Wed, 27 Nov 2019 04:56:30 -0800 (PST)
MIME-Version: 1.0
References: <e39c043d-d098-283d-97b0-2a44aefec2f1@free.fr> <20191127124638.GC5108@optiplex>
In-Reply-To: <20191127124638.GC5108@optiplex>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Nov 2019 09:56:36 -0300
Message-ID: <CAOMZO5AeMgUjH4pxC4B1OFqHZDgtXs3dAiFazKEa9_txd81v6A@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Andrew Lunn <andrew@lunn.ch>, Peng Fan <peng.fan@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Wed, Nov 27, 2019 at 9:47 AM Oliver Graute <oliver.graute@gmail.com> wrote:

> I'am using this DTS which I'am currently working on:
>
> https://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/689501.html
> >
> > I bet one dollar that 6d4cd041f0af triggered a latent bug in the DTS.
>
> So what should I fix in my device tree?

Some suggestions you could try:

- Try to use phy-mode = "rgmii-id"; instead,
- The PHY address 0 does not match the reg value of 4, so you need to
double check the PHY address and make the @ and reg values to match.
- If you have a GPIO connected to the Ethernet PHY reset pin, then you
should describe it in the dts and also provide a delay as per the
AR803X datasheet.

Regards,

Fabio Estevam
