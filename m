Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E66DC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D202089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="LZt8N0gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfGaOjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:39:25 -0400
Received: from mail-eopbgr10127.outbound.protection.outlook.com ([40.107.1.127]:11589
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729249AbfGaOjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVpjd/i/eVx0lI8YxZDvRiBAKcOIRrw4DkFkImm15MiRzlscZTd0ZxovgxKGCjL79BS+tewI2VvkkIarKWqfqkF3Fc5VMIBkE7l2kgBUof6mn9ksaPFif9Bd5JD7YsnkOLlXAm4hZnMDgOOasPO3Snk/55q9KBj93xejE1sGeZ+fQI2bl0gQS0bR5FMG+3VUNXMH34CgoMON89dKELUHZNlwiL4ykIOrAPLajsKcu8LZzan29OvjGky/R65U20gE1JrVJlOuUNxhxJS/ymx9bRRRY9AUxCNe1uB+FnZ8qDCbHZqrQFhCztmSzrSrzmLM059+xJ4J32kEvZHurUl5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+XH4gmHLneMT/tW5/acb2ISNC7xH+b3TxM52Z3XVpw=;
 b=LFVc+XRI2frywTEpxntvMyTeEMHpevQbwuW1QWdTCgZPDCE9I8Ndcnfx2L8tI6ClaUSwqt2rK0jeJZ729hyN+rjBEBRaedaEg/Ono4KGNUj9odrigwf5RQBAbJQoeXmbYy7zvx1sDMIv6o/EybyHSiFxva1B4m+IJdXHgO+QtH9UPvvwFXuK/WQSFtICfw2Tpraozab03Y8s339oG1ngtfYwsH5wmLqD5XcY0NhGnpTbbXZGDfkN5sSV8rgSCuNzWwZSKWMB4YoUk9xXjjx/fuGRovVUCWJg8d3+UaBYWcCvq0NVMojev0kCH9+cYu2tcevsvrtTqPMcILHufpxHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+XH4gmHLneMT/tW5/acb2ISNC7xH+b3TxM52Z3XVpw=;
 b=LZt8N0gxwTpNG3OjfwHbRma1VyZMEQGRsBYrXBSRBITjaivfejD3QkgpNDLdn9XxeTXkflTCfgHHUmy/fcvB73IIVr/F0DFBA6m6/bXBRZlxDlTTnGn5/VPwPQbLkzxeGurLMZjfxLQB3z5eSp1VORMT/UNpHOrqfEDIt3poInA=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB4095.eurprd05.prod.outlook.com (52.134.19.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 14:39:19 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 14:39:19 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v2 08/20] ARM: dts: imx7-colibri: Add touch controllers
Thread-Topic: [PATCH v2 08/20] ARM: dts: imx7-colibri: Add touch controllers
Thread-Index: AQHVR5zSfqDLO7YI3kGn89/J0dQlQqbkq6cAgAAglgA=
Date:   Wed, 31 Jul 2019 14:39:19 +0000
Message-ID: <8ba2c50bbe5a4a02bd676371a24e2d6f2b05f102.camel@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
         <20190731123750.25670-9-philippe.schenker@toradex.com>
         <CAOMZO5B3BcpjbnsXuE5abX8YsuLDrkkHU=RBt6w_SpwuRkTvXA@mail.gmail.com>
In-Reply-To: <CAOMZO5B3BcpjbnsXuE5abX8YsuLDrkkHU=RBt6w_SpwuRkTvXA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76ca7865-608a-455d-fd29-08d715c4decf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB4095;
x-ms-traffictypediagnostic: VI1PR0502MB4095:
x-microsoft-antispam-prvs: <VI1PR0502MB4095FB7F3B7AA8D98597F7A1F4DF0@VI1PR0502MB4095.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:136;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(136003)(39850400004)(396003)(366004)(189003)(199004)(256004)(5660300002)(54906003)(99286004)(558084003)(53546011)(6506007)(1730700003)(66066001)(44832011)(118296001)(8676002)(186003)(1411001)(2501003)(8936002)(36756003)(14454004)(102836004)(316002)(25786009)(3846002)(26005)(7736002)(446003)(64756008)(81166006)(1361003)(86362001)(229853002)(81156014)(53936002)(6116002)(478600001)(11346002)(66446008)(2906002)(6486002)(76176011)(2616005)(486006)(476003)(68736007)(66946007)(6246003)(4326008)(66476007)(66556008)(6916009)(6512007)(305945005)(71190400001)(71200400001)(6436002)(91956017)(2351001)(7416002)(5640700003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4095;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gh7Tqsb/QjzPU6lVNzYptZ1+gSg7B8clNQB0P4HebHmV5ki1QTe/oTlVFzsbZ3VdbXKDUiUKtY7ILnW1NXBFoz68QX4udRpmMMAbjEf3w50AlWW4Upv9AIw6C+3MUaCGHbTYUOMfTgc7fDi5cPJkZMfS+0HYX/6mkqCaLktODbQYvMdVuMxzaw/UxF9Rbb7e9c/cV3uTZWn066FEz2hmLMJViM5vAUN4tTsY9SOck31vEfjS6OUsMmt5YGAdsnr1Mr6zFTpyE4OT7uRjH7smm4/HOVkq0CqzbL3mSpzjb3+C8FB8CkYRHYrTH+NnUbkwPTtW/W49q54jE9jGLxW4k5nYhaBH3mRQA8N/C+vIuPQQnWF+TcEC3J8HMcuazmrnaFh2nkwslt4HKkEqJ67FQ5R1Eub9ABrjLDhJQw17CTI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADF45B12F529474F828A569027DB3A3C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ca7865-608a-455d-fd29-08d715c4decf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 14:39:19.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDA5OjQyIC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBPbiBXZWQsIEp1bCAzMSwgMjAxOSBhdCA5OjM4IEFNIFBoaWxpcHBlIFNjaGVua2VyDQo+IDxw
aGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+ID4gQWRkIGF0bWVsIG14dCBt
dWx0aXRvdWNoIGNvbnRyb2xsZXIgYW5kIFRvdWNoUmV2b2x1dGlvbiBtdWx0aXRvdWNoDQo+IA0K
PiBZb3UgbWlzc2VkIHRvIHVwZGF0ZWQgdGhlIGNvbW1pdCBsb2cgOy0pDQoNCkFoLCBzaG9vdCEg
Oi0pIFRoYW5rcy4NCg0KSSB3aWxsIHNlbmQgYSB2MyB0aGVuLCBuZXh0IHdlZWsuDQo=
