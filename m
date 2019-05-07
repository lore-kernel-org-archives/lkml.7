Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196F0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE052087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYDBlMQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfEGKzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:55:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35418 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGKzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:55:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id m20so4675733lji.2;
        Tue, 07 May 2019 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VXRQC0UsjauveYOiCa1HYIm6GnidpMCvjvUYDOoy8Kk=;
        b=VYDBlMQM/nMdmQESkPNOIOO0h9ONTG/hgvDy8XsTml1o4qUTDLnhRfle9wOL/Zaklv
         va6dq8w70Itj6U1a0GNuU53NVSeQs+Q9lAbDTHZiUh+C+h/TgpwHaZIBejQg3Qw7TqiJ
         o0ISt0SNZCrwyBVZwDgyDHFTeGtQXJZmLvamAW0ayMpIs26LlnmNy7C4hivNW+Rq4Sdm
         HzBc0KFQsIdMtAqpLaeadJXI0mSLZcJOFcmIIejiZZtn1YNFT/XUO9vCu2ckz5yrNVTZ
         aqPylUWrfsjepkTy7Al4ppslefHU6G3Xu6BjPt/OyzO1KDl75KQip4qak1B1XeKUb4ep
         qTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VXRQC0UsjauveYOiCa1HYIm6GnidpMCvjvUYDOoy8Kk=;
        b=KhK47tB9ktGgPssfLoOufC83X8boXDEQEfdZs2Leg+HTjuX67lt6O+NIXmqqUuAsLm
         lsZGuF/hhwIKdJoIRgqGyu+hcxFh8cvnCPhPBohgkHTRgzUuWvPVj7+QsfkypHCQ0K7T
         yVR/R4m6pxS+XlSLMcyxOJFLt18xwOaWd5dPf2EeQerLYz+Fua1/NHUJBnXlQU9ULPud
         msSNpOuCNqHOGo+Im6QhmnEdtn5asfq05A90F+EMD5veKUk7gIEfUlt0y91a4fF0P9JW
         kAZ9bWnB7VBYm2CUHE9GKVVes2mQ34X/xVYc3FK5wipljw945kz4mFFbwLr6b5ygrME6
         54cw==
X-Gm-Message-State: APjAAAUpLmJBaYcoGV1qHwn7YiCg4kdnEW4t7ebSmvFt+Ot/M0QZ5dbr
        mX/apRg9DNjs3xerFXlupExmzQlpTiJydjDO80M=
X-Google-Smtp-Source: APXvYqzG7AIMRfvZsHfREXhwZ2Vicp5dmMb3CrEXJw5WkOuq4TRI1BSQoriBbA7VwVewocx0xBmOjkzmaCaPMCXnOmg=
X-Received: by 2002:a2e:390c:: with SMTP id g12mr18105225lja.174.1557226518508;
 Tue, 07 May 2019 03:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557215047.git.agx@sigxcpu.org> <299e28042e0a24c0cde593873bdfb15e18187a92.1557215047.git.agx@sigxcpu.org>
In-Reply-To: <299e28042e0a24c0cde593873bdfb15e18187a92.1557215047.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 May 2019 07:55:23 -0300
Message-ID: <CAOMZO5CQXmmw50J3Pjy8wKOr+BBEo_-B9ChV32bq1Re4_0-4CQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] phy: Add driver for mixel mipi dphy found on
 NXP's i.MX8 SoCs
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 4:47 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> This adds support for the Mixel DPHY as found on i.MX8 CPUs but since
> this is an IP core it will likely be found on others in the future. So
> instead of adding this to the nwl host driver make it a generic PHY
> driver.
>
> The driver supports the i.MX8MQ. Support for i.MX8QM and i.MX8QXP can be
> added once the necessary system controller bits are in via
> mixel_dphy_devdata.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Co-developed-by: Robert Chiras <robert.chiras@nxp.com>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
