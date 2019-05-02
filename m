Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE61BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBBC21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0Ah6TDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEBP26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:28:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40161 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfEBP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id o16so2194143lfl.7;
        Thu, 02 May 2019 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=prm1fyhXs0jWTAHPn6CLV/HtaSlxTqydNTX71G2xSCs=;
        b=r0Ah6TDQTHwK7cH76U0v6wgZe6avx5iEHW7ZyZtQeMWJ0BM96xdA5Cl0z7TybVCWq2
         GdJs4hBIjaMk2+bN1HDaTf6zOqe5hO2sgp6ZtwfTS5/fgwSJDtrNJWjCDsbNjpl3/Sa4
         pymiyFG6nYLpfuMR0Z6lMg2u0eUJ4y2Q7N2OfhBsIvVvaOFxPAvTamFXL7Nc7D/v6Wfu
         IAjQPZdRp88rdrNlYeCMsQUlqoccabRM797x4zAWUFICHLLBwyerZdw7uU9+/LxV2+Cf
         JPDpJOTOT9fun6uCI1IgogwQHc91rbibBlm3/21cJycV86XiKrFcKaWknQV1nMlUbn7F
         S9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=prm1fyhXs0jWTAHPn6CLV/HtaSlxTqydNTX71G2xSCs=;
        b=da7XReLoTdCycnQ2Jbl/0iF4haiP5uF7YMWetEv/mlynALo1sON1DqkLzlp+KpL35p
         NbSN1tZ781FacuMU9QCa5SgC8Vy2GqEKzpqbi+zwO6d6CNVm6PmsIAbnRZmVHgAEuueB
         0Z4Y2/6LiwEk02FiwwTQn2UcQyZctJRle/lDIdteQSUGg/awodmE0rX42xNPxBXxYAA2
         0EHI2nB+Q31dmngcLqvT348X3mfBUJZSiv+JRxUiQCeY8v1sChSHWqDG8dWP3fzYY37V
         qkgSeC8x0YikSVxT43/ddoaajmkXJl7BH1VLtxXotFw18+7e5Ve7cIqt36S2vlJ3P7EE
         gLkQ==
X-Gm-Message-State: APjAAAXfHWs61zcOWrSXzrVx6WgavmHMaGmrAZXaXtilHl242T/6sCRw
        ojA4g93aLpQE0PHiIJcBbVdbr729ATcqKuXD+9s=
X-Google-Smtp-Source: APXvYqzMcVGIejleD+/wKh8TcnzqGnJxMNAmrH86SrHVOreuURuClXNb7c4WEX+3sFRf5peisBBVvSR/1IhjXSA4LuM=
X-Received: by 2002:a19:f001:: with SMTP id p1mr2498539lfc.27.1556810932481;
 Thu, 02 May 2019 08:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190430074730.8236-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20190430074730.8236-1-sebastien.szymanski@armadeus.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 2 May 2019 12:28:46 -0300
Message-ID: <CAOMZO5D=BHWgOieLfz4bxL8v4bDmNOutUUnYSzW89KNtYn=Z9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: Add csi node
To:     =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Rui Miguel Silva <rui.silva@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Rui]

On Tue, Apr 30, 2019 at 4:47 AM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> Add csi node for i.MX6UL SoC.
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dts=
i
> index 62ed30c781ed..af322bc58333 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -951,6 +951,17 @@
>                                 };
>                         };
>
> +                       csi: csi@21c4000 {
> +                               compatible =3D "fsl,imx6ul-csi", "fsl,imx=
7-csi";
> +                               reg =3D <0x021c4000 0x4000>;
> +                               interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_=
HIGH>;
> +                               clocks =3D <&clks IMX6UL_CLK_DUMMY>,
> +                                        <&clks IMX6UL_CLK_CSI>,
> +                                        <&clks IMX6UL_CLK_DUMMY>;
> +                               clock-names =3D "axi", "mclk", "dcic";

Also, I understand you followed
Documentation/devicetree/bindings/media/imx7-csi.txt and passed these
three clocks, but looking at the i.MX7D and i.MX6UL/ULL Reference
Manuals, I don't find the  the descriptions for the "axi" and "dcic"
CSI clocks.

It looks like that only "mclk" is what we really need here.

Should we change the bindings and the imx7-csi driver to not request
"axi" and "dcic" clocks?

Rui, what do you think? If you agree I can send a fix for this.

Thanks
