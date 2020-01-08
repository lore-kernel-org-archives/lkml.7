Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6BFC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA55206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="O/0QdSre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAHHQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:16:08 -0500
Received: from mail-eopbgr60100.outbound.protection.outlook.com ([40.107.6.100]:15234
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgAHHQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:16:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIVjCFxJJmq7Sh7nnZ/aFAVAZLFnuPctXLNWwHV8uRyaKX+5osam7yZqCW5Ha7HqbsbFlsvwt4qCWRTg36opv5O2DZwC00btDSyt3ERtjB7a6yMG/MRjEkv4uHVpODhtNzZyfqQJAm9lUc08v/q+Es6SHrO+0UzQfCJUvd+jC9HVBN0HHSjhE4tjEltcnBY/zhWtLUhGJ9jgh0czkvW1c2sgvETT/I7Ih0tomsI4j9zM5QYZXrOQgiy7h5ktnArtX+mo+nLX0KwYor0kjAsYNZcZB4lnjST0lcoPziCPhIr1XW5Tp+oJ5TRsO4Fh9YiQWTwyagWTwM7eaxVCFK46Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hQAAQ6XvNzJvstg/T/YaAOdRKR2buNkJlF5JtEOBrU=;
 b=bY5+Z6tT2WZH6YpshVA4RyBwmodlN6LkX6Azq+koRbOoBmJhDmiEwslVfu80vpJWLV45BRywwm43FuY4dCV9pDJmAEz6KgoREK6kyQ5O7HSMZGF9IWA2gpf7eurLsBlEb3kwUxVtlvv3A+pNx1mYfwKXpsFBcLhvYYztU0aJwBZxs5nJ7MbPZzM1X3ie5m3isx1/mt6gDMYE5Bz7/0FzFeX0K3NtOXVUztFBoD91/1E+g5qiCrlk1ubhKO1sg+QTFXoNcC6fZ46VbxddlLFxFe32xceqENQT1YkS5C5nSOjjKpTqknzjTIlaKP/P+lL3i9LqBl5OqfmK1pV1oFmVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hQAAQ6XvNzJvstg/T/YaAOdRKR2buNkJlF5JtEOBrU=;
 b=O/0QdSrem0lexufKMYLS3QUDEBDuNB+YAv1xMFa44MCKyUdXjVSIgFAMbDEuZlXo6UqrSe0/Qf3hJQ77Nd/rQbTaH80s/j41d+B+Rv9KYXdRzGGFh1Fsjg84Alb3HSRn65RYrksOjLI9J2XqFKx55Rzdm7+fvwyzCpefwa3HzBQ=
Received: from HE1PR02MB3258.eurprd02.prod.outlook.com (10.170.242.32) by
 HE1PR02MB3226.eurprd02.prod.outlook.com (10.170.243.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 07:16:04 +0000
Received: from HE1PR02MB3258.eurprd02.prod.outlook.com
 ([fe80::24fe:bc90:5c45:acbf]) by HE1PR02MB3258.eurprd02.prod.outlook.com
 ([fe80::24fe:bc90:5c45:acbf%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 07:16:03 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: removing extra ;
Thread-Topic: [PATCH] habanalabs: removing extra ;
Thread-Index: AQHVxabWlT3g5pqcFUWJu8jo3DzCwafgWrqQ
Date:   Wed, 8 Jan 2020 07:16:03 +0000
Message-ID: <HE1PR02MB3258A53C1C794E196748052CD23E0@HE1PR02MB3258.eurprd02.prod.outlook.com>
References: <20200107220717.31447-1-oded.gabbay@gmail.com>
In-Reply-To: <20200107220717.31447-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc04f2d7-d28e-478f-fefc-08d7940a9f43
x-ms-traffictypediagnostic: HE1PR02MB3226:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR02MB3226968DDECB876487A9A3C9D23E0@HE1PR02MB3226.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39850400004)(346002)(376002)(366004)(199004)(189003)(9686003)(6506007)(53546011)(478600001)(81156014)(4326008)(7696005)(8936002)(8676002)(86362001)(33656002)(81166006)(186003)(26005)(55016002)(66946007)(110136005)(76116006)(52536014)(2906002)(66476007)(66556008)(558084003)(66446008)(316002)(64756008)(5660300002)(71200400001)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR02MB3226;H:HE1PR02MB3258.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rsRNtmtIzxK77d8iGVk3eqUtinw4MMS8/4a+8CGsGUnY5ays/rwAJTv4GEX5tDwDztgL/xogahvmT3Tf+qkDxLaVgxl9KLbT1dnx2i7uh3efR0au1YSTGRtxdDtRwLPy46HcIBA4LhjRzFozaTBEBkXT480bZ6LW6jKQ+s2LTz4qvci5BXLthyk9sDcERUo3DAXOW60lSZZRUjV5f5KxmB1BnUunhSYS/b2KJTpRPGlNSAsW5vWtfgvppEFwIt4/EOlACVbF+btunKpeVey0tqB6Xa9OIzXMbCZgo14ja7S3TNUJctXkUvlHU0g85nqFgQw2+kWHpQxrHB6JVR9eU3/qkJe2Nzd4Jt52JIvPEGrJBhsRRKrWKWOkLCxCs5Z5VpcXQsNsYkTXxXddaBl9ajtiPc7qSjdMeZyxBndz4aWrKsFuwTwospj4y+oqY3Zz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: dc04f2d7-d28e-478f-fefc-08d7940a9f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 07:16:03.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wzk1Qvvg/SJ0V0TTUHVYPR//jyA+vtRR22GjGBV/9/DyRaw/zLa2Xj3R8UFeCusRbCSF7ZFRfxyY6ukGwtzyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR02MB3226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 0:07, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> There is an extra ; after the end of a function, which needs to be remove=
d
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>

