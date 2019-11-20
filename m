Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3933FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0325D20714
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OLU/cHGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfKTP7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:59:30 -0500
Received: from mail-eopbgr730041.outbound.protection.outlook.com ([40.107.73.41]:26275
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbfKTP7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:59:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKYaBhx1H1Mc5TzfIMYXCvmUnphvKh95kAwMemdTpMTsrlKi5P226gE9QCPrEaByWlwOoMUx1QhNK/5gzbL1fwFi/mCSernFX8qpIW1ZMudhGBGTTmZgqYgDM5JK3aTEDl2U3e1KR7ESbls0JLNrWfLMK9zxb5kXi0HZruAUQgU/fOyHfgV6AXEnLQkmh44eZqmFShNBbcWhjoKNHdUkC9/Vy2dj566g3aElNNHAvznJHdh98liWCLXZiAxFq8ebZDBFrjR5OOd85qBUtC9GwjTZRGNlN9gmvyXk71Mm9jEDQMAFwpVOAfbqFWwbg8k4ZDwnAUbSMB0MHRjOvYDKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW38+05mTW/8ck7Y8ZaJXJprQ8wF1U8WJTAfoGRqk6g=;
 b=QVpQzqO/plzDk3re9CRRjG0P0qHjo9ciY7mfRkNLOe2Tx2Qt3JIbMbtmX+wPLQMPL4d99qhQo2rM/o+ffgL0+2meF1X2b6+Djaj7gfxbMz4uHtOitjP0c5qeiSBKXqyNUMVBBoyri9dYkY3yKDFUJMoe19Cxat4WCD2+zGI6a5owuPd2FRr4Eg4r7egb11gZT0PPckBao5two0ZJYvb5Pub58aSTPRQfsLug/uDKS+m0zFCe6v9Fe4u1sVcH8iYY0zZEs+NyzW30wiFRyN/l4mnOswjasZsKYoTF9v2Gck+usD8aqH9r4B+4WiKCnKMG1oI+VExMovlkcQrcJWh0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW38+05mTW/8ck7Y8ZaJXJprQ8wF1U8WJTAfoGRqk6g=;
 b=OLU/cHGAnthtSqUwePTBuUvdGlE2qpwCRu+Thb/qhwIn0Q7TRjl9vhpjcDcCYM7rdjujeInhKseqqxlwN168vrsbibnR5qEiyces6fiL2sZvRw/I7kXJIewVtC7t0lPGJGRJqHSePse4apeDoF3QUODdtW/rx3gfsyx0I0bRqZM=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6456.namprd02.prod.outlook.com (52.132.231.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 15:59:25 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 15:59:25 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Thread-Topic: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Thread-Index: AQHVnzbvRwd5Ss/ZH0ugJQL96aPqOKeUNshQ
Date:   Wed, 20 Nov 2019 15:59:24 +0000
Message-ID: <CH2PR02MB6359CE45D06E908634CDA855CB4F0@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20191120001030.30779-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20191120001030.30779-1-luc.vanoostenryck@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b612d33f-ceb9-4e8f-a66d-08d76dd29da3
x-ms-traffictypediagnostic: CH2PR02MB6456:|CH2PR02MB6456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB64568DC90A782724B291CBAECB4F0@CH2PR02MB6456.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(13464003)(66446008)(26005)(110136005)(11346002)(476003)(76176011)(229853002)(316002)(305945005)(6116002)(3846002)(33656002)(74316002)(66476007)(8936002)(76116006)(66556008)(71190400001)(66946007)(14444005)(81166006)(81156014)(256004)(64756008)(71200400001)(52536014)(8676002)(7696005)(6506007)(5660300002)(66066001)(446003)(9686003)(486006)(102836004)(2906002)(107886003)(186003)(7736002)(14454004)(4326008)(6436002)(25786009)(99286004)(478600001)(55016002)(86362001)(2501003)(53546011)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6456;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nje14Gx1IbB2EWyMkl6TLk8LUT061L4Pw9ISi7e6f4YYk/cGl54Gby1JdVM/uLrqKv4iBXLJNuivzxlQB0r4yqMGD0/ZYagqyng/gBSBWLvEz1fgdYaJUaNQVp/lDM/+BsSDT2Ln9zVf+dcfcHjy/M7tSuKYlh7zeB3GrtdhXhn3jdVqP5xt1/Iy5N4NXzDY31CYTdX0Fh9Pt2n5we+6BBNyNfp3eMEe5CelVRUCOM8g4UxNO8ODR6wjpUgX4HPd6G+WwoQm/5ng4x3UNflQ5dFH/Fo/OM1ejkxfubKDlXx3sMZYUUtut+YQtCZWnHlUpBXgmPQzi/zWzE6JRMfW7Xxr99+2KGIJPgWwl9VHWMDogkVpqXRcRCDOjdDQdaEaaWKUCY2QcF+YyktjhO39E8Kq9o2x6/e4QamPX6XMNMgM+82FFyobxPRLgXA4Ilnw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b612d33f-ceb9-4e8f-a66d-08d76dd29da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 15:59:24.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76Db1XvxDRT0LD7bpXMibBdwjtv0mIl9yBmZ9oYj9OJeSTCFNJKaoCEg7KD32abpp2J4MEeIJp3Ctqs9RP7r9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

For the sake of my understanding I'd like to ask you when the .pole method =
is defined=20
Why I'm asking this? I have a fairly new book (published in 2017) which sug=
gests what is implemented in SDFEC driver.

I'll test your suggestions and will come back to you soon.

Regards
Dragan


> -----Original Message-----
> From: Luc Van Oostenryck [mailto:luc.vanoostenryck@gmail.com]
> Sent: Wednesday 20 November 2019 00:11
> To: linux-kernel@vger.kernel.org
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>; Derek Kiernan <dkie=
rnan@xilinx.com>; Dragan Cvetic
> <draganc@xilinx.com>
> Subject: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
>=20
> xsdfec_poll() is defined as returning 'unsigned int' but the
> .poll method is declared as returning '__poll_t', a bitwise type.
>=20
> Fix this by using the proper return type and using the EPOLL
> constants instead of the POLL ones, as required for __poll_t.
>=20
> CC: Derek Kiernan <derek.kiernan@xilinx.com>
> CC: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 11835969e982..48ba7e02bed7 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -1025,25 +1025,25 @@ static long xsdfec_dev_compat_ioctl(struct file *=
file, unsigned int cmd,
>  }
>  #endif
>=20
> -static unsigned int xsdfec_poll(struct file *file, poll_table *wait)
> +static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
>  {
> -	unsigned int mask =3D 0;
> +	__poll_t mask =3D 0;
>  	struct xsdfec_dev *xsdfec;
>=20
>  	xsdfec =3D container_of(file->private_data, struct xsdfec_dev, miscdev)=
;
>=20
>  	if (!xsdfec)
> -		return POLLNVAL | POLLHUP;
> +		return EPOLLNVAL | EPOLLHUP;
>=20
>  	poll_wait(file, &xsdfec->waitq, wait);
>=20
>  	/* XSDFEC ISR detected an error */
>  	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
>  	if (xsdfec->state_updated)
> -		mask |=3D POLLIN | POLLPRI;
> +		mask |=3D EPOLLIN | EPOLLPRI;
>=20
>  	if (xsdfec->stats_updated)
> -		mask |=3D POLLIN | POLLRDNORM;
> +		mask |=3D EPOLLIN | EPOLLRDNORM;
>  	spin_unlock_irqrestore(&xsdfec->error_data_lock, xsdfec->flags);
>=20
>  	return mask;
> --
> 2.24.0

