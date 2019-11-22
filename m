Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72A220658
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="E7pvN+Es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKVTnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:43:12 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:47781
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbfKVTnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:43:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwwx2VkhgBTHn8OpB9M/vWBRo/KuUdsGedAtVKNNkG1afnssY56/MYXBjciKHZF78BwQTRmrvmVMvt1tfpUeSs6xcLEs2uxb+zlN0BQMW7iVfLFUn1smY3E/SK+c0gGH/p1SDSHEo72pLce5YpoFi25vfgBrPitsaogC+iPLsjz5WkQjB2aEgBHk0/on1KjlD+qtu7cPaNB7ZKHE24g+EfpZT6A/7LQxV5waDGKUJ6qwLvT7vTdXSwp24K5cWEDDAXNIg7t2jvFOCFtla8VzKyjJ8mVOXjMAxVsE1HgaVi5mdgCVFPi/5T5SIkrPl7CQpsONqsv47scpnplweB0geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMVTJs3gA21QbjgXI/0Pv/F3ftSB8rP6iacsqtlb4GU=;
 b=P2kOSkw5cIgZDTgfeILLoW8B3Z7cI8+dpGNRChHTJLPawL/DbJHbNVrFrdlk7e4K/Ygl4Hh+YlkukSXwP4xrh+HtqLcW0hC3PEnwaDo6hfBwGFBMHK7zJhpbfuDQhSJPZw4egR+gX8jlEqZj16mmI/r6Bo43SfsX2wlWzHpeYWk/HEPDRUWl7SWdtmYb6VYn2ljcjhrmKbQlKOrDfPvF4n6fqvdpoz5+pGwSTdgI0woHPB1KiuA0xK8DvlXrQGy/gdYNJRGdRzDL+Qti93moQAmkjG6/xhuFfJOEzUDn3vUf2TXD3yzNqcW009xj47d7ibQ2sR/typMdymGRpqbxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMVTJs3gA21QbjgXI/0Pv/F3ftSB8rP6iacsqtlb4GU=;
 b=E7pvN+Esz3xmvUNC0ZZAhIoii7zM/uxSadML1Cg6Bjq1MH7uGlzE8RxOHUPRm64596g93nlrXAs/2ewgXAju6jsIQT6DNLS9Omdg1axFNfUAtXFQ9VvUnl77lqb1+mcKtsQf8qYC5vwjkgFlCu8HI9I/T/gNjLNQvROMSwq6WE0=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2549.eurprd05.prod.outlook.com (10.168.77.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Fri, 22 Nov 2019 19:43:06 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1%12]) with mapi id 15.20.2474.021; Fri, 22 Nov
 2019 19:43:06 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     "minyard@acm.org" <minyard@acm.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] ipmi: fix ipmb_poll()'s return type
Thread-Topic: [PATCH] ipmi: fix ipmb_poll()'s return type
Thread-Index: AQHVoWy9dzHT4ezyPkGsfMiFXFnBaaeXlxkg
Date:   Fri, 22 Nov 2019 19:43:06 +0000
Message-ID: <DB6PR0501MB27127F64884DEA1AF3E4620ADA490@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20191120000741.30657-1-luc.vanoostenryck@gmail.com>
 <20191122194041.GB3527@minyard.net>
In-Reply-To: <20191122194041.GB3527@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c59618a-b592-4395-ba42-08d76f843206
x-ms-traffictypediagnostic: DB6PR0501MB2549:
x-microsoft-antispam-prvs: <DB6PR0501MB2549E74BEC90F4DC6370A07ADA490@DB6PR0501MB2549.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(13464003)(199004)(189003)(102836004)(186003)(316002)(6506007)(53546011)(25786009)(110136005)(7696005)(54906003)(52536014)(71200400001)(11346002)(446003)(5660300002)(80792005)(71190400001)(256004)(26005)(76176011)(4326008)(55016002)(8676002)(14444005)(7736002)(305945005)(9686003)(66066001)(2906002)(6246003)(74316002)(86362001)(229853002)(81166006)(81156014)(76116006)(2501003)(14454004)(66476007)(8936002)(64756008)(66556008)(478600001)(3846002)(66946007)(66446008)(99286004)(6116002)(33656002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2549;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bhy+7VwUzGSo5o1zKncK8uNJ8ShwHq5LD/lYmNqyTByxhVtrTecMrPebP1u3zSa+N8wL7zFyi+rrZi61bKASeCmCozaWTCdIKt9ETOFHnWjmXw8gTlu2i5MloqhEAZVFUo03YS9sNV7K4WCo6yCNXKnbPUCcwo30pnHTAWULa3wIvlZtb4FC5oHsyFfz+6K7uumMvmUDk0gY2tbPhQbFCw8GIWY5iQL0kG0y3tcLgq/vK8Q9zB93/RGELjYSVPh3gUFWvjtWyGTYTEzjkFC0eUO+7YnU5gC57ngvQ9dsMlZAqzFKBs53sb4HUcQV8Kv18GT1heVDqSprFo2CJjtGrulLnCWY4NJ/hSXa2n3yXxsQkAF/FcP0g4Q6RacKFXjtL9jpRMPEHLv9/SVxmpx65+GryCbygttHKrJXD/6GyrP/5z3EnQPuH7w0GkVgr4nk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c59618a-b592-4395-ba42-08d76f843206
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 19:43:06.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijQ+HftZDk4dExIDnqJ1DxOE37ZENIqjpS5Xo8N5PLNEDJoiYRktftqOf/wOcj6UxJqim8Ka/ykR/PmopkGxGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Asmaa Mnebhi <asmaa@mellanox.com>

-----Original Message-----
From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
Sent: Friday, November 22, 2019 2:41 PM
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org; openipmi-developer@lists.sourceforge.net;=
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Asmaa Mnebhi <Asmaa@mella=
nox.com>
Subject: Re: [PATCH] ipmi: fix ipmb_poll()'s return type

On Wed, Nov 20, 2019 at 01:07:41AM +0100, Luc Van Oostenryck wrote:
> ipmb_poll() is defined as returning 'unsigned int' but the .poll=20
> method is declared as returning '__poll_t', a bitwise type.
>=20
> Fix this by using the proper return type and using the EPOLL constants=20
> instead of the POLL ones, as required for __poll_t.

Copying the author for comment, but this looks ok with me.

-corey

>=20
> CC: Corey Minyard <minyard@acm.org>
> CC: openipmi-developer@lists.sourceforge.net
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c=20
> b/drivers/char/ipmi/ipmb_dev_int.c
> index 285e0b8f9a97..2ea51147c3e8 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -154,16 +154,16 @@ static ssize_t ipmb_write(struct file *file, const =
char __user *buf,
>  	return ret ? : count;
>  }
> =20
> -static unsigned int ipmb_poll(struct file *file, poll_table *wait)
> +static __poll_t ipmb_poll(struct file *file, poll_table *wait)
>  {
>  	struct ipmb_dev *ipmb_dev =3D to_ipmb_dev(file);
> -	unsigned int mask =3D POLLOUT;
> +	__poll_t mask =3D EPOLLOUT;
> =20
>  	mutex_lock(&ipmb_dev->file_mutex);
>  	poll_wait(file, &ipmb_dev->wait_queue, wait);
> =20
>  	if (atomic_read(&ipmb_dev->request_queue_len))
> -		mask |=3D POLLIN;
> +		mask |=3D EPOLLIN;
>  	mutex_unlock(&ipmb_dev->file_mutex);
> =20
>  	return mask;
> --
> 2.24.0
>=20
