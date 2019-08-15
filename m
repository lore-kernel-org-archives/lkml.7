Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FB6C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CB3206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="eZ19Aemb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfHONoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:44:23 -0400
Received: from mail-eopbgr150137.outbound.protection.outlook.com ([40.107.15.137]:61301
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732183AbfHONoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:44:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaOpHLLXZdwfmqZHjLTgT+FvLd0wOvH1zx2StbWhgKHIwz/xoB6DmfSKGI1VKeAWftWAHcdVpBuU5R2+biM7va15y6GvXCMKGBkS/pFSnXjS9dA2EZ8zaG9/6ZCpxNw0cnjreck08SJ3xVSLm9TzsyxvMn0NrocR6B4Nn/0eJe6j/v2UrbCd6BIeeOrJ9BdXdHvnVGuIKVO3XZAgL0GR//mgvZcX2ysoU70R9aXIkJzYyjAoUQTlM2MuMhOhdmFNjlWey2jVAas7lmJM5vCsAk5aH97ZInWsciNVrzlbGsIvr3A0dQRxSA6aFZ5ZDFasmHa9d4IHkZoBJ5Z5eVbq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k//nUEraPgm5k1EcUWcJrEeglR9RYdlVUg2KMZuqdU=;
 b=PpxKH1SYmdocTrtsYbILk+36r0voDG0H9cLaiJ2Al1EFRRWUY6FDhNXMreOiL1DphxnO2um+TXNtrK/cl2lmjG4+iIgsc5l1emKg/WkJ3yTXZjWDPqdA/HL5J+7cxORxd0KxZJMLLqhldmkxfVdCyiRPs49/HELQkQIESU4RNmZz5Pe/x12tqtNZnwbQt8FM/sklAQZcxtqsEiIQxa8sRcBD/9zV+z6oSe8p6g4qvOHTnlT6UEhTIIfhXN11Jx/5jPg0LQkez1MW5+2V+LWLjZMeRbj/TZ12cPHc67kjfasmguDJlb8aSOrueA1PGPTrx8kxb1uNbBkhsUYzq0DkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k//nUEraPgm5k1EcUWcJrEeglR9RYdlVUg2KMZuqdU=;
 b=eZ19AembRd5JRp/+nKnD2cZhHF/pLzbxIntDwOiJqT+0qXOIvsZWmptwrAYtzeqa/awNp2QeDJfGpF3KkPnz4iLI03kZ0T2QdSAWDw+GsNthzd5fdYuasFrNvhOA5rYGonPosj0wQYaxrXhSbS/mFECBvkuNwqjmOq5A2mGkGEU=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB4623.eurprd05.prod.outlook.com (20.176.3.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Thu, 15 Aug 2019 13:44:16 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 13:44:16 +0000
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
Subject: Re: [PATCH v4 18/21] ARM: dts: imx6ull-colibri: Add general wakeup
 key used on Colibri
Thread-Topic: [PATCH v4 18/21] ARM: dts: imx6ull-colibri: Add general wakeup
 key used on Colibri
Thread-Index: AQHVU2+G5EKLAPrjz0meIc5Mt81I6w==
Date:   Thu, 15 Aug 2019 13:44:14 +0000
Message-ID: <CAGgjyvFSUCYUxbCU2fOXNH6gBOpw5gay+T8eyk=AKHB0OTornA@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-19-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-19-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0501CA0051.eurprd05.prod.outlook.com
 (2603:10a6:200:68::19) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAUJXFenEcYdbNFVzrdvOzI970Z9oOQANOK9wRJLPGogbS1UAdvo
        +qWhsPm/5vqG+syisX3Hs67dV1CXaC4oW4/3uFw=
x-google-smtp-source: APXvYqz2aWlA5FtxQU478yrfyBzlUiVVpdPuB5J9HooRP3eJBco0tbChI9YfB5VmOCqezypY67MivtPzL2bPUd33A/s=
x-received: by 2002:a50:9084:: with SMTP id c4mr5464976eda.237.1565876653514;
 Thu, 15 Aug 2019 06:44:13 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvFSUCYUxbCU2fOXNH6gBOpw5gay+T8eyk=AKHB0OTornA@mail.gmail.com>
x-originating-ip: [209.85.208.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b672bfbb-ce83-4ffe-1c0d-08d72186a924
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4623;
x-ms-traffictypediagnostic: VI1PR05MB4623:
x-microsoft-antispam-prvs: <VI1PR05MB4623B7241D0BC08CFFB7C5B9F9AC0@VI1PR05MB4623.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(376002)(39840400004)(136003)(189003)(199004)(66476007)(66446008)(64756008)(66556008)(256004)(66946007)(186003)(6436002)(8936002)(11346002)(305945005)(6636002)(450100002)(316002)(14454004)(76176011)(2906002)(86362001)(9686003)(486006)(6512007)(52116002)(6486002)(95326003)(53936002)(102836004)(6506007)(386003)(53546011)(26005)(6862004)(55446002)(81166006)(81156014)(478600001)(3846002)(476003)(7736002)(61726006)(6246003)(25786009)(6116002)(5660300002)(54906003)(71200400001)(71190400001)(8676002)(66066001)(44832011)(107886003)(99286004)(61266001)(498394004)(229853002)(446003)(4326008)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4623;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /cXj5DMVC9ufGlTjjteeGyf3bRua5JtRvdahx/rm65eVYuTAHM78KgnI+y2rYgoCwJLErRjOQSPWvmmSN05tY6TKd0EFiXcrgnz5Zk7AzDLskps1Z8fx7ASs6Ipi0X7i1vQuyrvJZRtuXV1lJ090Ck0vpQV0HnWXNpgtZpwEXjDr4Ode5wH5bbDhPHBPZT6rL24HWTEtRfVHwKFjNV6G1z3SHe6ShR2yfZp5Fc4NG0GMcLdPRx4YRi9EeARSS/PgXu8MNn+ZSwzcJ2tGxE6BQl5Mzh0GoVryGepFFxAjiUh1W0Ikp+dacZ33qWjls83bLB8wmH77KBvgn45qUaMee3CZIwOXlxWtooBpqYfuYn3skuJeTdhrkLtuzmBXMQlB6LHm37uOMp/3xF3/tE7TL5iH+cssT/7A1Smvz8HnVWc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <41F6EBF36EABB04D96823C2145A359AF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b672bfbb-ce83-4ffe-1c0d-08d72186a924
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 13:44:14.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJt7q2EA01M5cPMl0iUvfaVk+Zmb3D9492lJsa2mmS3hQpMurqLZZzb08dt51wG5T7eIqNilGZHSXkstUxyPApo9v1q1fa+drW2C8+eSH8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyMyBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gVGhpcyBhZGRzIHRoZSBwb3Nz
aWJpbGl0eSB0byB3YWtlIHRoZSBtb2R1bGUgd2l0aCBhbiBleHRlcm5hbCBzaWduYWwNCj4gYXMg
ZGVmaW5lZCBpbiB0aGUgQ29saWJyaSBzdGFuZGFyZA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGls
aXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+IEFja2VkLWJ5
OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IE9sZWtzYW5kciBTdXZvcm92IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4N
Cg0KPg0KPiAtLS0NCj4NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBBZGQgTWFyY2VsIFppc3dpbGVy
J3MgQWNrDQo+DQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0K
Pg0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8IDE0
ICsrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMu
ZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ldmFsLXYzLmR0c2kNCj4g
aW5kZXggYjYxNDdjNzZkMTU5Li5hNzg4NDlmZDJhZmEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiBAQCAtOCw2ICs4LDIwIEBA
DQo+ICAgICAgICAgICAgICAgICBzdGRvdXQtcGF0aCA9ICJzZXJpYWwwOjExNTIwMG44IjsNCj4g
ICAgICAgICB9Ow0KPg0KPiArICAgICAgIGdwaW8ta2V5cyB7DQo+ICsgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImdwaW8ta2V5cyI7DQo+ICsgICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiArICAgICAgICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX3Nu
dnNfZ3Bpb2tleXM+Ow0KPiArDQo+ICsgICAgICAgICAgICAgICBwb3dlciB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGxhYmVsID0gIldha2UtVXAiOw0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBncGlvcyA9IDwmZ3BpbzUgMSBHUElPX0FDVElWRV9ISUdIPjsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgbGludXgsY29kZSA9IDxLRVlfV0FLRVVQPjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZGVib3VuY2UtaW50ZXJ2YWwgPSA8MTA+Ow0KPiArICAgICAgICAgICAgICAgICAg
ICAgICB3YWtldXAtc291cmNlOw0KPiArICAgICAgICAgICAgICAgfTsNCj4gKyAgICAgICB9Ow0K
PiArDQo+ICAgICAgICAgLyogZml4ZWQgY3J5c3RhbCBkZWRpY2F0ZWQgdG8gbWNwMjUxNSAqLw0K
PiAgICAgICAgIGNsazE2bTogY2xrMTZtIHsNCj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAiZml4ZWQtY2xvY2siOw0KPiAtLQ0KPiAyLjIyLjANCj4NCg0KDQotLSANCkJlc3QgcmVnYXJk
cw0KT2xla3NhbmRyIFN1dm9yb3YNCg0KVG9yYWRleCBBRw0KQWx0c2FnZW5zdHJhc3NlIDUgfCA2
MDQ4IEhvcncvTHV6ZXJuIHwgU3dpdHplcmxhbmQgfCBUOiArNDEgNDEgNTAwDQo0ODAwIChtYWlu
IGxpbmUpDQo=
