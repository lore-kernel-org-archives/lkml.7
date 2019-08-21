Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045D6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82F1206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="axDB/EoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfHUM3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:29:43 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:34432
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbfHUM3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:29:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLCGY5juTq329rcOrCULdNNvJb1/SohowXOsg9srtBFO+RUMT3xE+ZVxpx+lQcblcDLdCRCWUqnT3v0NLRe/NbSx823sin8gX0SoCtVoymVhdjNv/Axx6gOa70Y0J59TdZ+GDMeGEpc5UVGzjTZiOpq61AUZIjd7wUJE0x6SEuY6uoT7y0tcd8lzMzLu+7FUQv4PZiXNjIe8DBqzkK0iYIevZQ1eTYKU9ob3UlB7c7wT+WHIE6L8xd9GJVo0y63nU86ekXPsbJkBQK6NELGtPL6a6W0T9ziuPUZnSTLgs/uGQIX6NwYN86md6uy1rwOlGodf3ULyiRDRIFFPOpf82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLqbqxBOQN2/GPnlvANSCnHFiFVbmLEjPu39txbea6g=;
 b=CxSE3z5uq5FQ3r04uY6ETPnDAZmyd4h/0T26JZijXOEp6+5n4P8q2bTd7VvSAZbVUoubNTN6nk/lr9DDx3VV9PdQJ2V6XFBW8mg0/g6UTzvfzTVPv9mUQdSAykTsk6YLb+U6N3juqT/5bHdLzG+GtqbU5Cys+lC1M14sxxUtwtJEVVNJxAOr1RPMs4LyT29SfKqAY3Bg4EVOT5enID3BpwoRhbTJhk1ECKyteldgIvZuh2HPifoW5c62RvzYA7WQUMoCidTntit7aM2rNyG663DPMqS+3LBIM54SHLSdXyRe1eLVlC01EjFHoq8BlfksgSgzLszwpkySGgT3f/Wbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLqbqxBOQN2/GPnlvANSCnHFiFVbmLEjPu39txbea6g=;
 b=axDB/EoDsXhVAZmSF+RB/k1R74duriQRTFU5OxeYU6TCAzy3gggfyjshGiEknQ+bUJxLrtVDouaavyo2lNTf6uluH74yLfikTIaPvbVDXVr8ZBQGdHMv6ZN9zX5ix+oRIJzyO0Q/YuXBaa5V74jnPxORP7p2TebKZORd+jUpJyo=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB5535.eurprd08.prod.outlook.com (52.133.247.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 12:29:39 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::586d:db76:56c3:51e5]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::586d:db76:56c3:51e5%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 12:29:39 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: =?Windows-1252?Q?Re:_[PATCH]_staging:_vt6656:_Delete_an_unnecessary_check?=
 =?Windows-1252?Q?_before_the_macro_call_=93dev=5Fkfree=5Fskb=94?=
Thread-Topic: =?Windows-1252?Q?[PATCH]_staging:_vt6656:_Delete_an_unnecessary_check_bef?=
 =?Windows-1252?Q?ore_the_macro_call_=93dev=5Fkfree=5Fskb=94?=
Thread-Index: AQHVWBkdo33lx9Cu5UScsQk7wN549acFh/6A
Date:   Wed, 21 Aug 2019 12:29:39 +0000
Message-ID: <20190821122936.GA17249@qd-ubuntu>
References: <ff6e12fb-f144-351b-25e9-a864b58d7acf@web.de>
In-Reply-To: <ff6e12fb-f144-351b-25e9-a864b58d7acf@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::13) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f077eee4-0ce7-4f88-c61c-08d726333c50
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:VI1PR08MB5535;
x-ms-traffictypediagnostic: VI1PR08MB5535:
x-microsoft-antispam-prvs: <VI1PR08MB553585B9854D3C362E493C09B3AA0@VI1PR08MB5535.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(366004)(396003)(376002)(346002)(39830400003)(199004)(189003)(5660300002)(476003)(2906002)(446003)(66946007)(305945005)(11346002)(53936002)(44832011)(3846002)(6116002)(6486002)(86362001)(66446008)(66476007)(66556008)(64756008)(102836004)(8936002)(186003)(486006)(7736002)(6246003)(81156014)(6512007)(9686003)(6506007)(386003)(81166006)(26005)(508600001)(6916009)(229853002)(76176011)(256004)(6436002)(33656002)(66066001)(99286004)(71200400001)(4744005)(316002)(1076003)(54906003)(25786009)(33716001)(14454004)(4326008)(71190400001)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5535;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eILLsWoQQI+u7jgGSq+pjbbXhgDVDsIjV8YMBVGBrmrF22sw7nq1pVB9qDX0D3tbNI5SH/0aCYu/b+CU59eN6wzDEr+A7JTzlpLy7wJYNE6NJEfsy7crz3t+iC7I/5SWyfd51fDTJNYsSo7ooJ+R+pIJqbQYzNyBlwZgyOCiTZcfl9b1CZ1flyle+N+iEm5CyQfMFQIwjDcLZ3+mS1pfg0g866r4HlQsZz+qI7SI3jOBzHyHG5Md+e1ER2MJPJOdhF64OveAxKvl0082qRs/WBuzQi9XNAkpWdPvcz69DSZjk2TJxjZ/aBpBsrvoB1jVagXWLKwnUSaX+PpMSKm0K/XklYIqcZYQq2OSD/iMiOFI/dpJcLDaMJJW3SYVJXMdFq0F3ylKL8i5hZdc1LnxVLo53TM5Tb2HsujwSoSSm00=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A94C004902C25A41B81281DBB938D576@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: f077eee4-0ce7-4f88-c61c-08d726333c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 12:29:39.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3V++MHc9rJRi/MR6o+yUBlBncSqDs+epd2F8hPK/PYuFgus1JYgLC+bxeqTLpFr4xnenOsnIKUeSQQF2Nw9FRf9kYhR7Cob2ZHv+OMm9tws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5535
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 02:07:56PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 21 Aug 2019 13:56:35 +0200
>=20
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the call is not needed.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/staging/vt6656/main_usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/m=
ain_usb.c
> index 856ba97aec4f..f57e890659aa 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -422,8 +422,7 @@ static void vnt_free_rx_bufs(struct vnt_private *priv=
)
>  		}
>=20
>  		/* deallocate skb */
> -		if (rcb->skb)
> -			dev_kfree_skb(rcb->skb);
> +		dev_kfree_skb(rcb->skb);
>=20
>  		kfree(rcb);
>  	}
> --
> 2.23.0
>=20

Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

Regards,
Quentin
