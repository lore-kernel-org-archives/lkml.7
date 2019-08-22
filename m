Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E123400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bBGzLPbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393191AbfHVRrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:47:23 -0400
Received: from mail-eopbgr760087.outbound.protection.outlook.com ([40.107.76.87]:59202
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393176AbfHVRrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMsdEZGGUo5ZdRr5SUAM0O8BAq5vooIgRpF5emY6x9iHR7EBTqr3omxcB21FMuNuyaMWIWQPlHKpx31n2Pe2Z5t56fYxJPHbovkSDYBA0gOx6KowBxJ9k2qAKfgFfpDAsbTwnu9inF2zTMcmsHfjELEq6ZzKFGzHZO47lrq3+oV/2khO/2F12HsV0esTzt8bciNNXCYDkp73hzl6s1oS8SHcgBQ0nJ9SH4Yk/ZTLEwD6e3EfFXbHPs/za0XQVGHUWXeizbzoKpL/CMejkCWSXGjjshXDCjiKt27MsmnLjCZTOteGoX+KLpkg7hnPkQIfQONPdFUWBrWHkVxolWG8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnSe1FjAEaFrTw9DipBiu4miPL9pi270EhJJdY0S+Mg=;
 b=gUDZbzoUeLispz2C4E7q2CT5lcEKePzktyHZOtZiCpCvIupkHPDF0k4yOq4CIaGYxcGiFPZ0I6kbxg07z8/XmOws5ZLWBYsmXLG2Li+8obt+RVZinuCnVf6xVrq0ZUXA6DcYW2+IaXbJA3vbOmnVVOru/QGC+wnWe2zsNNly0xkF5uqp8SwfNm8HbfJeIIHzkRUXmyj5BQbaeIoTdhFyYVvqEdpkdst5hbeagJ2/i9CcpInLdYKukZL/4l8nR2mG0w+wZUT045EESGacNMtLLCfM3W0N9v/YEC26geIVQzHok1wav64eCuT1PWDnNAB1snX3l8mHU4xo4mqkfdkxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnSe1FjAEaFrTw9DipBiu4miPL9pi270EhJJdY0S+Mg=;
 b=bBGzLPbNaVBU38MMyxooD2cXgzyRJvzvyFq3ydTU6Z1+8A3xhBGuV8N5gCllzW4/rueKYkfW08Bl3yTeRJ2nxy5ba+IIirhpnBa5g6TkEHANjHkON/WswBoWqFM9sTXS6SU6c4bstqgvgxKt/jlb69eo/KEYlR8vgwl4MhQXwyY=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6789.namprd02.prod.outlook.com (20.180.17.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 17:47:15 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:47:15 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Derek Kiernan <dkiernan@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 1/4] misc: xilinx_sdfec: Fix a couple small information
 leaks
Thread-Topic: [PATCH 1/4] misc: xilinx_sdfec: Fix a couple small information
 leaks
Thread-Index: AQHVV+76IySGJCWDyUaqUkp57fbBeqcHcz0A
Date:   Thu, 22 Aug 2019 17:47:15 +0000
Message-ID: <CH2PR02MB63599214D1FC937E256FCBC4CBA50@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20190821070606.GA26957@mwanda>
In-Reply-To: <20190821070606.GA26957@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2c1b4d6-1523-4bc0-629b-08d72728c55f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR02MB6789;
x-ms-traffictypediagnostic: CH2PR02MB6789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB6789C461F6BD39F79B14A203CBA50@CH2PR02MB6789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39840400004)(376002)(396003)(136003)(13464003)(189003)(199004)(2906002)(316002)(229853002)(6636002)(66476007)(76116006)(76176011)(66946007)(54906003)(305945005)(74316002)(478600001)(99286004)(110136005)(64756008)(66446008)(66556008)(55016002)(9686003)(6436002)(71200400001)(71190400001)(7736002)(7696005)(14444005)(3846002)(486006)(6116002)(66066001)(33656002)(53936002)(52536014)(5660300002)(14454004)(11346002)(446003)(53546011)(6246003)(8936002)(6506007)(81166006)(81156014)(26005)(8676002)(25786009)(186003)(102836004)(86362001)(4326008)(256004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6789;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QNGLJxcarTz1b8iq3vS2CG3307r087GuDZ+9E6QbrOjGSpLiobL1wVUnz/UjfTiRt7GckO89z1mIPh6GCJYm9HPO6AcT2gdHfopWYRJaB2D01otN5u9sKZdBZKV0NbZd/oYESHBrL3kh8eNoUT3OnsPnkvBZ4i+jpN85ccBxx0Jyj6i0SB7M86bVxCF79czy+2aXbU3qCEiYwVau0e3uOV92tQtfhJSyzQVlAyP2Rv2w5rqfP8jfcGdaZCli+KUutPygrqVB8ovHQmvJ7Of8SQucpvJmU4f4eVDpcCaMDWvwWAyiV5s85HtjolS5yhmWRJ1JRHfcAY8pDq4vxntYpgBhlDFSbz1d/Sx83zLjkesFhG6NdeEb6/Bn0LVfl3UGpp1gSr05V6sbMrOBmF20jQcm5JAtI5yNm67dEwi9lNo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c1b4d6-1523-4bc0-629b-08d72728c55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:47:15.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSc6oXetkG+P6R1fVG+GeBl4YnNdUcju01zgYkLCNwChSYPv4xjjqx+mt4E/vJZavDT/+o0OeDSOlK8b+BEr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday 21 August 2019 08:06
> To: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>
> Cc: Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org>; Michal Simek <michals@xilinx.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; kerne=
l-janitors@vger.kernel.org
> Subject: [PATCH 1/4] misc: xilinx_sdfec: Fix a couple small information l=
eaks
>=20
> These structs have holes in them so we end up disclosing a few bytes of
> uninitialized stack data.
>=20
> drivers/misc/xilinx_sdfec.c:305 xsdfec_get_status() warn: check that 'sta=
tus' doesn't leak information (struct has a hole after 'activity')
> drivers/misc/xilinx_sdfec.c:449 xsdfec_get_turbo() warn: check that 'turb=
o_params' doesn't leak information (struct has a hole after
> 'scale')
>=20
> We need to zero out the holes with memset().
>=20
> Fixes: 6bd6a690c2e7 ("misc: xilinx_sdfec: Add stats & status ioctls")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 912e939dec62..dc1b8b412712 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -295,6 +295,7 @@ static int xsdfec_get_status(struct xsdfec_dev *xsdfe=
c, void __user *arg)
>  	struct xsdfec_status status;
>  	int err;
>=20
> +	memset(&status, 0, sizeof(status));
>  	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
>  	status.state =3D xsdfec->state;
>  	xsdfec->state_updated =3D false;
> @@ -440,6 +441,7 @@ static int xsdfec_get_turbo(struct xsdfec_dev *xsdfec=
, void __user *arg)
>  	if (xsdfec->config.code =3D=3D XSDFEC_LDPC_CODE)
>  		return -EIO;
>=20
> +	memset(&turbo_params, 0, sizeof(turbo_params));
>  	reg_value =3D xsdfec_regread(xsdfec, XSDFEC_TURBO_ADDR);
>=20
>  	turbo_params.scale =3D (reg_value & XSDFEC_TURBO_SCALE_MASK) >>
> --
> 2.20.1

Reviewed-by: Dragan Cvetic <dragan.cvetic@xilinx.com>

Thanks,
Dragan
