Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD14C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B8B2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 12:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMz9JSdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKWMZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 07:25:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33131 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKWMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 07:25:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id d6so7568051lfc.0;
        Sat, 23 Nov 2019 04:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9bPAlk5H2fFBXl0/0I4i5G2Ml8jO2DAr9KJz+P/jaNM=;
        b=hMz9JSdbYfwAELa86xEHNr1O7KXvsq3+gr5CsMLffgYSX5wBrihmbcjyM160ayxp+b
         jvO9CsICpjigJ1qkaLw+WOC/Um36kx6tqeUarGxd6zg2K2jCO1IX6VgiwjvzMn4pca33
         F+Wsylt8DUg0XhXP7TB4kPMhe30T+Qy3YgvT+OmMeDh/seYThT51QvgdHC+nXIxaaimb
         V2zgALbHaiuTEByoPz435dp8Rz8SJk0SKMWKHOKV5btevBv5sRh/AzuYn4WJcO98xVSf
         I0M/6BOKane8ZrNwbsyRuS/VnyyG/Gw3164wiOtqzr+aefeozljJhkFQ3D9O1bdOgbMy
         yXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9bPAlk5H2fFBXl0/0I4i5G2Ml8jO2DAr9KJz+P/jaNM=;
        b=Yrk4mdomM7z5KUnyJqZiPsSU54TlnICEoQfVa7S/FI4MEUaE6yrImhEB1xJ4dJVPNL
         gJoqiKM3LdZZKe2TzMHg9GVnZX8Fr8+hNoT5fY7FHvI6vhHV/W/1sy4/L9UVOQPI9Hez
         vYtZqtlikdTE8oaYJ/ll7EZ/k4xgAeiO+WPLMld3t4I+9Xj6zHbgGGCWiLHASN2DcU4u
         tMPMElXrIne2HqUtwla8Fgsva1uAGumhyiyKJXkwpYkCP8qGrD7d+6ZYmRGgrYtRuu9+
         FWkIpZZp3g1JBVfVNComsA1vL9yak/cWBQ7W/dNjbsDLNAUOMvmrV4kQesGV+KVdh54q
         XjHw==
X-Gm-Message-State: APjAAAWh5LvurVBlERBPTACpYYzwOnLncKfhnwACnMCdk7NVU2Mbdccs
        n/5rqFaPNN5egLbjIC5O+LJSvv4kqpcrBWTv/AA=
X-Google-Smtp-Source: APXvYqxT6NcFyrouxig79V/rPjUvKpEFe1luhwbSFTmicydLzuc/d74UY/7a8ZEjpUaytHq3g+1nOkyT7gKYrTj6kG4=
X-Received: by 2002:ac2:533c:: with SMTP id f28mr9419931lfh.12.1574511919258;
 Sat, 23 Nov 2019 04:25:19 -0800 (PST)
MIME-Version: 1.0
References: <59793b1ae533636528942b2cec14ec68b9830fcf.1574510649.git.agx@sigxcpu.org>
In-Reply-To: <59793b1ae533636528942b2cec14ec68b9830fcf.1574510649.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 23 Nov 2019 09:25:21 -0300
Message-ID: <CAOMZO5B_RWoUA3AX=ivAbEPFMQyD+WO8v1t20gZVef7zDz2YuQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add eLCDIF controller
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Sat, Nov 23, 2019 at 9:09 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi
> index 7f9319452b58..00aa63bfd816 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -448,6 +448,23 @@
>                                 fsl,sdma-ram-script-name =3D "imx/sdma/sd=
ma-imx7d.bin";
>                         };
>
> +                       lcdif: lcdif@30320000 {
> +                               compatible =3D "fsl,imx8mq-lcdif", "fsl,i=
mx28-lcdif";

fsl,imx8mq-lcdif should also be documented.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
