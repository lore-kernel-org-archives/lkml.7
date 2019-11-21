Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB76C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E586C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DevMdwE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKUPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:40:14 -0500
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:53615
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfKUPkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:40:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3wf6B/sO0dPaVZtWCfiy7Ma39WNrz2GO/rP4M7JNZx7pEOO5VdLns2SB3odAqyVXKE9GrOzLHLij1ZTqBiyr8dzLIDt6N6IvbFSpwMwLvjcJ0/HmL6V3sz/uu0xaZG/JawrOkNN2Ehcf4XqiHjLElIBQsaxypoBWCeXFGRmMpiivI7qdVEVV4Wi9KFc0+NwtrI3Hi/Hgad6GshrqMGHjGfWSRVDZSkUKiih0ZEZa1dgS7lr3ePsuU5IRYkQQth+3W/BfIqIef9lA8SpIPVylR4jaIByMlZ4G/8aQ50U+rhYdIK2eRiq1l3iiIY5+O/weUc2mAMd1ILXIy4/TwFt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi1xLAi/pfn0pRQ57K22k40iTIJH9kvVtWWBPqcOHWI=;
 b=Ex2WYAJLcycWlOx7iqg2qEtKBhYzeM3S5v5jZFAYM0lOUWyXCej5wunI9GFp5KmmzrG0o8eEUSMAS1j4OfPjxKlPUUd5D8QJ2+roH1PPurAekbtv6DqzVHU+OZ3/Kqu7ff4voBexCM7VuFBD6ZslnjLbr8JQambj1O3P4DVWX6CL1UeSpZR/1+nMo2zbBbOXY4H4hCGg0GFH77QP+9zH6LWgNppf7OiVM8JRt46pV/padPxDg+Dvwr3mkmxikLGykINJKGi/N7mBkOVAc269hpR9mWYaVqy3rE+ZuBpX0pfZr+H5WGli2pR87u+ek61h6A+EfrEWGtX8gI8lFhj6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi1xLAi/pfn0pRQ57K22k40iTIJH9kvVtWWBPqcOHWI=;
 b=DevMdwE34maK2Uj57sys73O+a9aZn1FKuhohM+Rrc3UqleIvMJvTy8n5tvKxF4yHQ59lxJwnw7Zodz6X3XJnYu3SGVY5gClQqLBDVy9P24bUSbmRD71il+6LqBvuULzeMIDFVCnZ67X9qo+w9OFUM1B5iCrXdkto8c6LcKHPGGs=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6391.namprd02.prod.outlook.com (52.132.229.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 21 Nov 2019 15:40:09 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 15:40:09 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH] misc: xilinx_sdfec: add missing __user annotation
Thread-Topic: [PATCH] misc: xilinx_sdfec: add missing __user annotation
Thread-Index: AQHVoGRt3CVcauEqNUiwvOc1prLddqeVwwaQ
Date:   Thu, 21 Nov 2019 15:40:09 +0000
Message-ID: <CH2PR02MB63591D25827E2A88BE9AE897CB4E0@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20191121120827.4079-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20191121120827.4079-1-luc.vanoostenryck@gmail.com>
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
x-ms-office365-filtering-correlation-id: 1ea6aaf8-a527-4e89-71e7-08d76e991773
x-ms-traffictypediagnostic: CH2PR02MB6391:|CH2PR02MB6391:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB639166058053630A84B10892CB4E0@CH2PR02MB6391.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(13464003)(199004)(189003)(102836004)(186003)(54906003)(76116006)(71190400001)(14454004)(110136005)(5660300002)(14444005)(478600001)(71200400001)(256004)(25786009)(2906002)(8676002)(446003)(7696005)(26005)(76176011)(6436002)(9686003)(53546011)(8936002)(107886003)(6246003)(11346002)(6116002)(33656002)(4326008)(3846002)(229853002)(55016002)(81166006)(81156014)(86362001)(66446008)(66556008)(66476007)(64756008)(66946007)(6506007)(316002)(66066001)(52536014)(2501003)(99286004)(7736002)(305945005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6391;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fx90W1R/09qIJnV1sRkWLD0aXZrVpkyvyjRPYL5zutDcG6O+GD4GjoZOa9R686BANZbz52RYIhTgoGBZS7aMtGRvE14obIMuXUXUzm4lCra1ndDbbRbWqikU6v8li6EnMXiKC1eaWwvDx2Fd+lHHmw81mldY59ol4IbburfrxHrJaCa2Xj71a63a9mhOvyDb6v5NUV+tNEFxGKD2hJDddexVoxKF6j26wUx1Nezg/pNvqyTCn0/iqy8ZWrndG2gRVhx5nM6lPwsqBn1Lzm30nNIcV1Zbj0KKSiSu75SXNv4MGkdrohLyd8tktxjJ97FHjhxxEYa67td671ZcqF/aAZFkrCp3cLOwyu6QftLS75rPLqIIUbLei5rHSbxKsGZZTMP6h7L9GCiEOmB6+nY9ZaJQd+z3NwJLxdeyybsOaZAcJX3ynlmG69mgzxbkn3ed
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea6aaf8-a527-4e89-71e7-08d76e991773
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 15:40:09.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5AKnksQZhxWSZyehK9MQnQ0tgH0LbhB5Mz5zNHTxQP+MIb6JtP8pGT2L+TThsvcMqwCemTmbBj30BzlF+Edug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6391
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

Find my comments below

> -----Original Message-----
> From: Luc Van Oostenryck [mailto:luc.vanoostenryck@gmail.com]
> Sent: Thursday 21 November 2019 12:08
> To: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; Luc Van Oostenryck <luc.vanoost=
enryck@gmail.com>; Derek Kiernan
> <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>
> Subject: [PATCH] misc: xilinx_sdfec: add missing __user annotation
>=20
> The second arg of xsdfec_set_order() is a 'void __user *'
> and this pointer is then used in get_user() which expect
> a __user pointer.
>=20
> But get_user() can't be used with a void pointer, it a
> pointer to the effective type. This is done here by casting
> the argument to a pointer to the effective type but the
> __user is missing in the cast.
>=20
> Fix this by adding the missing __user in the cast.
>=20
> CC: Derek Kiernan <derek.kiernan@xilinx.com>
> CC: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 11835969e982..f05e1b4c2826 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -733,7 +733,7 @@ static int xsdfec_set_order(struct xsdfec_dev *xsdfec=
, void __user *arg)
>  	enum xsdfec_order order;
>  	int err;
>=20
> -	err =3D get_user(order, (enum xsdfec_order *)arg);
> +	err =3D get_user(order, (enum xsdfec_order __user *)arg);
>  	if (err)
>  		return -EFAULT;
>=20
> --
> 2.24.0


Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
