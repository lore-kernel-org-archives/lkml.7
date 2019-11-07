Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98BEC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5A3207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Dn3OSl6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbfKGOXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:23:34 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:51847
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfKGOXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:23:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTCpZaaKTYkEckXg2a6AeI/NXwDIw6djG0cCFOsNBhjHrgT3QgD6FPyqIOj7Zh96Oa6mBGaU2YErNjgsI5Aqpa0FeOPdGsto9sRmKY+ot1bfzF65CpZQNvSnFVMiQg9DVvZEnZfO85r3N/BCZMRM4YPlX3+1m21bpMCkRtD6kTmlU/lYoKGS4usyqsdtskxFpC1WoTyyODBrdW60TvLjk+AuRMrx0o8D+vBGxyOK5Iukhl0YkJb6u3hUPhQDeN1DnTcC2vPFtzEoixUWXoC2/VrnDx7na4BiaX3OYezxFsXvkVImyecRryju8TPeSr1oNAxj3ov4ABMKRhZvxW+xDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2+6w4QLpYPiAqHx/ZIBGv/3ZOriajfvs3sqbZWgrok=;
 b=Dc0WSmAYKXwAVAhsonkSC0zYi8jyOl6ufQ0ivlOaVpv+papINcNwfy4ySUTRAMCRRXBWiQJFYdpTE5Edfhoyk8B8Mx/WsFfSl2unhUUa6O1DdHC0Bq0S8+ZEDJKMWColhsMez9vctAQ6ET9JAqK2AnmxDF7+OO1g7HzWJwIbROlrk4zYCSB2KdnF/6nataJBjo+Rho5aUuyFgUmC0Z3vfjrKNiKmiHe97ZIvGjvvDT4frUPVJBSipy6LVGPw51SGAbHLIhcIupw/8Pqf2bJOD2REiV4tTW0i8yw+51lx/Lg1eQmBDh94S3gzzxtwiLxu7lyRwuFIcQxGZ14mtpKU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2+6w4QLpYPiAqHx/ZIBGv/3ZOriajfvs3sqbZWgrok=;
 b=Dn3OSl6jDzZfCvnoRts6LWkj7C6SCOwPOHXZswvLTBfQg4RWW++MT6YGsw0BtyoX9r/Kyaurgm8j980AoLJoyjva5ugVaHb2FSjdCoZLS/dV7bYa6Zce2+lFeGwEXVOw9B3NKn+BIIMaIU2fGdicnP0Ja8VcrpDbavAl53uGb2U=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2310.eurprd05.prod.outlook.com (10.168.56.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 14:23:29 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1%12]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 14:23:29 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     "minyard@acm.org" <minyard@acm.org>,
        Vijay Khemka <vijaykhemka@fb.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "sdasari@fb.com" <sdasari@fb.com>
Subject: RE: [PATCH v2] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Topic: [PATCH v2] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Index: AQHVlNCPTAuJYh4uBUOyQnqtKtQrYKd/toOAgAANqzA=
Date:   Thu, 7 Nov 2019 14:23:29 +0000
Message-ID: <DB6PR0501MB271256AD5BC602AAF90CBDA5DA780@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20191106182921.1086795-1-vijaykhemka@fb.com>
 <20191107133425.GA10276@minyard.net>
In-Reply-To: <20191107133425.GA10276@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92d4ea31-f556-47db-934e-08d7638e0f78
x-ms-traffictypediagnostic: DB6PR0501MB2310:
x-microsoft-antispam-prvs: <DB6PR0501MB23104B39BD5225C2319E2D33DA780@DB6PR0501MB2310.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(39840400004)(136003)(13464003)(189003)(199004)(446003)(6436002)(229853002)(11346002)(71200400001)(71190400001)(476003)(478600001)(7416002)(14454004)(2906002)(486006)(9686003)(55016002)(5660300002)(7696005)(81166006)(81156014)(66066001)(8676002)(76176011)(8936002)(86362001)(66556008)(52536014)(2501003)(76116006)(66946007)(99286004)(64756008)(66446008)(66476007)(80792005)(33656002)(6506007)(53546011)(14444005)(4326008)(74316002)(54906003)(110136005)(25786009)(316002)(305945005)(26005)(3846002)(256004)(186003)(102836004)(7736002)(6246003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2310;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWm3BmpjGGcBxQwh5sB8AbvMZOCpBNNFHC+k76JaqceQxEEMmj4G/OnjoORSJI25CtXn5KI4bwNX98FQ+mdnpMfFz7T6CgTaMJMob3BWIVwXHJULl4+iHq89S33IqUnK7B1m48f79kTZfqbWULneOuQjxzXiz39jVS6/yoZ54LMZTVyO6O7b34S8FxRMNTja2kCrH39HyYV+l4/XqG2V9jk3K8NDAuJjKQlX4s+U9SXEM4osP6Ikjr93AMEpyAEN4lOSIxJnwsg2A0PiPvdU4WSkqRMDKCSdzIa9QX1Mw0jVUUGvs0MbQDiDcL/cQayswSZBqPHtXghflcIPJD3Nb61nLa7EoCJNFDX+fGPWKADPwSL3yGl7mMSrcwneQ2pj4KNtsj05y+n3t8khdu2ntrT25QQp5YHPvV92mZnLnohcotTbfzrSLduXOxMz7yjp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d4ea31-f556-47db-934e-08d7638e0f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 14:23:29.0911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kivpT510xJ3W6vgpsqPJYakDQKRbOrNlK+ra7B26O7d+dAXNICySM7NAgLe+Qw6CusWQuOGp/61xBm3+4wCjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Corey!

-----Original Message-----
From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
Sent: Thursday, November 7, 2019 8:34 AM
To: Vijay Khemka <vijaykhemka@fb.com>
Cc: Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org>; openipmi-developer@lists.sourceforge.net; linux-kernel@vger.kernel=
.org; cminyard@mvista.com; Asmaa Mnebhi <Asmaa@mellanox.com>; joel@jms.id.a=
u; linux-aspeed@lists.ozlabs.org; sdasari@fb.com
Subject: Re: [PATCH v2] drivers: ipmi: Support for both IPMB Req and Resp

On Wed, Nov 06, 2019 at 10:29:21AM -0800, Vijay Khemka wrote:
> Removed check for request or response in IPMB packets coming from=20
> device as well as from host. Now it supports both way communication to=20
> device via IPMB. Both request and response will be passed to=20
> application.
>=20
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Thanks, this is in my for-next tree now.  Asnaam, I took your previous comm=
ents as a "Reviewed-by", if that is ok.

-corey

> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c=20
> b/drivers/char/ipmi/ipmb_dev_int.c
> index 285e0b8f9a97..ae3bfba27526 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -133,9 +133,6 @@ static ssize_t ipmb_write(struct file *file, const ch=
ar __user *buf,
>  	rq_sa =3D GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
>  	netf_rq_lun =3D msg[NETFN_LUN_IDX];
> =20
> -	if (!(netf_rq_lun & NETFN_RSP_BIT_MASK))
> -		return -EINVAL;
> -
>  	/*
>  	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
>  	 * i2c_smbus_xfer
> @@ -203,25 +200,16 @@ static u8 ipmb_verify_checksum1(struct ipmb_dev *ip=
mb_dev, u8 rs_sa)
>  		ipmb_dev->request.checksum1);
>  }
> =20
> -static bool is_ipmb_request(struct ipmb_dev *ipmb_dev, u8 rs_sa)
> +/*
> + * Verify if message has proper ipmb header with minimum length
> + * and correct checksum byte.
> + */
> +static bool is_ipmb_msg(struct ipmb_dev *ipmb_dev, u8 rs_sa)
>  {
> -	if (ipmb_dev->msg_idx >=3D IPMB_REQUEST_LEN_MIN) {
> -		if (ipmb_verify_checksum1(ipmb_dev, rs_sa))
> -			return false;
> +	if ((ipmb_dev->msg_idx >=3D IPMB_REQUEST_LEN_MIN) &&
> +	   (!ipmb_verify_checksum1(ipmb_dev, rs_sa)))
> +		return true;
> =20
> -		/*
> -		 * Check whether this is an IPMB request or
> -		 * response.
> -		 * The 6 MSB of netfn_rs_lun are dedicated to the netfn
> -		 * while the remaining bits are dedicated to the lun.
> -		 * If the LSB of the netfn is cleared, it is associated
> -		 * with an IPMB request.
> -		 * If the LSB of the netfn is set, it is associated with
> -		 * an IPMB response.
> -		 */
> -		if (!(ipmb_dev->request.netfn_rs_lun & NETFN_RSP_BIT_MASK))
> -			return true;
> -	}
>  	return false;
>  }
> =20
> @@ -273,8 +261,7 @@ static int ipmb_slave_cb(struct i2c_client=20
> *client,
> =20
>  	case I2C_SLAVE_STOP:
>  		ipmb_dev->request.len =3D ipmb_dev->msg_idx;
> -
> -		if (is_ipmb_request(ipmb_dev, GET_8BIT_ADDR(client->addr)))
> +		if (is_ipmb_msg(ipmb_dev, GET_8BIT_ADDR(client->addr)))
>  			ipmb_handle_request(ipmb_dev);
>  		break;
> =20
> --
> 2.17.1
>=20
