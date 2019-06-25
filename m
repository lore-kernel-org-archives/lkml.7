Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F4C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23F3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561501945;
	bh=cSuQxxaq84YwOFPQHIHja20RlhSxafVamByUrHvRrDQ=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=iXt+nPBVSX77O93Z/CYBh3fvTxkmBbYCIHL82MkwLgD1yXE3PswAJ82o4lOff1PV2
	 6brJ5T14zvP81z7tKnbG/isp2pKXLOEFLBCwMwXnNG0NrGsd2QYIBiiR9sxiGb8pF7
	 7N/ebsJJjR4P5momFU5kmKxIZMJs/P6UmAFSjqSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFYWcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfFYWcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:32:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8EC2053B;
        Tue, 25 Jun 2019 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561501943;
        bh=cSuQxxaq84YwOFPQHIHja20RlhSxafVamByUrHvRrDQ=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=uOThxdWIbQIHssS8dVd8WO2sv4HnWY9Krnf6kAdWBWn+vn4mff8AGaU7SXJfDPhQh
         R4W3J5zoId9HAY1DA6y3R2SF0uCSl/dNLEEHvscypDCrIjnWYyYi9IAO2n+zDnSwEJ
         9POD0+D4ltW1DyG5nDqCpTX0MxTKdezfL79viuNE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561453316-11481-1-git-send-email-abel.vesa@nxp.com>
References: <1561453316-11481-1-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx8mq: Mark AHB clock as critical
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:32:22 -0700
Message-Id: <20190625223223.3B8EC2053B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-06-25 02:01:56)
> Keep the AHB clock always on since there is no driver to control it and
> all the other clocks that use it as parent rely on it being always enable=
d.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 5fbc2a7..b48268b 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -398,7 +398,7 @@ static int imx8mq_clocks_probe(struct platform_device=
 *pdev)
>         clks[IMX8MQ_CLK_NOC_APB] =3D imx8m_clk_composite_critical("noc_ap=
b", imx8mq_noc_apb_sels, base + 0x8d80);
> =20
>         /* AHB */
> -       clks[IMX8MQ_CLK_AHB] =3D imx8m_clk_composite("ahb", imx8mq_ahb_se=
ls, base + 0x9000);
> +       clks[IMX8MQ_CLK_AHB] =3D imx8m_clk_composite_critical("ahb", imx8=
mq_ahb_sels, base + 0x9000);

Please add a comment into the code why it's critical.

>         clks[IMX8MQ_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb", i=
mx8mq_audio_ahb_sels, base + 0x9100);
> =20
>         /* IPG */
> --=20
> 2.7.4
>=20
