Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBFAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF512084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EKD/Ymm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfCKHaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:30:35 -0400
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:39906
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbfCKHae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1CRsCYw982KjPA5JmpVPUTyDn3D0jMzRxNRohVJ/9c=;
 b=EKD/Ymm2w6dP2txyajXgLC/Cewy74FX1mYeHCtyZRYHMYOCTwogZw0PHuQhiF7ECzp22FyBXM9J4AHvOpyod56cNKWkJhCNTXZ5FCOJ9SUakEESI6DRFzbwhHaadV6zhVxQuI4VJvqGCEzy0E7KDA39oZo2hf/mcBn3CTxQkmzg=
Received: from BN3PR0301MB0897.namprd03.prod.outlook.com (10.160.156.14) by
 BN3PR0301MB1315.namprd03.prod.outlook.com (10.161.210.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Mon, 11 Mar 2019 07:30:31 +0000
Received: from BN3PR0301MB0897.namprd03.prod.outlook.com
 ([fe80::7124:cacd:f50f:2fdf]) by BN3PR0301MB0897.namprd03.prod.outlook.com
 ([fe80::7124:cacd:f50f:2fdf%9]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:30:31 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
Thread-Topic: [PATCH] net: ieee802154: fix a potential NULL pointer
 dereference
Thread-Index: AQHU19vi9FjyjlcxI0uICR6+hJF3wKYGCQIw
Date:   Mon, 11 Mar 2019 07:30:31 +0000
Message-ID: <BN3PR0301MB0897817BBE72CE6A33A1DE728E480@BN3PR0301MB0897.namprd03.prod.outlook.com>
References: <20190311072517.29740-1-kjlu@umn.edu>
In-Reply-To: <20190311072517.29740-1-kjlu@umn.edu>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83b5408e-c41d-45b8-286a-08d6a5f3712c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0301MB1315;
x-ms-traffictypediagnostic: BN3PR0301MB1315:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN3PR0301MB1315;23:Ho4gpYfaAaxFh6hnGkDHIAztASSK9r/HQ4wJf?=
 =?iso-8859-1?Q?A0w+7+PU5PxRLs6u3aaGxMEQVsxXQW1YzzNtAEuiC+CVpXOlcMScOIXJbn?=
 =?iso-8859-1?Q?iR7UX37cOYu46yvYKSL/tEN9vAelPQ2fRo18WvQyOsV0LR/ECfAG/VYr0S?=
 =?iso-8859-1?Q?2ml77j1yclij6TyEbI1Cuz2WNKqPODUBYLrdqY5z6JFrameitdyqtt3NTg?=
 =?iso-8859-1?Q?inJPxGDuH/ELqZrckDXg9rJ8dnBOLhtW6lZbuos1ANWaLlM6gfCoqF+oqf?=
 =?iso-8859-1?Q?uY9fSwuYBuLdd7S2QT2CH8zjnwFi0hh8KC4aQuKZyGE6CYPAvDqlK0cwh4?=
 =?iso-8859-1?Q?gS7s6L9A215Y/l8r3ks/y630SkwChVsVRR6oguMfq+nPK7iRWJBLWrNEwR?=
 =?iso-8859-1?Q?KrLNEdjq0RXPKNIkj1cPghbS7cHeS3LgXjMJvSe6XNq29H8LSTYzFdg1nL?=
 =?iso-8859-1?Q?wNfLWHE7ewBY7BIci9TGl4uk6EVDyziN+9Ok3tmJOZvps8nXqJr9cDrnFQ?=
 =?iso-8859-1?Q?CusHsqXsZ7FNmltsxsjF+w+9TEMUeE+8mJvGa7YWXkrlvSgtwwrCkpOBNR?=
 =?iso-8859-1?Q?sVESMVDarcL31Z8ZNBZZGOtIbQX+YKiSMD+jMfmoGsmqXs6jNzURJsdjqP?=
 =?iso-8859-1?Q?XUOMiCOkZAKexrT6rihAijdw7ETIFM1C7hI7XBU8DuK4uKviLS/h3LRUjr?=
 =?iso-8859-1?Q?h2bfShf3Q9mAzqwEabutm/0UYdkhbIWVgIxkVVruKxY7vhHUXwnVlRYRc5?=
 =?iso-8859-1?Q?dkQoHQ0tKTCINSQtTp7mCkzsp1YQh6sR6moQNgsYS7zg+8OzbzmwvEUJWO?=
 =?iso-8859-1?Q?j3hVRm621D53eOMqHgg2HWSz3nsfH4vWVlF4+4qg2L+Azg+umTj9bBeCC4?=
 =?iso-8859-1?Q?Sd8FjD9JHZO/ZJyA9djzSRJAE2xp/WipGECIrB1TJqe9tPGUZX9sWqzOvn?=
 =?iso-8859-1?Q?ZEA/yG0idmhGFOlygZq5r9v5/Wb9RxxfG3MSwWZJeXiMjthht97MW5qv1H?=
 =?iso-8859-1?Q?/pEaF9Nmnvcx6sFl6G/ZW3JDfG47+IL5V06ltVyn8/XWUCprnTYJwG7mzl?=
 =?iso-8859-1?Q?siDKzzq1dIpa0PmiKdKbx2O5xbWodBer1L/FtTZdklgbHrROivme0X6uSk?=
 =?iso-8859-1?Q?IDlSfu9c3ScJV28Vfj9T0jKbrsHtCGLvPeP6aQt8uNcwdEVLCUzWrt8u/b?=
 =?iso-8859-1?Q?+OXkYZwzyzHTanaiYtyqhrTcbLNoi9U9n9eBLI/lQyGNayOMfXQzdlrNrW?=
 =?iso-8859-1?Q?LeisTd+9lfKDWhvfkn655BJb4Hhs/T97nCrPqmnQ04fFARJysEOUOPGcqM?=
 =?iso-8859-1?Q?2nQzSZPkdya3NTyPwlQcv8SZexSH+h/s2zA1rq8FmnmNPlURpwjf2d9NwV?=
 =?iso-8859-1?Q?2QYgr0tJBvpD87uh01ucNOv7IkghiVaG9/42jtmN/YU8zM8PYTfR9BFJke?=
 =?iso-8859-1?Q?Z4TYev1S7Kb5bGW1gPEVfu0MwZOyeyRi0VEeAhb7bPVlIfDNfPhjNgqiRH?=
 =?iso-8859-1?B?QT09?=
x-microsoft-antispam-prvs: <BN3PR0301MB13152C5151C81A959A5484438E480@BN3PR0301MB1315.namprd03.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(136003)(39860400002)(346002)(376002)(13464003)(199004)(189003)(6436002)(25786009)(54906003)(14454004)(4326008)(53936002)(55016002)(2906002)(8936002)(52536013)(97736004)(446003)(11346002)(86362001)(71190400001)(71200400001)(8676002)(81156014)(81166006)(486006)(478600001)(256004)(5660300002)(106356001)(186003)(66066001)(476003)(7696005)(99286004)(3846002)(6916009)(68736007)(33656002)(6116002)(76176011)(229853002)(2171002)(6246003)(316002)(6506007)(53546011)(105586002)(72206003)(102836004)(74316002)(6346003)(26005)(305945005)(7736002)(9686003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0301MB1315;H:BN3PR0301MB0897.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /kjHfXx0vPBh4Nz0yGfTk2EWFE7G4QvpjmmTe5SctJu7P12GKJ/imWeIpc8qtuaE4ijbe4afhcw0dmFyeFJXMhyVhVt5MGUgn1QJLJwoCEASF+JisS99I9UF2CzX1yn13RDUjt0kYhjXl2VQQ+hvGczrD6EXe8LcxfwuSq1arPeHWES6OOSdtarRBq3U5x2yNktGZTqsWrgMvO+TGur8tyXHrIfF81KYCl00lVnwRnxBk97aGue4/IehZZXVFdXfQGDOkHI/IPAv/ZlV2uoxgXsjpNfQUtwbjUetfDxRXRWaEM7s/H4fgw13CRaSTRFUAFYHJz0qzMqI+Zj0T/le5caARQTgp1lQKMa6wENAdxGhBOHw5W1BB/v0BqBEkR6y2XiaWib6eUCfechs9F5hOJoxIFfyQuIkQMfPAxkzmWg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b5408e-c41d-45b8-286a-08d6a5f3712c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:30:31.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0301MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kangjie Lu [mailto:kjlu@umn.edu]
> Sent: Montag, 11. M=E4rz 2019 08:25
> To: kjlu@umn.edu
> Cc: pakki001@umn.edu; Hennerich, Michael <Michael.Hennerich@analog.com>; =
Alexander Aring <alex.aring@gmail.com>; Stefan
> Schmidt <stefan@datenfreihafen.org>; David S. Miller <davem@davemloft.net=
>; linux-wpan@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] net: ieee802154: fix a potential NULL pointer dereferenc=
e
>=20
> In case alloc_ordered_workqueue fails, the fix releases
> sources and returns -ENOMEM to avoid NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/net/ieee802154/adf7242.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/ad=
f7242.c
> index cd1d8faccca5..cd6b95e673a5 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
>         INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
>         lp->wqueue =3D alloc_ordered_workqueue(dev_name(&spi->dev),
>                                              WQ_MEM_RECLAIM);
> +       if (unlikely(!lp->wqueue)) {
> +               ret =3D -ENOMEM;
> +               goto err_hw_init;
> +       }
>=20
>         ret =3D adf7242_hw_init(lp);
>         if (ret)
> --
> 2.17.1

