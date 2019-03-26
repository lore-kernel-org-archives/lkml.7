Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DB920863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553606432;
	bh=++ohudIKf1bylFwoG3UmwPuW2ukf9kVYeU/M5rF+bmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RdomOp7YtF/K3xbIX6kpoTWG04lSEVDu/gGYCmRMSnZ+YyX5AqDQv6thlYzBdrlDF
	 ECcgeomqA42f2hg5SLPbjnMKCZ2JSpRCpVbeQWL0F1yfDNa+kSn9izn+gXirPAEBjq
	 YZxylzklciWPdkViHYr2QWllge2TRf/2L1rzcOqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfCZNUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZNUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:20:30 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA4920863
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553606429;
        bh=++ohudIKf1bylFwoG3UmwPuW2ukf9kVYeU/M5rF+bmo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2q+DXd2ousbmZ36gmi4RAi0EvIocE3oZZVgIKtrA7JScb4+TqrSIJS2TrRz1+T4xW
         K6kvjbAuQgn+iJtxI1eFFkKQQAlVsor6MFUd9TNzhcfHqpqwWmwbYc6R4BsvIUqKeQ
         cqjGGs3lDh7FfDiJBf3uj6XAFL0z2u8EsJhoP9mw=
Received: by mail-qk1-f173.google.com with SMTP id w20so7543047qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 06:20:29 -0700 (PDT)
X-Gm-Message-State: APjAAAWCgCDZ/ZbhHjvriL1ciqwNKooAZsCIpOmfmCThEIyRhuHjNYSh
        MKLJMTBRUj1jGZjDAltltM77EOUUfeP61d2X3Q==
X-Google-Smtp-Source: APXvYqwLhm3F7MHYJc20XaAxnbgSAVYQRSSuJhlpvh8A2yL36LQwsOYqDYoH6t0DrKho3KZTjoW0z8oLeQ0aXp+uh08=
X-Received: by 2002:a37:d285:: with SMTP id f127mr24509566qkj.147.1553606428266;
 Tue, 26 Mar 2019 06:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553523114.git.agx@sigxcpu.org> <3319783f60fedd7f0029dd60a51c76a75003fe05.1553523114.git.agx@sigxcpu.org>
In-Reply-To: <3319783f60fedd7f0029dd60a51c76a75003fe05.1553523114.git.agx@sigxcpu.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Mar 2019 08:20:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJrct6atOOto4hdDaRZKhnPda7ATV=7+OofWNUJFD=i8Q@mail.gmail.com>
Message-ID: <CAL_JsqJrct6atOOto4hdDaRZKhnPda7ATV=7+OofWNUJFD=i8Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] dt-bindings: phy: Add documentation for mixel dphy
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 9:14 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Add support for the MIXEL DPHY IP as found in the NXP's i.MX8MQ.

Please use get_maintainers.pl and send patches to the correct lists.

>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../bindings/phy/mixel,mipi-dsi-phy.txt       | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-=
phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt=
 b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> new file mode 100644
> index 000000000000..d3646580412a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> @@ -0,0 +1,29 @@
> +Mixel DSI PHY for i.MX8
> +
> +The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along =
the
> +MIPI-DSI IP from Northwest Logic). It represents the physical layer for =
the
> +electrical signals for DSI.
> +
> +Required properties:
> +- compatible: Must be:
> +  - "mixel,imx8mq-mipi-dphy"
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Must contain the following entries:
> +  - "phy_ref": phandle and specifier referring to the DPHY ref clock
> +- reg: the register range of the PHY controller
> +- #phy-cells: number of cells in PHY, as defined in
> +  Documentation/devicetree/bindings/phy/phy-bindings.txt
> +  this must be <0>
> +
> +Optional properties:
> +- power-domains: phandle to power domain
> +
> +Example:
> +       mipi_dphy: mipi_dphy@30A0030 {

dphy@30a0030

> +               compatible =3D "mixel,imx8mq-mipi-dphy";
> +               clocks =3D <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +               clock-names =3D "phy_ref";
> +               reg =3D <0x30A00300 0x100>;
> +               power-domains =3D <&pd_mipi0>;
> +               #phy-cells =3D <0>;
> +        };
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
