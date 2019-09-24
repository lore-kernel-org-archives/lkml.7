Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05168C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86A620820
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aonNFhhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408420AbfIXBi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:38:57 -0400
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:47425
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729129AbfIXBi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAPveNLFgHkKg0TnuMrVYFysQRnB8C1Ld1HcEEMPWRqt2OpB0H6frUePkaffrrpmGfGcA2yERhCEI40jCiaKO8pGnExjV/6W9eY6j/7lSzHhqfzv15raFSJeMFoBnS3XPVu295Cd7ZT8HHAXo0iR3/1CQzQIFp7lxHXinjJ36GLg5LHYBKzEe9s9tnthCHbIJJj7jtrArIVQLcCaj9uSt4QHDITbm+vOmx4a4VyYUaES4HEwAmW4mjNChZhfnIwD5PSWJX5oWZDAudwnBY99fQkYon1jcLbOoOrPJMOMxKrZpuSRWFeXzRh0qXFvCDdEUkcSNWy9nXHSnN7FtdAHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnIRD6or0+5xL1WvTSxYAdQ6kcMLorgwl0F7Avgbquc=;
 b=KC1pbbNj7jLb32BD/3pg/Lv4AXT/3OgYRSKPFczh8bqz9bePK+caujnvkxHqY0oBA8BrlvTlzduLc1TAyuJk72BJG0TBjs0Kl2ro/pQZQAcBddAqhUjSJ+idmGzCRJd/QoTKL/pGvQi37abAQCTFrsqz6MuE7s8OFdIZe1nIjZaBc518yogiYZJaeQ811zIj3Lyvxx48jl+uvdqPR02rj96qR3LPHkS72OJkLm9qhksjDmLchIL0wnpEcl92T+Oj9NwpIHx+c1ku9+7h82/4RseYwiVehHK+lR5mPyMJtApUTN+4kfyGcDilQrQEU0NV/yahITY/FX0VBrjp7sBynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnIRD6or0+5xL1WvTSxYAdQ6kcMLorgwl0F7Avgbquc=;
 b=aonNFhheYhPtkvoN68UcAlvGR/KyaAPFcBI8y3upkLE3LdfG/qFYJl8EyqW0ywAW4xayEZCizYb++FgZ8IuUunZ+dqkeE4/NWfqtd1AiV5/HDHc2PvxiK3AbkdBzNFE4NtOj9BKNjTxGX0MD6JCOLGxhsjpHkKY+9w/HxxH3xqU=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6511.eurprd04.prod.outlook.com (20.179.233.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 01:38:50 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 01:38:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Duan <fugang.duan@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.or" <dmaengine@vger.kernel.or>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 2/3] dmaengine: imx-sdma: fix dma freezes
Thread-Topic: [PATCH v4 2/3] dmaengine: imx-sdma: fix dma freezes
Thread-Index: AQHVbvaw7dXFB7AvOUuEjPPnVNzhIKc6C1wA
Date:   Tue, 24 Sep 2019 01:38:50 +0000
Message-ID: <VE1PR04MB66383C69998D640F66A8D1DC89840@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190919142942.12469-1-philipp.puschmann@emlix.com>
 <20190919142942.12469-3-philipp.puschmann@emlix.com>
In-Reply-To: <20190919142942.12469-3-philipp.puschmann@emlix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b706b8f7-867d-4cf2-45de-08d7408ff34d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6511;
x-ms-traffictypediagnostic: VE1PR04MB6511:|VE1PR04MB6511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6511825891C91BFD8A405ED789840@VE1PR04MB6511.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(54534003)(199004)(189003)(52536014)(102836004)(5660300002)(11346002)(66446008)(76116006)(86362001)(81166006)(81156014)(478600001)(8676002)(305945005)(7736002)(25786009)(26005)(9686003)(6246003)(186003)(316002)(8936002)(14454004)(486006)(6506007)(33656002)(66476007)(7696005)(66556008)(74316002)(3846002)(66946007)(6116002)(55016002)(7416002)(71190400001)(4326008)(4001150100001)(64756008)(54906003)(66066001)(2906002)(76176011)(476003)(99286004)(256004)(229853002)(6436002)(2501003)(71200400001)(110136005)(14444005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6511;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d4PhIgDP3xSAym6ielLfsL+JGcpZuIw4y+Obo32w4jX71+d90ijTs0d0PI1sWSzaBon0R0JhBEeMYHZlaLdxNpdNsiDIAbqw3BNNlSflZlfQjgSskRvURErubELSJprs97w/Evg3UtOXNErrZJho7U7Zp7ldoBTlqhgzWyj/LRshOZ33iU/tyUSsQo4q1Wc3+e2DkadWwz202XmGVnplCPvc8R7+mhozj3gDovlV5yYR8iNVUfA6XL/V/mYeg64g9oIzWuBglCu97/eLcXdPqiupUVaR4pclTwWGY3G6xsc6+W7BxcYAXqq54aRKXC5iHrxG2eLvdiiwQUUkcvIzl718wR0g5zV68RSZNA11e6ez78SOi1kmVwPasM8fK0l95PBe/lgUAhMli4cjMroXzmdNPzRqeaoRc2uWq5f7UDo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b706b8f7-867d-4cf2-45de-08d7408ff34d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 01:38:50.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovwGFaxgfyN7uByQkGRxUPOlP+dQSUXA5egx4VjtvrzMq1o61p5PEwIzXVDYFmTfyQJ0nFMTkDSmpwBzIbZHTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-9-19 22:30 Philipp Puschmann <philipp.puschmann@emlix.com> wrote=20
> For some years and since many kernel versions there are reports that the =
RX
> UART SDMA channel stops working at some point. The workaround was to
> disable DMA for RX. This commit tries to fix the problem itself.
>=20
> Due to its license i wasn't able to debug the sdma script itself but it s=
omehow
> leads to blocking the scheduling of the channel script when a running sdm=
a
> script does not find any free descriptor in the ring to put its data into=
.
>=20
> If we detect such a potential case we manually restart the channel.
>=20
> As sdmac->desc is constant we can move desc out of the loop.
>=20
> Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
In fact, it's a refine patch rather than bug fix, just restore cyclic trans=
fer
back in the corner case. There are two causes for such 'corner case':
1. improper number of BD or length of BD setting for cyclic, so that BD cou=
ld
be consumed very quickly, worst case is uart Aging timer which one byte
may consume one BD. So for such case, enlarge more BDs is the right way as
your UART patch.
2. High cpu loading so that SDMA interrupt handler can't run in time to set=
=20
BD_DONE flag back again, at last all BDs consumed. In such case, this patch
may blind other coding issues such as long time window of disable irq(spin_=
lock_irq)
. So I think this patch is much like a refine/restore patch, and it's bette=
r to add
a clear print information to hint user channel is restoring and unexpected =
high cpu
loading is coming...

> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>=20
> Changelog v4:
>  - fixed the fixes tag
>=20
> Changelog v3:
>  - use correct dma_wmb() instead of dma_wb()
>  - add fixes tag
>=20
> Changelog v2:
>  - clarify comment and commit description
>=20
>  drivers/dma/imx-sdma.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> e029a2443cfc..a32b5962630e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -775,21 +775,23 @@ static void sdma_start_desc(struct sdma_channel
> *sdmac)  static void sdma_update_channel_loop(struct sdma_channel
> *sdmac)  {
>  	struct sdma_buffer_descriptor *bd;
> -	int error =3D 0;
> -	enum dma_status	old_status =3D sdmac->status;
> +	struct sdma_desc *desc =3D sdmac->desc;
> +	int error =3D 0, cnt =3D 0;
> +	enum dma_status old_status =3D sdmac->status;
>=20
>  	/*
>  	 * loop mode. Iterate over descriptors, re-setup them and
>  	 * call callback function.
>  	 */
> -	while (sdmac->desc) {
> -		struct sdma_desc *desc =3D sdmac->desc;
> +	while (desc) {
>=20
>  		bd =3D &desc->bd[desc->buf_tail];
>=20
>  		if (bd->mode.status & BD_DONE)
>  			break;
>=20
> +		cnt++;
> +
>  		if (bd->mode.status & BD_RROR) {
>  			bd->mode.status &=3D ~BD_RROR;
>  			sdmac->status =3D DMA_ERROR;
> @@ -822,6 +824,17 @@ static void sdma_update_channel_loop(struct
> sdma_channel *sdmac)
>  		if (error)
>  			sdmac->status =3D old_status;
>  	}
> +
> +	/* In some situations it may happen that the sdma does not found any
> +	 * usable descriptor in the ring to put data into. The channel is
> +	 * stopped then. While there is no specific error condition we can
> +	 * check for, a necessary condition is that all available buffers for
> +	 * the current channel have been written to by the sdma script. In
> +	 * this case and after we have made the buffers available again,
> +	 * we restart the channel.
> +	 */
> +	if (cnt >=3D desc->num_bd)
> +		sdma_enable_channel(sdmac->sdma, sdmac->channel);
>  }
>=20
>  static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
> --
> 2.23.0

