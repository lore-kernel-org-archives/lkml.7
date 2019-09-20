Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A598C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208D4217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k91bm4Ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394708AbfITCoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:44:38 -0400
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:50055
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388350AbfITCoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:44:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq8lhjoXTKLRWz17v7whL/QuaLGRbwnVk7sc3tWmG0i0YJGaiairq0thP0eCYfAuHHImS6kM3ApqNJoAvx2CL28yh/6HoR/JLYkfaDIyS4oezfqHc1KT6eDa2hR9Q62q7VCjLPpC4Qu/hHDAymfSrHs1jB7n/J3mfS+1jLkIizhGw7l6mzUO9E33fh/+Sn75oZnjNQkX4GLtGz7bFbKiz60WtBpFLghfad9CTw0XGMUkqd3idM2sV/TP83U20NYInpU1neqI9pybKkwsSMfcyxMnS/FtffkSkF7UK538HukY/HsXwTGdw5C7qFszIHkfZQ0z8zbpuKBztodGXoncRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5lyX5pJb+Cu7vIUgQHU76lsQ9j3sWP+prDicFUQKEM=;
 b=cJrCxSEveSYsaxJEXcHaqoliHC/fOO0Axz+LamHfztSyQ7rTMx/3w9zZFd8Y86ThjJ4+gvo/7Q3I2XNPnYnLgQxXa3CLY5n/2BeT+PBAOdkZ/k4l1pHNeAxckN7qlyoRpwvUowcdbsZFhqZ6I2DuLb8SNOEFWTMhy49eSP6vJjnlx89W/thKw6cis2O2sUzY7oXnMGoUiwzSp8Q4KqEjB99A06Ae6Urr9SudYBJmGBCGEJAhJ3KuzK6tohX2UAWMW6rc1O+nL9DnCdSPIEe4a37qjK++ZuJBi4tfP0fR7lTnsS1CfpSFhY4D8PsUJ9oIxgsZkSbzoJwGPVEsSM9GNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5lyX5pJb+Cu7vIUgQHU76lsQ9j3sWP+prDicFUQKEM=;
 b=k91bm4HoQoSyF1tNJ4TyzwdrSxQYxIwqP1fG521HZLNgKo/As7QOjylVhN5PE1fqlVmWuF/dL08bTZoEBV8WalyxPQldPoda+Xmk4FFOHJVByw5pIeOASOKxRFDlmIp+HjIiXuiD6QAwCgfeXubn7+ssySuTPpINJQFIq0NvRyA=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3712.eurprd04.prod.outlook.com (52.134.15.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 02:44:33 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::f919:a62a:998c:6e9a]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::f919:a62a:998c:6e9a%6]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 02:44:33 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robin Gong <yibin.gong@nxp.com>,
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
Subject: RE: [EXT] [PATCH v4 0/3] Fix UART DMA freezes for i.MX SOCs
Thread-Topic: [EXT] [PATCH v4 0/3] Fix UART DMA freezes for i.MX SOCs
Thread-Index: AQHVbvawZ3M9Pccxp0iKGAqRTaAJlKcz3AJg
Date:   Fri, 20 Sep 2019 02:44:33 +0000
Message-ID: <VI1PR0402MB36002C1C1E5A48EBA2385406FF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190919142942.12469-1-philipp.puschmann@emlix.com>
In-Reply-To: <20190919142942.12469-1-philipp.puschmann@emlix.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e38708cf-f9b0-45be-5cab-08d73d74782b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3712;
x-ms-traffictypediagnostic: VI1PR0402MB3712:|VI1PR0402MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB37123F1C5955607E631DE7A4FF880@VI1PR0402MB3712.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(189003)(199004)(54534003)(55016002)(305945005)(478600001)(9686003)(66066001)(26005)(14454004)(6436002)(7736002)(74316002)(6246003)(25786009)(4326008)(256004)(14444005)(7416002)(229853002)(71190400001)(71200400001)(66446008)(11346002)(2501003)(8936002)(446003)(476003)(8676002)(66946007)(64756008)(81156014)(66556008)(81166006)(102836004)(6506007)(186003)(5660300002)(66476007)(86362001)(99286004)(33656002)(7696005)(76176011)(6116002)(486006)(3846002)(52536014)(2906002)(76116006)(54906003)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3712;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cpP1fmF+aj2TqdmSXWITrq6I8oXDV11f93uEyN11UOAVr0nt+gqb2mYh8xAy6kz1zfpYMX2USSwHjJJSMWmEciciBq1gAdKl2Df162G2BZKnx6z5eC9rdE3mcpdXPx2AjtzQUA8DaON6FOXIKaiKQidak263+0yd7ZXp5ZanMcLy5R5+r2ThbPdguFeTbqsiyU7q/jodt5xSqYzb8FNI2mOQ8xIKDyIXGmMmILiERT6HBTxgIRK7ZgfR/WaE91x09vzW2YKy+MdgX3yznOf9p/DKSKm9y8jKEz/QPDjHVSyVNcRu0GkkKJvJHo3Z28kkgX7voLQAgWfHy8Ie03TpSVSDOewYH+l9mCQC2xgqSdPZGUYTWwtEoA03c238lRMc7WKg9cH4wNfVR3ot4+zdn1r+5bATweTz9mzG9UFoqRY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38708cf-f9b0-45be-5cab-08d73d74782b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 02:44:33.6223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUx0JS+3ci5cSWOyo7OWhbaapN5XMf5UmKSc8MlMP0kP68pAyrFk5jTpQjnB+bPXgU5NhNDG5bVuUEduoHzW0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Puschmann <philipp.puschmann@emlix.com> Sent: Thursday, Septe=
mber 19, 2019 10:30 PM
> For some years and since many kernel versions there are reports that RX
> UART DMA channel stops working at one point. So far the usual workaround
> was to disable RX DMA. This patches fix the underlying problem.
>=20
> When a running sdma script does not find any usable destination buffer to=
 put
> its data into it just leads to stopping the channel being scheduled again=
. As
> solution we manually retrigger the sdma script for this channel and by th=
is
> dissolve the freeze.
>=20
> While this seems to work fine so far, it may come to buffer overruns when=
 the
> channel - even temporary - is stopped. This case has to be addressed by
> device drivers by increasing the number of DMA periods.
>=20
> This patch series was tested with the current kernel and backported to ke=
rnel
> 4.15 with a special use case using a WL1837MOD via UART and provoking the
> hanging of UART RX DMA within seconds after starting a test application. =
It
> resulted in well known
>   "Bluetooth: hci0: command 0x0408 tx timeout"
> errors and complete stop of UART data reception. Our Bluetooth traffic
> consists of many independent small packets, mostly only a few bytes, caus=
ing
> high usage of periods.
>=20
> Changelog v4:
>  - fixed the fixes tags
>=20
> Changelog v3:
>  - fixes typo in dma_wmb
>  - add fixes tags
>=20
> Changelog v2:
>  - adapt title (this patches are not only for i.MX6)
>  - improve some comments and patch descriptions
>  - add a dma_wb() around BD_DONE flag
>  - add Reviewed-by tags
>  - split off  "serial: imx: adapt rx buffer and dma periods"
>=20
> Philipp Puschmann (3):
>   dmaengine: imx-sdma: fix buffer ownership
>   dmaengine: imx-sdma: fix dma freezes
>   dmaengine: imx-sdma: drop redundant variable
>=20
>  drivers/dma/imx-sdma.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> --
> 2.23.0

The patch set look fine that is really to fix some corner issue from the lo=
gical view.

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
