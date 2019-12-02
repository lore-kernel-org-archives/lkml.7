Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FBFC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B2420661
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XBO2mq/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLBJqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:46:08 -0500
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:48854
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfLBJqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:46:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJLDTQMACobf7e8u1MsoZNm1aD6yX2Y+Nq5pRnpssF2wyJqVU8wf000ApJbVwgCyOFDBoW1bbQTa4StOl0kThhVOhZeQmWE9RLMERB1lzR+OXww88BA/m8NQwabZyqXFAEPynlTya1EfDEO3+EId/SKrmTRD1INtfdS3dIcYE5xXiMkDker2294bLhMpZ4SKmUU41Y8gK08hcBvoHKukWhVlzgwDwchHR/HhPAr1cpAuQKr/UfixczUtLBqsQv1uA+UOkMS0XYdzDBli1kyJgd/cE7tkEpWk1oaNbiCtTT+9lVgvKHDeek93RxVzUfr0aXWIfJfInsNptJ/QI9aMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHKD30VXFMShPA1Yq6qDTuokNKWFsacsp5qNK3o/p64=;
 b=I1voTlVJXQB+JfmzA9dEULelTVvbX0j6wzdtCZsbZiXKjbirU6UTPD7l7zp9l5k27nuowjfQzVr82IbuWNmRKWM1m1E3J0sL62RUu46N7NLWabdN7qO5d0BDOpji6nKHWqcWI9OG2epFdTvee+FFzqw5c6OEDUMZkKhFoqs7jrBYUc6WPU0wwqup3v6mItoL37v9KDCH6huDzmQItCzygffuXbl/G3CoFZGiUXGkTIqHNqaqhdCWYx8q9bDbebmGj2e8bGV2zV3Zn8utsiLj1xd2gi/i3x5fMQANWIAT832W1/rXlKkDCyBEIgYM3NIGxVWdvIgmSiC40oUnE3bTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHKD30VXFMShPA1Yq6qDTuokNKWFsacsp5qNK3o/p64=;
 b=XBO2mq/YZiFY6rBDHHqB5Ytki70GiKKT/jmTJI/zYWggmLcVCJvHW7cporhosGQh/6dqTumKt5fCPfbXovRQOsefVICaVNraPZek9pjnBD4H5U07jYMz3lQtDrA2EbzJciJbtya+1AvCBfiee8nAhEN12xuUf/+qGAdE9x5nImw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4706.eurprd04.prod.outlook.com (20.177.40.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 09:45:25 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 09:45:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH] ahci: imx: i.MX8QM: fix error handling
Thread-Topic: [PATCH] ahci: imx: i.MX8QM: fix error handling
Thread-Index: AQHVmRhVtJOcbRZcDU+JyEEqGXtClKemuBgg
Date:   Mon, 2 Dec 2019 09:45:24 +0000
Message-ID: <AM0PR04MB448164AD76243D955BC025E588430@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1573535674-25364-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573535674-25364-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [114.220.170.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43451e89-36f8-425a-190a-08d7770c5b51
x-ms-traffictypediagnostic: AM0PR04MB4706:|AM0PR04MB4706:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4706391460B390501E44673D88430@AM0PR04MB4706.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(51234002)(2906002)(229853002)(9686003)(6246003)(102836004)(14454004)(478600001)(110136005)(66476007)(7736002)(86362001)(66556008)(64756008)(26005)(256004)(76176011)(14444005)(4326008)(5024004)(66446008)(6506007)(7696005)(7416002)(25786009)(74316002)(71190400001)(71200400001)(186003)(52536014)(6436002)(55016002)(54906003)(6116002)(3846002)(305945005)(8936002)(11346002)(2201001)(446003)(76116006)(5660300002)(2501003)(81156014)(8676002)(81166006)(33656002)(99286004)(44832011)(316002)(66946007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4706;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5xLjIX6aMgomFluNY6YbB5tHZ8IQwdpGFRAsLzlJods3zXp8Q5KxrrkEJlarI61tJETQfzO8UdGNRRmjMm24NLeibbckBaOmlfRBL2cgyHHT9Pe0GvdaxQ/NkUNeWTZ+WlWXEzjQTBDLxgh9mI+0JK68E6gH5xmAe1PvhaO0XVCEGirXsQRgiE5J2h2bsxm8Tnl9MsGxY8ZGMc4Y3QhTAkn/PEgOaaJKEcsYNxuhvnJj0BhdeDZMRTWYCPTvmvZg9seItgnlZgzZBlbipTZufVBnlFsIz6uceyKzPQHE0RKjSw8b2dsdVeT9zNY9WEiYi7H+t0qYciZEVeBl8mu0l/Js5T6dLVobP+DaXwf/sXOzYqg9zw6HuYMgVR4S0aEXxCIWDGCpmp9fVcHiePHNmqi0Nud7swN+x+9oSGxpGQXCmxZ6FcNI8ICBuElw+9xmUYYXllmkBIxWeRynD7hZA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43451e89-36f8-425a-190a-08d7770c5b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 09:45:24.9110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PK47h6uymx3cvgoeIkORYdEQFpU9tU4SBVCzQ6HbzLHpysw1sn1Eh5raqbsuVys5USDmo4q296VLIV6e2P09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4706
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] ahci: imx: i.MX8QM: fix error handling

Ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> When imx8_sata_enable failed, need to jump to path disable_clk.
> Otherwise there will be kernel dump as following.
>     Workqueue: events deferred_probe_work_func
>     pstate: 60000005 (nZCv daif -PAN -UAO)
>     pc : _regulator_put.part.27+0x34/0x158
>     lr : _regulator_put.part.27+0x2c/0x158
>     sp : ffff80001286bb00
>     x29: ffff80001286bb00 x28: 0000000000000000
>     x27: 0000000000000000 x26: ffff8000100fddf0
>     x25: 0000000000000000 x24: 000000000000001b
>     x23: ffff80001286bbd8 x22: ffff0008ea007600
>     x21: ffff0008ea0104f0 x20: ffff0008ea007e00
>     x19: ffff8000120753e8 x18: 0000000000000010
>     x17: 00000000eefd8a54 x16: 00000000deadbeef
>     x15: ffffffffffffffff x14: ffff800011f198c8
>     x13: 0000000000000000 x12: 0000000000000001
>     x11: 0000000000000000 x10: 0000000000000990
>     x9 : ffff80001286b870 x8 : ffff0008eb99c0f0
>     x7 : ffff0008eb99b880 x6 : ffff0008eb99b7c0
>     x5 : 00000000000001df x4 : 0000000000001adb
>     x3 : ffff8008de089000 x2 : a4c383a3cc862400
>     x1 : 0000000000000000 x0 : 0000000000000001
>     Call trace:
>      _regulator_put.part.27+0x34/0x158
>      regulator_put+0x34/0x48
>      ahci_platform_put_resources+0x64/0xd0
>      release_nodes+0x1b0/0x220
>      devres_release_all+0x34/0x50
>      really_probe+0x1b8/0x308
>      driver_probe_device+0x54/0xe8
>      __device_attach_driver+0x80/0xb8
>      bus_for_each_drv+0x78/0xc8
>      __device_attach+0xd4/0x130
>      device_initial_probe+0x10/0x18
>      bus_probe_device+0x90/0x98
>      deferred_probe_work_func+0x64/0x98
>      process_one_work+0x1e0/0x358
>      worker_thread+0x208/0x488
>      kthread+0x118/0x120
>      ret_from_fork+0x10/0x18
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/ata/ahci_imx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c index
> bfc617cc8ac5..1d6a5ef78259 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -692,6 +692,8 @@ static int imx_sata_enable(struct ahci_host_priv
> *hpriv)
>  		}
>  	} else if (imxpriv->type =3D=3D AHCI_IMX8QM) {
>  		ret =3D imx8_sata_enable(hpriv);
> +		if (ret)
> +			goto disable_clk;
>  	}
>=20
>  	usleep_range(1000, 2000);
> --
> 2.16.4

