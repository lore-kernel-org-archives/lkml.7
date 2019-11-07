Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3049C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42472178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L0nL7Xxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKGGhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:37:32 -0500
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:31558
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbfKGGhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:37:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlNFw82usSFNqWQzcgJnWOTkxr8WESw/jFHy5RNjvepoOK6LYTgqT0fVESiQq8Qhy527rhQuAvzBPmArt1Md3mo19XsOJ3DomUAXsEn6MbO5aHHnFXJKXmb9nbXMZsuPaS/+z6zoN7QMWGun6A6lpO3AMqsO/QnGIwfW3DqbbaaFO6u38D3K67mgkbTLK0Nw2anqLCN4dnJfvKelIUvWi5XVWF2sBgeQ0yFNry4gc4fd6kIuUb5vmAFymtBn7ePyystsWVtQcL84hXG6YwewIvHY4GmYFiLYQjRL4ZO4hDxKuOxa0B6KqxgGJ/FjKEXCG1KrEeHwY+qXCi4zDY0/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNXtmNcbX8LR1o+A1iR2EMBYqSMdKw6VuTf18QE9WfU=;
 b=FOBKXjji3OsUMhkBnvVK9SFLbr/4wG2+6UhLzn5w34At3DepMgB5yKLFPBAYMlOos3w2tfhNv073XYwb5BroBprK74PCwW0kOZM+XkrFA+ktmuDwrV1eyRK46vtfuGjN2M8m0+WKGFxr+TIITyv8wkpamGXDWNZtbGU7WShE8jt35HU/siMRHTDM5s5tK7QkPdKsq1FCD9iiPdPlI/zQpFUDQtoy3G4mso7JEgWOXRoFyF9BWDpAYR++mRuKnZBD1U6xOvQkbxTRQhjQaMaT8j4eCbWPKPVlodgFY7GpwsnOHzuHP+heZMXyWEpYdoQDfAMYRyluKe8aY/wCSUCWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNXtmNcbX8LR1o+A1iR2EMBYqSMdKw6VuTf18QE9WfU=;
 b=L0nL7XxxwAvDfFq+d9ccDMviIf9cdV1/eUn/B6lAmqMZj4go9PbrraB3U9+ZSyoTGIl93kLmsbyqLwdLueFasEGgXxCL/NJIzCdgZJYr0IV6waqW6AK1CH8AvTUcS77mR1qQSe7jJO5bMc6iAKuZhsc56HKt33Hcw0ta3lqY+1A=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4908.eurprd04.prod.outlook.com (20.176.234.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 06:37:28 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c%7]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 06:37:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] tty: serial: imx: use the sg count from dma_map_sg
Thread-Topic: [PATCH] tty: serial: imx: use the sg count from dma_map_sg
Thread-Index: AQHVlRfNofENwEaBB0GOB39FR9UWa6d/QU4w
Date:   Thu, 7 Nov 2019 06:37:28 +0000
Message-ID: <DB7PR04MB4490A84F6E06BD2D54261A9688780@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <1573095656-749-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573095656-749-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ccee4f5-b03c-495b-ab4e-08d7634cf570
x-ms-traffictypediagnostic: DB7PR04MB4908:|DB7PR04MB4908:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB49080293535D7A357664FE5E88780@DB7PR04MB4908.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(76116006)(66556008)(2906002)(66476007)(64756008)(66946007)(476003)(66446008)(316002)(33656002)(3846002)(7736002)(305945005)(74316002)(8676002)(54906003)(76176011)(6116002)(6506007)(102836004)(81156014)(186003)(7696005)(26005)(8936002)(81166006)(110136005)(71190400001)(71200400001)(44832011)(478600001)(14444005)(11346002)(256004)(486006)(99286004)(86362001)(9686003)(2201001)(14454004)(6246003)(25786009)(55016002)(229853002)(52536014)(4326008)(5660300002)(6436002)(66066001)(2501003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4908;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwYQUAaq5BoSHxJXdNQwomCf7e+4yo5118ac30egXxSma95JyITWQaY1d/tFhnYinsuNstZiokAtPSvsNPFYyjxKy286dTlZvLrjEr76NF3BE1wfiUvFPv/GMfiCbGoWFh6gyRKf4aZTDLBJEgQ3i/5DjLN/bHpE14BuRn9deuwJRWkvSwrRTHBfVPkkDKHyJjCPjoAMsYpl1D2IzLFw6Hrnsc5s4cJEmPTRtOLSsDFe+Cj7E50bC/coaBM3F/NyNEJOd6mPletpHGm4AqehVieIahG1UzB0UC5kTvtQJ6oHQQ/3t4BsnhiiQ/hnSiVew9PeBNAFxgakDJxJasRwv1MZPgHVejGiTUMtJCJR9QUzIYrn9FDV/MPklEiy21DN1HXK7h6IAgd2JIS28/1FQnINWTVs9nhdwrweKmJHSzGt2RF247V9WbaI/1ZHxtab
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccee4f5-b03c-495b-ab4e-08d7634cf570
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 06:37:28.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnOdgEwCrxf9t8kjFTGjsBfydE6nq8PiLeDrg2pKmCMlxmKuCIiMYJvnL+DAeHnkpu3aVg7oUlKQhh+UjpTL2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] tty: serial: imx: use the sg count from dma_map_sg

Ignore this patch. Wrong fix, will have V2.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The dmaengine_prep_slave_sg needs to use sg count returned by
> dma_map_sg, not use sport->dma_tx_nents, because the return value of
> dma_map_sg is not always same with "nents".
>=20
> And update sport->dma_tx_nents with value from dma_map_sg to avoid
> modifing dma_unmap_sg
>=20
> Fixes: b4cdc8f61beb("serial: imx: add DMA support for imx6q")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> 87c58f9f6390..bda7f59ec60e 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -619,6 +619,9 @@ static void imx_uart_dma_tx(struct imx_port *sport)
>  		dev_err(dev, "DMA mapping error for TX.\n");
>  		return;
>  	}
> +
> +	sport->dma_tx_nents =3D ret;
> +
>  	desc =3D dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
>  					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
>  	if (!desc) {
> --
> 2.16.4

