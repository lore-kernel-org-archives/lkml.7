Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCAC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A542146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="Lx5VbCAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgAFV3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:29:16 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:62238
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbgAFV3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:29:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2exxUuPiLTqa9/YAk9gg3+JAlzGJx78EAml78kIokOZYvID5UJReDo5elUuGgi3u5TVywOP6lEhvx+TDRPmFJn/U3K6bygPKQ5oCrThjSzsvuM6iwH299l6hItW1jXRIjdP02mT7qKE1EEW6rO9oK8EPyBdJOFw8LpOXwSgnstg3bNGBb0Kj9It/53/IFIMXGr/fxzKJS8v28XGWpvZiKferSe/QCv7zQcSij4TtCNTQ1g8rE7DIRrDn06euHldjg4UqvluE7f5fAWAMo0CpWH2DoGVkaxfKmsov4a6+zSFuXrdYkTjKXZjhEW5OEJCcgLjPdxVXM8wMP3EB7A/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBUWyVhfoGjBVm2kizd7FvYY6mMNJRe8TJmO9UNrzCI=;
 b=WmaqMdGYXJATnWgLdl31+MYhfwMqQq9uqmz01KINN723C/P6RK+z2r/6/C75uD0ey7WiokrqZ5m+GNEPNiYs+smuGzhrXLm7Pp2z/JHq7EDpWy2jxwI3oT76wOTxm9TPqpuXgQ0vey4QRNiLlYIMv4EHcaCVxhCRsCEm1lWCeOCZa+YW0Ibv6lUYTNzwex/FaKzxeJ/wrnf3PQ8aSMOmKm4dN7sKxjZPzb+7Xn7l9xa13aLSkxJ6LcKrf3TuMcgFnMrQLekewKdal3e8+xIxphexJS//wZHIbrTFK3OP30usohYpwwBmo5Tzo2bsQE2bBifh9rOsPeHTs3QGEqBT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBUWyVhfoGjBVm2kizd7FvYY6mMNJRe8TJmO9UNrzCI=;
 b=Lx5VbCApAvlscaFZ4zfoU+CQPQVaQpBRNsnf3FGiX9EOaaT+7lfAzZhbixvCFbvYGy96sUvT+QA39myZC6zXbG9TitkRxfpoOvSYnXw2YW3nmQRnTVlYDgfSWyP65z5Q84PiNT4dMWR/dpTVvhsAOAZpqqf2GxrAygVCKRf0/uU=
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4380.eurprd08.prod.outlook.com (20.179.43.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Mon, 6 Jan 2020 21:29:12 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::11b4:6ffd:de3:a862]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::11b4:6ffd:de3:a862%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 21:29:12 +0000
Received: from jiffies (54.37.17.75) by LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 21:29:11 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
CC:     "forest@alittletooquiet.net>" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: vt6656: remove unnecessary parenthesis
Thread-Topic: [PATCH] staging: vt6656: remove unnecessary parenthesis
Thread-Index: AQHVvymPkthkrGEOIUC0/lb0tsdKH6feMlaA
Date:   Mon, 6 Jan 2020 21:29:11 +0000
Message-ID: <20200106212909.GA54084@jiffies>
References: <20191230155520.GA27072@user-ThinkPad-X230>
In-Reply-To: <20191230155520.GA27072@user-ThinkPad-X230>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [54.37.17.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cd016f1-f105-4537-8eef-08d792ef78bc
x-ms-traffictypediagnostic: DBBPR08MB4380:
x-microsoft-antispam-prvs: <DBBPR08MB43808ED2FD27686538292795B33C0@DBBPR08MB4380.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39830400003)(396003)(136003)(189003)(199004)(66476007)(6916009)(1076003)(44832011)(55236004)(53546011)(66946007)(66556008)(66446008)(5660300002)(26005)(64756008)(956004)(86362001)(4326008)(9686003)(33656002)(8936002)(508600001)(71200400001)(33716001)(54906003)(52116002)(16526019)(6496006)(8676002)(316002)(55016002)(9576002)(2906002)(81156014)(186003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4380;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9rE5duUSZ1buAMf4lJBy+PaSZYbWSgFSgWyD0Pw9ohpXYee1ed+GEfHAgwVLRn56p2mh6DcPc4/kHyN3NM32TKvNGmC/FVuRBLgqhpv0AzprgA+C10aKPDitz/QuvTc+TybgAxNQ1G6hG1/YW26vlgzlYIgz4dt+jizsKWC92dKStt76MQrbfGalQjAFBFdFUC8cDVQrY9towJBdlTqajoYWAkUuowjb79slRbUNuOch2KDO/PQGJvycDEejvpcItJSX53BZkut7ErsySchIMZ0oCIh51hfVu1quDH8GtK14mHeNGHouH4Mh0hLx+sBuE1VOqj2ly860jrZ4avG3yUQJ0aS0su9NKYOfQc50JCJAcUOxRrGweKNSF20JlE9XaYLh9RgPs+MpXOgJWQciQJf8jlAwvPDwXMR4N46qdsHDn9ZxbiKjEg6EzvZSzPsB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5AE5B2A8DE48D04AA2DF6B6D212304F6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd016f1-f105-4537-8eef-08d792ef78bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 21:29:11.9345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9U2QkJDQWW22yUnm16RqWHSuVx7RP5cEbsi8Mat+XkDyhG7S5Thoag/5DW17S5ZRI5LS9ab0j8J9E58vf/4+06hRiAqKKR79XSTnRidZBbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4380
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/19 10:55:20, Amir Mahdi Ghorbanian wrote:
> Remove unnecessary parenthesis to abide by kernel
> coding-style.
>=20
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>

Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

> ---
>  drivers/staging/vt6656/baseband.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/b=
aseband.c
> index 8d19ae71e7cc..25fb19fadc57 100644
> --- a/drivers/staging/vt6656/baseband.c
> +++ b/drivers/staging/vt6656/baseband.c
> @@ -381,8 +381,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
> =20
>  	dev_dbg(&priv->usb->dev, "RF Type %d\n", priv->rf_type);
> =20
> -	if ((priv->rf_type =3D=3D RF_AL2230) ||
> -	    (priv->rf_type =3D=3D RF_AL2230S)) {
> +	if (priv->rf_type =3D=3D RF_AL2230 ||
> +	    priv->rf_type =3D=3D RF_AL2230S) {
>  		priv->bb_rx_conf =3D vnt_vt3184_al2230[10];
>  		length =3D sizeof(vnt_vt3184_al2230);
>  		addr =3D vnt_vt3184_al2230;
> @@ -461,8 +461,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
>  	if (ret)
>  		goto end;
> =20
> -	if ((priv->rf_type =3D=3D RF_VT3226) ||
> -	    (priv->rf_type =3D=3D RF_VT3342A0)) {
> +	if (priv->rf_type =3D=3D RF_VT3226 ||
> +	    priv->rf_type =3D=3D RF_VT3342A0) {
>  		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_MACREG,
>  					 MAC_REG_ITRTMSET, 0x23);
>  		if (ret)
> --=20
> 2.17.1
>=20
