Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636A1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303F423428
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gDYZ9KTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393415AbfHVRr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:47:56 -0400
Received: from mail-eopbgr760057.outbound.protection.outlook.com ([40.107.76.57]:34942
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393214AbfHVRrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:47:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX9fl2r4wlhsMbem5DOrZM/LOYqCxOilkGZDUxTKi+wlHiWksTkMb+IykJ9GJcmH4R5vHBiSNNTdKQteYBJM74IUoxPkthVsJRDIDlAGKK3twLg29Y6xQ0CMcmlBL0ycFwIBFWG5GccrEGJM5wiey0URzl60SZbQuLtTer75fzdauWp/BDf13SP+GihhGjYXxZ/a6tHF6COMfjx2pABZVUY8L0eGnkbub2I+nfFBdNMrHrYrhKlMAzUaTyepgrc5uw1wg22hZqph5Q/kaCaQxUvwLf1VhglbfLltHkW1Ot1QoM/DmLe4chLWlCe/FVhdGsChSckjGko3h1t6IntCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqDa3pIwIiqDvvxtt27nz9xXjLuh4u4Tolb+kQ3PrU0=;
 b=iqqNP9oqKrQuIINeo6YBPteo/Gq9HnR0rU41C0kiDod1U/pJ9kZcP8CAF1fxw7IIDtbZTbyQb+3yLNanfrV3/Ct+OdNDgbvsK39O4auT/SaRayEC0GxpowTV+pGTp8GIHG7loO46jvaHi6/0DGgHcjJb70RzaTxxvTfD/Uiwi0hY+PijvPjzSFeZKI2vuDticON6xpQCL0qKNZZxSGdR0i9AV2lnvww45jsyVXqlT1df4b+LgdF7RATzOMJ7NVQ3iPCSBNVeIK/HyFWYSiLdHY6qVSgPPPfE0mGRDxn+lb7DQY+B//mDhrI/uBMen2Lpz9/oTb3/t9P6qDKc/PSo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqDa3pIwIiqDvvxtt27nz9xXjLuh4u4Tolb+kQ3PrU0=;
 b=gDYZ9KTkAOk87dYgOxIRA/QyP7nmXzvocb5LT1sgpmt7p4MiXdVxhfq05FPC11id/L7Yz0Yoy9MxceAr5b6siwVByLHEvWpH9Bi7HaWerMnlSZkf3abhxz+sN4lZMMkm1gSF0zHkChBc2ZtMlwDUbQWh0JGDkdFFM7tX0IVZY1o=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6789.namprd02.prod.outlook.com (20.180.17.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 17:47:40 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:47:40 +0000
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
Subject: RE: [PATCH 2/4] misc: xilinx_sdfec: Return -EFAULT if
 copy_from_user() fails
Thread-Topic: [PATCH 2/4] misc: xilinx_sdfec: Return -EFAULT if
 copy_from_user() fails
Thread-Index: AQHVV+8TkOGZsbP3SkqxFCOXwmgcjqcHc2uw
Date:   Thu, 22 Aug 2019 17:47:40 +0000
Message-ID: <CH2PR02MB63593847840988DBE32C8D65CBA50@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20190821070606.GA26957@mwanda> <20190821070702.GB26957@mwanda>
In-Reply-To: <20190821070702.GB26957@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4580992c-29b0-4533-586d-08d72728d3f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR02MB6789;
x-ms-traffictypediagnostic: CH2PR02MB6789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB6789AFAFFA59CFC111C0B867CBA50@CH2PR02MB6789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(199004)(189003)(13464003)(5660300002)(14454004)(53936002)(52536014)(11346002)(446003)(486006)(6116002)(3846002)(33656002)(66066001)(476003)(256004)(8936002)(6246003)(6506007)(53546011)(26005)(81156014)(81166006)(8676002)(86362001)(4326008)(25786009)(186003)(102836004)(66946007)(66476007)(6636002)(76116006)(76176011)(478600001)(74316002)(305945005)(316002)(2906002)(229853002)(54906003)(6436002)(9686003)(55016002)(7696005)(7736002)(71190400001)(71200400001)(64756008)(66446008)(99286004)(110136005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6789;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h53mQyTeQJm6b6NQHRq3mYWy4k8YoA325JxFdlvTZhL7WawSwBT4/YBefKQ/YPQFtO1pNdzro0vpc6u467tQXpExvxpT9gZGaS1tbd58OjiykMFddxvSLEbni8d+n9owSzM+wpi/PklYTLrRNedoEBMt+cxOj8fX1VMx4vAfBL0phyyp6yl9YdQ7pBjlz/dhtBVO6sJaPsQt6UbN+fRKepoxKn7HWmAqYoF0JcMmR00s7hff343rTW/N0q0vNLNIa3GgX4HHcRY3DPIsTnay3LYPZnHFliLKmApvWQkxi1gXfL4eozwKJFkau80Et2KzjQuzKRvTrLgUDs62ktPDMo43CDKxgh1vnwWJNU9RTGJ6KFAb0RilA/8hVG77eNwLt2B2ySAlb2PqVtLV1d+aZYqJtAUI5h9DZaaJdiDitrg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4580992c-29b0-4533-586d-08d72728d3f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:47:40.3399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nmf6MiNZEULTLlkFWvBetcdWtaHP4+U1CS1TgV3H4QUVGXB8qAgOEa1R0nGZ2AeLBPDnglCd3tjRLr9lmf534A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday 21 August 2019 08:07
> To: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>
> Cc: Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org>; Michal Simek <michals@xilinx.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; kerne=
l-janitors@vger.kernel.org
> Subject: [PATCH 2/4] misc: xilinx_sdfec: Return -EFAULT if copy_from_user=
() fails
>=20
> The copy_from_user() funciton returns the number of bytes remaining to
> be copied but we want to return -EFAULT to the user.
>=20
> Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index dc1b8b412712..813b82c59360 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -651,9 +651,10 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec=
, void __user *arg)
>  	if (!ldpc)
>  		return -ENOMEM;
>=20
> -	ret =3D copy_from_user(ldpc, arg, sizeof(*ldpc));
> -	if (ret)
> +	if (copy_from_user(ldpc, arg, sizeof(*ldpc))) {
> +		ret =3D -EFAULT;
>  		goto err_out;
> +	}
>=20
>  	if (xsdfec->config.code =3D=3D XSDFEC_TURBO_CODE) {
>  		ret =3D -EIO;
> --
> 2.20.1

Reviewed-by: Dragan Cvetic <dragan.cvetic@xilinx.com>

Thanks,
Dragan
