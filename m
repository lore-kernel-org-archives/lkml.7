Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814F0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE7D208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="dfrxEOMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407230AbfHIPAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:00:53 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:32386
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfHIPAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXsso22e7daSkBd222uWj8zvLd/eoHr1nzifCmpULAA4zuiqSrOnE/KMUrEatC0vR4IEIwDep2+53+16sNoJxfFPFCaT7KnYJwwi2eNrjgvMyJkEoNB6hygjCe2MSClUO4QaA6C6GrDOFlHLgOKtik/jS0aEeruuyTOtlXInPKFlrBV58+0F0ADPOvCdM9EZ7GF21lYQKy5ArEYTmrG2xXZZ0XeTY4RqqZZMzf6fmKTDl6EMzdwR8RO26cO8/ya2w8NaKe8fnrEGIOrKdSR4S3wlaU0Vlw11cEdmO7LAJiOAt6Exgk73UH5zM7lsmNA+vDcDmIijOfUImP1MubPlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRhFdyQV8oFntXECIDlE+UjsS++x4UxqJ1rMAFuWti0=;
 b=FVi9PqW598r1V47HKQHNYaeUip6H0FZRDpKdHR9Z3Pr+oE+N4x7ri45UZnMsoNnS0HozfWIrucuJIhKCyIP2154Q4GRJnxQqoA9dxbsGn2VQvIOpVSyHRcSzGpKVDY884mmtja2RLOmbrgCMo1JL/S1+1ht4K2k3FBG+8UayeKZsYuhbzveR9SlsaTmqsanqXwVhmBXMFhpMKfCZhLskY7ze3N7JXDH6shKECarJAO4ityeZ26oH4GWiXc5LqOtES8A+qIMK8kJQhPjIReLVwETko41GIgO7MzBuu69M2wdYnUJURq975J7OF/QnmNyyS/hZ8Dnpv73EtRp+otTvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRhFdyQV8oFntXECIDlE+UjsS++x4UxqJ1rMAFuWti0=;
 b=dfrxEOMnZ7sDAyYU/Y3WjhRy3wiKLJOdt6MAvzJ/NmmIVCI+x8ZiBLi+dyN8LN0WB1lbg8QrYGbLMWr0m0Ro934+MYjsMKRbPODuPWQeyY+CDJhsK4P7RA/E0cblNXuygNsEpFXzaDBwv1n69g0LKVPGG0bL3oniBFCITikuE28=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB5647.eurprd05.prod.outlook.com (20.178.120.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 9 Aug 2019 15:00:49 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:00:49 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 10/21] ARM: dts: imx6qdl-colibri: Add missing pin
 declaration in iomuxc
Thread-Topic: [PATCH v3 10/21] ARM: dts: imx6qdl-colibri: Add missing pin
 declaration in iomuxc
Thread-Index: AQHVTPnPhX4Vi6jCPESx4uK0xhBEO6by7IAA
Date:   Fri, 9 Aug 2019 15:00:49 +0000
Message-ID: <c0fa7267d6741ebfc5936e7650388f364dfc63c9.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-11-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-11-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bef4fc6b-c5bc-4e25-f7a7-08d71cda5d90
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5647;
x-ms-traffictypediagnostic: VI1PR05MB5647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5647878695886EE7DF2D1ECCFBD60@VI1PR05MB5647.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(189003)(199004)(53936002)(316002)(66946007)(6246003)(6436002)(86362001)(81166006)(81156014)(8676002)(4326008)(71190400001)(66446008)(229853002)(64756008)(7736002)(66476007)(305945005)(2201001)(91956017)(76116006)(36756003)(66556008)(6506007)(6486002)(102836004)(186003)(118296001)(110136005)(8936002)(76176011)(2616005)(71200400001)(11346002)(446003)(486006)(44832011)(476003)(14454004)(46003)(2501003)(54906003)(5660300002)(7416002)(6512007)(256004)(25786009)(2906002)(99286004)(478600001)(6116002)(32563001)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5647;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p+VkuSTNdnwgkmG720WugOkEPKW8UgscqC52GOwyS668JeiIx5vlyTzXXdkcVo5cfTU4sFQAOfo0Jsy9CuyUxd73wRH54X7849oXyr+51bbGxaAK0WCpNlfadZC4/0c49OPSSnJi8nd2JDHupRgOp8bfY08EuwqUcYXzN+aqVKlrV5DZPa6INE4pZ7Mh6jHmzqqnjfYqVuedFozX5bORrR/4X4HvhImaBB+UGhzePNtnGqFhZrJkI1riXUACHVCplFvmQtSBNo+LD5zZEg5vgvgaEJ8VNCqvamrbQWEvd8cDAQaBDVtYhZS90mQkD6HtnFI9yGoDE9XFcYy68J7K3jMwycMFHIL+xrEP2Uy6r0a8Kl2l/71aF7zMbomqbnNjwfzVIlP/tLPNAQIZmh9FNRgnq1PN+6JqDR2vasdgnd4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8959A8F1E13A494281877C2426FEB519@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef4fc6b-c5bc-4e25-f7a7-08d71cda5d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:00:49.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t10+v6gyA/zqnSu8U6CkV/6NefNxhViN33TPqvxJ5tcxVzruNTjEw/kMlUkNVMvdlySdsysb0oh55gN0ahTJXLVZabx9HkKVI/tHqd0QZh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gVGhpcyBhZGRzIHRoZSBtdXhpbmcgZm9yIHRoZSBvcHRpb25hbCBwaW5zIHVzYi1vYyAo
b3ZlcmN1cnJlbnQpIGFuZA0KPiB1c2ItaWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
ZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoNCkFja2VkLWJ5OiBN
YXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4g
DQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPiANCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpIHwgMTQgKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kNCj4gYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0KPiBpbmRleCAwMTlkZGE2Yjg4YWQuLjlhNjNkZWJh
YjBiNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0
c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kNCj4gQEAg
LTYxNSw2ICs2MTUsMTMgQEANCj4gIAkJPjsNCj4gIAl9Ow0KPiAgDQo+ICsJcGluY3RybF91c2Jo
X29jXzE6IHVzYmhfb2MtMSB7DQo+ICsJCWZzbCxwaW5zID0gPA0KPiArCQkJLyogVVNCSF9PQyAq
Lw0KPiArCQkJTVg2UURMX1BBRF9FSU1fRDMwX19HUElPM19JTzMwCQkweDFiMA0KPiBiMA0KPiAr
CQk+Ow0KPiArCX07DQo+ICsNCj4gIAlwaW5jdHJsX3NwZGlmOiBzcGRpZmdycCB7DQo+ICAJCWZz
bCxwaW5zID0gPA0KPiAgCQkJTVg2UURMX1BBRF9HUElPXzE3X19TUERJRl9PVVQgMHgxYjBiMA0K
PiBAQCAtNjgxLDYgKzY4OCwxMyBAQA0KPiAgCQk+Ow0KPiAgCX07DQo+ICANCj4gKwlwaW5jdHJs
X3VzYmNfaWRfMTogdXNiY19pZC0xIHsNCj4gKwkJZnNsLHBpbnMgPSA8DQo+ICsJCQkvKiBVU0JD
X0lEICovDQo+ICsJCQlNWDZRRExfUEFEX05BTkRGX0QyX19HUElPMl9JTzAyCQkweDFiMA0KPiBi
MA0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gIAlwaW5jdHJsX3VzZGhjMTogdXNkaGMxZ3JwIHsN
Cj4gIAkJZnNsLHBpbnMgPSA8DQo+ICAJCQlNWDZRRExfUEFEX1NEMV9DTURfX1NEMV9DTUQJMHgx
NzA3MQ0K
