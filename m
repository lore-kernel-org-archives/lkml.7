Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4221C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6086D21744
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="eS2SKMzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfHOLBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:01:18 -0400
Received: from mail-eopbgr50128.outbound.protection.outlook.com ([40.107.5.128]:3394
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728128AbfHOLBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:01:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAzWVse5Iq6vSkHaiZuxugCxTV3YSFivZRs9TuWQeryea9CZpl+gi2dtvmnUubSO8K0AGitjxmUqkoTzVvBvt2VOVfmOM+PaeuvJnRppLHjin292Aj0Wu7G02XRCTVzE3MR7UOsUtQo3Qu+76rl4YnPMEBu4gZDZX8gT/rD2pIa19dqokUFcEnWgxfBnOGlw4nz5B0X2/bupZ5zQoxXoqM4JeH9DHO/uA7af3V2C6hQWt2/V4sI0jWCl7Ho78bkhhBS5Ujcp8mM+bcCon7xTb/72ztOQvp2dCEiqlk4Eoju6c4HDpKY8j16RL7OD17ghD0sHR7zhom3k5ufF0tpaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLJgK3ZFupXucWqvO0Y5evuL5e7nHOm6/Tw/4zVqY1E=;
 b=M2TtBKNSGiF0+vwU1PBXvI2QIfKXqmGp+5t8BfK28WDS8RAROh+fklb50qYJfIYb0MOZCbq12C/0l0kyYkI33f8M38rgmqkOI2iCzOfCAq7O0OJPQnhG/qAPlqssgbLk2RHd3/IEuJK+BgKTGiIJQuy3zQUJ6YfbqjYb3K62hfKQdrFu57hdKKrL/qzNTJqZhNnQQFVYwueCQAT8Ulot8IT9TpmQaLbbZhZccI4lJtP9RpMQfrFhRhJlKHED7Su7ugEg6DtP4LjjXxlzLNYbaTyj2Qy78ds88ZLs4PjPgoenMjPyHV5qX2drb4MxhHuTpbe301UkVkstTGp1igzcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLJgK3ZFupXucWqvO0Y5evuL5e7nHOm6/Tw/4zVqY1E=;
 b=eS2SKMzGZ/kjc4srDKfDFl/jIN58ULg4lCBzGwGzZo38zccXcLOej3Zq66BnW8nrrHPMnSKNR3Afva/ik2z+7RskZnPtDeDbx0DjLcYMnjXU0Y/gZ0DP3bFoy6v5wPvdu4E+a0/YqHTc1evNfuPCKXvLmzz0sdBC5k3UJbYunhc=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5808.eurprd05.prod.outlook.com (20.178.122.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Thu, 15 Aug 2019 11:00:33 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 11:00:34 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 13/21] ARM: dts: imx6-colibri: Add missing pinmuxing to
 Toradex eval board
Thread-Topic: [PATCH v4 13/21] ARM: dts: imx6-colibri: Add missing pinmuxing
 to Toradex eval board
Thread-Index: AQHVU1e1NRA+fGlpEEevock7VPX/Ow==
Date:   Thu, 15 Aug 2019 11:00:34 +0000
Message-ID: <CAGgjyvGX2y8jxyWeFAPqo-q4y0p47Wrcsxh67aw-0UyaShvQ2g@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-14-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-14-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::47) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAVQPHgxZP+sak8aYwOh+N3ZGARFj1bICrmXoDzAnxoUPt3eyOnD
        yb9RpAYb9zmHb+mCYBeZW0htdV/AFhjAfzKEosk=
x-google-smtp-source: APXvYqyqVjlj6VXkS9oIMYC+clm0WCzRevHp/UfhWXzFKfkcarbPwf6+WulmXEm7WPolG0/IbyXu0LD3jBeYkW/Nk1Y=
x-received: by 2002:a17:906:7c49:: with SMTP id
 g9mr1598168ejp.262.1565866436743; Thu, 15 Aug 2019 03:53:56 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvGX2y8jxyWeFAPqo-q4y0p47Wrcsxh67aw-0UyaShvQ2g@mail.gmail.com>
x-originating-ip: [209.85.208.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93292d4e-2840-4950-03d8-08d7216fcc0e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5808;
x-ms-traffictypediagnostic: VI1PR05MB5808:
x-microsoft-antispam-prvs: <VI1PR05MB58089292A325960013DFAFF1F9AC0@VI1PR05MB5808.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(346002)(136003)(39840400004)(189003)(199004)(2906002)(6862004)(81166006)(81156014)(71190400001)(8676002)(11346002)(3846002)(8936002)(6512007)(498394004)(71200400001)(86362001)(9686003)(6116002)(55446002)(6436002)(229853002)(6506007)(53546011)(66556008)(66476007)(386003)(486006)(6636002)(476003)(186003)(14454004)(256004)(478600001)(66446008)(5660300002)(53936002)(25786009)(6486002)(26005)(66946007)(450100002)(4326008)(44832011)(66066001)(305945005)(61266001)(316002)(95326003)(446003)(107886003)(6246003)(99286004)(102836004)(76176011)(52116002)(7736002)(54906003)(61726006)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5808;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PalgcE+7U7Maw1Errcke81iWi/VMlI771019aOcJjZKgm3COrlhMX88FHYD6HPomTyf3mSdHdnLlXxl8cP/lxVpblNaJWP0aDshXDr9Z3JPgOHYsaRewJY34Vt6xPjAsfxnOrksAszBaOqCw/Rqw3idAnaPTOZhbPpgFJ9TrL72h/XYGy6wYErLqSXYzUROGvK6Srgx3incAC8CqhZ87fyoCXconjn7XSj/Vwzl1TPXRkpiTMVyoXps7HKrFiwQqFfQFo31lPXg51rXSif56weEKSBCJsuJbkRuLPNRCeV7fso2TO+ZcGpVdSJrvcDOLWJcs/tO6q5yy2R9F9g40Du0DBvnHKASD5uin7RwJwpQ9B+NNuaOD2S23/MNxSkPDd7P1dAliIbxayLJLO3Aaq4SO34tHnj27rjZGjpSxgAA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <37954B5DB7D46C468C941201897E8E4B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93292d4e-2840-4950-03d8-08d7216fcc0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 11:00:34.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M093ry9JVEREIibpp3VLG3utKfalLaVONfZ0HL09N5TzELUDSdKGUoDgdN10XOnufl3OMJIc+KFkPe0m5IdvFkp6+gm+5BV0e32gf83E+2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyMyBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gVGhpcyBwYXRjaCBhZGRzIHNv
bWUgbWlzc2luZyBwaW5tdXhpbmcgdGhhdCBpcyBpbiB0aGUgY29saWJyaQ0KPiBzdGFuZGFyZCB0
byB0aGUgZHRzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlw
cGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+IEFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE9sZWtzYW5kciBTdXZv
cm92IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4NCg0KPg0KPiAtLS0NCj4NCj4gQ2hh
bmdlcyBpbiB2NDoNCj4gLSBBZGQgTWFyY2VsIFppc3dpbGVyJ3MgQWNrDQo+DQo+IENoYW5nZXMg
aW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBDb21taXQgdGl0bGUNCj4NCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZkbC1jb2xpYnJpLWV2YWwtdjMuZHRzIHwgOCArKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12My5kdHMgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2ZGwtY29saWJyaS1ldmFsLXYzLmR0cw0KPiBpbmRleCA3NjNmYjVlOTBiZDMuLmU3
YTJkOGMzYjJkNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGli
cmktZXZhbC12My5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmkt
ZXZhbC12My5kdHMNCj4gQEAgLTE5MSw2ICsxOTEsMTQgQEANCj4gIH07DQo+DQo+ICAmaW9tdXhj
IHsNCj4gKyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArICAgICAgIHBpbmN0
cmwtMCA9IDwNCj4gKyAgICAgICAgICAgICAgICZwaW5jdHJsX3dlaW1fZ3Bpb18xICZwaW5jdHJs
X3dlaW1fZ3Bpb18yDQo+ICsgICAgICAgICAgICAgICAmcGluY3RybF93ZWltX2dwaW9fMyAmcGlu
Y3RybF93ZWltX2dwaW9fNA0KPiArICAgICAgICAgICAgICAgJnBpbmN0cmxfd2VpbV9ncGlvXzUg
JnBpbmN0cmxfd2VpbV9ncGlvXzYNCj4gKyAgICAgICAgICAgICAgICZwaW5jdHJsX3VzYmhfb2Nf
MSAmcGluY3RybF91c2JjX2lkXzENCj4gKyAgICAgICA+Ow0KPiArDQo+ICAgICAgICAgcGluY3Ry
bF9wY2FwXzE6IHBjYXAtMSB7DQo+ICAgICAgICAgICAgICAgICBmc2wscGlucyA9IDwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgTVg2UURMX1BBRF9HUElPXzlfX0dQSU8xX0lPMDkgICAweDFi
MGIwIC8qIFNPRElNTSAyOCAqLw0KPiAtLQ0KPiAyLjIyLjANCj4NCg0KDQotLSANCkJlc3QgcmVn
YXJkcw0KT2xla3NhbmRyIFN1dm9yb3YNCg0KVG9yYWRleCBBRw0KQWx0c2FnZW5zdHJhc3NlIDUg
fCA2MDQ4IEhvcncvTHV6ZXJuIHwgU3dpdHplcmxhbmQgfCBUOiArNDEgNDEgNTAwDQo0ODAwICht
YWluIGxpbmUpDQo=
